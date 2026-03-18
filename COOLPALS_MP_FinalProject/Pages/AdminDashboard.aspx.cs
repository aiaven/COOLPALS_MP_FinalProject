using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class AdminDashboard : Page
    {
        private string connString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Pages/Login.aspx");
                return;
            }

            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Pages/Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadUsers();
                LoadCategories();
                LoadRequests();
                ShowTab("Users");
            }
        }

        private void ShowTab(string tabName)
        {
            pnlUsers.Visible = tabName == "Users";
            pnlCategories.Visible = tabName == "Categories";
            pnlRequests.Visible = tabName == "Requests";
        }

        protected void ShowUsersTab(object sender, EventArgs e) { ShowTab("Users"); }
        protected void ShowCategoriesTab(object sender, EventArgs e) { ShowTab("Categories"); }
        protected void ShowRequestsTab(object sender, EventArgs e) { ShowTab("Requests"); }

        private void ShowMessage(string message, bool isError = false)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = isError ? "msg-error" : "msg-success";
            lblMessage.Visible = true;
        }

        // ── LOAD ─────────────────────────────────────────────────────────────
        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT UserID, FirstName, LastName, Email, Role, IsActive
                                 FROM Users ORDER BY UserID";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT CategoryID, CategoryName, Description
                                 FROM SkillCategories ORDER BY CategoryID";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCategories.DataSource = dt;
                gvCategories.DataBind();
            }
        }

        private void LoadRequests()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT lr.RequestID,
                           learner.FirstName + ' ' + learner.LastName AS Learner,
                           tutor.FirstName   + ' ' + tutor.LastName   AS Tutor,
                           s.SkillName AS Skill,
                           lr.Status,
                           lr.RequestDate
                    FROM   LearningRequests lr
                    INNER JOIN Users  learner ON lr.LearnerID = learner.UserID
                    INNER JOIN Users  tutor   ON lr.TutorID   = tutor.UserID
                    INNER JOIN Skills s       ON lr.SkillID   = s.SkillID
                    ORDER BY lr.RequestDate DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvRequests.DataSource = dt;
                gvRequests.DataBind();
            }
        }

        // ── USERS ─────────────────────────────────────────────────────────────

        // Hides all buttons on the admin's own row
        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            int currentAdminId = Convert.ToInt32(Session["UserID"]);
            int rowUserId = Convert.ToInt32(gvUsers.DataKeys[e.Row.RowIndex].Value);

            if (rowUserId == currentAdminId)
            {
                // Clear every control in the actions cell and show a dash
                int lastCell = e.Row.Cells.Count - 1;
                e.Row.Cells[lastCell].Controls.Clear();
                e.Row.Cells[lastCell].Text = "<span class=\"row-locked\">— your account</span>";
            }
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Edit is fully disabled for Users — block server-side
            ShowMessage("Editing user details is not permitted.", true);
            ShowTab("Users");
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            LoadUsers();
            ShowTab("Users");
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Blocked — no editing allowed
            ShowMessage("Editing user details is not permitted.", true);
            gvUsers.EditIndex = -1;
            LoadUsers();
            ShowTab("Users");
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int currentAdminId = Convert.ToInt32(Session["UserID"]);
            int targetUserId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            // Block deactivating own account
            if (targetUserId == currentAdminId)
            {
                ShowMessage("You cannot deactivate your own account.", true);
                ShowTab("Users");
                return;
            }

            // Block deactivating another Admin
            string targetRole = gvUsers.Rows[e.RowIndex].Cells[4].Text.Trim();
            if (targetRole == "Admin")
            {
                ShowMessage("You cannot deactivate another Admin account.", true);
                ShowTab("Users");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET IsActive = 0 WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", targetUserId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadUsers();
            ShowMessage("User deactivated successfully.");
            ShowTab("Users");
        }

        // ── CATEGORIES ────────────────────────────────────────────────────────
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string categoryName = txtCategoryName.Text.Trim();
            string description = txtCategoryDescription.Text.Trim();

            if (string.IsNullOrWhiteSpace(categoryName))
            {
                ShowMessage("Category name is required.", true);
                ShowTab("Categories");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string checkDupe = "SELECT COUNT(*) FROM SkillCategories WHERE CategoryName = @Name";
                SqlCommand checkCmd = new SqlCommand(checkDupe, conn);
                checkCmd.Parameters.AddWithValue("@Name", categoryName);
                int exists = (int)checkCmd.ExecuteScalar();

                if (exists > 0)
                {
                    ShowMessage("A category with that name already exists.", true);
                    ShowTab("Categories");
                    return;
                }

                string query = @"INSERT INTO SkillCategories (CategoryName, Description)
                                 VALUES (@CategoryName, @Description)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                cmd.Parameters.AddWithValue("@Description",
                    string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);
                cmd.ExecuteNonQuery();
            }

            txtCategoryName.Text = "";
            txtCategoryDescription.Text = "";
            LoadCategories();
            ShowMessage("Category added successfully.");
            ShowTab("Categories");
        }

        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            LoadCategories();
            ShowTab("Categories");
        }

        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            LoadCategories();
            ShowTab("Categories");
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvCategories.Rows[e.RowIndex];
            string categoryName = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string description = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();

            if (string.IsNullOrWhiteSpace(categoryName))
            {
                ShowMessage("Category name cannot be empty.", true);
                ShowTab("Categories");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string checkDupe = "SELECT COUNT(*) FROM SkillCategories WHERE CategoryName = @Name AND CategoryID <> @ID";
                SqlCommand checkCmd = new SqlCommand(checkDupe, conn);
                checkCmd.Parameters.AddWithValue("@Name", categoryName);
                checkCmd.Parameters.AddWithValue("@ID", categoryId);
                int dupe = (int)checkCmd.ExecuteScalar();

                if (dupe > 0)
                {
                    ShowMessage("Another category with that name already exists.", true);
                    ShowTab("Categories");
                    return;
                }

                string query = @"UPDATE SkillCategories
                                 SET CategoryName = @CategoryName, Description = @Description
                                 WHERE CategoryID = @CategoryID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                cmd.Parameters.AddWithValue("@Description",
                    string.IsNullOrWhiteSpace(description) ? (object)DBNull.Value : description);
                cmd.Parameters.AddWithValue("@CategoryID", categoryId);
                cmd.ExecuteNonQuery();
            }

            gvCategories.EditIndex = -1;
            LoadCategories();
            ShowMessage("Category updated successfully.");
            ShowTab("Categories");
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string checkQuery = "SELECT COUNT(*) FROM Skills WHERE CategoryID = @CategoryID";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@CategoryID", categoryId);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    ShowMessage("Cannot delete this category because it is used by existing skills.", true);
                    ShowTab("Categories");
                    return;
                }

                string deleteQuery = "DELETE FROM SkillCategories WHERE CategoryID = @CategoryID";
                SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                deleteCmd.Parameters.AddWithValue("@CategoryID", categoryId);
                deleteCmd.ExecuteNonQuery();
            }

            LoadCategories();
            ShowMessage("Category deleted successfully.");
            ShowTab("Categories");
        }

        // ── REQUESTS ──────────────────────────────────────────────────────────
        protected void gvRequests_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvRequests.EditIndex = e.NewEditIndex;
            LoadRequests();
            ShowTab("Requests");
        }

        protected void gvRequests_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvRequests.EditIndex = -1;
            LoadRequests();
            ShowTab("Requests");
        }

        protected void gvRequests_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int requestId = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvRequests.Rows[e.RowIndex];
            string status = ((TextBox)row.Cells[4].Controls[0]).Text.Trim();

            string[] validStatuses = { "Pending", "Accepted", "Declined", "Cancelled", "Completed" };
            if (Array.IndexOf(validStatuses, status) < 0)
            {
                ShowMessage("Invalid status. Allowed: Pending, Accepted, Declined, Cancelled, Completed.", true);
                ShowTab("Requests");
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    UPDATE LearningRequests
                    SET Status        = @Status,
                        ResponseDate  = CASE WHEN @Status IN ('Accepted','Declined') AND ResponseDate  IS NULL THEN GETDATE() ELSE ResponseDate  END,
                        CompletedDate = CASE WHEN @Status = 'Completed'              AND CompletedDate IS NULL THEN GETDATE() ELSE CompletedDate END,
                        CancelledDate = CASE WHEN @Status = 'Cancelled'              AND CancelledDate IS NULL THEN GETDATE() ELSE CancelledDate END
                    WHERE RequestID = @RequestID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@RequestID", requestId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvRequests.EditIndex = -1;
            LoadRequests();
            ShowMessage("Request updated successfully.");
            ShowTab("Requests");
        }

        protected void gvRequests_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int requestId = Convert.ToInt32(gvRequests.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "DELETE FROM LearningRequests WHERE RequestID = @RequestID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@RequestID", requestId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadRequests();
            ShowMessage("Request deleted successfully.");
            ShowTab("Requests");
        }
    }
}