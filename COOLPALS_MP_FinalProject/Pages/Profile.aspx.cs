using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class Profile : Page
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

                int userId = Convert.ToInt32(Session["UserID"]);
                LoadUserProfile(userId);
                LoadUserSkills(userId);
                LoadAvailableSkills(userId);
                SetEditMode(false);

                if (Session["ProfileMessage"] != null)
                {
                    lblMessage.Text = Session["ProfileMessage"].ToString();

                    if (Session["ProfileMessageColor"] != null && Session["ProfileMessageColor"].ToString() == "Red")
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    else
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                    Session.Remove("ProfileMessage");
                    Session.Remove("ProfileMessageColor");
                }
            }
        }

        private void SetEditMode(bool enabled)
        {
            // Profile info follows Edit Profile mode
            txtFirstName.ReadOnly = !enabled;
            txtLastName.ReadOnly = !enabled;
            txtProgram.ReadOnly = !enabled;
            txtBio.ReadOnly = !enabled;

            ddlYearLevel.Enabled = enabled;
            fuProfilePic.Enabled = enabled;
            btnUploadPic.Enabled = enabled;

            // Skills section stays usable
            ddlAvailableSkills.Enabled = enabled;
            ddlProficiency.Enabled = enabled;
            txtYearsExperience.ReadOnly = !enabled;
            chkCanTutor.Enabled = enabled;
            btnAddSkill.Enabled = enabled;

            gvUserSkills.Enabled = enabled;
            gvUserSkills.Columns[5].Visible = enabled;

            btnEditProfile.Visible = !enabled;
            btnSave.Visible = enabled;
            btnCancelEdit.Visible = enabled;
        }

        protected void EditProfile(object sender, EventArgs e)
        {
            SetEditMode(true);
            lblMessage.Text = "";
        }

        protected void CancelProfileEdit(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            LoadUserProfile(userId);
            LoadUserSkills(userId);
            LoadAvailableSkills(userId);
            SetEditMode(false);
            lblMessage.Text = "";
        }

        private void LoadUserProfile(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT FirstName, LastName, Email, Program, YearLevel, Bio, ProfileImage
                                 FROM Users
                                 WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtFirstName.Text = reader["FirstName"].ToString();
                    txtLastName.Text = reader["LastName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtProgram.Text = reader["Program"] == DBNull.Value ? "" : reader["Program"].ToString();
                    txtBio.Text = reader["Bio"] == DBNull.Value ? "" : reader["Bio"].ToString();

                    if (reader["YearLevel"] != DBNull.Value)
                    {
                        string year = reader["YearLevel"].ToString();
                        if (ddlYearLevel.Items.FindByValue(year) != null)
                            ddlYearLevel.SelectedValue = year;
                    }

                    imgProfile.ImageUrl = reader["ProfileImage"] == DBNull.Value
                        ? "~/Images/default-profile.png"
                        : reader["ProfileImage"].ToString();
                }

                reader.Close();
            }
        }

        protected void SaveProfile(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"UPDATE Users
                                 SET FirstName = @FirstName,
                                     LastName = @LastName,
                                     Program = @Program,
                                     YearLevel = @YearLevel,
                                     Bio = @Bio
                                 WHERE UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                cmd.Parameters.AddWithValue("@Program", string.IsNullOrWhiteSpace(txtProgram.Text) ? (object)DBNull.Value : txtProgram.Text.Trim());
                cmd.Parameters.AddWithValue("@YearLevel", Convert.ToInt32(ddlYearLevel.SelectedValue));
                cmd.Parameters.AddWithValue("@Bio", string.IsNullOrWhiteSpace(txtBio.Text) ? (object)DBNull.Value : txtBio.Text.Trim());
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["FirstName"] = txtFirstName.Text.Trim();
            Session["LastName"] = txtLastName.Text.Trim();

            Session["ProfileMessage"] = "Profile updated successfully.";
            Session["ProfileMessageColor"] = "Green";

            Response.Redirect("~/Pages/Profile.aspx");
        }

        protected void UploadProfilePic(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (!fuProfilePic.HasFile)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please choose an image first.";
                return;
            }

            string extension = Path.GetExtension(fuProfilePic.FileName).ToLower();
            if (extension != ".jpg" && extension != ".jpeg" && extension != ".png")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Only JPG, JPEG, and PNG files are allowed.";
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            string fileName = "user_" + userId + extension;
            string virtualPath = "~/Images/" + fileName;
            string physicalPath = Server.MapPath(virtualPath);

            fuProfilePic.SaveAs(physicalPath);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET ProfileImage = @ProfileImage WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProfileImage", virtualPath);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Session["ProfileMessage"] = "Profile picture updated successfully.";
            Session["ProfileMessageColor"] = "Green";
            Response.Redirect("~/Pages/Profile.aspx");
        }

        private void LoadAvailableSkills(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            SELECT SkillID, SkillName
            FROM Skills
            WHERE SkillID NOT IN (
                SELECT SkillID
                FROM UserSkills
                WHERE UserID = @UserID
            )
            ORDER BY SkillName";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlAvailableSkills.DataSource = reader;
                ddlAvailableSkills.DataTextField = "SkillName";
                ddlAvailableSkills.DataValueField = "SkillID";
                ddlAvailableSkills.DataBind();

                reader.Close();
            }

            ddlAvailableSkills.Items.Insert(0, new ListItem("-- Select Skill --", ""));
        }

        private void LoadUserSkills(int userId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT 
                        us.UserSkillID,
                        s.SkillName,
                        us.ProficiencyLevel,
                        us.YearsExperience,
                        us.CanTutor
                    FROM UserSkills us
                    INNER JOIN Skills s ON us.SkillID = s.SkillID
                    WHERE us.UserID = @UserID
                    ORDER BY s.SkillName";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@UserID", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUserSkills.DataSource = dt;
                gvUserSkills.DataBind();
            }
        }

        protected void AddSkill(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);

            if (ddlAvailableSkills.Items.Count == 0)
            {
                Session["ProfileMessage"] = "No more available skills to add.";
                Session["ProfileMessageColor"] = "Red";
                Response.Redirect("~/Pages/Profile.aspx");
                return;
            }

            int skillId;

            if (!int.TryParse(ddlAvailableSkills.SelectedValue, out skillId))
            {
                Session["ProfileMessage"] = "Please select a valid skill first.";
                Session["ProfileMessageColor"] = "Red";
                Response.Redirect("~/Pages/Profile.aspx");
                return;
            }

            string proficiency = ddlProficiency.SelectedValue;
            int yearsExperience = 0;

            if (!string.IsNullOrWhiteSpace(txtYearsExperience.Text))
            {
                int.TryParse(txtYearsExperience.Text.Trim(), out yearsExperience);
            }

            bool canTutor = chkCanTutor.Checked;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Check if this user already has this skill
                string checkQuery = @"SELECT COUNT(*) 
                              FROM UserSkills 
                              WHERE UserID = @UserID AND SkillID = @SkillID";

                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@UserID", userId);
                checkCmd.Parameters.AddWithValue("@SkillID", skillId);

                int existingCount = (int)checkCmd.ExecuteScalar();

                if (existingCount > 0)
                {
                    Session["ProfileMessage"] = "You already added this skill.";
                    Session["ProfileMessageColor"] = "Red";
                    Response.Redirect("~/Pages/Profile.aspx");
                    return;
                }

                string query = @"
            INSERT INTO UserSkills (UserID, SkillID, ProficiencyLevel, YearsExperience, CanTutor)
            VALUES (@UserID, @SkillID, @ProficiencyLevel, @YearsExperience, @CanTutor)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@SkillID", skillId);
                cmd.Parameters.AddWithValue("@ProficiencyLevel", proficiency);
                cmd.Parameters.AddWithValue("@YearsExperience", yearsExperience == 0 ? (object)DBNull.Value : yearsExperience);
                cmd.Parameters.AddWithValue("@CanTutor", canTutor);

                cmd.ExecuteNonQuery();
            }

            Session["ProfileMessage"] = "Skill added successfully.";
            Session["ProfileMessageColor"] = "Green";
            Response.Redirect("~/Pages/Profile.aspx");
        }

        protected void EditSkill(object sender, GridViewEditEventArgs e)
        {
            gvUserSkills.EditIndex = e.NewEditIndex;
            LoadUserSkills(Convert.ToInt32(Session["UserID"]));
        }

        protected void UpdateSkill(object sender, GridViewUpdateEventArgs e)
        {
            int userSkillId = Convert.ToInt32(gvUserSkills.DataKeys[e.RowIndex].Value);
            int userId = Convert.ToInt32(Session["UserID"]);
            GridViewRow row = gvUserSkills.Rows[e.RowIndex];

            string proficiency = "";
            string yearsText = "";
            int yearsExperience = 0;
            bool canTutor = false;

            if (row.Cells.Count > 2 && row.Cells[2].Controls.Count > 0)
            {
                TextBox txtProficiency = row.Cells[2].Controls[0] as TextBox;
                if (txtProficiency != null)
                {
                    proficiency = txtProficiency.Text.Trim();
                }
            }

            if (row.Cells.Count > 3 && row.Cells[3].Controls.Count > 0)
            {
                TextBox txtYears = row.Cells[3].Controls[0] as TextBox;
                if (txtYears != null)
                {
                    yearsText = txtYears.Text.Trim();
                    int.TryParse(yearsText, out yearsExperience);
                }
            }

            if (row.Cells.Count > 4)
            {
                foreach (Control control in row.Cells[4].Controls)
                {
                    if (control is CheckBox cb)
                    {
                        canTutor = cb.Checked;
                        break;
                    }
                }
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            UPDATE UserSkills
            SET ProficiencyLevel = @ProficiencyLevel,
                YearsExperience = @YearsExperience,
                CanTutor = @CanTutor
            WHERE UserSkillID = @UserSkillID
              AND UserID = @UserID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProficiencyLevel", proficiency);
                cmd.Parameters.AddWithValue("@YearsExperience", yearsExperience == 0 ? (object)DBNull.Value : yearsExperience);
                cmd.Parameters.AddWithValue("@CanTutor", canTutor);
                cmd.Parameters.AddWithValue("@UserSkillID", userSkillId);
                cmd.Parameters.AddWithValue("@UserID", userId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvUserSkills.EditIndex = -1;
            LoadUserSkills(userId);

            lblMessage.Visible = true;
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Skill updated successfully.";
        }

        protected void CancelEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUserSkills.EditIndex = -1;
            LoadUserSkills(Convert.ToInt32(Session["UserID"]));
        }

        protected void DeleteSkill(object sender, GridViewDeleteEventArgs e)
        {
            int userSkillId = Convert.ToInt32(gvUserSkills.DataKeys[e.RowIndex].Value);
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM UserSkills WHERE UserSkillID = @UserSkillID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserSkillID", userSkillId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadUserSkills(userId);
            LoadAvailableSkills(userId);

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Skill deleted successfully.";
        }
    }
}
