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

            if( data<now || isNaN(data)){
               alert("Il campo 'DATA DI SCADENZA' richiede una data superiore a "+NowDate.getDate()+"/"+NowDate.getMonth()+"/"+NowDate.getFullYear()+" (Oggi)");
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
<body>
<%@include file="/include/adminHeader.jsp"%>
<main class="flex flex-col justify-center items-center pt-8 pb-8">
    <h1 class="my-4 uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl">Gestione: <%=(action.equals("modify")) ? "Modifica Coupon" : "Nuovo Coupon"%></h1>
    <section id="insModFormSection" class="w-2/5">
        <form name="insModForm" action="Dispatcher" method="post">
            <div class="field">
                <label class="font-medium" for="name">Nome</label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="text" id="name" name="name"
                       value="<%=(action.equals("modify")) ? coupon.getName() : ""%>"
                       placeholder="SUMMER"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label class="font-medium" for="% di sconto">% di sconto</label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="text" id="% di sconto" name="discount"
                       value="<%=(action.equals("modify")) ? coupon.getDiscount() : ""%>"
                       placeholder="50"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field">
                <label class="font-medium" for="data di scadenza">Data di Scadenza</label>
                <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3 mt-1" type="date" id="data di scadenza" name="exp_date"
                       value="<%=(action.equals("modify")) ? coupon.getExp_date() : ""%>"
                       placeholder="2020-11-25"
                       required size="20" maxlength="50"/>
            </div>
            <div class="field my-4">
                <input type="button" name ="Invia" class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-20" value="Invia"/>
                <input type="button" name="backButton" class="bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-24 ml-2" value="Annulla"/>
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
<%@include file="/include/adminFooter.jsp"%>
</body>

</html>
