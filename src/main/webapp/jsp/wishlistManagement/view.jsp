<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="com.vino.vino.model.mo.Wishlist"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Homepage";
    List<Wishlist> wishlist_tuples = (List<Wishlist>) request.getAttribute("wishlist_tuples");

%>

<!DOCTYPE html>
<html>
  <head>
    <%@include file="/include/htmlHead.jsp"%>
      <script language="javascript">

          function productViewFunc(wine_id) {
              f = document.productView;
              f.wine_id.value = wine_id;
              f.requestSubmit();
          }

          function AddToCart(wine_id) {
              alert("Aggiunto al carrello");
              document.AddToCartForm.wine_id.value = wine_id;
              document.AddToCartForm.requestSubmit();
          }

          function RemoveFromWishlist(wine_id) {
              alert("Rimosso dalla wishlist");
              document.RemoveFromWishlistForm.wine_id.value = wine_id;
              document.RemoveFromWishlistForm.requestSubmit();
          }

          function mainOnLoadHandler() {}
      </script>
  </head>
  <body>
    <%@include file="/include/header.jsp"%>
    <main class="bg-white">
        <div class="container mx-auto flex flex-wrap pt-4 pb-12">
            <div class="flex justify-center w-full m-4 mt-8">
                <p class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl">Wishlist</p>
            </div>
            <div class="flex flex-col flex-wrap pt-4 pb-12">
                <%for (i = 0; i < wishlist_tuples.size(); i++) {%>
                <div class="w-full p-6 flex flex-row flex-no-wrap justify-between border-t border-gray-400">
                  <section class="flex flex-row flex-no-wrap flex-start order-1">
                      <div class="order-1 m-4 w-1/6">
                          <a id="single-item" href="javascript:productViewFunc(<%=wishlist_tuples.get(i).getWine().getWineId()%>)">
                              <img src="<%=wishlist_tuples.get(i).getWine().getProductImage()%>" class="rounded" alt="stock wine image">
                          </a>
                      </div>
                      <div class="order-2 m-4">
                          <div class="flex flex-col flex-wrap">
                              <div class="order-1 my-2">
                                  <p class="pt-1 text-gray-900 text-xl"><span class="font-medium uppercase">nome </span><%=wishlist_tuples.get(i).getWine().getName()%></p>
                                  <p class="pt-1"><span class="font-medium uppercase">annata </span><%=wishlist_tuples.get(i).getWine().getAnnata()%></p>
                                  <p class="pt-1 font-light text-2xl antialiased"><%=wishlist_tuples.get(i).getWine().getPrice()%> &euro;</p>
                              </div>
                          </div>
                      </div>
                  </section>
                  <section class="order-2 w-20 mt-4 flex flex-col flex-wrap w-32">
                      <div class="order-1 ml-4">
                          <div class="float ml-8">
                              <a href="javascript:AddToCart(<%=wishlist_tuples.get(i).getWine().getWineId()%>)" class="bg-gray-500 hover:bg-gray-700 text-white font-bold rounded-full flex flex-row flex-no-wrap justify-center px-1 py-2 w-24 mb-4">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white" d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white" d="M17 16a3 3 0 11-2.83 2H9.83a3 3 0 11-5.62-.1A3 3 0 015 12V4H3a1 1 0 110-2h3a1 1 0 011 1v1h14a1 1 0 01.9 1.45l-4 8a1 1 0 01-.9.55H5a1 1 0 000 2h12zM7 12h9.38l3-6H7v6zm0 8a1 1 0 100-2 1 1 0 000 2zm10 0a1 1 0 100-2 1 1 0 000 2z"/></svg>
                              </a>
                              <a href="javascript:RemoveFromWishlist(<%=wishlist_tuples.get(i).getWine().getWineId()%>)" class="bg-red-400 hover:bg-gray-700 text-white font-bold rounded-full flex flex-row flex-wrap justify-center px-1 py-2 w-24">
                                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-white mx-1" d="M8 6V4c0-1.1.9-2 2-2h4a2 2 0 012 2v2h5a1 1 0 010 2h-1v12a2 2 0 01-2 2H6a2 2 0 01-2-2V8H3a1 1 0 110-2h5zM6 8v12h12V8H6zm8-2V4h-4v2h4zm-4 4a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1zm4 0a1 1 0 011 1v6a1 1 0 01-2 0v-6a1 1 0 011-1z"/></svg>
                              </a>
                          </div>
                      </div>
                  </section>
                  </div>
                  <%}%>
            </div>
            <%if(wishlist_tuples.isEmpty()){%>
            <div class="text-center w-full flex justify-center items-center">
                <p class="font-medium mt-6">La Whishlist e' vuota.</p>
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

        <form name="RemoveFromWishlistForm" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="WishlistManagement.RemoveWine"/>
            <input type="hidden" name="viewUrl" value="wishlistManagement/view"/>
        </form>

        </main>
        <%@include file="/include/footer.jsp"%>
    </body>
</html>
