<%@ page import="com.vino.vino.model.mo.Language" %><%


    //setto la lingua di default a italiano se non è selezionata nessuna lingua

    Language language = (Language)request.getAttribute("language");
    String languageString = (language != null) ? language.getLanguage() : null;
    System.out.println("jsp" + languageString);
    if ((!"ita".equals(languageString) && !"eng".equals(languageString) && !"ven".equals(languageString))) {
        languageString = "ita";
    }
%>
<script language="javascript">
  function accountViewFunc(user_id) {
      f = document.accountView;
      f.user_id.value = user_id;
      f.requestSubmit();
  }

  function myordersViewFunc(user_id) {
      f = document.myordersView;
      f.user_id.value = user_id;
      f.requestSubmit();
  }

  function setCategoryFunc(category) {
      f = document.categoryView;
      f.category.value = category;
      f.requestSubmit();
  }


</script>
<header class="w-full z-30 top-0 py-1 bg-black">
  <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-6 py-3">

    <nav class="hidden md:flex md:items-center md:w-auto w-full order-3 md:order-2">
      <ul class="md:flex items-center justify-between text-base text-gray-100 pt-4 md:pt-0">
        <li><a class="inline-block no-underline hover:text-red-200 hover:underline py-2 px-4" href="javascript:setCategoryFunc('Rosso')">Rossi</a></li>
        <li><a class="inline-block no-underline  hover:text-red-200 hover:underline py-2 px-4" href="javascript:setCategoryFunc('Bianco')">Bianchi</a></li>
        <li><a class="inline-block no-underline hover:text-red-200 hover:underline py-2 px-4" href="javascript:setCategoryFunc('Champagne')">Champagne</a></li>
        <li><a class="inline-block no-underline  hover:text-red-200 hover:underline py-2 px-4" href="javascript:setCategoryFunc('Altro')">Altro</a></li>
      </ul>
    </nav>

      <a id="logo" href="Dispatcher?controllerAction=HomeManagement.view" class="order-1 md:order-1 flex items-center tracking-wider no-underline hover:no-underline font-bold text-white text-2xl"><% if(languageString.equals("eng")){ %>FerlaVenieri Winery<%} if(languageString.equals("ita")){ %>Cantina FerlaVenieri <%}%></a>
      <div class="order-2 md:order-3 flex items-center p-4">
          <div  class="hover-trigger relative inline-block">
              <div class="relative inline-block">
                  <svg fill="#000000" width="24px" height="24px" viewBox="0 0 24 24" id="user" data-name="Flat Color" xmlns="http://www.w3.org/2000/svg" class="icon flat-color"><path id="primary" d="M21,20a2,2,0,0,1-2,2H5a2,2,0,0,1-2-2,6,6,0,0,1,6-6h6A6,6,0,0,1,21,20Zm-9-8A5,5,0,1,0,7,7,5,5,0,0,0,12,12Z" style="fill: rgb(255, 255, 255);"></path></svg>
              </div>
              <div class="hover-target absolute hidden bg-gray-700 text-white rounded px-2 shadow-lg py-4 m-0 z-50">
                  <%if(!loggedOn) {%>
                  <a class="hover:bg-gray-800 block py-2 px-4 w-full" href="javascript:loginForm.requestSubmit()"><% if(languageString.equals("eng")){ %>Login<%} if(languageString.equals("ita")){ %>Accedi <%}%></a>
                  <a class="hover:bg-gray-800 block py-2 px-4 w-full" href="javascript:registerForm.requestSubmit()"><% if(languageString.equals("eng")){ %>Register<%} if(languageString.equals("ita")){ %>Registrati <%}%></a>
                  <%} else {%>
                  <a class="hover:bg-gray-800 block py-2 px-4 w-full" href="javascript:accountViewFunc(<%=loggedUser.getUserId()%>)"><% if(languageString.equals("eng")){ %>Account<%} if(languageString.equals("ita")){ %>Profilo <%}%></a>
                  <a class="hover:bg-gray-800 block py-2 px-4 w-full" href="javascript:myordersViewFunc(<%=loggedUser.getUserId()%>)"><% if(languageString.equals("eng")){ %>Orders<%} if(languageString.equals("ita")){ %>Ordini <%}%></a>
                  <a class="hover:bg-gray-800 block py-2 px-4 w-full" href="javascript:logoutForm.requestSubmit()"><% if(languageString.equals("eng")){ %>Logout<%} if(languageString.equals("ita")){ %>Esci <%}%></a>
                  <%}%>
              </div>
          </div>
          <%if(loggedOn){%>
          <section>
              <%if(loggedUser.isAdmin()){%>
              <a id="admin" href="javascript:AdminZone.requestSubmit()" class="pl-3 inline-block relative">
              <svg style="fill: rgb(255, 255, 255)" width="24px" height="24px" viewBox="0 0 1920 1920" xmlns="http://www.w3.org/2000/svg">
                  <path d="M983.727 5.421 1723.04 353.62c19.765 9.374 32.414 29.252 32.414 51.162v601.525c0 489.6-424.207 719.774-733.779 887.943l-34.899 18.975c-8.47 4.517-17.731 6.889-27.105 6.889-9.262 0-18.523-2.372-26.993-6.89l-34.9-18.974C588.095 1726.08 164 1495.906 164 1006.306V404.78c0-21.91 12.65-41.788 32.414-51.162L935.727 5.42c15.134-7.228 32.866-7.228 48 0ZM757.088 383.322c-176.075 0-319.285 143.323-319.285 319.398 0 176.075 143.21 319.285 319.285 319.285 1.92 0 3.84 0 5.76-.113l58.504 58.503h83.689v116.781h116.781v83.803l91.595 91.482h313.412V1059.05l-350.57-350.682c.114-1.807.114-3.727.114-5.647 0-176.075-143.21-319.398-319.285-319.398Zm0 112.942c113.732 0 206.344 92.724 205.327 216.62l-3.953 37.271 355.426 355.652v153.713h-153.713l-25.412-25.299v-149.986h-116.78v-116.78H868.108l-63.812-63.7-47.209 5.309c-113.732 0-206.344-92.5-206.344-206.344 0-113.732 92.612-206.456 206.344-206.456Zm4.98 124.98c-46.757 0-84.705 37.948-84.705 84.706s37.948 84.706 84.706 84.706c46.757 0 84.706-37.948 84.706-84.706s-37.949-84.706-84.706-84.706Z" fill-rule="evenodd"/>
              </svg>
              </a>
              <%}%>
              <a id="cart" href="javascript:cartForm.requestSubmit()" class="pl-3 inline-block relative">
              <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui  hover:text-black" d="M17 16a3 3 0 11-2.83 2H9.83a3 3 0 11-5.62-.1A3 3 0 015 12V4H3a1 1 0 110-2h3a1 1 0 011 1v1h14a1 1 0 01.9 1.45l-4 8a1 1 0 01-.9.55H5a1 1 0 000 2h12zM7 12h9.38l3-6H7v6zm0 8a1 1 0 100-2 1 1 0 000 2zm10 0a1 1 0 100-2 1 1 0 000 2z"/></svg>
              </a>
              <a id="wishlist" href="javascript:wishlistForm.requestSubmit()" class="pl-3 inline-block relative">
                  <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12.76 3.76a6 6 0 018.48 8.48l-8.53 8.54a1 1 0 01-1.42 0l-8.53-8.54a6 6 0 018.48-8.48l.76.75.76-.75zm7.07 7.07a4 4 0 10-5.66-5.66l-1.46 1.47a1 1 0 01-1.42 0L9.83 5.17a4 4 0 10-5.66 5.66L12 18.66l7.83-7.83z"/></svg>                  </a>
              </a>
          </section>
          <%}%>
          <section>
              <a id="flag" href="javascript:EngLang.requestSubmit()" class="pl-3 inline-block relative">
                  <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path d="M494.7 78.5c-159.5-37.1-319 45.5-478.6 8.3c-8.9-2-16.1 3.1-16.1 12v314.4c0 8.9 7.2 18.2 16.1 20.3c159.5 37.1 319-45.5 478.6-8.3c8.9 2.1 16.1-3 16.1-11.9V98.9c0-9-7.2-18.3-16.1-20.4z" fill="#0b67b2"></path><path d="M510.8 98.8c0-8.9-7.2-18.2-16.1-20.3c-1-.2-2.1-.5-3.1-.7L313.9 186V74.8c-39 4.7-78 11.1-117 15.8v94.2L45 92.3c-9.6-1.4-19.2-3.2-28.9-5.5c-8.9-2-16.1 3.1-16.1 12v20.8l128 77.9H0v117h133.9L0 396v17.2c0 8.9 7.2 18.2 16.1 20.3c3 .7 6 1.3 8.9 1.9l171.8-104.7v106.4c39-4.7 78-11.1 117-15.8v-91.9L460.7 419c11.3 1.5 22.6 3.5 33.9 6.2c8.9 2.1 16.1-3 16.1-11.9v-18.4l-131.9-80.3h131.9v-117h-126l126-76.7c.1-7.5.1-14.8.1-22.1z" fill="#ff473e"></path><path d="M412.9 323.5l97.9 59.6v23.4l-136.3-83h-51.3l164.3 100.1c-16.6-3.5-33.3-5.7-49.9-7l-114.7-69.8v73.6c-6 .7-12 1.4-18 2.2v-117h205.9v18h-97.9zm-225 114.8c6-.7 12-1.4 18-2.2V305.5H0v18h99.9L0 384.3v23.4l138.3-84.2h49.6v1L11.7 431.8c1.4.7 2.9 1.3 4.4 1.7c7.9 1.8 15.8 3.4 23.7 4.7L187.9 348v90.3zM0 188.5v18h205.9v-117c-6 .8-12 1.5-18 2.2v76L68.7 95.1c-17.2-1.5-34.4-4-51.6-8l166.5 101.4h-51.3L0 107.9v23.4l94 57.2H0zM322.9 73.7c-6 .7-12 1.4-18 2.2v130.6h205.9v-18h-92l92-56v-23.4l-130.4 79.4h-51.3L502.8 82.7c-2.4-2-5.1-3.5-8.1-4.2c-5.9-1.4-11.7-2.5-17.6-3.6l-154.2 93.9V73.7z" fill="#e8e8e8"></path></svg></a>
              <a id="flageng" href="javascript:ItaLang.requestSubmit()" class="pl-3 inline-block relative">
                  <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path fill="#00B89C" d="M16.101 433.477c51.257 11.934 102.515 11.496 153.772 6.648v-.146c106.749-10.903 213.498-42.724 320.248-17.049c9.944 2.392 19.499-5.177 19.499-15.405V94.03c0-.632-.05-1.253-.123-1.868c-2.445-6.466-8.167-12.093-14.835-13.639c-97.449-22.688-194.899-.69-292.348 11.399c-10.813 1.452-21.626 2.773-32.439 3.878v-.3c-51.257 4.848-102.515 5.286-153.772-6.648C7.209 84.79 0 89.89 0 98.788v314.424c0 8.886 7.209 18.204 16.101 20.265z"></path><path fill="#FF473E" d="M509.619 92.532c-2.364-6.619-8.163-12.435-14.959-14.01c-51.638-12.022-103.276-11.49-154.914-6.54v346.626c51.638-4.95 103.276-5.482 154.914 6.54c6.795 1.575 12.595-1.041 14.959-6.328V92.532z"></path><path fill="#E8E8E8" d="M169.873 440.125c56.624-5.356 113.249-16.089 169.873-21.517V71.982c-56.624 5.428-113.249 16.161-169.873 21.517v346.626z"></path></svg></a>
          </section>
      </div>
  </div>
