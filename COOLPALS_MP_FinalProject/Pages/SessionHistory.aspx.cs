using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace COOLPALS_MP_FinalProject
{
    public partial class SessionHistory : Page
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

                LoadRequests();
            }
        }

        private void LoadRequests()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
                    SELECT
                        lr.RequestID,
                        u.FirstName + ' ' + u.LastName AS TutorName,
                        s.SkillName,
                        lr.Message,
                        lr.Availability,
                        lr.Status,
                        lr.RequestDate,
                        lr.ResponseDate,
                        lr.CompletedDate,
                        lr.CancelledDate
                    FROM LearningRequests lr
                    INNER JOIN Users u ON lr.TutorID = u.UserID
                    INNER JOIN Skills s ON lr.SkillID = s.SkillID
                    WHERE lr.LearnerID = @UserID OR lr.TutorID = @UserID
                    ORDER BY lr.RequestDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@UserID", userId);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvHistory.DataSource = dt;
                gvHistory.DataBind();
            }
        }

        protected void ddlActions_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddl.NamingContainer;
            HiddenField hfRequestID = (HiddenField)row.FindControl("hfRequestID");

            int requestId = Convert.ToInt32(hfRequestID.Value);

            if (ddl.SelectedValue == "Cancel")
            {
                UpdateRequestStatus(requestId, "Cancelled", null);
            }
            else if (ddl.SelectedValue == "Complete")
            {
                UpdateRequestStatus(requestId, "Completed", DateTime.Now);
            }
        }

        private void UpdateRequestStatus(int requestId, string status, DateTime? completedDate)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"UPDATE LearningRequests
                                 SET Status = @Status, CompletedDate = @CompletedDate
                                 WHERE RequestID = @RequestID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@CompletedDate", (object)completedDate ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@RequestID", requestId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadRequests(); 
        }

        private void CancelRequest(int requestId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"
            UPDATE LearningRequests
            SET Status = 'Cancelled',
                CancelledDate = CASE 
                    WHEN CancelledDate IS NULL THEN GETDATE()
                    ELSE CancelledDate
                END
            WHERE RequestID = @RequestID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@RequestID", requestId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvHistory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CancelRequest")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int requestId = Convert.ToInt32(gvHistory.DataKeys[rowIndex].Value);

                CancelRequest(requestId);
                LoadRequests();
            }
        }
    }
}
