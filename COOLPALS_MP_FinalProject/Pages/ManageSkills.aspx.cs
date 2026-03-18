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
                bool isAdmin = Session["Role"] != null && Session["Role"].ToString() == "Admin";

                if (isAdmin)
                {
                    lnkBackProfile.NavigateUrl = "~/Pages/AdminDashboard.aspx";
                    lnkBackProfile.Text = "← Back to Admin Dashboard";
                }
                else
                {
                    lnkBackProfile.NavigateUrl = "~/Pages/Profile.aspx";
                    lnkBackProfile.Text = "← Back to My Profile";
                }

                LoadAvailableSkills();
            }
        }

        // Available skills to add to profile
        private void LoadAvailableSkills()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT s.SkillID, s.SkillName, c.CategoryName, s.Description
                                 FROM Skills s
                                 INNER JOIN SkillCategories c ON s.CategoryID = c.CategoryID";
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
                                 WHERE s.SkillName LIKE @kw OR c.CategoryName LIKE @kw";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@kw", "%" + keyword + "%");

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvSkills.DataSource = dt;
                gvSkills.DataBind();
            }
        }

        // Add skill to profile
        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AddSkill")
            {
                int skillId = Convert.ToInt32(e.CommandArgument);
                int userId = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO UserSkills(UserID, SkillID, ProficiencyLevel, YearsExperience, CanTutor, DateAdded)
                                     VALUES(@uid, @sid, 'Beginner', 0, 0, GETDATE())";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@sid", skillId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // Redirect back to Profile so the student sees their updated skills
                Response.Redirect("~/Pages/Profile.aspx");
            }
        }
    }
}
