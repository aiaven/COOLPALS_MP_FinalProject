using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class ManageSkills : Page
    {
        private readonly string connString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            bool isAdmin = Session["Role"] != null && Session["Role"].ToString() == "Admin";

            if (!IsPostBack)
            {
                if (isAdmin)
                {
                    lnkBackProfile.NavigateUrl = "~/Pages/AdminDashboard.aspx";
                    lnkBackProfile.Text = "← Back to Admin Dashboard";
                    btnShowAddNew.Visible = true;
                    LoadCategories();
                    pnlAdminForm.Visible = false;
                }
                else
                {
                    lnkBackProfile.NavigateUrl = "~/Pages/Profile.aspx";
                    lnkBackProfile.Text = "← Back to My Profile";
                    pnlAdminForm.Visible = false;
                    btnShowAddNew.Visible = false;
                }

                ClearForm();
                LoadAvailableSkills();
            }
        }

        private bool IsAdmin()
        {
            return Session["Role"] != null && Session["Role"].ToString() == "Admin";
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT CategoryID, CategoryName FROM SkillCategories ORDER BY CategoryName";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlCategory.DataSource = reader;
                        ddlCategory.DataTextField = "CategoryName";
                        ddlCategory.DataValueField = "CategoryID";
                        ddlCategory.DataBind();
                    }
                }
            }

            ddlCategory.Items.Insert(0, new ListItem("-- Select Category --", ""));
        }

        private void LoadAvailableSkills()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT s.SkillID, s.SkillName, c.CategoryName, s.Description
                                 FROM Skills s
                                 INNER JOIN SkillCategories c ON s.CategoryID = c.CategoryID
                                 ORDER BY s.SkillName";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSkills.DataSource = dt;
                gvSkills.DataBind();
            }
        }

        protected void SearchSkills(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT s.SkillID, s.SkillName, c.CategoryName, s.Description
                                 FROM Skills s
                                 INNER JOIN SkillCategories c ON s.CategoryID = c.CategoryID
                                 WHERE s.SkillName LIKE @kw
                                    OR c.CategoryName LIKE @kw
                                    OR s.Description LIKE @kw
                                 ORDER BY s.SkillName";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@kw", "%" + keyword + "%");

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSkills.DataSource = dt;
                gvSkills.DataBind();
            }
        }

        protected void btnShowAddNew_Click(object sender, EventArgs e)
        {
            if (!IsAdmin())
            {
                Response.Redirect("~/Pages/Profile.aspx");
                return;
            }

            ClearForm();
            pnlAdminForm.Visible = true;
            btnSaveSkill.Text = "Save Skill";
            lblMessage.Text = "";
        }

        protected void btnSaveSkill_Click(object sender, EventArgs e)
        {
            if (!IsAdmin())
            {
                Response.Redirect("~/Pages/Profile.aspx");
                return;
            }

            string skillName = txtSkillName.Text.Trim();
            string description = txtDescription.Text.Trim();

            if (string.IsNullOrWhiteSpace(skillName))
            {
                ShowMessage("Please enter a skill name.", true);
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlCategory.SelectedValue))
            {
                ShowMessage("Please select a category.", true);
                return;
            }

            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string duplicateQuery = @"SELECT COUNT(*) 
                                          FROM Skills
                                          WHERE SkillName = @SkillName
                                            AND CategoryID = @CategoryID
                                            AND (@SkillID = 0 OR SkillID <> @SkillID)";

                using (SqlCommand dupCmd = new SqlCommand(duplicateQuery, conn))
                {
                    int currentSkillId = string.IsNullOrWhiteSpace(hfSkillID.Value) ? 0 : Convert.ToInt32(hfSkillID.Value);

                    dupCmd.Parameters.AddWithValue("@SkillName", skillName);
                    dupCmd.Parameters.AddWithValue("@CategoryID", categoryId);
                    dupCmd.Parameters.AddWithValue("@SkillID", currentSkillId);

                    int existingCount = Convert.ToInt32(dupCmd.ExecuteScalar());
                    if (existingCount > 0)
                    {
                        ShowMessage("That skill already exists in the selected category.", true);
                        return;
                    }
                }

                if (string.IsNullOrWhiteSpace(hfSkillID.Value))
                {
                    string insertQuery = @"INSERT INTO Skills (SkillName, CategoryID, Description)
                                           VALUES (@SkillName, @CategoryID, @Description)";

                    using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName);
                        cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                        cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);

                        cmd.ExecuteNonQuery();
                    }

                    ShowMessage("Skill added successfully.", false);
                }
                else
                {
                    int skillId = Convert.ToInt32(hfSkillID.Value);

                    string updateQuery = @"UPDATE Skills
                                           SET SkillName = @SkillName,
                                               CategoryID = @CategoryID,
                                               Description = @Description
                                           WHERE SkillID = @SkillID";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@SkillName", skillName);
                        cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                        cmd.Parameters.AddWithValue("@Description", string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);
                        cmd.Parameters.AddWithValue("@SkillID", skillId);

                        cmd.ExecuteNonQuery();
                    }

                    ShowMessage("Skill updated successfully.", false);
                }
            }

            ClearForm();
            pnlAdminForm.Visible = false;
            btnSaveSkill.Text = "Save Skill";
            LoadAvailableSkills();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ClearForm();
            pnlAdminForm.Visible = false;
            lblMessage.Text = "";
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!IsAdmin())
            {
                return;
            }

            if (e.CommandName == "EditSkill")
            {
                int skillId = Convert.ToInt32(e.CommandArgument);
                LoadSkillForEdit(skillId);
            }
            else if (e.CommandName == "DeleteSkill")
            {
                int skillId = Convert.ToInt32(e.CommandArgument);
                DeleteSkill(skillId);
            }
        }

        private void LoadSkillForEdit(int skillId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT SkillID, SkillName, CategoryID, Description
                                 FROM Skills
                                 WHERE SkillID = @SkillID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@SkillID", skillId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfSkillID.Value = reader["SkillID"].ToString();
                            txtSkillName.Text = reader["SkillName"].ToString();
                            ddlCategory.SelectedValue = reader["CategoryID"].ToString();
                            txtDescription.Text = reader["Description"] == DBNull.Value ? "" : reader["Description"].ToString();
                        }
                    }
                }
            }
            pnlAdminForm.Visible = true;
            btnSaveSkill.Text = "Update Skill";
            ShowMessage("Editing selected skill.", false);
        }

        private void DeleteSkill(int skillId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string checkUserSkillsQuery = "SELECT COUNT(*) FROM UserSkills WHERE SkillID = @SkillID";
                using (SqlCommand checkCmd = new SqlCommand(checkUserSkillsQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@SkillID", skillId);
                    int userSkillCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (userSkillCount > 0)
                    {
                        ShowMessage("This skill cannot be deleted because it is already assigned to one or more users.", true);
                        return;
                    }
                }

                string checkRequestsQuery = "SELECT COUNT(*) FROM LearningRequests WHERE SkillID = @SkillID";
                using (SqlCommand checkCmd = new SqlCommand(checkRequestsQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@SkillID", skillId);
                    int requestCount = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (requestCount > 0)
                    {
                        ShowMessage("This skill cannot be deleted because it is already used in learning requests.", true);
                        return;
                    }
                }

                string deleteQuery = "DELETE FROM Skills WHERE SkillID = @SkillID";
                using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@SkillID", skillId);
                    cmd.ExecuteNonQuery();
                }
            }

            ClearForm();
            LoadAvailableSkills();
            ShowMessage("Skill deleted successfully.", false);
        }

        private void ClearForm()
        {
            hfSkillID.Value = "";
            txtSkillName.Text = "";
            txtDescription.Text = "";

            if (ddlCategory.Items.Count > 0)
            {
                ddlCategory.SelectedIndex = 0;
            }
        }

        private void ShowMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isError
                ? System.Drawing.Color.FromName("#CC0000")
                : System.Drawing.Color.FromName("#1F7A1F");
        }
    }
}