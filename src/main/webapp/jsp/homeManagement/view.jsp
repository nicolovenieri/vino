<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="com.vino.vino.model.mo.Showcase" %>
<%@ page import="java.util.logging.Logger" %>
<%@ page import="com.vino.vino.services.logservice.LogService" %>
<%@ page import="java.util.logging.Level" %>

<%  Logger logger = LogService.getApplicationLogger();
    int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Homepage";

    List<Wine> wines = (List<Wine>) request.getAttribute("wines");
    List<Wine> showcase_wines = (List<Wine>) request.getAttribute("showcase_wines");


    //gestisco vini suggeriti
    List<Wine> preferred_wines = new ArrayList<Wine>();
    boolean preferencesEnable = false;
    try {
        if(request.getAttribute("preferred_wines") != null && loggedOn) {
            preferred_wines = (List<Wine>) request.getAttribute("preferred_wines");
        }

        if(!preferred_wines.isEmpty() && preferred_wines != null) {
            preferencesEnable = true;
        }
    } catch (NullPointerException e) {
        logger.log(Level.SEVERE, "JSP Error (preferred_wines)", e);
    }

    //gestisco posizione nella visualizzazione del catalogo
    int arrayPos = 0;
    int viewSize = 8;
    try {
        if(request.getAttribute("arrayPos") != null) {
            arrayPos = (Integer) request.getAttribute("arrayPos");
        }
    } catch (NullPointerException e) {
        logger.log(Level.SEVERE, "JSP Error (arrayPos)", e);
    }

    if(arrayPos + viewSize > wines.size()) {
        viewSize = wines.size() - arrayPos;
    }

    int forwardArrayPos = arrayPos + viewSize;
    int backwardArrayPos = arrayPos - 8;

    boolean defaultMode = true;
    boolean searchMode = false;
    boolean showcaseMode = false;

    //gestisco ricerca
    String searchedItem = "";
    try {
        if(request.getAttribute("searchMode") != null) {
            searchMode = (Boolean) request.getAttribute("searchMode");
        }
    } catch (NullPointerException e) {
        logger.log(Level.SEVERE, "JSP Error (searchMode)", e);
    }

    try {
        if(request.getAttribute("showcaseMode") != null) {
            showcaseMode = (Boolean)request.getAttribute("showcaseMode");
        }
    } catch (NullPointerException e) {
        logger.log(Level.SEVERE, "JSP Error (showcaseMode)", e);
    }

    if(searchMode) {
        searchedItem = (String) request.getAttribute("searchedItem");
    }


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

          function searchFunc(name) {
              f = document.searchForm;
              f.searchString.value = name;
              f.requestSubmit();
          }

          function AddToCart(wine_id) {
              alert("Aggiunto al carrello");
              document.AddToCartForm.wine_id.value = wine_id;
              document.AddToCartForm.requestSubmit();
          }

          function AddToWishlist(wine_id,language) {
              alert("Aggiunto alla wishlist");
              document.AddToWishlistForm.wine_id.value = wine_id;
              document.AddToWishlistForm.requestSubmit();
          }

          function mainOnLoadHandler() {}

      </script>
  </head>
  <body>
    <%@include file="/include/header.jsp"%>

    <div class="w-full flex justify-center">
        <div class="w-1/6 flex flex-row flex-no-wrap justify-center items-center m-4 p-2">
            <div class="flex items-center" id="store-nav-content">
                <div class="pt-2 relative mx-auto text-gray-600">
                    <form id="searchForm" name="searchForm" action="Dispatcher" method="post">
                        <input type="hidden" name="controllerAction" value="HomeManagement.searchView">
                        <input type="text" name="searchString" placeholder="<% if(languageString.equals("eng")){ %>Search<%} if(languageString.equals("ita")){ %>Ricerca <%}%>" class="border-2 border-gray-300 bg-white h-10 px-5 pr-16 rounded-lg text-sm focus:outline-none">
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
    <%if(!searchMode){%>
    <div class="w-full flex justify-center items-center my-4">
        <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl"><% if(languageString.equals("eng")){ %>Today's Wines<%} if(languageString.equals("ita")){ %>Vini del Giorno <%}%></h2>
    </div>

    <!-- CODICE DINAMICO DA VEDERE
    <div id="showcase" class="carousel container mx-auto p-6">
        <div class="carousel-inner relative overflow-hidden w-full rounded-md shadow-md">
            <% for(int k = 0; k < showcase_wines.size(); k++){ %>

    <input class="carousel-open" type="radio" id="carousel-<%= k+1 %>" name="carousel" aria-hidden="true" hidden="<%= k == 0 ? "" : "hidden" %>" <%= k == 0 ? "checked=checked" : "" %>>
    <div class="carousel-item absolute opacity-0" style="height:50vh;">
        <div class="block h-full w-full mx-auto flex pt-6 md:pt-0 md:items-center bg-cover bg-right" style="background-image: url('<%= showcase_wines.get(k).getProductImage() %>');">
            <div class="container mx-auto flex justify-center items-center">
                <div class="flex flex-col w-full lg:w-1/2 items-center px-6 tracking-wide">
                    <p class="text-white text-2xl my-4"><%= showcase_wines.get(k).getName() %></p>
                    <a class="text-white text-xl inline-block no-underline border-b border-gray-600 leading-relaxed hover:text-black hover:border-black" href="javascript:productViewFunc(<%= showcase_wines.get(k).getWineId() %>)">
                        <% if(languageString.equals("eng")){ %>View Product<% } if(languageString.equals("ita")){ %>Visualizza Prodotto<% } %>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <label for="carousel-<%= k == 0 ? showcase_wines.size() : k %>" class="prev control-<%= k+1 %> w-10 h-10 ml-2 md:ml-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900 leading-tight text-center z-10 inset-y-0 left-0 my-auto">
        <
    </label>
    <label for="carousel-<%= k == showcase_wines.size() - 1 ? 1 : k+2 %>" class="next control-<%= k+1 %> w-10 h-10 mr-2 md:mr-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900 leading-tight text-center z-10 inset-y-0 right-0 my-auto">
        >
    </label>
    <% } %>

    <ol class="carousel-indicators">
        <% for(int k = 0; k < showcase_wines.size(); k++){ %>
        <li class="inline-block mr-3">
            <label for="carousel-<%= k+1 %>" class="carousel-bullet cursor-pointer block text-4xl text-gray-400 hover:text-gray-900">.</label>
        </li>
        <% } %>
    </ol>
    </div>
    </div>
    -->

    <div id="showcase" class="carousel container mx-auto p-6">
        <div class="carousel-inner relative overflow-hidden w-full rounded-md shadow-md">
            <!--Slide 1-->
            <input class="carousel-open" type="radio" id="carousel-1" name="carousel" aria-hidden="true" hidden="" checked="checked">
            <div class="carousel-item absolute opacity-0" style="height:50vh;">
                <div class="block h-full w-full mx-auto flex pt-6 md:pt-0 md:items-center bg-cover bg-right" style="background-image: url('https://images.unsplash.com/photo-1562601579-599dec564e06?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80');">

                    <div class="container mx-auto flex justify-center items-center">
                        <div class="flex flex-col w-full lg:w-1/2 items-center px-6 tracking-wide">
                            <p class="text-white text-2xl my-4"><%=showcase_wines.get(0).getName()%></p>
                            <a class="text-white text-xl inline-block no-underline border-b border-gray-600 leading-relaxed hover:text-black hover:border-black" href="javascript:productViewFunc(<%=showcase_wines.get(0).getWineId()%>)"><% if(languageString.equals("eng")){ %>View Product<%} if(languageString.equals("ita")){ %>Visualizza Prodotto <%}%></a>
                        </div>
                    </div>
                </div>
            </div>
            <label for="carousel-3" class="prev control-1 w-10 h-10 ml-2 md:ml-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900 leading-tight text-center z-10 inset-y-0 left-0 my-auto">
                <
            </label>
            <label for="carousel-2" class="next control-1 w-10 h-10 mr-2 md:mr-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900 leading-tight text-center z-10 inset-y-0 right-0 my-auto">
                >
            </label>

            <!--Slide 2-->
            <input class="carousel-open" type="radio" id="carousel-2" name="carousel" aria-hidden="true" hidden="">
            <div class="carousel-item absolute opacity-0 bg-cover bg-right" style="height:50vh;">
                <div class="block h-full w-full mx-auto flex pt-6 md:pt-0 md:items-center bg-cover bg-right" style="background-image: url('https://images.unsplash.com/photo-1543060534-2c124acc29ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2550&q=80');">


                    <div class="container mx-auto flex justify-center items-center">
                        <div class="flex flex-col w-full lg:w-1/2 items-center px-6 tracking-wide">
                            <p class="text-white text-2xl my-4"><%=showcase_wines.get(1).getName()%></p>
                            <a class="text-white text-xl inline-block no-underline border-b border-gray-600 leading-relaxed hover:text-black hover:border-black" href="javascript:productViewFunc(<%=showcase_wines.get(1).getWineId()%>)"><% if(languageString.equals("eng")){ %>View Product<%} if(languageString.equals("ita")){ %>Visualizza Prodotto <%}%></a>
                        </div>
                    </div>

                </div>
            </div>
            <label for="carousel-1" class="prev control-2 w-10 h-10 ml-2 md:ml-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900  leading-tight text-center z-10 inset-y-0 left-0 my-auto">
                <
            </label>
            <label for="carousel-3" class="next control-2 w-10 h-10 mr-2 md:mr-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900  leading-tight text-center z-10 inset-y-0 right-0 my-auto">
                >
            </label>

            <!--Slide 3-->
            <input class="carousel-open" type="radio" id="carousel-3" name="carousel" aria-hidden="true" hidden="">
            <div class="carousel-item absolute opacity-0" style="height:50vh;">
                <div class="block h-full w-full mx-auto flex pt-6 md:pt-0 md:items-center bg-cover bg-bottom" style="background-image: url('https://images.unsplash.com/photo-1560089168-4169937e37d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1951&q=80');">


                    <div class="container mx-auto flex justify-center items-center">
                        <div class="flex flex-col w-full lg:w-1/2 items-center px-6 tracking-wide">
                            <p class="text-white text-2xl my-4"><%=showcase_wines.get(2).getName()%></p>
                            <a class="text-white text-xl inline-block no-underline border-b border-gray-600 leading-relaxed hover:text-black hover:border-black" href="javascript:productViewFunc(<%=showcase_wines.get(2).getWineId()%>)"><% if(languageString.equals("eng")){ %>View Product<%} if(languageString.equals("ita")){ %>Visualizza Prodotto <%}%></a>
                        </div>
                    </div>

                </div>
            </div>
            <label for="carousel-2" class="prev control-3 w-10 h-10 ml-2 md:ml-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900  leading-tight text-center z-10 inset-y-0 left-0 my-auto">
                <
            </label>
            <label for="carousel-1" class="next control-3 w-10 h-10 mr-2 md:mr-10 absolute cursor-pointer hidden text-3xl font-bold text-black hover:text-white rounded-full bg-white hover:bg-gray-900  leading-tight text-center z-10 inset-y-0 right-0 my-auto">
                >
            </label>

            <!-- Add additional indicators for each slide-->
            <ol class="carousel-indicators">
                <li class="inline-block mr-3">
                    <label for="carousel-1" class="carousel-bullet cursor-pointer block text-4xl text-gray-400 hover:text-gray-900">.</label>
                </li>
                <li class="inline-block mr-3">
                    <label for="carousel-2" class="carousel-bullet cursor-pointer block text-4xl text-gray-400 hover:text-gray-900">.</label>
                </li>
                <li class="inline-block mr-3">
                    <label for="carousel-3" class="carousel-bullet cursor-pointer block text-4xl text-gray-400 hover:text-gray-900">.</label>
                </li>
            </ol>

        </div>
    </div>
    <%}%>

    <main class="bg-white">

      <div class="container mx-auto flex flex-wrap pb-12">

          <nav id="page-title" class="w-full z-30 top-0 px-6 py-1">
              <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-2 py-3">
                  <%if(searchMode && !wines.isEmpty()){%>
                  <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl"><% if(languageString.equals("eng")){ %>Search results for<%} if(languageString.equals("ita")){ %>Risultato ricerca per<%}%> '<%=searchedItem%>'</h2>
                  <%}else if(showcaseMode && !wines.isEmpty()){%>
                  <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl"><% if(languageString.equals("eng")){ %>Showcase<%} if(languageString.equals("ita")){ %>Vetrina<%}%></h2>
                  <%} if(!wines.isEmpty() && !searchMode && !showcaseMode){%>
                  <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl"><% if(languageString.equals("eng")){ %>Store<%} if(languageString.equals("ita")){ %>Negozio<%}%></h2>
                  <%}%>
              </div>
          </nav>

          <%if(searchMode && wines.isEmpty()){%>
          <div class="w-full flex justify-center">
              <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl"><% if(languageString.equals("eng")){ %>No results for<%} if(languageString.equals("ita")){ %>Nessun risultato per<%}%> '<%=searchedItem%>'</h2>
          </div>
          <%}%>

          <%for (i = arrayPos; i < arrayPos + viewSize; i++) {%>
          <div class="relative w-full md:w-1/3 xl:w-1/4 sm:w-1/3 p-6 flex flex-col">
                  <%if(loggedOn){%>
                  <div>
                      <a class="absolute top-0 right-0 rounded-full bg-white z-50 mt-8 mr-8" href="javascript:AddToCart(<%=wines.get(i).getWineId()%>)">
                          <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui fill-current text-gray-700" width="24" height="24"><path d="M17 11a1 1 0 010 2h-4v4a1 1 0 01-2 0v-4H7a1 1 0 010-2h4V7a1 1 0 012 0v4h4z"/></svg>
                      </a>
                      <a class="absolute top-0 right-0 rounded-full bg-transparent z-50 mt-8 mr-16" href="javascript:AddToWishlist(<%=wines.get(i).getWineId()%>)">
                          <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui fill-current text-red-400" width="24" height="24" viewBox="0 0 20 20"><path d="M10 3.22l-.61-.6a5.5 5.5 0 00-7.78 7.77L10 18.78l8.39-8.4a5.5 5.5 0 00-7.78-7.77l-.61.61z"/></svg>
                      </a>
                  </div>
                  <%}%>
                  <a id="product-image" href="javascript:productViewFunc(<%=wines.get(i).getWineId()%>)">
                      <img src="<%=wines.get(i).getProductImage()%>" class="hover:shadow-lg rounded" alt="stock wine image">
                      <p class="pt-3 flex items-center justify-between text-gray-900 font-medium"><%=wines.get(i).getName()%></p>
                      <p class="pt-1 font-light text-xl subpixel-antialiased"><%=wines.get(i).getPrice()%> &euro;</p>
                  </a>
              </div>
          <%}%>
        </div>

        <%if(!searchMode && !showcaseMode){%>
        <div class="w-full mb-8 pb-8 flex justify-center items-center">
            <div class="inline-flex">

                <%if(arrayPos < 8) {%>
                <p class="bg-gray-200 text-gray-800 font-bold py-2 px-4 rounded-l">
                    <% if(languageString.equals("eng")){ %>Back<%} if(languageString.equals("ita")){ %>Precedente<%}%>
                </p>
                <%}else{%>
                <a class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-l"
                   href="javascript:backwardForm.requestSubmit()">
                    <% if(languageString.equals("eng")){ %>Back<%} if(languageString.equals("ita")){ %>Precedente<%}%>
                </a>
                <%}%>

            <%if(arrayPos + viewSize >= wines.size()) {%>
                <p class="bg-gray-200 text-gray-800 font-bold py-2 px-4 rounded-r">
                    <% if(languageString.equals("eng")){ %>Next<%} if(languageString.equals("ita")){ %>Successiva<%}%>
                </p>
                <%}else{%>
                <a class="bg-gray-300 hover:bg-gray-400 text-gray-800 font-bold py-2 px-4 rounded-r"
                   href="javascript:forwardForm.requestSubmit()">
                    <% if(languageString.equals("eng")){ %>Next<%} if(languageString.equals("ita")){ %>Successiva<%}%>
                </a>
                <%}%>
            </div>
        </div>
        <%}%>

