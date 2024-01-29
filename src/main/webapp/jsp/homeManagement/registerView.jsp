<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Registrazione";
%>

<!DOCTYPE html>
<html>
<head>
    <script>
        function mainOnLoadHandler() {
        }
    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
    <body>
        <%@include file="/include/header.jsp"%>
        <main class="flex flex-col justify-center items-center pb-8">

            <div class="w-full bg-gray-100 flex justify-center">
                <div class="w-1/6 flex flex-row flex-no-wrap justify-between items-center m-4 p-2">
                    <p class="p-1 font-medium">Gia utente?</p>
                    <a class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-20" href="javascript:loginViewForm.requestSubmit()">
                        Log in
                    </a>
                </div>
            </div>

            <div class="px-8 pt-6 pb-8 mb-4 flex flex-col w-1/3">
                <div class="flex justify-center">
                    <div class="mb-4 w-1/2 mr-1">
                        <label class="block text-grey-darker text-sm font-bold mb-2" for="name">
                            Nome
                        </label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="registerForm" id="name" name="name" type="text" placeholder="Mario" maxlength="40" required>
                    </div>
                    <div class="mb-4 w-1/2 ml-1">
                        <label class="block text-grey-darker text-sm font-bold mb-2" for="surname">
                            Cognome
                        </label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="registerForm" id="surname" name="surname" type="text" placeholder="Rossi" maxlength="40" required>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-grey-darker text-sm font-bold mb-2" for="email">
                        Email
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="registerForm" id="email" name="email" type="text" placeholder="mario.rossi@example.com" maxlength="40" required>
                </div>
                <div class="mb-4">
                    <label class="block text-grey-darker text-sm font-bold mb-2" for="username">
                        Username
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="registerForm" id="username" name="username" type="text" placeholder="mario" maxlength="12" required>
                </div>
                <div class="mb-4">
                    <label class="block text-grey-darker text-sm font-bold mb-2" for="password">
                        Password
                    </label>
                    <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3" form="registerForm" id="password" name="password" type="password" placeholder="******************" maxlength="40" required>
                </div>

                <button class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-40" type="submit" form="registerForm">
                    Registrazione
                </button>

            </div>

            <form id="registerForm" name="registerForm" method="post" action="Dispatcher">
                <input type="hidden" name="controllerAction" value="HomeManagement.register"/>
            </form>

            <form id="loginViewForm" name="loginViewForm" method="post" action="Dispatcher">
                <input type="hidden" name="controllerAction" value="HomeManagement.loginView"/>
            </form>

        </main>
        <%@include file="/include/footer.jsp"%>
    </body>
</html>