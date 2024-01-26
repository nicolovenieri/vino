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

<header class="w-full z-30 top-0 py-1 bg-gray-300">
  <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-6 py-3">
    <nav class="hidden md:flex md:items-center md:w-auto w-full order-3 md:order-2">
      <ul class="md:flex items-center justify-between text-base text-gray-700 pt-4 md:pt-0">
        <li><a class="inline-block no-underline hover:text-black hover:underline py-2 px-4" href="javascript:setCategoryFunc('Rosso')">Rossi</a></li>
        <li><a class="inline-block no-underline hover:text-black hover:underline py-2 px-4" href="javascript:setCategoryFunc('Bianco')">Bianchi</a></li>
        <li><a class="inline-block no-underline hover:text-black hover:underline py-2 px-4" href="javascript:setCategoryFunc('Spumante')">Spumanti</a></li>
        <li><a class="inline-block no-underline hover:text-black hover:underline py-2 px-4" href="javascript:setCategoryFunc('Altro')">Altro</a></li>
      </ul>
    </nav>
    <a id="logo" href="Dispatcher?controllerAction=HomeManagement.view" class="order-1 md:order-1 flex items-center tracking-wider no-underline hover:no-underline font-bold text-gray-800 text-2xl">Polifenoli</a>
      <div class="order-2 md:order-3 flex items-center p-4">
          <div  class="hover-trigger relative inline-block">
              <div class="relative inline-block">
                  <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui hover:text-black" width="24" height="24"><path d="M12 12a5 5 0 110-10 5 5 0 010 10zm0-2a3 3 0 100-6 3 3 0 000 6zm9 11a1 1 0 01-2 0v-2a3 3 0 00-3-3H8a3 3 0 00-3 3v2a1 1 0 01-2 0v-2a5 5 0 015-5h8a5 5 0 015 5v2z"/></svg>
              </div>
              <div class="hover-target absolute hidden bg-gray-400 text-gray-800 rounded px-2 shadow-lg py-4 m-0 z-50">
                  <%if(!loggedOn) {%>
                  <a class="hover:bg-gray-500 block py-2 px-4 w-full" href="javascript:loginForm.requestSubmit()">Login</a>
                  <a class="hover:bg-gray-500 block py-2 px-4 w-full" href="javascript:registerForm.requestSubmit()">Registrati</a>
                  <%} else {%>
                  <a class="hover:bg-gray-500 block py-2 px-4 w-full" href="javascript:accountViewFunc(<%=loggedUser.getUserId()%>)">Account</a>
                  <a class="hover:bg-gray-500 block py-2 px-4 w-full" href="javascript:myordersViewFunc(<%=loggedUser.getUserId()%>)">Ordini</a>
                  <a class="hover:bg-gray-500 block py-2 px-4 w-full" href="javascript:logoutForm.requestSubmit()">Logout</a>
                  <%}%>
              </div>
          </div>
          <%if(loggedOn){%>
          <section>
              <a id="cart" href="javascript:cartForm.requestSubmit()" class="pl-3 inline-block relative">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui  hover:text-black" d="M17 16a3 3 0 11-2.83 2H9.83a3 3 0 11-5.62-.1A3 3 0 015 12V4H3a1 1 0 110-2h3a1 1 0 011 1v1h14a1 1 0 01.9 1.45l-4 8a1 1 0 01-.9.55H5a1 1 0 000 2h12zM7 12h9.38l3-6H7v6zm0 8a1 1 0 100-2 1 1 0 000 2zm10 0a1 1 0 100-2 1 1 0 000 2z"/></svg>
              </a>
              <a id="wishlist" href="javascript:wishlistForm.requestSubmit()" class="pl-3 inline-block relative">
                  <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"><path class="heroicon-ui" d="M12.76 3.76a6 6 0 018.48 8.48l-8.53 8.54a1 1 0 01-1.42 0l-8.53-8.54a6 6 0 018.48-8.48l.76.75.76-.75zm7.07 7.07a4 4 0 10-5.66-5.66l-1.46 1.47a1 1 0 01-1.42 0L9.83 5.17a4 4 0 10-5.66 5.66L12 18.66l7.83-7.83z"/></svg>                  </a>
              </a>
          </section>
          <%}%>
      </div>
  </div>
</header>

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