<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>

<%
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Login";
%>

<!DOCTYPE html>
<html>
<head>
    <script>

        function loginCheck() {
            var usernameTextField = document.querySelector("#username");
            var usernameTextFieldMsg = "Lo username \xE8 obbligatorio.";
            var passwordTextField = document.querySelector("#password");
            var passwordTextFieldMsg = "La password \xE8 obbligatoria.";

            if (usernameTextField != undefined && passwordTextField != undefined ) {
                usernameTextField.setCustomValidity(usernameTextFieldMsg);
                usernameTextField.addEventListener("change", function () {
                    this.setCustomValidity(this.validity.valueMissing ? usernameTextFieldMsg : "");
                });
                passwordTextField.setCustomValidity(passwordTextFieldMsg);
                passwordTextField.addEventListener("change", function () {
                    this.setCustomValidity(this.validity.valueMissing ? passwordTextFieldMsg : "");
                });
            }
        }

        function mainOnLoadHandler() {}

        window.addEventListener("load", loginCheck);
    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
    <body>
        <%@include file="/include/header.jsp"%>
        <main class="flex flex-col justify-center items-center pb-8">

            <div class="w-full bg-gray-100 flex justify-center">
                <div class="w-1/6 flex flex-row flex-no-wrap justify-between items-center m-4 p-2">
                    <p class="p-1 font-medium"><%if (languageString.equals("ita")){%>Non sei registrato?<%}if (languageString.equals("eng")){ %>You aren't registered yet? <% }%></p>
                    <a class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-28" href="javascript:registerViewForm.requestSubmit()">
                        <%if (languageString.equals("ita")){%>Registrati<%}if (languageString.equals("eng")){ %>Register<% }%>
                    </a>
                </div>
            </div>

            <div class="px-8 pt-6 pb-8 mb-4 flex flex-col w-1/4">
                    <div class="mb-4">
                        <label class="block text-grey-darker text-sm font-bold mb-2" for="username">
                            <%if (languageString.equals("ita")){%>NomeUtente<%}if (languageString.equals("eng")){ %>Username<% }%>
                        </label>
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="loginForm" id="username" name="username" type="text" placeholder="Username" maxlength="12" required>
                    </div>
                    <div class="mb-6">
                        <label class="block text-grey-darker text-sm font-bold mb-2" for="password">
                            Password
                        </label>
                        <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-3" form="loginForm" id="password" name="password" type="password" placeholder="**************" maxlength="40" required>
                    </div>
                    <button class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-20" type="submit" form="loginForm">
                        <%if (languageString.equals("ita")){%>Accedi<%}if (languageString.equals("eng")){ %>Login <% }%>
                    </button>
            </div>

            <form id="loginForm" name="loginForm" action="Dispatcher" method="post">
                <input type="hidden" name="controllerAction" value="HomeManagement.login">
            </form>

            <form id="registerViewForm" name="registerViewForm" method="post" action="Dispatcher">
                <input type="hidden" name="controllerAction" value="HomeManagement.registerView">
            </form>

        </main>
        <div class="h-20"></div>
        <%@include file="/include/footer.jsp"%>
    </body>
</html>