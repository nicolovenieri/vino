<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Order"%>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%  String applicationMessage = (String) request.getAttribute("applicationMessage");
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    DateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
    DateFormat timeFormatter = new SimpleDateFormat("HH:mm");
    DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
    String menuActiveLink = formatter.format(order_tuples.get(0).getTimestamp().getTime());
    int i;
%>

<!DOCTYPE html>
<html>
<head>
    <script language="javascript">

        function changeOrderStatus(user_id, order_date) {
            document.changeOrderStatusForm.status.value = document.getElementById('status').value;
            document.changeOrderStatusForm.user_id.value = user_id;
            document.changeOrderStatusForm.order_date.value = order_date;
            document.changeOrderStatusForm.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="w-full bg-gray-500">
    <div id="main-container" class="w-full container mx-auto flex-col flex-wrap justify-center items-center">
        <h1 class="flex items-center justify-between text-black font-bold text-2xl mt-12 mb-6 ml-6"><%if (languageString.equals("ita")){%>Ordine del <%}if (languageString.equals("eng")){ %>Date of order: <% }%> <%=dateFormatter.format(order_tuples.get(0).getTimestamp())%> <%if (languageString.equals("ita")){%>alle:<%}if (languageString.equals("eng")){ %>Time: <% }%><%=dateFormatter.format(order_tuples.get(0).getTimestamp())%> alle <%=timeFormatter.format(order_tuples.get(0).getTimestamp())%></h1>
        <div class="bg-gray-100 divide-y rounded-md mb-12">
            <%for (i = 0; i < order_tuples.size(); i++) {%>
            <section class="mb-4 p-4">
                <h1 class="pt-2 flex items-center justify-between text-gray-900 font-bold uppercase"><%=order_tuples.get(i).getWine().getName()%></h1>
                <p class="pt-2 text-gray-900 font-regular">
                <span class="font-medium text-lg">
                    <%if (languageString.equals("ita")){%>Quantita'<%}if (languageString.equals("eng")){ %>Amount<% }%>
                </span><%=order_tuples.get(i).getQuantity()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                <span class="font-medium text-lg">
                    <%if (languageString.equals("ita")){%>Prezzo<%}if (languageString.equals("eng")){ %>Price<% }%>
                </span><%=order_tuples.get(i).getWine().getPrice()%> &euro;
                </p>
            </section>
            <%}%>
            <h1 class="flex items-center justify-between text-gray-900 font-bold p-6 mx-2"><%if (languageString.equals("ita")){%>Totale: <%}if (languageString.equals("eng")){ %>Total: <% }%> <%=order_tuples.get(0).getTotalAmount()%> &euro;</h1>
        </div>
        <div class="bg-gray-100 divide-y rounded-md mb-12 flex flex-col flex-wrap">
            <h1 class="flex items-center justify-between text-gray-900 font-bold text-xl p-4">Tracciamento spedizione</h1>
            <p class="font-medium p-4"><%if (languageString.equals("ita")){%>Stato attuale: <%}if (languageString.equals("eng")){ %>Delivery status: <% }%> <span class="font-normal"><%=order_tuples.get(0).getStatus()%></span></p>
            <div class="inline-block relative w-64 mx-6 my-3">
                <select name="status" id="status" class="block appearance-none w-full bg-white border border-gray-400 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline">
                    <option><%if (languageString.equals("ita")){%>Processamento ordine <%}if (languageString.equals("eng")){ %>Order processing<% }%></option>
                    <option><%if (languageString.equals("ita")){%>Ordine spedito <%}if (languageString.equals("eng")){ %>Order shipped<% }%></option>
                    <option><%if (languageString.equals("ita")){%>Ordine in consegna <%}if (languageString.equals("eng")){ %>Order delivering<% }%></option>
                    <option><%if (languageString.equals("ita")){%>Ordine consegnato <%}if (languageString.equals("eng")){ %>Order delivered<% }%></option>
                    <option><%if (languageString.equals("ita")){%>In ritardo <%}if (languageString.equals("eng")){ %>Order Late<% }%></option>
                </select>
                <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                    <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"/></svg>
                </div>
            </div>
            <a class="bg-gray-700 hover:bg-green-500 hover:text-black text-white font-bold py-2 pl-5 rounded-full w-40 mx-6 my-3" href="javascript:changeOrderStatus(<%=order_tuples.get(0).getUser().getUserId()%>, <%=order_tuples.get(0).getTimestamp().getTime()%>)">
                <%if (languageString.equals("ita")){%>Aggiorna stato<%}if (languageString.equals("eng")){ %>Update status<% }%>
            </a>
        </div>
    </div>

    <form name="changeOrderStatusForm" action="Dispatcher" method="post">
        <input type="hidden" name="status"/>
        <input type="hidden" name="user_id"/>
        <input type="hidden" name="order_date"/>
        <input type="hidden" name="controllerAction" value="UserManagement.changeStatus"/>
    </form>

</main>
<div class=" w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>

</html>