</header>

<form name="ItaLang" method="post" action="Dispatcher">
    <input type="hidden" name="language" value="ita"/>
    <input type="hidden" name="controllerAction" value="HomeManagement.changelang"/>
</form>
<form name="EngLang" method="post" action="Dispatcher">
    <input type="hidden" name="language" value="eng"/>
    <input type="hidden" name="controllerAction" value="HomeManagement.changelang"/>
</form>
<form name="AdminZone" method="post" action="Dispatcher">
    <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
</form>
<form name="loginForm" method="post" action="Dispatcher">
    <input type="hidden" name="controllerAction" value="HomeManagement.loginView"/>
</form>

<form name="registerForm" method="post" action="Dispatcher">
    <input type="hidden" name="controllerAction" value="HomeManagement.registerView"/>
</form>

<form name="accountView" method="post" action="Dispatcher">
    <input type="hidden" name="user_id">
    <input type="hidden" name="controllerAction" value="UserProfile.view"/>
</form>

<form name="myordersView" method="post" action="Dispatcher">
    <input type="hidden" name="user_id">
    <input type="hidden" name="controllerAction" value="OrderManagement.view"/>
</form>

<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>

<form name="cartForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="CartManagement.view"/>
</form>

<form name="wishlistForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="WishlistManagement.view"/>
</form>

<form name="categoryView" method="post" action="Dispatcher">
    <input type="hidden" name="category">
    <input type="hidden" name="controllerAction" value="HomeManagement.categoryView"/>
</form>