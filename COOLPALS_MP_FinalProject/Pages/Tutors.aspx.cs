using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class Tutor : Page
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

                LoadCategories();
                LoadTutors();
            }
        }

        private void LoadTutors(string skillFilter = "", string categoryFilter = "")
        {
            int currentUserId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT u.UserID, u.FirstName, u.LastName, u.Program, u.YearLevel,
                                s.SkillID, s.SkillName, sc.CategoryName, 
                                us.ProficiencyLevel, us.YearsExperience
                         FROM UserSkills us
                         INNER JOIN Users u ON us.UserID = u.UserID
                         INNER JOIN Skills s ON us.SkillID = s.SkillID
                         INNER JOIN SkillCategories sc ON s.CategoryID = sc.CategoryID
                         WHERE us.CanTutor = 1
                           AND u.IsActive = 1
                           AND u.UserID <> @CurrentUserID";

                if (!string.IsNullOrWhiteSpace(skillFilter))
                {
                    query += " AND s.SkillName LIKE @skill";
                }

                if (!string.IsNullOrWhiteSpace(categoryFilter))
                {
                    query += " AND s.CategoryID = @categoryId";
                }

                query += " ORDER BY s.SkillName, u.LastName, u.FirstName";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@CurrentUserID", currentUserId);

                if (!string.IsNullOrWhiteSpace(skillFilter))
                {
                    da.SelectCommand.Parameters.AddWithValue("@skill", skillFilter + "%");
                }

                if (!string.IsNullOrWhiteSpace(categoryFilter))
                {
                    da.SelectCommand.Parameters.AddWithValue("@categoryId", categoryFilter);
                }

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvTutors.DataSource = dt;
                gvTutors.DataBind();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT CategoryID, CategoryName FROM SkillCategories ORDER BY CategoryName";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlCategory.DataSource = reader;
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();

                reader.Close();
            }

            ddlCategory.Items.Insert(0, new ListItem("All Categories", ""));
        }

        protected void SearchTutors(object sender, EventArgs e)
        {
            string skillFilter = txtSearch.Text.Trim();
            string categoryFilter = ddlCategory.SelectedValue;

            // Ignore very short searches like just 1 letter
            if (!string.IsNullOrWhiteSpace(skillFilter) && skillFilter.Length < 2)
            {
                gvTutors.DataSource = null;
                gvTutors.DataBind();
                return;
            }

            LoadTutors(skillFilter, categoryFilter);
        }

        protected void gvTutors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "RequestTutor")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                int tutorId = Convert.ToInt32(gvTutors.DataKeys[rowIndex]["UserID"]);
                int skillId = Convert.ToInt32(gvTutors.DataKeys[rowIndex]["SkillID"]);

                string firstName = gvTutors.Rows[rowIndex].Cells[0].Text;
                string lastName = gvTutors.Rows[rowIndex].Cells[1].Text;
                string tutorName = firstName + " " + lastName;

                Response.Redirect("~/Pages/Requests.aspx?TutorID=" + tutorId +
                                  "&TutorName=" + Server.UrlEncode(tutorName) +
                                  "&SkillID=" + skillId);
            }
        }
    }
}
