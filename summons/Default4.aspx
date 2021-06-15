<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default4.aspx.cs" Inherits="Default4" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script>
        function GetUserValue() {
            var person = prompt("請再次輸入傳票編號", "");
            if (person != null && person != "") {
                //document.getElementById("<%=hdnUserInput.ClientID%>").value = person;
                document.getElementById(($("#hdnUserInput1")
                return true;
            }
            else
                return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:LinkButton Text="Test" ID="lnkButton" OnClick="lnkButton_Click" OnClientClick="return GetUserValue();" runat="server" />
            <asp:HiddenField runat="server" ID="hdnUserInput" />
        </div>
    </form>
</body>
</html>