using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;


namespace COOLPALS_MP_FinalProject
{
    public partial class Login : Page
    {
        protected void LoginUser(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validation: required fields
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "Email and password are required.";
                return;
            }

            // Validation: email format
            if (!email.Contains("@") || !email.Contains("."))
            {
                lblMessage.Text = "Please enter a valid email address.";
                return;
            }

            // Ensures that the password is at least 6 characters long
            if (password.Length < 6)
            {
                lblMessage.Text = "Password must be at least 6 characters long.";
                return;
            }
            int userId = AuthenticateUser(email, password);

            if (userId > 0)
            {
                string role = GetUserRole(userId);

                // Successful login
                Session["UserID"] = userId;
                Session["Role"] = role;

                if (role == "Admin")
                {
                    Response.Redirect("~/Pages/AdminDashboard.aspx");
                }
                else
                {
                    Response.Redirect("~/Pages/Default.aspx");
                }
            }
            else
            {
                // Invalid credentials
                lblMessage.Text = "Invalid email or password.";
            }
        }

        private string GetUserRole(int userId)
        {
            string role = "";

            string connString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT Role FROM Users WHERE UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        role = result.ToString();
                    }
                }
            }

            return role;
        }

        private int AuthenticateUser(string email, string password)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["PairEdDBConnection"].ConnectionString;
            string hashedPassword = HashPassword(password);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"SELECT UserID, FirstName, LastName, Email
                                 FROM Users
                                 WHERE Email = @Email AND PasswordHash = @PasswordHash AND IsActive = 1";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int userId = Convert.ToInt32(reader["UserID"]);

                            // Save important user data in Session
                            Session["UserID"] = userId;
                            Session["FirstName"] = reader["FirstName"].ToString();
                            Session["LastName"] = reader["LastName"].ToString();
                            Session["Email"] = reader["Email"].ToString();

                            return userId;
                        }
                    }
                }
            }

            return -1;
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));

                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }

                return builder.ToString();
            }
        }
    }
}
