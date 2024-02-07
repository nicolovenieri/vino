<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
  boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  User loggedUser = (User) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  String menuActiveLink = "Interfaccia di amministrazione";
%>

<!DOCTYPE html>

<html>
  <head>
      <%@include file="/include/htmlHead.jsp"%>
      <script language="javascript">
          function mainOnLoadHandler() {}
      </script>
  </head>
  <body class="bg-yellow-200">
    <%@include file="/include/adminHeader.jsp"%>
    <main class="w-full flex flex-col justify-center items-center"  >
        <div class="my-6">
            <%--                 Utenti                   --%>
            <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:userManagementForm.requestSubmit()">
                    <p class="uppercase font-bold text-white text-2xl pr-2"><% if (languageString.equals("ita")) { %>Gestione Utenti<% } if( languageString.equals("eng")) { %>User Management<% }%></p>
                    <svg fill="#000000" width="40px" height="40px" viewBox="0 0 24 24" id="user" data-name="Flat Color" xmlns="http://www.w3.org/2000/svg" class="icon flat-color"><path id="primary" d="M21,20a2,2,0,0,1-2,2H5a2,2,0,0,1-2-2,6,6,0,0,1,6-6h6A6,6,0,0,1,21,20Zm-9-8A5,5,0,1,0,7,7,5,5,0,0,0,12,12Z" style="fill: rgb(255, 255, 255);"></path></svg>
                </a>
            </div>
                <%--                 Vini                   --%>
            <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:wineManagementForm.requestSubmit()"">
                    <p class="uppercase font-bold text-white text-2xl pr-2"><% if (languageString.equals("ita")) { %>Gestione Vini <% } if( languageString.equals("eng")) { %>Wine Management<% }%></p>
                    <svg style="fill: rgb(255, 255, 255)" width="40px" height="40px" viewBox="0 0 24 24" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/">
                    <g>
                        <rect height="6" width="12" y="1" x="6" fill="#ecf0f1"/>
                        <path d="m11 14h2v2h-2z" fill="#7f8c8d"/>
                        <path d="m6 1v1 7c0 3.314 2.6863 6 6 6 3.314 0 6-2.686 6-6v-7-1h-1v1 6.4688c0 3.0582-2.239 5.5312-5 5.5312-2.7614 0-5-2.473-5-5.5312v-6.4688-1h-1z" fill="#bdc3c7"/>
                        <path d="m7 6v1 1 0.4688c0 3.0582 2.2386 5.5312 5 5.5312 2.761 0 5-2.473 5-5.5312v-0.4688-1-1h-10z" fill="#e74c3c"/>
                        <path d="m11 16h2v6h-2z" fill="#95a5a6"/>
                        <path d="m7 22h10v1h-10z" fill="#bdc3c7"/>
                        <path d="m7 6h10v1h-10z" fill="#c0392b"/>
                        <path d="m7 2v7c0 2.761 2.2386 5 5 5 2.761 0 5-2.239 5-5v-7h-1v4.0312 2.9688c0 2.209-1.791 4-4 4-2.2091 0-4-1.791-4-4v-2.9688-4.0312h-1z" fill="#ecf0f1"/>
                    </g>
                </svg>
                </a>
            </div>
                <%--                 Showcase                   --%>
            <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:showcaseManagementForm.requestSubmit()">
                    <p class="uppercase font-bold text-white text-2xl pr-2"><% if (languageString.equals("ita")) { %>Gestione Vetrina <% } if( languageString.equals("eng")) { %>Showcase Management<% }%></p>
                    <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M6 6c0-1.4 0-2.1.272-2.635a2.5 2.5 0 0 1 1.093-1.093C7.9 2 8.6 2 10 2h4c1.4 0 2.1 0 2.635.272a2.5 2.5 0 0 1 1.092 1.093C18 3.9 18 4.6 18 6v12c0 1.4 0 2.1-.273 2.635a2.5 2.5 0 0 1-1.092 1.092C16.1 22 15.4 22 14 22h-4c-1.4 0-2.1 0-2.635-.273a2.5 2.5 0 0 1-1.093-1.092C6 20.1 6 19.4 6 18V6zm14 0a1 1 0 1 1 2 0v12a1 1 0 1 1-2 0V6zM3 5a1 1 0 0 0-1 1v12a1 1 0 1 0 2 0V6a1 1 0 0 0-1-1z" fill="#000000" style="fill: rgb(255, 255, 255)"/></svg>                </a>
            </div>
                <%--                 Coupon                   --%>
            <div class="order-1 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 flex flex-row justify-between items-stretch w-auto rounded w-full uppercase py-4 px-6" href="javascript:couponManagementForm.requestSubmit()">
                    <p class="uppercase font-bold text-white text-2xl pr-2"><% if (languageString.equals("ita")) { %>Gestione Coupon <% } if( languageString.equals("eng")) { %>Coupon Management<% }%></p>
                    <svg style="fill: rgb(255, 255, 255)" fill="#000000" width="40px" height="40px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" d="M15,6 C15,6.55228475 14.5522847,7 14,7 C13.4477153,7 13,6.55228475 13,6 L3,6 L3,7.99946819 C4.2410063,8.93038753 5,10.3994926 5,12 C5,13.6005074 4.2410063,15.0696125 3,16.0005318 L3,18 L13,18 C13,17.4477153 13.4477153,17 14,17 C14.5522847,17 15,17.4477153 15,18 L21,18 L21,16.0005318 C19.7589937,15.0696125 19,13.6005074 19,12 C19,10.3994926 19.7589937,8.93038753 21,7.99946819 L21,6 L15,6 Z M23,18 C23,19.1045695 22.1045695,20 21,20 L3,20 C1.8954305,20 1,19.1045695 1,18 L1,14.8880798 L1.49927404,14.5992654 C2.42112628,14.0660026 3,13.0839642 3,12 C3,10.9160358 2.42112628,9.93399737 1.49927404,9.40073465 L1,9.11192021 L1,6 C1,4.8954305 1.8954305,4 3,4 L21,4 C22.1045695,4 23,4.8954305 23,6 L23,9.11192021 L22.500726,9.40073465 C21.5788737,9.93399737 21,10.9160358 21,12 C21,13.0839642 21.5788737,14.0660026 22.500726,14.5992654 L23,14.8880798 L23,18 Z M14,16 C13.4477153,16 13,15.5522847 13,15 C13,14.4477153 13.4477153,14 14,14 C14.5522847,14 15,14.4477153 15,15 C15,15.5522847 14.5522847,16 14,16 Z M14,13 C13.4477153,13 13,12.5522847 13,12 C13,11.4477153 13.4477153,11 14,11 C14.5522847,11 15,11.4477153 15,12 C15,12.5522847 14.5522847,13 14,13 Z M14,10 C13.4477153,10 13,9.55228475 13,9 C13,8.44771525 13.4477153,8 14,8 C14.5522847,8 15,8.44771525 15,9 C15,9.55228475 14.5522847,10 14,10 Z"/>
                    </svg>
                </a>
            </div>
        </div>

        <form name="wineManagementForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="WineManagement.view"/>
        </form>

        <form name="userManagementForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="UserManagement.view"/>
        </form>
        <form name="couponManagementForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="CouponManagement.view"/>
        </form>

        <form name="showcaseManagementForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="ShowcaseManagement.view"/>
        </form>

    </main>
    <div class="fixed w-full bottom-0 bg-yellow-300">
        <%@include file="/include/adminFooter.jsp"%>
    </div>
</html>
