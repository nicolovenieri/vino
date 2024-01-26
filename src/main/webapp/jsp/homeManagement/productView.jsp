<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@ page import="java.util.List" %>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    Wine wine = (Wine)request.getAttribute("wine");
    String menuActiveLink = wine.getName();

    List<Wine> preferred_wines = null;
    boolean preferencesEnable = false;
    try {
        preferred_wines = (List<Wine>) request.getAttribute("preferred_wines");
        if(!preferred_wines.isEmpty() && preferred_wines != null) {
            preferencesEnable = true;
        }
    } catch (NullPointerException e) { }
    int i;
%>

<!DOCTYPE html>
<html>
<head>
    <script language="javascript">

        function AddToCart(wine_id) {
            alert("Aggiunto al carrello");
            document.AddToCartForm.wine_id.value = wine_id;
            document.AddToCartForm.requestSubmit();
        }

        function AddToWishlist(wine_id) {
            alert("Aggiunto alla wishlist");
            document.AddToWishlistForm.wine_id.value = wine_id;
            document.AddToWishlistForm.requestSubmit();
        }

        function productViewFunc(wine_id) {
            f = document.productView;
            f.wine_id.value = wine_id;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
    <body>
        <%@include file="/include/header.jsp"%>
        <main class="w-full">
            <%--PRODUCT DATA--%>
            <div id="main-container" class="flex flex-col px-32 mb-8">
                <%if(!loggedOn){%>
                <div class="w-1/2 mx-auto container bg-gray-100 rounded-md mt-12 py-4 flex flex-row justify-start">
                    <div class="ml-4 mr-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui fill-current text-gray-500" d="M12 22a10 10 0 110-20 10 10 0 010 20zm0-2a8 8 0 100-16 8 8 0 000 16zm0-9a1 1 0 011 1v4a1 1 0 01-2 0v-4a1 1 0 011-1zm0-4a1 1 0 110 2 1 1 0 010-2z"/></svg>
                    </div>
                    <p>Loggati per aggiungere un prodotto al carrello</p>
                </div>
                <%}%>
                <div class="flex flex-row">
                    <div id="image-section" class="float w-1/2 py-12 pr-8 mt-5 md:flex-shrink-0">
                        <img class="float-right rounded-md w-1/2 max-w-md" src="<%=wine.getProductImage()%>" alt="stock wine image">
                    </div>
                    <section id="info-section" class="w-1/2 py-12">
                        <h1 class="pt-3 text-gray-900 font-bold text-2xl"><%=wine.getName()%></h1>
                        <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Vitigni
                    </span><%=wine.getVitigni()%>
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                   <span class="font-medium text-lg">
                       Alcool
                   </span> <%=wine.getAlcool()%>%
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Formato
                    </span><%=wine.getFormat()%>l
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Annata
                    </span><%=wine.getAnnata()%>
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Denominazione
                    </span><%=wine.getDenominazione()%>
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                    <span class="font-medium text-lg">
                        Temperatura di servizio
                    </span><%=wine.getTemperature()%>c
                        </p>
                        <p class="pt-3 text-gray-900 text-3xl">
                            <%=wine.getPrice()%> &euro;
                        </p>
                        <%if(loggedOn){%>
                        <div class="float">
                            <a class="zoom-animation float-left bg-gray-700 hover:bg-blue-dark text-white font-bold px-4 py-2 mt-6 rounded-full w-28" href="javascript:AddToCart(<%=wine.getWineId()%>)">
                                Aggiungi al carrello
                            </a>
                            <a class="zoom-animation float-left bg-red-400 hover:bg-blue-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-28" href="javascript:AddToWishlist(<%=wine.getWineId()%>)">
                                Aggiungi alla Wishlist
                            </a>
                        </div>
                        <%}%>
                    </section>
                </div>
                <section class="mx-auto container p-4 border-t border-gray-300">
                    <h1 class="my-4 pt-3 text-gray-900 font-bold text-2xl">Note di degustazione</h1>
                    <p><%=wine.getDescription()%></p>
                </section>
            </div>

            <%if(preferencesEnable){%>
            <div class="flex justify-center items-center my-">
                <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl">Vini della categoria '<%=preferred_wines.get(0).getCategory()%>' consigliati</h2>
            </div>
            <section id="suggested-products" class="container mx-auto flex flex-wrap mt-4 mb-8">
                <%for(i = 0; i < preferred_wines.size(); i++){%>
                <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col">
                    <%if(loggedOn){%>
                    <div>
                        <a class="absolute top-0 right-0 rounded-full bg-white z-50 mt-8 mr-8" href="javascript:AddToCart(<%=preferred_wines.get(i).getWineId()%>)">
                            <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui fill-current text-gray-700" width="24" height="24"><path d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                        </a>
                        <a class="absolute top-0 right-0 rounded-full bg-transparent z-50 mt-8 mr-16" href="javascript:AddToWishlist(<%=preferred_wines.get(i).getWineId()%>)">
                            <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui fill-current text-red-400" width="24" height="24" viewBox="0 0 20 20"><path d="M10 3.22l-.61-.6a5.5 5.5 0 00-7.78 7.77L10 18.78l8.39-8.4a5.5 5.5 0 00-7.78-7.77l-.61.61z"/></svg>
                        </a>
                    </div>
                    <%}%>
                    <a href="javascript:productViewFunc(<%=preferred_wines.get(i).getWineId()%>)">
                        <img src="<%=preferred_wines.get(i).getProductImage()%>" class="hover:shadow-lg rounded" alt="stock wine image">
                        <p class="pt-3 flex items-center justify-between text-gray-900 font-medium"><%=preferred_wines.get(i).getName()%></p>
                        <p class="pt-1 font-light text-xl subpixel-antialiased"><%=preferred_wines.get(i).getPrice()%> &euro;</p>
                    </a>
                </div>
                <%}%>
            </section>
            <%}%>

                <form name="AddToCartForm" method="post" action="Dispatcher">
                    <input type="hidden" name="wine_id"/>
                    <input type="hidden" name="controllerAction" value="CartManagement.AddWine"/>
                    <input type="hidden" name="viewUrl" value="homeManagement/view"/>
                </form>

                <form name="AddToWishlistForm" method="post" action="Dispatcher">
                    <input type="hidden" name="wine_id"/>
                    <input type="hidden" name="controllerAction" value="WishlistManagement.AddWine"/>
                    <input type="hidden" name="viewUrl" value="homeManagement/view"/>
                </form>

                <form name="productView" method="post" action="Dispatcher">
                    <input type="hidden" name="wine_id"/>
                    <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
                </form>

        </main>
    <%@include file="/include/footer.jsp"%>
    </body>
</html>