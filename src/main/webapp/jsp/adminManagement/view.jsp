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
  <body>
    <%@include file="/include/adminHeader.jsp"%>
    <main class="w-full flex flex-col justify-center items-center">
        <div class="my-6">
            <div class="order-1 mt-8 flex flex-row justify-between items-stretch">
                <a class="bg-gray-700 hover:opacity-75 rounded w-full uppercase font-bold text-white text-2xl py-2 px-6" href="javascript:userManagementForm.requestSubmit()">Gestione Utenti</a>
            </div>
            <div class="order-2 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 rounded w-full uppercase font-bold text-white text-2xl py-2 px-6" href="javascript:wineManagementForm.requestSubmit()">Gestione Vini</a>
            </div>
            <div class="order-3 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 rounded w-full uppercase font-bold text-white text-2xl py-2 px-6" href="javascript:showcaseManagementForm.requestSubmit()">Gestione Vetrina</a>
            </div>
            <div class="order-4 mt-8 flex flex-row justify-between items-stretch w-auto">
                <a class="bg-gray-700 hover:opacity-75 rounded w-full uppercase font-bold text-white text-2xl py-2 px-6" href="javascript:couponManagementForm.requestSubmit()">Gestione Coupon</a>
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
    <div class="fixed w-full bottom-0">
        <%@include file="/include/adminFooter.jsp"%>
    </div>
</html>
