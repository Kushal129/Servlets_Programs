using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cie
{
    public partial class user : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
            
        string conn = "Data Source=LAPTOP-PQJ1JGEE\\SQLEXPRESS;Initial Catalog=test;Integrated Security=True";
        protected void btnAddEvent_Click(object sender, EventArgs e)
        {

            string fullName = txtEventFullName.Text;
            string contactNumber = txtContactNumber.Text;
            DateTime eventDateTime = DateTime.Parse(txtEventDateTime.Text);
            string eventOption = ddlEventOption.SelectedValue;
            string description = txtDescription.Text;

            using (SqlConnection con = new SqlConnection(conn))
            {
                string query = "INSERT INTO Events (FullName, ContactNumber, EventDateTime, EventOption, Description) VALUES (@FullName, @ContactNumber, @EventDateTime, @EventOption, @Description)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@FullName", fullName);
                    cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                    cmd.Parameters.AddWithValue("@EventDateTime", eventDateTime);
                    cmd.Parameters.AddWithValue("@EventOption", eventOption);
                    cmd.Parameters.AddWithValue("@Description", description);

                    try
                    {
                        con.Open();
                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Event added successfully.');", true);
                        }
                        else
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Failed to add event. Please try again.');", true);
                        }
                    }
                    catch (Exception ex)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
                    }
                }
            }
        }
    }
}