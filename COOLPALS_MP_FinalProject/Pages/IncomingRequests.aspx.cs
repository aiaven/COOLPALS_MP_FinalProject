using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject.Pages
{
    public partial class IncomingRequests : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserID"] == null)
                {
                    Response.Redirect("~/Pages/Login.aspx");
                    return;
                }

                if (!UserCanTutor())
                {
                    Response.Redirect("~/Pages/Default.aspx");
                    return;
                }

                LoadIncomingRequests();
            }
        }

        private bool UserCanTutor()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT COUNT(*) 
                         FROM UserSkills
                         WHERE UserID = @UserID AND CanTutor = 1";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                return count > 0;
            }
        }

        private void LoadIncomingRequests()
        {
            int tutorId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // CURRENT REQUESTS
                string currentQuery = @"
            SELECT 
                lr.RequestID,
                u.FirstName + ' ' + u.LastName AS LearnerName,
                s.SkillName,
                lr.Message,
                lr.Availability,
                lr.Status,
                lr.RequestDate
            FROM LearningRequests lr
            INNER JOIN Users u ON lr.LearnerID = u.UserID
            INNER JOIN Skills s ON lr.SkillID = s.SkillID
            WHERE lr.TutorID = @TutorID
              AND lr.Status IN ('Pending', 'Accepted')
            ORDER BY lr.RequestDate DESC";

                SqlDataAdapter daCurrent = new SqlDataAdapter(currentQuery, conn);
                daCurrent.SelectCommand.Parameters.AddWithValue("@TutorID", tutorId);

                DataTable dtCurrent = new DataTable();
                daCurrent.Fill(dtCurrent);

                gvIncomingRequests.DataSource = dtCurrent;
                gvIncomingRequests.DataBind();

                // HISTORY
                string historyQuery = @"
            SELECT 
                lr.RequestID,
                u.FirstName + ' ' + u.LastName AS LearnerName,
                s.SkillName,
                lr.Message,
                lr.Availability,
                lr.Status,
                lr.RequestDate
            FROM LearningRequests lr
            INNER JOIN Users u ON lr.LearnerID = u.UserID
            INNER JOIN Skills s ON lr.SkillID = s.SkillID
            WHERE lr.TutorID = @TutorID
              AND lr.Status IN ('Declined', 'Completed', 'Cancelled')
            ORDER BY lr.RequestDate DESC";

                SqlDataAdapter daHistory = new SqlDataAdapter(historyQuery, conn);
                daHistory.SelectCommand.Parameters.AddWithValue("@TutorID", tutorId);

                DataTable dtHistory = new DataTable();
                daHistory.Fill(dtHistory);

                gvRequestHistory.DataSource = dtHistory;
                gvRequestHistory.DataBind();

                if (dtCurrent.Rows.Count == 0 && dtHistory.Rows.Count == 0)
                {
                    lblMessage.Text = "No incoming requests yet.";
                }
                else
                {
                    lblMessage.Text = "";
                }
            }
        }

        protected void gvIncomingRequests_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int requestId = Convert.ToInt32(gvIncomingRequests.DataKeys[rowIndex].Values["RequestID"]);

            if (e.CommandName == "AcceptRequest")
            {
                UpdateRequestStatus(requestId, "Accepted");
            }
            else if (e.CommandName == "DeclineRequest")
            {
                UpdateRequestStatus(requestId, "Declined");
            }
            else if (e.CommandName == "CompleteRequest")
            {
                UpdateRequestStatus(requestId, "Completed");
            }
            else if (e.CommandName == "CancelRequest")
            {
                UpdateRequestStatus(requestId, "Cancelled");
            }

            LoadIncomingRequests();
        }

        private void UpdateRequestStatus(int requestId, string status)
        {
            int tutorId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            UPDATE LearningRequests
            SET Status = @Status,
                ResponseDate = CASE 
                    WHEN @Status IN ('Accepted','Declined') AND ResponseDate IS NULL THEN GETDATE()
                    ELSE ResponseDate
                END,
                CompletedDate = CASE
                    WHEN @Status = 'Completed' AND CompletedDate IS NULL THEN GETDATE()
                    ELSE CompletedDate
                END,
                CancelledDate = CASE
                    WHEN @Status = 'Cancelled' AND CancelledDate IS NULL THEN GETDATE()
                    ELSE CancelledDate
                END
            WHERE RequestID = @RequestID
              AND TutorID = @TutorID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@RequestID", requestId);
                cmd.Parameters.AddWithValue("@TutorID", tutorId);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();

                if (rowsAffected == 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "You are not allowed to update this request.";
                    return;
                }
            }

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Request updated successfully.";
        }
    }
}
