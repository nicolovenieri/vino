<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Showcase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Vetrina";
    List<Showcase> showcases = (List<Showcase>) request.getAttribute("showcases");
    List<Wine> wines = (List<Wine>) request.getAttribute("wines");
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function insertShowcase() {
            document.insertForm.requestSubmit();
        }

        function deleteElement(wine_id) {
            document.deleteForm.wine_id.value = wine_id;
            document.deleteForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center">
    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-medium text-gray-800 text-xl"> <%if (languageString.equals("ita")){%>Vetrina<%}if (languageString.equals("eng")){ %>Showcase<% }%></p>
    </div>

    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-medium text-gray-800 text-xl"> <%if (languageString.equals("ita")){%>Vini presenti in vetrina<%}if (languageString.equals("eng")){ %>Showcase's Wines<% }%></p>
        <a class="ml-2 mt-1" href="javascript:insertWineForm.requestSubmit()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>

    <div class="container mx-auto flex flex-wrap pb-12">
        <%for (i = 0; i < showcases.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col">
            <p class="float-left pt-3 text-gray-900 font-medium pr-4"><%=wines.get(i).getName()%></p>
            <div class="float-right flex flex-no-wrap flex-row">
                <a class="ml-2" href="javascript:deleteElement(<%=showcases.get(i).getWineId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertWineForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="ShowcaseManagement.delete"/>
    </form>

</main>
<div class="w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
</html>
