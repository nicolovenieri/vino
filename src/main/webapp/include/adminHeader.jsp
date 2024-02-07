<%@ page import="com.vino.vino.model.mo.Language" %><%


    //setto la lingua di default a italiano se non è selezionata nessuna lingua

    Language language = (Language)request.getAttribute("language");
    String languageString = (language != null) ? language.getLanguage() : null;
    System.out.println("jsp" + languageString);
    if ((!"ita".equals(languageString) && !"eng".equals(languageString))) {
        languageString = "ita";
    }
%>
<% if (languageString.equals("ita")) { %>
<header class="w-full z-30 top-0 py-1 bg-red-900">
    <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-6 py-3">
        <section class="order-1 md:order-1 flex items-center">
            <a id="logo" class="no-underline hover:no-underline tracking-wider font-bold text-white text-2xl" href="Dispatcher?controllerAction=AdminManagement.view">Cantina FerlaVenieri</a>
            <p class="font-medium text-green-400 text-sm uppercase pl-4 pt-2">Accesso eseguito come amministratore</p>
        </section>
        <div class="order-2 md:order-3 flex items-center p-4">
            <div  class="hover-trigger relative inline-block">
                <button class="relative inline-block">
                    <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg" class="heroicon-ui hover:text-black" width="24" height="24"><path d="M12 12a5 5 0 110-10 5 5 0 010 10zm0-2a3 3 0 100-6 3 3 0 000 6zm9 11a1 1 0 01-2 0v-2a3 3 0 00-3-3H8a3 3 0 00-3 3v2a1 1 0 01-2 0v-2a5 5 0 015-5h8a5 5 0 015 5v2z"/></svg>
                </button>
                <div class="hover-target absolute hidden bg-red-700 text-white rounded px-2 shadow-lg py-4 m-0 z-50">
                    <a class="hover:bg-red-500 block py-2 px-4 w-full"href="javascript:logoutForm.requestSubmit()">Esci</a>
                </div>
            </div>
            <div class="hover-trigger relative inline-block">
                <section>
                    <a id="home" href="javascript:HomeForm.requestSubmit()" class="pl-3 inline-block relative">
                        <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg"
                             width="24px" height="24px" viewBox="0 0 52 52" enable-background="new 0 0 52 52" xml:space="preserve">
<g>
    <path d="M49,27h-5v22c0,0.6-0.4,1-1,1H33c-0.6,0-1-0.4-1-1V32H20v17c0,0.6-0.4,1-1,1H9c-0.6,0-1-0.4-1-1V27H3
		c-0.4,0-0.8-0.2-0.9-0.6C1.9,26,2,25.6,2.3,25.3l23-23c0.4-0.4,1.1-0.4,1.4,0l23,23c0.3,0.3,0.3,0.7,0.2,1.1S49.4,27,49,27z"/>
</g>
</svg>
                    </a>
                    <a id="flagitaita" href="javascript:EngLang.requestSubmit()" class="pl-3 inline-block relative">
                        <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path d="M494.7 78.5c-159.5-37.1-319 45.5-478.6 8.3c-8.9-2-16.1 3.1-16.1 12v314.4c0 8.9 7.2 18.2 16.1 20.3c159.5 37.1 319-45.5 478.6-8.3c8.9 2.1 16.1-3 16.1-11.9V98.9c0-9-7.2-18.3-16.1-20.4z" fill="#0b67b2"></path><path d="M510.8 98.8c0-8.9-7.2-18.2-16.1-20.3c-1-.2-2.1-.5-3.1-.7L313.9 186V74.8c-39 4.7-78 11.1-117 15.8v94.2L45 92.3c-9.6-1.4-19.2-3.2-28.9-5.5c-8.9-2-16.1 3.1-16.1 12v20.8l128 77.9H0v117h133.9L0 396v17.2c0 8.9 7.2 18.2 16.1 20.3c3 .7 6 1.3 8.9 1.9l171.8-104.7v106.4c39-4.7 78-11.1 117-15.8v-91.9L460.7 419c11.3 1.5 22.6 3.5 33.9 6.2c8.9 2.1 16.1-3 16.1-11.9v-18.4l-131.9-80.3h131.9v-117h-126l126-76.7c.1-7.5.1-14.8.1-22.1z" fill="#ff473e"></path><path d="M412.9 323.5l97.9 59.6v23.4l-136.3-83h-51.3l164.3 100.1c-16.6-3.5-33.3-5.7-49.9-7l-114.7-69.8v73.6c-6 .7-12 1.4-18 2.2v-117h205.9v18h-97.9zm-225 114.8c6-.7 12-1.4 18-2.2V305.5H0v18h99.9L0 384.3v23.4l138.3-84.2h49.6v1L11.7 431.8c1.4.7 2.9 1.3 4.4 1.7c7.9 1.8 15.8 3.4 23.7 4.7L187.9 348v90.3zM0 188.5v18h205.9v-117c-6 .8-12 1.5-18 2.2v76L68.7 95.1c-17.2-1.5-34.4-4-51.6-8l166.5 101.4h-51.3L0 107.9v23.4l94 57.2H0zM322.9 73.7c-6 .7-12 1.4-18 2.2v130.6h205.9v-18h-92l92-56v-23.4l-130.4 79.4h-51.3L502.8 82.7c-2.4-2-5.1-3.5-8.1-4.2c-5.9-1.4-11.7-2.5-17.6-3.6l-154.2 93.9V73.7z" fill="#e8e8e8"></path></svg></a>
                    <a id="flagengita" href="javascript:ItaLang.requestSubmit()" class="pl-3 inline-block relative">
                        <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path fill="#00B89C" d="M16.101 433.477c51.257 11.934 102.515 11.496 153.772 6.648v-.146c106.749-10.903 213.498-42.724 320.248-17.049c9.944 2.392 19.499-5.177 19.499-15.405V94.03c0-.632-.05-1.253-.123-1.868c-2.445-6.466-8.167-12.093-14.835-13.639c-97.449-22.688-194.899-.69-292.348 11.399c-10.813 1.452-21.626 2.773-32.439 3.878v-.3c-51.257 4.848-102.515 5.286-153.772-6.648C7.209 84.79 0 89.89 0 98.788v314.424c0 8.886 7.209 18.204 16.101 20.265z"></path><path fill="#FF473E" d="M509.619 92.532c-2.364-6.619-8.163-12.435-14.959-14.01c-51.638-12.022-103.276-11.49-154.914-6.54v346.626c51.638-4.95 103.276-5.482 154.914 6.54c6.795 1.575 12.595-1.041 14.959-6.328V92.532z"></path><path fill="#E8E8E8" d="M169.873 440.125c56.624-5.356 113.249-16.089 169.873-21.517V71.982c-56.624 5.428-113.249 16.161-169.873 21.517v346.626z"></path></svg></a>
                </section>
            </div>
        </div>

    </div>
</header>
<% } if (languageString.equals("eng")) { %>
<header class="w-full z-30 top-0 py-1 bg-red-900">
    <div class="w-full container mx-auto flex flex-wrap items-center justify-between mt-0 px-6 py-3">
        <section class="order-1 md:order-1 flex items-center">
            <a id="logoeng" class="no-underline hover:no-underline tracking-wider font-bold text-white text-2xl" href="Dispatcher?controllerAction=AdminManagement.view">FerlaVenieri Winery</a>
            <p class="font-medium text-green-400 text-sm uppercase pl-4 pt-2">Logged as administrator</p>
        </section>
        <div class="order-2 md:order-3 flex items-center p-4">
            <div  class="hover-trigger relative inline-block">
                <button class="relative inline-block">
                    <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg" class="heroicon-ui hover:text-black" width="24" height="24"><path d="M12 12a5 5 0 110-10 5 5 0 010 10zm0-2a3 3 0 100-6 3 3 0 000 6zm9 11a1 1 0 01-2 0v-2a3 3 0 00-3-3H8a3 3 0 00-3 3v2a1 1 0 01-2 0v-2a5 5 0 015-5h8a5 5 0 015 5v2z"/></svg>
                </button>
                <div class="hover-target absolute hidden bg-red-700 text-white rounded px-2 shadow-lg py-4 m-0 z-50">
                    <a class="hover:bg-red-500 block py-2 px-4 w-full"href="javascript:logoutForm.requestSubmit()">Logout</a>
                </div>
            </div>
            <div class="hover-trigger relative inline-block">
                <section>
                    <a id="homeeng" href="javascript:HomeForm.requestSubmit()" class="pl-3 inline-block relative">
                        <svg style="fill: rgb(255, 255, 255)" xmlns="http://www.w3.org/2000/svg"
                             width="24px" height="24px" viewBox="0 0 52 52" enable-background="new 0 0 52 52" xml:space="preserve">
<g>
    <path d="M49,27h-5v22c0,0.6-0.4,1-1,1H33c-0.6,0-1-0.4-1-1V32H20v17c0,0.6-0.4,1-1,1H9c-0.6,0-1-0.4-1-1V27H3
		c-0.4,0-0.8-0.2-0.9-0.6C1.9,26,2,25.6,2.3,25.3l23-23c0.4-0.4,1.1-0.4,1.4,0l23,23c0.3,0.3,0.3,0.7,0.2,1.1S49.4,27,49,27z"/>
</g>
</svg>
                    </a>
                    <a id="flagitaeng" href="javascript:EngLang.requestSubmit()" class="pl-3 inline-block relative">
                        <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path d="M494.7 78.5c-159.5-37.1-319 45.5-478.6 8.3c-8.9-2-16.1 3.1-16.1 12v314.4c0 8.9 7.2 18.2 16.1 20.3c159.5 37.1 319-45.5 478.6-8.3c8.9 2.1 16.1-3 16.1-11.9V98.9c0-9-7.2-18.3-16.1-20.4z" fill="#0b67b2"></path><path d="M510.8 98.8c0-8.9-7.2-18.2-16.1-20.3c-1-.2-2.1-.5-3.1-.7L313.9 186V74.8c-39 4.7-78 11.1-117 15.8v94.2L45 92.3c-9.6-1.4-19.2-3.2-28.9-5.5c-8.9-2-16.1 3.1-16.1 12v20.8l128 77.9H0v117h133.9L0 396v17.2c0 8.9 7.2 18.2 16.1 20.3c3 .7 6 1.3 8.9 1.9l171.8-104.7v106.4c39-4.7 78-11.1 117-15.8v-91.9L460.7 419c11.3 1.5 22.6 3.5 33.9 6.2c8.9 2.1 16.1-3 16.1-11.9v-18.4l-131.9-80.3h131.9v-117h-126l126-76.7c.1-7.5.1-14.8.1-22.1z" fill="#ff473e"></path><path d="M412.9 323.5l97.9 59.6v23.4l-136.3-83h-51.3l164.3 100.1c-16.6-3.5-33.3-5.7-49.9-7l-114.7-69.8v73.6c-6 .7-12 1.4-18 2.2v-117h205.9v18h-97.9zm-225 114.8c6-.7 12-1.4 18-2.2V305.5H0v18h99.9L0 384.3v23.4l138.3-84.2h49.6v1L11.7 431.8c1.4.7 2.9 1.3 4.4 1.7c7.9 1.8 15.8 3.4 23.7 4.7L187.9 348v90.3zM0 188.5v18h205.9v-117c-6 .8-12 1.5-18 2.2v76L68.7 95.1c-17.2-1.5-34.4-4-51.6-8l166.5 101.4h-51.3L0 107.9v23.4l94 57.2H0zM322.9 73.7c-6 .7-12 1.4-18 2.2v130.6h205.9v-18h-92l92-56v-23.4l-130.4 79.4h-51.3L502.8 82.7c-2.4-2-5.1-3.5-8.1-4.2c-5.9-1.4-11.7-2.5-17.6-3.6l-154.2 93.9V73.7z" fill="#e8e8e8"></path></svg></a>
                    <a id="flagengeng" href="javascript:ItaLang.requestSubmit()" class="pl-3 inline-block relative">
                        <svg width="24px" height="24px" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" aria-hidden="true" role="img" class="iconify iconify--fxemoji" preserveAspectRatio="xMidYMid meet"><path fill="#00B89C" d="M16.101 433.477c51.257 11.934 102.515 11.496 153.772 6.648v-.146c106.749-10.903 213.498-42.724 320.248-17.049c9.944 2.392 19.499-5.177 19.499-15.405V94.03c0-.632-.05-1.253-.123-1.868c-2.445-6.466-8.167-12.093-14.835-13.639c-97.449-22.688-194.899-.69-292.348 11.399c-10.813 1.452-21.626 2.773-32.439 3.878v-.3c-51.257 4.848-102.515 5.286-153.772-6.648C7.209 84.79 0 89.89 0 98.788v314.424c0 8.886 7.209 18.204 16.101 20.265z"></path><path fill="#FF473E" d="M509.619 92.532c-2.364-6.619-8.163-12.435-14.959-14.01c-51.638-12.022-103.276-11.49-154.914-6.54v346.626c51.638-4.95 103.276-5.482 154.914 6.54c6.795 1.575 12.595-1.041 14.959-6.328V92.532z"></path><path fill="#E8E8E8" d="M169.873 440.125c56.624-5.356 113.249-16.089 169.873-21.517V71.982c-56.624 5.428-113.249 16.161-169.873 21.517v346.626z"></path></svg></a>
                </section>
            </div>
        </div>

    </div>
</header>
<% }%>
<form name="HomeForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.view"/>
</form>

<form name="logoutForm" action="Dispatcher" method="post">
    <input type="hidden" name="controllerAction" value="HomeManagement.logout"/>
</form>
<form name="ItaLang" method="post" action="Dispatcher">
    <input type="hidden" name="language" value="ita"/>
    <input type="hidden" name="controllerAction" value="AdminManagement.changelangAdmin"/>
</form>
<form name="EngLang" method="post" action="Dispatcher">
    <input type="hidden" name="language" value="eng"/>
    <input type="hidden" name="controllerAction" value="AdminManagement.changelangAdmin"/>
</form>
