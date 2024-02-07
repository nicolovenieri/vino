<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Coupon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Gestione Coupon";
    List<Coupon> Coupons = (List<Coupon>) request.getAttribute("coupons");
%>

<!DOCTYPE html>

<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function insertCoupon() {
            document.insertForm.requestSubmit();
        }

        function deleteCoupon(id) {
            document.deleteForm.coupon_id.value = id;
            document.deleteForm.requestSubmit();
        }

        function modifyCoupon(id) {
            document.modifyForm.coupon_id.value = id;
            document.modifyForm.requestSubmit();
        }

        function mainOnLoadHandler() {}

    </script>
</head>
<body>
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full flex flex-col justify-center items-center">
    <div class="mt-8 flex flex-row justify-between items-stretch">
        <p class="uppercase font-medium text-gray-800 text-xl"><%if (languageString.equals("ita")){%>Lista coupon<%}if (languageString.equals("eng")){ %>Coupons list<% }%></p>
        <a class="ml-2 mt-1" href="javascript:insertCoupon()">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm1-9h2a1 1 0 010 2h-2v2a1 1 0 01-2 0v-2H9a1 1 0 010-2h2V9a1 1 0 012 0v2z"/></svg>
        </a>
    </div>
    <div class="container mx-auto flex flex-wrap pb-12">
        <%for (i = 0; i < Coupons.size(); i++) {%>
        <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col">
            <div class="flex flex-no-wrap justify-start">
                <p class="float-left pt-0 text-gray-900 font-medium pr-4"><%=Coupons.get(i).getName()%></p>
                <p class="float-left pt-0 text-gray-700 font-medium pr-4">(<%=Coupons.get(i).getDiscount()%>%)</p>
                <%--            <p class="float-left pt-0 text-gray-700 font-medium pr-4"><%=Coupons.get(i).getExp_date()%></p>--%>
                <%--            <p class="float-left pt-0 text-gray-700 font-medium pr-4"><%=Coupons.get(i).getCouponId()%></p>--%>
            </div>
            <div class="float-right flex flex-no-wrap flex-row">
                <a href="javascript:modifyCoupon(<%=Coupons.get(i).getCouponId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui"  d="M9 4.58V4c0-1.1.9-2 2-2h2a2 2 0 012 2v.58a8 8 0 011.92 1.11l.5-.29a2 2 0 012.74.73l1 1.74a2 2 0 01-.73 2.73l-.5.29a8.06 8.06 0 010 2.22l.5.3a2 2 0 01.73 2.72l-1 1.74a2 2 0 01-2.73.73l-.5-.3A8 8 0 0115 19.43V20a2 2 0 01-2 2h-2a2 2 0 01-2-2v-.58a8 8 0 01-1.92-1.11l-.5.29a2 2 0 01-2.74-.73l-1-1.74a2 2 0 01.73-2.73l.5-.29a8.06 8.06 0 010-2.22l-.5-.3a2 2 0 01-.73-2.72l1-1.74a2 2 0 012.73-.73l.5.3A8 8 0 019 4.57zM7.88 7.64l-.54.51-1.77-1.02-1 1.74 1.76 1.01-.17.73a6.02 6.02 0 000 2.78l.17.73-1.76 1.01 1 1.74 1.77-1.02.54.51a6 6 0 002.4 1.4l.72.2V20h2v-2.04l.71-.2a6 6 0 002.41-1.4l.54-.51 1.77 1.02 1-1.74-1.76-1.01.17-.73a6.02 6.02 0 000-2.78l-.17-.73 1.76-1.01-1-1.74-1.77 1.02-.54-.51a6 6 0 00-2.4-1.4l-.72-.2V4h-2v2.04l-.71.2a6 6 0 00-2.41 1.4zM12 16a4 4 0 110-8 4 4 0 010 8zm0-2a2 2 0 100-4 2 2 0 000 4z"/></svg>
                </a>
                <a class="ml-2" href="javascript:deleteCoupon(<%=Coupons.get(i).getCouponId()%>)">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-red-400" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                </a>
            </div>
        </div>
        <%}%>
    </div>

    <%--        APPLICATION FORM--%>

    <form name="insertForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="CouponManagement.insertView"/>
    </form>
    <form name="deleteForm" method="post" action="Dispatcher">
        <input type="hidden" name="coupon_id"/>
        <input type="hidden" name="controllerAction" value="CouponManagement.delete"/>
    </form>
    <form name="modifyForm" method="post" action="Dispatcher">
        <input type="hidden" name="coupon_id"/>
        <input type="hidden" name="controllerAction" value="CouponManagement.modifyView"/>
    </form>
</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div></html>
