<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Cart"%>
<%@page import="com.vino.vino.model.mo.Coupon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.math.BigDecimal" %>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Checkout";

    List<Cart> carts = (List<Cart>) request.getAttribute("carts");
    User user = (User)request.getAttribute("user");

    Coupon coupon = null;

    BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal shipping = (BigDecimal) request.getAttribute("shipping");
    BigDecimal total_discounted = BigDecimal.ZERO;

    try{
        coupon = (Coupon)request.getAttribute("coupon"); //da passare al controller del checkout al momento dell'acquisto per effettuare lo sconto
        total_discounted = (BigDecimal)request.getAttribute("total_discounted"); //per motivazioni grafiche, necessario a visualizzare il nuovo prezzo dopo l'applicazione del coupon
    }
    catch(NullPointerException e) { }
%>

<!DOCTYPE html><html>
<head>
    <script lang="javascript">
        var now = Date.now();
        var NowDate = new Date(now)

        function ApplyCoupon() {
            if (document.getElementById("coupon_input").value=="")
                alert("Coupon non inserito")
            else {
                document.CouponApplyForm.coupon_name.value = document.getElementById("coupon_input").value;
                document.CouponApplyForm.requestSubmit();
            }
        }

        function DynamicFormCheck_int(e) {
            var EventTriggerName = (e.target.id);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo '" + EventTriggerName + "' richiede un numero");
        }

         function DynamicFormCheck_date(e) {
             var EventTriggerName = (e.target.id);
             var data = Date.parse("01/"+document.CompleteOrderForm.exp_date.value);


            if(data<now){
                alert("La tua carta \u00E8 scaduta, inserisci nel campo '" + EventTriggerName + "' una data superiore a "+NowDate.getMonth()+"/"+NowDate.getFullYear()+" (Oggi)");
            }
             if(isNaN(data)){
                 alert("Il campo '" + EventTriggerName + "' richiede una data");
             }

         }

        function StaticFormCheck(){
            var card_number =  document.CompleteOrderForm.card_n.value;
            var cvc = document.CompleteOrderForm.cvc.value;
            var data = Date.parse("01/"+document.CompleteOrderForm.exp_date.value);

            if(isNaN(card_number)){
                alert("Il campo 'NUMERO DI CARTA' richiede un numero");
                return false;
            }

            if(isNaN(cvc)){
                alert("Il campo 'CVC/CCV' richiede un numero");
                return false;
            }

            if(data<now){
                alert("La tua carta \u00E8 scaduta, inserisci nel campo 'DATA DI SCADENZA' una data superiore a "+NowDate.getMonth()+"/"+NowDate.getFullYear()+" (Oggi)");
                return false;
            }
            if(isNaN(data)){
                alert("Il campo 'DATA DI SCADENZA' richiede una data");
                return false;
            }

            return true;
        }

        function CompleteOrder(coupon_id) {
            if (StaticFormCheck()) {
            document.CompleteOrderForm.coupon_id.value = coupon_id;
            document.CompleteOrderForm.requestSubmit();
            }
        }


        function mainOnLoadHandler() {
            document.CompleteOrderForm.card_n.addEventListener("change", DynamicFormCheck_int);
            document.CompleteOrderForm.cvc.addEventListener("change", DynamicFormCheck_int);
            document.CompleteOrderForm.exp_date.addEventListener("change", DynamicFormCheck_date);
        }

    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
