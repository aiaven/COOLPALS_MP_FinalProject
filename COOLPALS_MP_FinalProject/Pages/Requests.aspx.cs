using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class Request : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                SetMinimumDate();
                LoadTimeSelectors();

                if (Request.QueryString["TutorID"] == null ||
                    Request.QueryString["TutorName"] == null ||
                    Request.QueryString["SkillID"] == null)
                {
                    lblMessage.Text = "Please select a tutor first.";
                    btnSubmit.Enabled = false;
                    return;
                }

                int tutorId, skillId;
                if (!int.TryParse(Request.QueryString["TutorID"], out tutorId) ||
                    !int.TryParse(Request.QueryString["SkillID"], out skillId))
                {
                    lblMessage.Text = "Invalid tutor or skill information.";
                    btnSubmit.Enabled = false;
                    return;
                }

                txtTutor.Text = Request.QueryString["TutorName"];
                LoadSkills(tutorId, skillId);
            }
        }

        private void LoadSkills(int tutorId, int selectedSkillId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            SELECT DISTINCT s.SkillID, s.SkillName
            FROM UserSkills us
            INNER JOIN Skills s ON us.SkillID = s.SkillID
            WHERE us.UserID = @TutorID
              AND us.CanTutor = 1
            ORDER BY s.SkillName";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TutorID", tutorId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlSkill.DataSource = reader;
                ddlSkill.DataTextField = "SkillName";
                ddlSkill.DataValueField = "SkillID";
                ddlSkill.DataBind();

                reader.Close();

                if (ddlSkill.Items.Count == 0)
                {
                    ddlSkill.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- No tutorable skills available --", ""));
                    ddlSkill.Enabled = false;
                    btnSubmit.Enabled = false;
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "This tutor currently has no available skills for tutoring.";
                    return;
                }

                ddlSkill.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Skill --", ""));

                if (ddlSkill.Items.FindByValue(selectedSkillId.ToString()) != null)
                {
                    ddlSkill.SelectedValue = selectedSkillId.ToString();
                }
                else
                {
                    ddlSkill.SelectedIndex = 0;
                }
            }
        }

        private void SetMinimumDate()
        {
            txtDate.Attributes["min"] = DateTime.Today.ToString("yyyy-MM-dd");
        }

        private void LoadTimeSelectors()
        {
            ddlHour.Items.Clear();
            ddlMinute.Items.Clear();
            ddlPeriod.Items.Clear();

            ddlHour.Items.Add(new ListItem("HH", ""));
            ddlMinute.Items.Add(new ListItem("MM", ""));
            ddlPeriod.Items.Add(new ListItem("AM/PM", ""));

            for (int i = 7; i <= 12; i++)
                ddlHour.Items.Add(new ListItem(i.ToString("00"), i.ToString()));

            for (int i = 1; i <= 7; i++)
                ddlHour.Items.Add(new ListItem(i.ToString("00"), i.ToString()));

            for (int i = 0; i < 60; i += 5)
                ddlMinute.Items.Add(new ListItem(i.ToString("00"), i.ToString()));

            ddlPeriod.Items.Add(new ListItem("AM", "AM"));
            ddlPeriod.Items.Add(new ListItem("PM", "PM"));
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblDateError.Text = "";
            lblTimeError.Text = "";

            if (string.IsNullOrWhiteSpace(txtDate.Text))
                return;

            DateTime selectedDate;
            if (!DateTime.TryParse(txtDate.Text, out selectedDate))
            {
                lblDateError.Text = "Please select a valid date.";
                txtDate.Text = "";
                return;
            }

            if (selectedDate.Date < DateTime.Today)
            {
                lblDateError.Text = "You cannot set a session before the current date.";
                txtDate.Text = "";
                return;
            }
        }

        protected void SubmitRequest(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            lblMessage.Text = "";
            lblDateError.Text = "";
            lblTimeError.Text = "";

            int learnerId = Convert.ToInt32(Session["UserID"]);

            int tutorId;
            if (!int.TryParse(Request.QueryString["TutorID"], out tutorId))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Invalid tutor selected.";
                return;
            }

            if (learnerId == tutorId)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "You cannot send a request to yourself.";
                return;
            }

            int skillId;
            if (!int.TryParse(ddlSkill.SelectedValue, out skillId))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please select a valid skill.";
                return;
            }

            DateTime selectedDate;
            if (string.IsNullOrWhiteSpace(txtDate.Text) || !DateTime.TryParse(txtDate.Text, out selectedDate))
            {
                lblDateError.Text = "Please select a valid requested date.";
                return;
            }

            if (selectedDate.Date < DateTime.Today)
            {
                lblDateError.Text = "You cannot set a session before the current date.";
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlHour.SelectedValue) ||
                string.IsNullOrWhiteSpace(ddlMinute.SelectedValue) ||
                string.IsNullOrWhiteSpace(ddlPeriod.SelectedValue))
            {
                lblTimeError.Text = "Please select a valid time.";
                return;
            }

            int hour = Convert.ToInt32(ddlHour.SelectedValue);
            int minute = Convert.ToInt32(ddlMinute.SelectedValue);
            string period = ddlPeriod.SelectedValue;

            if (period == "PM" && hour != 12)
                hour += 12;
            if (period == "AM" && hour == 12)
                hour = 0;

            TimeSpan selectedTime = new TimeSpan(hour, minute, 0);

            TimeSpan minTime = new TimeSpan(7, 0, 0);
            TimeSpan maxTime = new TimeSpan(19, 0, 0);

            if (selectedTime < minTime || selectedTime > maxTime)
            {
                lblTimeError.Text = "Session time must be between 7:00 AM and 7:00 PM.";
                return;
            }

            DateTime fullRequestedDateTime = selectedDate.Date.Add(selectedTime);

            if (fullRequestedDateTime < DateTime.Now)
            {
                lblDateError.Text = "You cannot set a session before the current date and time.";
                return;
            }

            string availability = fullRequestedDateTime.ToString("MMMM dd, yyyy hh:mm tt");
            string notes = txtNotes.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string duplicateCheckQuery = @"
                    SELECT COUNT(*)
                    FROM LearningRequests
                    WHERE LearnerID = @learner
                      AND TutorID = @tutor
                      AND SkillID = @skill
                      AND Status = 'Pending'";

                SqlCommand duplicateCmd = new SqlCommand(duplicateCheckQuery, conn);
                duplicateCmd.Parameters.AddWithValue("@learner", learnerId);
                duplicateCmd.Parameters.AddWithValue("@tutor", tutorId);
                duplicateCmd.Parameters.AddWithValue("@skill", skillId);

                conn.Open();

                int existingPending = Convert.ToInt32(duplicateCmd.ExecuteScalar());
                if (existingPending > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "You already have a pending request for this tutor and skill.";
                    return;
                }

                string query = @"
                    INSERT INTO LearningRequests
                    (LearnerID, TutorID, SkillID, Message, Availability, Status, RequestDate)
                    VALUES
                    (@learner, @tutor, @skill, @message, @availability, @status, @requestDate)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@learner", learnerId);
                cmd.Parameters.AddWithValue("@tutor", tutorId);
                cmd.Parameters.AddWithValue("@skill", skillId);
                cmd.Parameters.AddWithValue("@message", string.IsNullOrWhiteSpace(notes) ? (object)DBNull.Value : notes);
                cmd.Parameters.AddWithValue("@availability", availability);
                cmd.Parameters.AddWithValue("@status", "Pending");
                cmd.Parameters.AddWithValue("@requestDate", DateTime.Now);

                cmd.ExecuteNonQuery();
            }

            Response.Redirect("~/Pages/SessionHistory.aspx");
        }
    }
}