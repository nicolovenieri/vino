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

    boolean setDelivered = false;
    try {
        setDelivered = (Boolean) request.getAttribute("setDeliveredSwitch");
    } catch (NullPointerException e) { }

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

        function mainOnLoadHandler() {}
    </script>
    <%@include file="/include/htmlHead.jsp"%>
</head>
<body>
<%@include file="/include/header.jsp"%>
<main>
    <div id="main-container" class="container mx-auto flex-col flex-wrap justify-center items-center">
        <h1 class="flex items-center justify-between text-gray-900 font-bold text-2xl mt-12 mb-6 ml-6">Ordine del <%=dateFormatter.format(order_tuples.get(0).getTimestamp())%> alle <%=timeFormatter.format(order_tuples.get(0).getTimestamp())%></h1>
        <div class="bg-gray-100 divide-y rounded-md mb-12">
            <%for (i = 0; i < order_tuples.size(); i++) {%>
            <section class="mb-4 p-4">
                <h1 class="pt-2 flex items-center justify-between text-gray-900 font-bold uppercase"><%=order_tuples.get(i).getWine().getName()%></h1>
                <p class="pt-2 text-gray-900 font-regular">
                <span class="font-medium text-lg">
                    Quantita
                </span><%=order_tuples.get(i).getQuantity()%>
                </p>
                <p class="pt-3 text-gray-900 font-regular">
                <span class="font-medium text-lg">
                    Prezzo
                </span><%=order_tuples.get(i).getWine().getPrice()%> &euro;
                </p>
            </section>
            <%}%>
            <h1 class="flex items-center justify-between text-gray-900 font-bold p-6">Totale: <%=order_tuples.get(0).getTotalAmount()%> &euro;</h1>
        </div>
        <div class="bg-gray-100 divide-y rounded-md mb-12">
            <h1 class="flex items-center justify-between text-gray-900 font-bold text-xl p-4">Tracciamento spedizione</h1>
            <p class="p-4 ml-2"><%=order_tuples.get(0).getStatus()%></p>
            <%if(!order_tuples.get(0).getStatus().equals("Ordine consegnato") || setDelivered){%>
            <button class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-64 mb-6 ml-6 mt-3" type="submit" form="setDeliveredForm">
                Marca come consegnato
            </button>
            <%}%>
        </div>
    </div>

    <form id="setDeliveredForm" name="setDeliveredForm" action="Dispatcher" method="post">
        <input type="hidden" name="order_date" value="<%=order_tuples.get(0).getTimestamp().getTime()%>"/>
        <input type="hidden" name="controllerAction" value="OrderManagement.setDelivered"/>
    </form>

</main>
<%@include file="/include/footer.jsp"%>
</body>
</html>