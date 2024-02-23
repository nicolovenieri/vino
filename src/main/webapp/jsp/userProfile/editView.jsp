<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="java.util.List"%>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Modifica profilo";

    User user = (User) request.getAttribute("user");
    String action=(user != null) ? "modify" : "insert";
%>

<!DOCTYPE html>
<html>
<head>
    <%@include file="/include/htmlHead.jsp"%>

    <script language="javascript">
        var status="<%=action%>"

        function DynamicFormCheck(e) {
            var EventTriggerName = (e.target.name);
            var EventTriggerValue = (e.target.value);

            if(isNaN(EventTriggerValue))
                alert("Il campo " + EventTriggerName + " richiede un numero");
        }
        function mainOnLoadHandler(){}
    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/header.jsp"%>
<main class="flex flex-col justify-center items-center pt-8 pb-8">
    <div class="w-full flex flex-row justify-center"><h1 class="my-4 uppercase tracking-wide font-bold text-black text-xl"><%if (languageString.equals("ita")){%>Modifica profilo<%}if (languageString.equals("eng")){ %>Edit Profile<% }%></h1></div>
    <section class="w-full flex flex-row flex-no-wrap justify-around">
        <section class="order-1 flex flex-col flex-wrap m-4 w-1/2">
            <div class="float">
                <div class="float-right flex-row bg-gray-200 rounded-lg border-bg-gray-500 mx-2 my-4 p-4 w-2/3">
                    <div class="flex flex-col m-2">
                        <div class="border-b border-bg-gray-500">
                            <p class="font-bold pt-2 m-4"><%if (languageString.equals("ita")){%>Info Utente<%}if (languageString.equals("eng")){ %>User Info<% }%></p>
                        </div>
                        <div class="m-4">
                            <label class="block text-grey-darker text-sm font-bold mb-2" for="username">
                                <%if (languageString.equals("ita")){%>Nome Utente<%}if (languageString.equals("eng")){ %>Username<% }%>
                            </label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="username" name="username" type="text" placeholder="mario123"
                                   value="<%=(user.getUsername() != null) ? user.getUsername() : ""%>" maxlength="12" >
                            <label class="block text-grey-darker text-sm font-bold my-2" for="username">
                                Password
                            </label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="password" name="password" type="password"
                                   value="<%=(user.getPassword() != null) ? user.getPassword() : ""%>" maxlength="32" >

                            <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                <div class="mr-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="cvc">
                                        <%if (languageString.equals("ita")){%>Nome<%}if (languageString.equals("eng")){ %>Name<% }%>
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="name" name="name" type="text" placeholder="Mario"
                                           value="<%=(user.getName() != null) ? user.getName() : ""%>" maxlength="40" >
                                </div>
                                <div class="ml-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="exp_date">
                                        <%if (languageString.equals("ita")){%>Cognome<%}if (languageString.equals("eng")){ %>Surname<% }%>
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="surname" name="surname" type="text" placeholder="Rossi"
                                           value="<%=(user.getSurname() != null) ? user.getSurname() : ""%>" maxlength="40" >
                                </div>
                            </div>

                            <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                <div class="mr-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="cvc">
                                        Email
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="email" name="email" type="email" placeholder="mario.rossi@example.com"
                                           value="<%=(user.getEmail() != null) ? user.getEmail() : ""%>" maxlength="40" >
                                </div>
                                <div class="ml-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="exp_date">
                                        <%if (languageString.equals("ita")){%>Telefono<%}if (languageString.equals("eng")){ %>Phone<% }%>
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="phone" name="phone" type="tel" minlength="10" placeholder="333 1231234"
                                           value="<%=(user.getPhone() != null) ? user.getPhone() : ""%>" maxlength="10" >
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="order-2 flex flex-col flex-wrap m-4 w-1/2">
            <div class="float">
                <div class="float-left flex-row bg-gray-100 rounded-lg border-bg-gray-500 mx-2 my-4 p-4 w-2/3">
                    <div class="flex flex-col m-2">
                        <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                            <p class="font-bold pt-2 m-4"><%if (languageString.equals("ita")){%>Info di pagamento<%}if (languageString.equals("eng")){ %>Payment Info<% }%></p>
                            <button type="submit" form="deleteCarta" class="pt-2 m-4"><svg width="24" height="24" viewBox="-0.5 0 19 19" version="1.1" xmlns="http://www.w3.org/2000/svg">

                                <title>icon/18/icon-delete</title>
                                <desc>Created with Sketch.</desc>
                                <defs>

                                </defs>
                                <g id="out" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage">
                                    <path d="M4.91666667,14.8888889 C4.91666667,15.3571429 5.60416667,16 6.0625,16 L12.9375,16 C13.3958333,16 14.0833333,15.3571429 14.0833333,14.8888889 L14.0833333,6 L4.91666667,6 L4.91666667,14.8888889 L4.91666667,14.8888889 L4.91666667,14.8888889 Z M15,3.46500003 L12.5555556,3.46500003 L11.3333333,2 L7.66666667,2 L6.44444444,3.46500003 L4,3.46500003 L4,4.93000007 L15,4.93000007 L15,3.46500003 L15,3.46500003 L15,3.46500003 Z" id="path" fill="#000000" sketch:type="MSShapeGroup">

                                    </path>
                                </g>
                            </svg></button>
                        </div>
                        <div class="m-4">
                            <label class="block text-grey-darker text-sm font-bold mb-2" for="card_n">
                                <%if (languageString.equals("ita")){%>Numero di carta<%}if (languageString.equals("eng")){ %>Card number<% }%>
                            </label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="card_n" name="card_n" type="text" minlength="16" placeholder="1234 1234 1234 1234"
                                   value="<%=(user.getCard_n() != null) ? user.getCard_n() : ""%>" maxlength="16" >
                            <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                <div class="mr-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="cvc">
                                        CVC/CCV
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="cvc" name="cvc" type="text" minlength="3" placeholder="567"
                                           value="<%=(user.getCvc() != 0) ? user.getCvc() : ""%>" maxlength="3" >
                                </div>
                                <div class="ml-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="exp_date">
                                        <%if (languageString.equals("ita")){%>Data di scadenza<%}if (languageString.equals("eng")){ %>Date of expire<% }%>
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="exp_date" name="exp_date" type="text" minlength="7" placeholder="MM/YYYY"
                                           value="<%=(user.getExp_date() != null) ? user.getExp_date() : ""%>" maxlength="7" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="float-left flex-row bg-gray-100 rounded-lg border-bg-gray-500 mx-2 my-4 p-4 w-2/3">
                    <div class="flex flex-col m-2">
                        <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                            <p class="font-bold pt-2 m-4"><%if (languageString.equals("ita")){%>Info di Spedizione<%}if (languageString.equals("eng")){ %>Shipping Info<% }%></p>
                            <button type="submit" form="deleteSpedizione" class="pt-2 m-4"><svg width="24" height="24" viewBox="-0.5 0 19 19" version="1.1" xmlns="http://www.w3.org/2000/svg" >

                                <title>icon/18/icon-delete</title>
                                <desc>Created with Sketch.</desc>
                                <defs>

                                </defs>
                                <g id="out" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" sketch:type="MSPage">
                                    <path d="M4.91666667,14.8888889 C4.91666667,15.3571429 5.60416667,16 6.0625,16 L12.9375,16 C13.3958333,16 14.0833333,15.3571429 14.0833333,14.8888889 L14.0833333,6 L4.91666667,6 L4.91666667,14.8888889 L4.91666667,14.8888889 L4.91666667,14.8888889 Z M15,3.46500003 L12.5555556,3.46500003 L11.3333333,2 L7.66666667,2 L6.44444444,3.46500003 L4,3.46500003 L4,4.93000007 L15,4.93000007 L15,3.46500003 L15,3.46500003 L15,3.46500003 Z" id="path" fill="#000000" sketch:type="MSShapeGroup">

                                    </path>
                                </g>
                            </svg></button>
                        </div>
                        <div class="m-4">
                            <label class="block text-grey-darker text-sm font-bold mb-2" for="street">
                                <%if (languageString.equals("ita")){%>Via<%}if (languageString.equals("eng")){ %>Street<% }%>

                            </label>
                            <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="street" name="street" type="text" placeholder="Via Rossi"
                                   value="<%=(user.getStreet() != null) ? user.getStreet() : ""%>" maxlength="50" >
                            <div class="flex flex-row flex-no-wrap justify-between my-2 py-2 w-full">
                                <div class="mr-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="civic">
                                        <%if (languageString.equals("ita")){%>Civico<%}if (languageString.equals("eng")){ %>Civic<% }%>

                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="civic" name="civic" type="text" placeholder="1"
                                           value="<%=(user.getCivic() != null) ? user.getCivic() : ""%>"maxlength="10" >
                                </div>
                                <div class="mx-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="cap">
                                        CAP
                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="cap" name="cap" type="text" minlength="5" placeholder="12345"
                                           value="<%=(user.getCap() != 0) ? user.getCap() : ""%>" maxlength="5" >
                                </div>
                                <div class="ml-2">
                                    <label class="block text-grey-darker text-sm font-bold mb-2" for="city">
                                        <%if (languageString.equals("ita")){%>Citta'<%}if (languageString.equals("eng")){ %>City<% }%>

                                    </label>
                                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker" form="editProfileForm" id="city" name="city" type="text" placeholder="Roma"
                                           value="<%=(user.getCity() != null) ? user.getCity() : ""%>" maxlength="30" >
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
    <div class="w-full flex flex-row justify-center">
        <button class="bg-gray-700 hover:bg-green-500 text-white hover:text-black font-bold py-2 px-4 rounded-full" type="submit" form="editProfileForm">
            <%if (languageString.equals("ita")){%>Conferma Modifiche<%}if (languageString.equals("eng")){ %>Confirm Changes<% }%>

        </button>
    </div>

    <form name="editProfileForm" id="editProfileForm" action="Dispatcher" method="post">
        <input type="hidden" name="controllerAction" value="UserProfile.modify"/>
    </form>

    <form name="deleteCarta" id="deleteCarta" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteCarta"/>
    </form>

    <form name="deleteSpedizione" id="deleteSpedizione" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.deleteSpedizione"/>
    </form>
    <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="UserProfile.view"/>
    </form>

</main>
<%@include file="/include/footer.jsp"%>
</body>

</html>
