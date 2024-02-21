<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.math.BigDecimal" %>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Carrello";

    List<Cart> carts = (List<Cart>) request.getAttribute("carts");

    BigDecimal total_amount = (BigDecimal) request.getAttribute("total_amount");
    BigDecimal subtotal = (BigDecimal) request.getAttribute("subtotal");
    BigDecimal shipping = (BigDecimal) request.getAttribute("shipping");
%>

<!DOCTYPE html>
<html>
  <head>

    <%@include file="/include/htmlHead.jsp"%>
      <script language="javascript">

          function AddToCart(wine_id) {
              alert("Aggiunto al carrello");
              document.AddToCartForm.wine_id.value = wine_id;
              document.AddToCartForm.requestSubmit();
          }

          function RemoveFromCart(wine_id) {
              alert("Rimosso dal carrello");
              document.RemoveFromCartForm.wine_id.value = wine_id;
              document.RemoveFromCartForm.requestSubmit();
          }

          function RemoveBlockFromCart(wine_id) {
              alert("Rimosso dal carrello");
              document.RemoveBlockFromCartForm.wine_id.value = wine_id;
              document.RemoveBlockFromCartForm.requestSubmit();
          }

          function AddToWishlist(wine_id) {
              alert("Aggiunto alla wishlist");
              document.AddToWishlistForm.wine_id.value = wine_id;
              document.AddToWishlistForm.requestSubmit();
          }

          function DeleteCart() {
              alert("Carrello svuotato");
              document.DeleteCartForm.requestSubmit();
          }


          function mainOnLoadHandler() {}
      </script>
  </head>
  <body  class="bg-black">
    <%@include file="/include/header.jsp"%>
    <main class="bg-gray-500">
        <div class="container mx-auto flex flex-wrap justify-center items-center pt-4 pb-12">
            <div class="flex justify-center w-full m-4 mt-8">
                <p class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl"><%if (languageString.equals("ita")){%>Carrello<%}if (languageString.equals("eng")){ %>Cart<% }%></p>
            </div>
            <div class="flex flex-col flex-wrap pt-4 pb-12">
              <%for (i = 0; i < carts.size(); i++) {%>
                  <div class="w-full p-6 flex flex-row flex-no-wrap justify-between border-t border-gray-400">
                      <section class="flex flex-row flex-no-wrap flex-start order-1 w-4/5">
<%--                          <div class="order-1 m-4 w-1/6">--%>
<%--                              <img src="<%=carts.get(i).getWine().getProductImage()%>" class="rounded" alt="stock wine image">--%>
<%--                          </div>--%>
                          <a href="#" class="w-1/6">
                              <img src="<%=carts.get(i).getWine().getProductImage()%>" class="rounded" alt="stock wine image">
                          </a>
                          <div class="order-2 m-4">
                              <div class="flex flex-col flex-wrap">
                                  <div class="order-1 my-2">
                                      <p class="pt-1 text-gray-900 font-medium"><%=carts.get(i).getWine().getName()%> <span class="font-normal">(<%=carts.get(i).getWine().getPrice()%> &euro;)</span></p>
                                      <p class="pt-1"><span class="font-medium"><%if (languageString.equals("ita")){%>Annata<%}if (languageString.equals("eng")){ %>Wine age<% }%> </span><%=carts.get(i).getWine().getAnnata()%></p>
                                  </div>
                                  <div class="order-2 flex flex-row flex-no-wrap">
                                      <a href="javascript:RemoveFromCart(<%=carts.get(i).getWine().getWineId()%>)" class="order-1 w-12 m-2 bg-gray-700 hover:bg-red-500 text-white font-bold rounded-full px-1 py-2 flex flex-row flex-no-wrap justify-center">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white" d="M17 11a1 1 0 010 2H7a1 1 0 010-2h10z"/></svg>
                                      </a>
                                          <p class="order-2 m-2 text-black font-bold rounded-full flex flex-row flex-no-wrap justify-center px-1 py-2"><%=carts.get(i).getQuantity()%></p>
                                      <a href="javascript:AddToCart(<%=carts.get(i).getWine().getWineId()%>)" class="order-3 w-12 m-2 bg-gray-700 hover:bg-green-500 text-white font-bold rounded-full px-1 py-2 flex flex-row flex-no-wrap justify-center">
                                          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white order-2 mx-1" d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                                      </a>
                                  </div>
                              </div>
                          </div>
                      </section>
                      <section class="order-2 w-20 mt-4 flex flex-col flex-wrap w-1/5">
                          <div class="order-1 ml-4">
                              <p class="pt-1 font-light text-2xl"><%=carts.get(i).getWine().getPrice().multiply(new BigDecimal(carts.get(i).getQuantity()))%> &euro;</p>
                          </div>
                          <div class="order-2 mx-2 mt-4 w-32">
                              <a href="javascript:RemoveBlockFromCart(<%=carts.get(i).getWine().getWineId()%>)" class="bg-gray-700 hover:bg-red-500 text-white hover:text-black font-bold rounded-full flex flex-row flex-wrap justify-center px-1 py-2">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white order-2 mx-1" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                              </a>
                          </div>
                      </section>
                  </div>
              <%}%>
            </div>
            <%if(total_amount.compareTo(BigDecimal.ZERO) != 0) {%>
            <div class="w-full float m-2 p-6 bg-gray-400 border border-bg-gray-500 rounded-b-lg rounded-lg flex flex-row flex-no-wrap justify-between">
                <div class="order-1 m-4 p-2 flex flex-row flex-no-wrap justify-between w-1/3">
                    <div class="order-1 flex flex-col flex-wrap content-around">
                        <p class="pb-4 font-bold text-2xl"><%if (languageString.equals("ita")){%>Totale (IVA inclusa)<%}if (languageString.equals("eng")){ %>Total amount (IVA included)<% }%></p>
                        <p class="pb-2 pt-2"><%if (languageString.equals("ita")){%>Subtotale<%}if (languageString.equals("eng")){ %>Subtotal<% }%></p>
                        <p class="pb-2 pt-3"><%if (languageString.equals("ita")){%>Spedizione (5% del totale)<%}if (languageString.equals("eng")){ %>Shipping (5% from total)<% }%></p>
                    </div>
                    <div class="order-2 flex flex-col flex-wrap content-around">
                        <p class="pb-4 font-light text-3xl"><%=total_amount.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                        <p class="pb-2"><%=subtotal%> &euro;</p>
                        <p class="pb-2"><%=shipping.setScale(2, RoundingMode.CEILING)%> &euro;</p>
                    </div>
                </div>
                <div class="order-2 flex flex-col flex-wrap pr-8">
                    <button class="zoom-animation float-left bg-gray-700 hover:bg-green-500 text-white font-bold px-4 py-2 mt-6 rounded-full w-28" type="submit" form="CheckoutForm">
                        <%if (languageString.equals("ita")){%>Procedi al pagamento<%}if (languageString.equals("eng")){ %>Checkout<% }%>
                    </button>
                    <a href="javascript: DeleteCart()" class="float-left bg-red-400 hover:bg-gray-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-28" type="submit" form="">
                        <%if (languageString.equals("ita")){%>Svuota il carrello<%}if (languageString.equals("eng")){ %>Empty your cart<% }%>
                    </a>
                </div>
            </div>
            <%} else {%>
            <div class="text-center w-full">
                <p class="font-medium mt-6"><%if (languageString.equals("ita")){%>Il carrello e' vuoto, prendi qualcosa da bere<%}if (languageString.equals("eng")){ %>The cart is empty, take a look at the wines<% }%></p>
            </div>
            <%}%>
        </div>

        <form name="productView" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
        </form>

        <form name="AddToCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="CartManagement.AddWine"/>
            <input type="hidden" name="viewUrl" value="cartManagement/view"/>
        </form>

        <form name="RemoveFromCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="CartManagement.RemoveWine"/>
            <input type="hidden" name="viewUrl" value="cartManagement/view"/>
        </form>

        <form name="RemoveBlockFromCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="CartManagement.RemoveWineBlock"/>
            <input type="hidden" name="viewUrl" value="cartManagement/view"/>
        </form>

        <form name="AddToWishlistForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="WishlistManagement.AddWine"/>
        </form>

        <form name="DeleteCartForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="CartManagement.DeleteCart"/>
            <input type="hidden" name="viewUrl" value="cartManagement/view"/>
        </form>

        <form name="CheckoutForm" id="CheckoutForm" method="post" action="Dispatcher">
            <input type="hidden" name="cart_id"/>
            <input type="hidden" name="controllerAction" value="CheckoutManagement.view"/>
        </form>

    </main>
    <%@include file="/include/footer.jsp"%>
</html>
