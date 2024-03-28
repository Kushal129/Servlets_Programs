<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="cie.admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Admin Page</h2>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Text=""></asp:Label>
            <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" OnRowDeleting="gvEvents_RowDeleting" DataKeyNames="Id">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Event ID" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" />
                    <asp:BoundField DataField="EventDateTime" HeaderText="Event Date & Time" DataFormatString="{0:MM/dd/yyyy hh:mm tt}" />
                    <asp:BoundField DataField="EventOption" HeaderText="Event Option" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:CommandField ShowDeleteButton="True" ButtonType="Button" DeleteText="Delete" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
