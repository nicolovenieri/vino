<header class="w-full z-30 top-0 py-1 bg-gray-300">
    <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-6 py-3">
        <section class="order-1 md:order-1 flex items-center">
            <a id="logo" class="no-underline hover:no-underline tracking-wider font-bold text-gray-800 text-2xl" href="Dispatcher?controllerAction=AdminManagement.view">Polifenoli</a>
            <p class="font-medium text-blue-700 text-sm uppercase pl-4 pt-2">Loggato come amministratore</p>
        </section>
        <div class="order-2 md:order-3 flex items-center p-4">
            <div  class="hover-trigger relative inline-block">
                <button class="relative inline-block">
                    <svg xmlns="http://www.w3.org/2000/svg" class="heroicon-ui hover:text-black" width="24" height="24"><path d="M12 12a5 5 0 110-10 5 5 0 010 10zm0-2a3 3 0 100-6 3 3 0 000 6zm9 11a1 1 0 01-2 0v-2a3 3 0 00-3-3H8a3 3 0 00-3 3v2a1 1 0 01-2 0v-2a5 5 0 015-5h8a5 5 0 015 5v2z"/></svg>
                </button>
                <div class="hover-target absolute hidden bg-gray-400 text-gray-800 rounded px-2 shadow-lg py-4 m-0 z-50">
                    <a class="hover:bg-gray-500 block py-2 px-4 w-full"href="javascript:logoutForm.requestSubmit()">Logout</a>
                </div>
            </div>
        </div>
    </div>
</header>

<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>