<%--        vini suggeriti--%>
        <%if(preferencesEnable){%>
        <div class="w-full flex justify-center items-center my-4">
            <h2 class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-2xl"><% if(languageString.equals("eng")){ %>Wines of Category<%} if(languageString.equals("ita")){ %>Vini della Categoria<%}%> '<%=preferred_wines.get(0).getCategory()%>' <% if(languageString.equals("eng")){ %>Suggested<%} if(languageString.equals("ita")){ %>Consigliati<%}%></h2>
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

        <form name="showcaseViewForm" method="post" action="Dispatcher">
            <input type="hidden" name="controllerAction" value="HomeManagement.showcaseView"/>
        </form>

        <form name="productView" method="post" action="Dispatcher">
            <input type="hidden" name="wine_id"/>
            <input type="hidden" name="controllerAction" value="HomeManagement.productView"/>
        </form>

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

        <form name="backwardForm" method="post" action="Dispatcher">
            <input type="hidden" name="arrayPos" value="<%=backwardArrayPos%>"/>
            <input type="hidden" name="controllerAction" value="HomeManagement.changePage"/>
            <input type="hidden" name="viewUrl" value="homeManagement/view"/>
        </form>

        <form name="forwardForm" method="post" action="Dispatcher">
            <input type="hidden" name="arrayPos" value="<%=forwardArrayPos%>"/>
            <input type="hidden" name="controllerAction" value="HomeManagement.changePage"/>
            <input type="hidden" name="viewUrl" value="homeManagement/view"/>
        </form>

    </main>
    <%@include file="/include/footer.jsp"%>
  </body>
</html>