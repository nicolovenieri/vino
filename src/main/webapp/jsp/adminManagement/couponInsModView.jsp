<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Coupon"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Inserimento coupon nel catalogo";

    Coupon coupon = (Coupon) request.getAttribute("coupon");
    String action=(coupon != null) ? "modify" : "insert";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>

    <script language="javascript">
        var status="<%=action%>"
        var now = Date.now();
        var NowDate = new Date(now)

        function DynamicFormCheck_int(e) {
            var EventTriggerName = (e.target.id);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo '" + EventTriggerName + "' richiede un numero");
        }


        function StaticFormCheck(){
            var discountValue = document.insModForm.discount.value;
            var data = Date.parse(document.insModForm.exp_date.value);
            /*var quantityValue = (document.insModForm.quantity.value);
            var alcoolValue = (document.insModForm.alcool.value);*/

            if(isNaN(discountValue)){
                alert("Il campo '% DI SCONTO' richiede un numero");
                return false;
            }

            return true;
        }

        function submitCoupon() {
            if (StaticFormCheck()) {

                document.insModForm.controllerAction.value = "CouponManagement."+status;
                document.insModForm.requestSubmit();
            }
        }

        function goback() {
            document.backForm.requestSubmit();
        }

        function mainOnLoadHandler() {
            document.insModForm.Invia.addEventListener("click", submitCoupon);
            document.insModForm.backButton.addEventListener("click", goback);
            document.insModForm.discount.addEventListener("change", DynamicFormCheck_int);
        }
    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="flex flex-col justify-center items-center pt-8 pb-8 bg-gray-500">
    <h1 class="my-4 uppercase tracking-wide no-underline hover:no-underline font-bold text-black text-xl"><%if (languageString.equals("ita")){%>Gestione<%}if (languageString.equals("eng")){ %>Management<% }%>: <%=(action.equals("modify")) ? "Modifica Coupon" : "Nuovo Coupon"%></h1>
    <section id="insModFormSection" class="w-2/5">
        <form name="insModForm" action="Dispatcher" method="post">
            <div class="field">
                <label class="font-medium" for="name"><%if (languageString.equals("ita")){%>Nome<%}if (languageString.equals("eng")){ %>Name<% }%></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="text" id="name" name="name"
                       value="<%=(action.equals("modify")) ? coupon.getName() : ""%>"
                       placeholder="Coupon name"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label class="font-medium" for="% di sconto"><%if (languageString.equals("ita")){%>Sconto (%)<%}if (languageString.equals("eng")){ %>Discount (%)<% }%></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="text" id="% di sconto" name="discount"
                       value="<%=(action.equals("modify")) ? coupon.getDiscount() : ""%>"
                       placeholder="10"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label class="font-medium" for="data di scadenza"><%if (languageString.equals("ita")){%>Data di scadenza<%}if (languageString.equals("eng")){ %>Date of expire<% }%></label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="date" id="data di scadenza" name="exp_date"
                       value="<%=(action.equals("modify")) ? coupon.getExp_date() : ""%>"
                       placeholder="2025-03-24"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field my-4">
                <input type="button" name ="Invia" class="bg-gray-700 hover:bg-green-500 hover:text-black text-white font-bold py-2 px-4 rounded-full w-20" value="<%if (languageString.equals("ita")){%>Invia<%}if (languageString.equals("eng")){ %>Done<% }%>"/>
                <input type="button" name="backButton" class="bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-24 ml-2" value="<%if (languageString.equals("ita")){%>Annulla<%}if (languageString.equals("eng")){ %>Delete<% }%>"/>
            </div>
            <%if (action.equals("modify")) {%>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="hidden" name="coupon_id" value="<%=coupon.getCouponId()%>"/>
            <%}%>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="hidden" name="controllerAction"/>
        </form>
    </section>

    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
    </form>

</main>
</body>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
</html>
