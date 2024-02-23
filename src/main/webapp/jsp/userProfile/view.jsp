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
    <body class="bg-gray-500">
    <%@include file="/include/header.jsp"%>
    <main class="w-full bg-gray-500 ">
        <%--USER DATA--%>
            <div>
                <div id="main-container" class="flex flex-row px-32">
                    <div id="image-section" class="float w-1/2 pt-12 pb-6 pr-8 mt-5 md:flex-shrink-0">
                        <!-- <img class="float-right rounded-md w-1/2 max-w-md" src="https://img.freepik.com/free-photo/medium-shot-man-tasting-wine-glass_23-2149428816.jpg?w=740&t=st=1706918585~exp=1706919185~hmac=83d549ca623344ebac7e21b342e29d9c5e4443eb43b98a41df6acd7447036e43" alt="stock user image"> -->
                        <?xml version="1.0" ?>

                        <!-- License: CC Attribution. Made by Ceria Studio: https://dribbble.com/ceriastd -->
                        <svg class="float-right rounded-md w-1/2 max-w-m" width="350" height="350" viewBox="0 0 61.7998 61.7998" xmlns="http://www.w3.org/2000/svg">

                            <title/>

                            <g data-name="Layer 2" id="Layer_2">

                                <g data-name="—ÎÓÈ 1" id="_ÎÓÈ_1">

                                    <circle cx="30.8999" cy="30.8999" fill="#fff" r="30.8999"/>

                                    <path d="M52.587 52.908a30.895 30.895 0 0 1-43.667-.291 9.206 9.206 0 0 1 4.037-4.832 19.799 19.799 0 0 1 4.075-2.322c-2.198-7.553 3.777-11.266 6.063-12.335 0 3.487 3.265 1.173 7.317 1.217 3.336.037 9.933 3.395 9.933-1.035 3.67 1.086 7.67 8.08 4.917 12.377a17.604 17.604 0 0 1 3.181 2.002 10.192 10.192 0 0 1 4.144 5.22z" fill="#00000" fill-rule="evenodd"/>

                                    <path d="M24.032 38.68l14.92.09v3.437l-.007.053a2.784 2.784 0 0 1-.07.462l-.05.341-.03.071c-.966 5.074-5.193 7.035-7.803 8.401-2.75-1.498-6.638-4.197-6.947-8.972l-.013-.059v-.2a8.897 8.897 0 0 1-.004-.207c0 .036.003.07.004.106z" fill="#f9dca4" fill-rule="evenodd"/>

                                    <path d="M38.953 38.617v4.005a7.167 7.167 0 0 1-.095 1.108 6.01 6.01 0 0 1-.38 1.321c-5.184 3.915-13.444.704-14.763-5.983z" fill-rule="evenodd" opacity="0.11"/>

                                    <path d="M18.104 25.235c-4.94 1.27-.74 7.29 2.367 7.264a19.805 19.805 0 0 1-2.367-7.264z" fill="#f9dca4" fill-rule="evenodd"/>

                                    <path d="M43.837 25.235c4.94 1.27.74 7.29-2.368 7.263a19.8 19.8 0 0 0 2.368-7.263z" fill="#f9dca4" fill-rule="evenodd"/>

                                    <path d="M30.733 11.361c20.523 0 12.525 32.446 0 32.446-11.83 0-20.523-32.446 0-32.446z" fill="#ffe8be" fill-rule="evenodd"/>

                                    <path d="M21.047 22.105a1.738 1.738 0 0 1-.414 2.676c-1.45 1.193-1.503 5.353-1.503 5.353-.56-.556-.547-3.534-1.761-5.255s-2.032-13.763 4.757-18.142a4.266 4.266 0 0 0-.933 3.6s4.716-6.763 12.54-6.568a5.029 5.029 0 0 0-2.487 3.26s6.84-2.822 12.54.535a13.576 13.576 0 0 0-4.145 1.947c2.768.076 5.443.59 7.46 2.384a3.412 3.412 0 0 0-2.176 4.38c.856 3.503.936 6.762.107 8.514-.829 1.752-1.22.621-1.739 4.295a1.609 1.609 0 0 1-.77 1.214c-.02.266.382-3.756-.655-4.827-1.036-1.07-.385-2.385.029-3.163 2.89-5.427-5.765-7.886-10.496-7.88-4.103.005-14 1.87-10.354 7.677z" fill="#8a5c42" fill-rule="evenodd"/>

                                    <path d="M19.79 49.162c.03.038 10.418 13.483 22.63-.2-1.475 4.052-7.837 7.27-11.476 7.26-6.95-.02-10.796-5.6-11.154-7.06z" fill="#434955" fill-rule="evenodd"/>

                                    <path d="M36.336 61.323c-.41.072-.822.135-1.237.192v-8.937a.576.576 0 0 1 .618-.516.576.576 0 0 1 .619.516v8.745zm-9.82.166q-.622-.089-1.237-.2v-8.711a.576.576 0 0 1 .618-.516.576.576 0 0 1 .62.516z" fill="#e6e6e6" fill-rule="evenodd"/>

                                </g>

                            </g>

                        </svg>
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