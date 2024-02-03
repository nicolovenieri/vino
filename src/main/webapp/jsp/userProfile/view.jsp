<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    User user = (User)request.getAttribute("user");
    String menuActiveLink = user.getName();%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function mainOnLoadHandler() {}

        function deletePrompt() {
            let deleteConfirmation = confirm("Sei sicuro di voler cancellare il profilo?");
            return deleteConfirmation;
        }

        function deleteProfile() {
            if(deletePrompt()) {
                document.deleteProfileForm.requestSubmit();
            }
        }

    </script>
</head>
    <body>
    <%@include file="/include/header.jsp"%>
    <main class="w-full">
        <%--USER DATA--%>
            <div>
                <div id="main-container" class="flex flex-row px-32">
                    <div id="image-section" class="float w-1/2 pt-12 pb-6 pr-8 mt-5 md:flex-shrink-0">
                        <img class="float-right rounded-md w-1/2 max-w-md" src="https://img.freepik.com/free-photo/medium-shot-man-tasting-wine-glass_23-2149428816.jpg?w=740&t=st=1706918585~exp=1706919185~hmac=83d549ca623344ebac7e21b342e29d9c5e4443eb43b98a41df6acd7447036e43" alt="stock user image">
                    </div>
                    <div id="info-section" class="w-1/2 pt-12 pb-6">
                        <h1 class="pt-3 flex items-center justify-between text-gray-900 font-bold text-2xl"><%=user.getName()%></h1>
                        <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            <%if (languageString.equals("ita")){%>NomeUtente<%}if (languageString.equals("eng")){ %>Username<% }%>
                        </span><%=user.getUsername()%>
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                       <span class="font-medium text-lg">
                           <%if (languageString.equals("ita")){%>Nome<%}if (languageString.equals("eng")){ %>Name<% }%>
                       </span> <%=user.getName()%>
                        </p>
                        <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            <%if (languageString.equals("ita")){%>Cognome<%}if (languageString.equals("eng")){ %>Surname<% }%>
                        </span><%=user.getSurname()%>
                        </p>
                        <%if(user.getEmail() != null) {%>
                        <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            Email
                        </span><%=user.getEmail()%>
                        </p>
                        <%}%>
                        <%if(user.getPhone() != null) {%>
                        <p class="pt-3 text-gray-900 font-regular">
                        <span class="font-medium text-lg">
                            <%if (languageString.equals("ita")){%>Telefono<%}if (languageString.equals("eng")){ %>Phone<% }%>
                        </span><%=user.getPhone()%>
                        </p>
                        <%}%>
                    </div>
                </div>
            </div>
            <div class="flex flex-row flex-no-wrap justify-center mx-4 px-4 mb-12">
                <a class="bg-gray-700 hover:bg-gray-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-40" href="javascript:editProfileViewForm.requestSubmit()">
                    <%if (languageString.equals("ita")){%>Modifica profilo<%}if (languageString.equals("eng")){ %>Edit profile<% }%>
                </a>
                <a class="bg-red-400 hover:bg-gray-dark text-white font-bold px-4 py-2 ml-6 mt-6 rounded-full w-28" href="javascript:deleteProfile()">
                    <%if (languageString.equals("ita")){%>Cancella profilo<%}if (languageString.equals("eng")){ %>Delete profile<% }%>
                </a>
            </div>

            <form id="deleteProfileForm" name="deleteProfileForm" method="post" action="Dispatcher">
                <input type="hidden" name="controllerAction" value="UserProfile.deleteProfile"/>
            </form>

            <form id="editProfileViewForm" name="editProfileViewForm" method="post" action="Dispatcher">
                <input type="hidden" name="controllerAction" value="UserProfile.editProfileView"/>
            </form>

    </main>
    <%@include file="/include/footer.jsp"%>
    </body>
</html>