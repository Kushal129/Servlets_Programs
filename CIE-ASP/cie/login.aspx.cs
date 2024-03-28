using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cie
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        string conn = "Data Source=LAPTOP-PQJ1JGEE\\SQLEXPRESS;Initial Catalog=test;Integrated Security=True";

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;

            using (SqlConnection con = new SqlConnection(conn))
            {
                string query = "SELECT FullName, Password, Role FROM Users WHERE Email = @Email";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Email", email);

                try
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        string fullName = reader.GetString(0);
                        string dbPassword = reader.GetString(1);
                        byte roleByte = reader.GetByte(2);
                        string role = roleByte.ToString();

                        if (password == dbPassword)
                        {
                            if (role == "0")
                            {
                                Session["UserName"] = fullName;
                                Response.Redirect("admin.aspx");
                                return;
                            }
                            else if (role == "1")
                            {
                                Session["UserName"] = fullName;
                                Response.Redirect("user.aspx");
                                return;
                            }
                        }
                        else
                        {
                            lblError.Text = "Invalid password. Please try again.";
                        }
                    }
                    else
                    {
                        lblError.Text = "User not found. Please register.";
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }

    }
}