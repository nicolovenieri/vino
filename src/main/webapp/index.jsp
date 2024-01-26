<%@page session="false"%>
<%String contextPath=request.getContextPath();%>
<!DOCTYPE HTML>
<html lang="it-IT">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=<%=contextPath%>/Dispatcher">
    <script type="text/javascript">
        function onLoadHandler() {
            window.location.href = "<%=contextPath%>/Dispatcher";
        }
        window.addEventListener("load", onLoadHandler);
    </script>
    <title>Page Redirection</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter&display=swap" rel="stylesheet">
</head>
<body>
<p style="font-family: 'Inter', sans-serif; padding: 12px">If you are not redirected automatically, follow the <a href='<%=contextPath%>/Dispatcher'>link</a></p>
</body>
</html>