<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="user.aspx.cs" Inherits="cie.user" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Add Event</h2>
            <div>
                <asp:Label ID="lblEventFullName" runat="server" Text="Full Name:"></asp:Label>
                <asp:TextBox ID="txtEventFullName" runat="server"></asp:TextBox>
            </div>
            <div>
                <asp:Label ID="lblContactNumber" runat="server" Text="Contact Number:"></asp:Label>
                <asp:TextBox ID="txtContactNumber" runat="server"></asp:TextBox>
            </div>
            <div>
                <asp:Label ID="lblEventDateTime" runat="server" Text="Event Date & Time:"></asp:Label>
                <asp:TextBox ID="txtEventDateTime" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
            </div>
            <div>
                <asp:Label ID="lblEventOption" runat="server" Text="Event Option:"></asp:Label>
                <asp:DropDownList ID="ddlEventOption" runat="server">
                    <asp:ListItem Text="Engagement" Value="Engagement"></asp:ListItem>
                    <asp:ListItem Text="Marriage" Value="Marriage"></asp:ListItem>
                    <asp:ListItem Text="Birthday" Value="Birthday"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <asp:Label ID="lblDescription" runat="server" Text="Description:"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>
            <div>
                <asp:Button ID="btnAddEvent" runat="server" Text="Add Event" OnClick="btnAddEvent_Click" />
            </div>
        </div>
    </form>
</body>
</html>
