<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="com.vino.vino.model.mo.Cart"%>
<%@page import="com.vino.vino.model.mo.Order"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.RoundingMode"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.sql.Time" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>


<%
    int i = 0;
    boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
    User loggedUser = (User) request.getAttribute("loggedUser");
    String applicationMessage = (String) request.getAttribute("applicationMessage");
    String menuActiveLink = "Homepage";
    List<Order> order_tuples = (List<Order>) request.getAttribute("order_tuples");

    TreeMap<Timestamp, List<Order>> ordersBySingleOrder = new TreeMap<Timestamp, List<Order>>(Collections.reverseOrder());
    for (Order order: order_tuples) {
        Timestamp order_date = order.getTimestamp();
        if (!ordersBySingleOrder.containsKey(order_date)) {
            ordersBySingleOrder.put(order_date, new ArrayList<Order>());
        }
        ordersBySingleOrder.get(order_date).add(order);
    }

//    Map<Timestamp, List<Order>> ordersByTimestamp = new HashMap<>();
//    ordersByTimestamp = order_tuples.stream().collect(Collectors.groupingBy(Order::getTimestamp));


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
  <body>
    <%@include file="/include/header.jsp"%>
    <main>
        <div class="container mx-auto flex flex-wrap py-4">
            <div class="flex justify-center w-full m-4 mt-8">
                <p class="uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl">Ordini</p>
            </div>
            <%if(!order_tuples.isEmpty()){%>
            <div class="w-full flex flex-col flex-wrap justify-center py-4 bg-gray-100 divide-y rounded-md mb-8">
                  <%for(Timestamp k : ordersBySingleOrder.keySet()) {%>
                  <div class="w-full p-4 flex flex-row flex-no-wrap justify-between">
                      <div class="m-2">
                          <a href="javascript:orderViewFunc(<%=k.getTime()%>)" class="font-medium"><%=outputFormatter.format(k)%></a>
                      </div>
                  </div>
                  <%}%>
            </div>
            <%} else {%>
            <div class="text-center w-full mb-4">
                <p class="font-medium mt-6">Nessun ordine effettuato.</p>
            </div>
            <%}%>
        </div>

        <form name="orderViewForm" method="post" action="Dispatcher">
            <input type="hidden" name="order_date"/>
            <input type="hidden" name="controllerAction" value="OrderManagement.orderView"/>
        </form>

    </main>
    <%@include file="/include/footer.jsp"%>
</html>
