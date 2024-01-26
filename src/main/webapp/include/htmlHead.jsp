<meta charset="utf-8"/>
<link rel="stylesheet" type="text/css" href="styles/output/main.css" media="screen" charset="UTF-8">
<title>Polifenoli: <%=menuActiveLink%></title>
<script>
  var applicationMessage;
  <%if (applicationMessage != null) {%>
    applicationMessage="<%=applicationMessage%>";
  <%}%>
  function onLoadHandler() {
    try { mainOnLoadHandler(); } catch (e) { alert(e); }

    if (applicationMessage != undefined) { alert(applicationMessage); }
  }
  window.addEventListener("load", onLoadHandler);
</script>