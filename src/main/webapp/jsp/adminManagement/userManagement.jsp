<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Utenti";
    List<User> users = (List<User>) request.getAttribute("users");

    int maxViewSize;
    if(users.size() < 8) {
        maxViewSize = users.size();
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

        function searchFunc(name) {
            f = document.searchForm;
            f.searchString.value = name;
            f.requestSubmit();
        }

        function setAdmin(id) {
            document.setAdminForm.user_id.value = id;
            document.setAdminForm.requestSubmit();
        }

        function orderManagement(user_id) {
            document.orderManagementForm.user_id.value = user_id;
            document.orderManagementForm.requestSubmit();
        }

        function deleteUser(id) {
            document.deleteForm.user_id.value = id;
            document.deleteForm.requestSubmit();
        }

        function maxViewSizeInc(maxViewSize) {

            <%if((maxViewSize + 8) > users.size()) {%>
            document.loadMoreForm.maxViewSize.value = <%=users.size()%>;
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
        <p class="uppercase font-bold text-black text-xl"><%if(languageString.equals("ita")){%>Lista Utenti<%}if(languageString.equals("eng")){%>User List<%}%></p>
    </div>
    <div class="w-full flex justify-center">
        <div class="w-1/6 flex flex-row flex-no-wrap justify-center items-center m-4 p-2">
            <div class="flex items-center" id="store-nav-content">
                <div class="pt-2 relative mx-auto text-gray-600">
                    <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="UserManagement.searchView">
                        <input type="text" name="searchString" placeholder="<%if(languageString.equals("ita")){%>Trova NomeUtente<%}if(languageString.equals("eng")){%>Find Username<%}%>" class="border-2 border-gray-300 bg-white h-10 px-5 pr-16 rounded-lg text-sm focus:outline-none">
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
        <%for (i = 0; i < users.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col border" >
            <div class="float-left flex flex-no-wrap justify-between items-center ">
                <div class="flex flex-col flex-wrap justify-start items-start">
                    <div class="flex flex-row flex-no-wrap justify-center items-center">
                        <a href="javascript:orderManagement(<%=users.get(i).getUserId()%>)" class="pt-3 text-gray-900 font-bold pr-4"><%=users.get(i).getName()%> <%=users.get(i).getSurname()%></a>
                        <%if(users.get(i).isAdmin()){%>
                            <p class="pt-3 text-green-600 font-bold ml-1"><%if(languageString.equals("ita")){%>Amministratore<%}if(languageString.equals("eng")){%>Admin User<%}%></p>
                        <%}%>
                    </div>
                    <p class="pt-3 text-gray-900 font-normal text-sm pr-4">
                        <span class="font-medium"><%if(languageString.equals("ita")){%>Nome Utente<%}if(languageString.equals("eng")){%>Username<%}%></span> <%=users.get(i).getUsername()%>
                        <span class="font-medium"><%if(languageString.equals("ita")){%>Id Utente<%}if(languageString.equals("eng")){%>User Id<%}%></span> (<%=users.get(i).getUserId()%>)
                    </p>
                </div>
            </div>
            <div class="float-right flex flex-no-wrap flex-row">
                <%if(!users.get(i).isAdmin()){%>
                <a href="javascript:setAdmin(<%=users.get(i).getUserId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-green-600" d="M11.85 17.56a1.5 1.5 0 01-1.06.44H10v.5c0 .83-.67 1.5-1.5 1.5H8v.5c0 .83-.67 1.5-1.5 1.5H4a2 2 0 01-2-2v-2.59A2 2 0 012.59 16l5.56-5.56A7.03 7.03 0 0115 2a7 7 0 11-1.44 13.85l-1.7 1.71zm1.12-3.95l.58.18a5 5 0 10-3.34-3.34l.18.58L4 17.4V20h2v-.5c0-.83.67-1.5 1.5-1.5H8v-.5c0-.83.67-1.5 1.5-1.5h1.09l2.38-2.39zM18 9a1 1 0 01-2 0 1 1 0 00-1-1 1 1 0 010-2 3 3 0 013 3z"/></svg>
                </a>
                <%}else{%>
                <a href="javascript:setAdmin(<%=users.get(i).getUserId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-gray-700" d="M11.85 17.56a1.5 1.5 0 01-1.06.44H10v.5c0 .83-.67 1.5-1.5 1.5H8v.5c0 .83-.67 1.5-1.5 1.5H4a2 2 0 01-2-2v-2.59A2 2 0 012.59 16l5.56-5.56A7.03 7.03 0 0115 2a7 7 0 11-1.44 13.85l-1.7 1.71zm1.12-3.95l.58.18a5 5 0 10-3.34-3.34l.18.58L4 17.4V20h2v-.5c0-.83.67-1.5 1.5-1.5H8v-.5c0-.83.67-1.5 1.5-1.5h1.09l2.38-2.39zM18 9a1 1 0 01-2 0 1 1 0 00-1-1 1 1 0 010-2 3 3 0 013 3z"/></svg>
                </a>
                <%}%>
                <a class="ml-2" href="javascript:deleteUser(<%=users.get(i).getUserId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
        <div class="w-full m-4 flex justify-center items-center">
            <%if(maxViewSize == users.size()){%>
            <p class="bg-blue-400 text-white font-bold py-2 px-4 rounded-full"><%if(languageString.equals("ita")){%>Altro<%}if(languageString.equals("eng")){%>More<%}%></p>
            <%} else {%>

            <a class="bg-blue-400 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full"
               href="javascript:maxViewSizeInc(<%=maxViewSize%>)">
                <%if(languageString.equals("ita")){%>Altri<%}if(languageString.equals("eng")){%>More<%}%>
            </a>
            <%}%>
        </div>
    </div>

    <%--        APPLICATION FORM--%>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.delete"/>
    </form>

    <form name="setAdminForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.setAdmin"/>
    </form>

    <form name="orderManagementForm" method="post" action="Dispatcher">
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="controllerAction" value="UserManagement.orderModView"/>
    </form>

    <form name="loadMoreForm" method="post" action="Dispatcher">
        <input type="hidden" name="maxViewSize" value="<%=maxViewSize%>"/>
        <input type="hidden" name="controllerAction" value="UserManagement.view"/>
    </form>

</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
