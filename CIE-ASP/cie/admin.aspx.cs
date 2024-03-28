using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace cie
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEventsGridView(); 
            }
        }

        string conn = "Data Source=LAPTOP-PQJ1JGEE\\SQLEXPRESS;Initial Catalog=test;Integrated Security=True";
        protected void BindEventsGridView()
        {

            using (SqlConnection connection = new SqlConnection(conn))
            {
                string query = "SELECT Id, FullName, ContactNumber, EventDateTime, EventOption, Description FROM Events";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        connection.Open();
                        SqlDataAdapter adapter = new SqlDataAdapter(command);
                        DataTable dtEvents = new DataTable();
                        adapter.Fill(dtEvents);

                        if (dtEvents.Rows.Count > 0)
                        {
                            gvEvents.DataSource = dtEvents;
                            gvEvents.DataBind();
                        }
                        else
                        {
                            gvEvents.DataSource = null;
                            gvEvents.DataBind();
                            lblMessage.Text = "No events found.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
        }

        protected void gvEvents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int eventId = Convert.ToInt32(gvEvents.DataKeys[e.RowIndex].Value);

            using (SqlConnection connection = new SqlConnection(conn))
            {
                string query = "DELETE FROM Events WHERE Id = @Id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", eventId);

                    try
                    {
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblMessage.Text = "Event deleted successfully.";
                            BindEventsGridView();
                        }
                        else
                        {
                            lblMessage.Text = "Failed to delete event.";
                        }
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
        }
    }
}