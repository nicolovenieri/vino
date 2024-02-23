<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Vini";
    List<Wine> wines = (List<Wine>) request.getAttribute("wines");

    int maxViewSize;
    if(wines.size() < 8) {
        maxViewSize = wines.size();
    } else{
        maxViewSize = 8;
    }
    try {
        maxViewSize = (Integer) request.getAttribute("maxViewSize");
    } catch (NullPointerException e) {}

%>

<!DOCTYPE html>

<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function insertWine() {
            document.insertForm.requestSubmit();
        }

        function deleteWine(id) {
            document.deleteForm.wine_id.value = id;
            document.deleteForm.requestSubmit();
        }

        function modifyWine(id) {
            document.modifyForm.wine_id.value = id;
            document.modifyForm.requestSubmit();
        }

        function searchFunc(name) {
            f = document.searchForm;
            f.searchString.value = name;
            f.requestSubmit();
        }

        function maxViewSizeInc(maxViewSize) {

            <%if((maxViewSize + 8) > wines.size()) {%>
            document.loadMoreForm.maxViewSize.value = <%=wines.size()%>;
            <%} else {%>
            document.loadMoreForm.maxViewSize.value = maxViewSize + 8;
            <%}%>
            document.loadMoreForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center bg-gray-500">
    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-bold text-black text-xl"><%if (languageString.equals("ita")){%>Lista vini<%}if (languageString.equals("eng")){ %>Wines list<% }%></p>
        <a class="ml-2 mt-1" href="javascript:insertWine()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>
    <div class="w-full flex justify-center">
        <div class="flex flex-row flex-no-wrap justify-between items-center m-4">
            <div class="flex items-center" id="store-nav-content">
                <div class="pt-2 relative mx-auto text-gray-600">
                    <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="WineManagement.searchView">
                        <input type="text" name="searchString" placeholder="<%if (languageString.equals("ita")){%>Cerca nome vino<%}if (languageString.equals("eng")){ %>Find wine name<% }%>" class="border-2 border-gray-300 bg-white h-10 px-5 pr-16 rounded-lg text-sm focus:outline-none">
                        <button type="submit" form="searchForm" class="absolute right-0 top-0 mt-5 mr-4">
                            <svg class="text-gray-600 h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg"
                                 xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px"
                                 viewBox="0 0 56.966 56.966" style="enable-background:new 0 0 56.966 56.966;" xml:space="preserve"
                                 width="512px" height="512px">
                                <path d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23  s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.92,2.162,0.92  c0.779,0,1.518-0.297,2.079-0.837C56.255,54.982,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17  s-17-7.626-17-17S14.61,6,23.984,6z" />
                            </svg>
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container mx-auto flex flex-wrap pb-12">
        <%for (i = 0; i < maxViewSize; i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col border">
            <div class="order-1 w-full flex flex-col flex-wrap items-center justify-between py-6 px-4">
                <section id="wine-info" class="w-full flex pb-2">
                    <p class="float-left text-gray-900 font-medium pr-4"><%=wines.get(i).getName()%></p>
                </section>
                <section id="wine-avalaibility" class="pt-2 w-full flex p-1 border-t border-gray-400">
                    <p><%if (languageString.equals("ita")){%>Quantita' disponibile in magazzino<%}if (languageString.equals("eng")){ %>Stock available quantity<% }%> <%=wines.get(i).getAvalaibility()%></p>
                </section>
            </div>
            <div class="order-2 float-right flex flex-no-wrap flex-row mx-4">
                <a href="javascript:modifyWine(<%=wines.get(i).getWineId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M9 4.58V4c0-1.1.9-2 2-2h2a2 2 0 012 2v.58a8 8 0 011.92 1.11l.5-.29a2 2 0 012.74.73l1 1.74a2 2 0 01-.73 2.73l-.5.29a8.06 8.06 0 010 2.22l.5.3a2 2 0 01.73 2.72l-1 1.74a2 2 0 01-2.73.73l-.5-.3A8 8 0 0115 19.43V20a2 2 0 01-2 2h-2a2 2 0 01-2-2v-.58a8 8 0 01-1.92-1.11l-.5.29a2 2 0 01-2.74-.73l-1-1.74a2 2 0 01.73-2.73l.5-.29a8.06 8.06 0 010-2.22l-.5-.3a2 2 0 01-.73-2.72l1-1.74a2 2 0 012.73-.73l.5.3A8 8 0 019 4.57zM7.88 7.64l-.54.51-1.77-1.02-1 1.74 1.76 1.01-.17.73a6.02 6.02 0 000 2.78l.17.73-1.76 1.01 1 1.74 1.77-1.02.54.51a6 6 0 002.4 1.4l.72.2V20h2v-2.04l.71-.2a6 6 0 002.41-1.4l.54-.51 1.77 1.02 1-1.74-1.76-1.01.17-.73a6.02 6.02 0 000-2.78l-.17-.73 1.76-1.01-1-1.74-1.77 1.02-.54-.51a6 6 0 00-2.4-1.4l-.72-.2V4h-2v2.04l-.71.2a6 6 0 00-2.41 1.4zM12 16a4 4 0 110-8 4 4 0 010 8zm0-2a2 2 0 100-4 2 2 0 000 4z"/></svg>
                </a>
                <a class="ml-2" href="javascript:deleteWine(<%=wines.get(i).getWineId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>

        <div class="w-full m-4 flex justify-center items-center">
            <%if(maxViewSize == wines.size()){%>
            <p class="bg-gray-500 text-white font-bold py-2 px-4 rounded-full"><%if (languageString.equals("ita")){%>Altri<%}if (languageString.equals("eng")){ %>Others<% }%></p>
            <%} else {%>

            <a class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full"
               href="javascript:maxViewSizeInc(<%=maxViewSize%>)">
                <%if (languageString.equals("ita")){%>Altri<%}if (languageString.equals("eng")){ %>Others<% }%>
            </a>
            <%}%>
        </div>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="WineManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="WineManagement.delete"/>
    </form>
    <form name="modifyForm" method="post" action="Dispatcher">
        <input type="hidden" name="wine_id"/>
        <input type="hidden" name="controllerAction" value="WineManagement.modifyView"/>
    </form>

    <form name="loadMoreForm" method="post" action="Dispatcher">
        <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>"/>
        <input type="hidden" name="controllerAction" value="WineManagement.view"/>
    </form>

</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
