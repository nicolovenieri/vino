<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Cart"%>
<%@page import="com.vino.vino.model.mo.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>

<%int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");

    User user = (User) request.getAttribute("user");
    String menuActiveLink = "Lista Ordini di " + user.getName();
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    TreeMap<Timestamp, List<Order>> ordersBySingleOrder = new TreeMap<Timestamp, List<Order>>(Collections.reverseOrder());
    for (Order order: order_tuples) {
        Timestamp order_date = order.getTimestamp();
        if (!ordersBySingleOrder.containsKey(order_date)) {
            ordersBySingleOrder.put(order_date, new ArrayList<Order>());
        }
        ordersBySingleOrder.get(order_date).add(order);
    }

    DecimalFormat df = new DecimalFormat("#.##");
    df.setRoundingMode(RoundingMode.FLOOR);

    DateFormat outputFormatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
%>

<!DOCTYPE html>
<html>
<head>

    <%@include file="/include/htmlHead.jsp"%>
    <script language="javascript">

        function orderViewFunc(order_date) {
            f = document.orderViewForm;
            f.order_date.value = order_date;
            f.requestSubmit();
        }

        function mainOnLoadHandler() {}
    </script>
</head>
<body class="bg-gray-500">
<%@include file="/include/adminHeader.jsp"%>
<main class="bg-gray-500">
    <div class="container mx-auto flex flex-wrap py-4">
        <div class="flex justify-center w-full m-4 mt-8">
            <p class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl"><%if (languageString.equals("ita")){%> Ordini di : <%=user.getName()%> <%}if (languageString.equals("eng")){ %> <%=user.getName()%>'s Orders <% }%></p>
        </div>
        <div class="w-full flex flex-col flex-wrap justify-center py-4 bg-gray-500 divide-y rounded-md mb-8">
            <%for(Timestamp k : ordersBySingleOrder.keySet()) {%>
            <%--              <%for (i = 0; i < order_tuples.size(); i++) {%>--%>
            <div class="w-full p-4 flex flex-row flex-no-wrap justify-between">
                <div class="m-2">
                    <a href="javascript:orderViewFunc(<%=k.getTime()%>)" class="font-medium"><%=outputFormatter.format(k)%></a>
                    <%--                          <a href="javascript:orderViewFunc(<%=order_tuples.get(i).getTimestamp().getTime()%>)" class="font-medium"><%=outputFormatter.format(order_tuples.get(i).getTimestamp())%></a>--%>
                </div>
                <%--                      <p class="text-xl mr-4"><%=order_tuples.get(i).getTotalAmount()%> &euro;</p>--%>
            </div>
            <%}%>
        </div>
    </div>

    <form name="orderViewForm" method="post" action="Dispatcher">
        <input type="hidden" name="order_date"/>
        <input type="hidden" name="controllerAction" value="UserManagement.singleOrderModView"/>
        <input type="hidden" name="user_id" value="<%=user.getUserId()%>"/>
    </form>

</main>
<div class="fixed w-full bottom-0">
    <%@include file="/include/adminFooter.jsp"%>
</div>
</html>