<body>
    <%@include file="/include/header.jsp"%>
    <div class="w-full flex justify-center items-center">
        <div class=" flex justify-center mt-8 w-2/3 pb-4">
            <p class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl">Checkout</p>
        </div>
    </div>
    <main class="flex justify-center mx-8">
        <section class="w-full flex flex-row flex-no-wrap justify-center">
            <section id="checkout-field" class="flex flex-col flex-wrap m-4 w-1/2">
                <div class="float">
                    <div class="float-right flex-row bg-gray-200 rounded-lg border-bg-gray-500 mx-2 my-4 p-4 w-2/3">
                        <div class="flex flex-col m-2">
                            <div class="border-b border-bg-gray-500">
                                <p class="font-bold pt-2 m-4">Info di pagamento</p>
                            </div>
                            <div class="m-4">
                                <label class="block text-grey-darker text-sm font-bold mb-2" for="Numero di Carta">
                                    Numero di Carta
                                </label>
                                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="Numero di Carta" name="card_n" type="text" placeholder="1234 1234 1234 1234"
                                       value="<%=(user.getCard_n() != null) ? user.getCard_n() : ""%>" maxlength="16" required>
                                <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                    <div class="mr-2">
                                        <label class="block text-grey-darker text-sm font-bold mb-2" for="CVC/CCV">
                                            CVC/CCV
                                        </label>
                                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="CVC/CCV" name="cvc" type="text" placeholder="567"
                                               value="<%=(user.getCvc() != 0) ? user.getCvc() : ""%>" maxlength="3" required>
                                    </div>
                                    <div class="ml-2">
                                        <label class="block text-grey-darker text-sm font-bold mb-2" for="Data di scadenza">
                                            Data di scadenza
                                        </label>
                                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="Data di scadenza" name="exp_date" type="text" placeholder="12/2026"
                                               value="<%=(user.getExp_date() != null) ? user.getExp_date() : ""%>" maxlength="7" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="float-right flex-row bg-gray-200 rounded-lg border-bg-gray-500 mx-2 my-4 p-4 w-2/3">
                        <div class="flex flex-col m-2">
                            <p class="font-bold pt-2 m-4 border-b border-bg-gray-400">Info di spedizione</p>
                            <div class="m-4">
                                <label class="block text-grey-darker text-sm font-bold mb-2" for="street">
                                    Via
                                </label>
                                <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="street" name="street" type="text" placeholder="Via Rossi"
                                       value="<%=(user.getStreet() != null) ? user.getStreet() : ""%>" maxlength="50" required>
                                <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                    <div class="mr-2">
                                        <label class="block text-grey-darker text-sm font-bold mb-2" for="civic">
                                            Civico
                                        </label>
                                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="civic" name="civic" type="text" placeholder="1"
                                               value="<%=(user.getCivic() != null) ? user.getCivic() : ""%>"maxlength="10" required>
                                    </div>
                                    <div class="mx-2">
                                        <label class="block text-grey-darker text-sm font-bold mb-2" for="cap">
                                            CAP
                                        </label>
                                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="cap" name="cap" type="text" placeholder="12345"
                                               value="<%=(user.getCap() != 0) ? user.getCap() : ""%>"maxlength="5" required>
                                    </div>
                                    <div class="ml-2">
                                        <label class="block text-grey-darker text-sm font-bold mb-2" for="city">
                                            Citta
                                        </label>
                                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="CompleteOrderForm" id="city" name="city" type="text" placeholder="Roma"
                                               value="<%=(user.getCity() != null) ? user.getCity() : ""%>" maxlength="30" required>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
           <section class="flex flex-col flex-wrap">
               <div class="mt-4 mx-4 order-1">
                   <div class="bg-gray-300 rounded-lg mx-4 my-4 p-4">
                       <p class="font-bold m-4">Coupon</p>
                       <div class="m-4 flex flex-col flex-wrap">
                           <input class="shadow appearance-none border border-red rounded w-3/4 py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="coupon_input" name="coupon_input"
                                  placeholder="SUMMER"
                                  required size="20" maxlength="48"/>
                           <div class="w-2/3 mt-4">
                               <a href="javascript:ApplyCoupon()" class="mb-2 bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full">
                                   Applica coupon
                               </a>
                           </div>
                       </div>
                   </div>
               </div>
               <div class="m-4 order-2">
                   <div class="bg-gray-300 rounded-lg mx-4 my-4 p-4">
                       <div class="border-b border-gray-400">
                           <p class="font-bold m-4">Riepilogo</p>
                       </div>
                       <section id="cart-list" class="=flex flex-col flex-wrap pt-2 p-2">
                           <%for (i = 0; i < carts.size(); i++) {%>
                           <div class="flex flex-row flex-no-wrap m-2 justify-between">
                               <p><span class="font-medium"><%=carts.get(i).getWine().getName()%></span>
                                   x<%=carts.get(i).getQuantity()%>
                               </p>
                               <p class="ml-4 text-2xl font-light"><%=carts.get(i).getWine().getPrice()%> &euro;</p>
                           </div>
                           <%}%>
                           <div class="m-2 md-6 flex flex-row flex-no-wrap justify-between border-t border-gray-400">
                               <div class="order-1 flex flex-col flex-wrap content-around pt-3">
                                   <%if(total_discounted==null){%>
                                   <p class="pb-4 font-bold text-xl">Totale (IVA inclusa)</p>
                                   <p class="pb-2">Subtotale</p>
                                   <p class="pb-2">Spedizione (5% del totale)</p>
                                   <%} else {%>
                                   <p class="pb-4 font-bold text-xl">Totale (IVA inclusa) (- <%=coupon.getDiscount()%>%)</p>
                                   <%}%>
                               </div>
                               <div class="order-2 flex flex-col flex-wrap content-around">
                                   <%if(total_discounted==null){%>
                                   <p class="pb-4 text-3xl"><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                   <p class="pb-2"><%=subtotal.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                   <p class="pb-2"><%=shipping.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                   <%} else {%>
                                   <p class="pb-4 text-3xl">
                                       <span class="line-through text-sm"><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</span>
                                        <%=total_discounted.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                                   <%}%>
                               </div>
                           </div>
                       </section>
                       <%if(coupon != null){%>
                       <a href="javascript:CompleteOrder(<%=coupon.getCouponId()%>)" class="zoom-animation m-4 bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-32">
                           Acquista
                       </a>
                       <%}else{%>
                       <a href="javascript:CompleteOrder()" class="zoom-animation m-4 bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-32">
                           Acquista
                       </a>
                       <%}%>
                       <button class="m-4 bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-32" type="submit" form="backForm">
                           Annulla
                       </button>
                   </div>
               </div>
           </section>
        </section>

        <form name="CompleteOrderForm" id="CompleteOrderForm" method="post" action="Dispatcher">
            <input type="hidden" name="coupon_id"/>
            <input type="hidden" name="controllerAction" value="CheckoutManagement.order"/>
        </form>

        <form name="backForm" id="backForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="HomeManagement.view"/>
        </form>

        <form name="CouponApplyForm" id="CouponApplyForm" method="post" action="Dispatcher">
            <input type="hidden" name="coupon_name"/>
            <input type="hidden" name="controllerAction" value="CouponManagement.Apply"/>
        </form>

    </main>
    <%@include file="/include/footer.jsp"%>
</body>
</html>
