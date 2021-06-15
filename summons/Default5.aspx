<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default5.aspx.cs" Inherits="Default5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<script type="text/javascript">
    $(document).ready(function () {
        SearchText();
    });
    function SearchText() {
        $(".autosuggest").autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Preferences.aspx/GetAutoCompleteData",
                    data: "{'Name':'" + document.getElementById('txtSearch').value + "'}",
                    dataType: "json",
                    success: function (data) {
                        response(data.d);
                    },
                    error: function (result) {
                        alert("Error");
                    }
                });
            }
        });
    }
</script>
</head>
<body>
<table style="width:auto">
    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" Text="Please Type Student Name:"></asp:Label>
        </td>
        <td>
            <input type="text" id="txtSearch" class="autosuggest" />
            <asp:TextBox ID="TextBox1" runat="server" Text=txtsearch Visible="true" class="autosuggest"></asp:TextBox>
        </td>
        <td>
            <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" style="height: 21px" />
        </td>
    </tr>
</table>
</body>
</html>
