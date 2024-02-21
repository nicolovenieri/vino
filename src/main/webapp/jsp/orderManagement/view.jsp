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
  <body class="bg-black">
    <%@include file="/include/header.jsp"%>
    <main class="bg-gray-500">
        <div class="container mx-auto flex flex-wrap py-4">
            <div class="flex justify-center w-full m-4 mt-8">
                <p class="uppercase tracking-wide no-underline hover:no-underline font-extrabold text-black text-xl"><%if (languageString.equals("ita")){%>Ordini<%}if (languageString.equals("eng")){ %>Orders<% }%>
                </p>
            </div>
            <%if(!order_tuples.isEmpty()){%>
            <div class="w-full flex flex-col flex-wrap justify-center py-4 bg-gray-400 divide-y rounded-md mb-8">
                  <%for(Timestamp k : ordersBySingleOrder.keySet()) {%>
                  <div class="w-full p-4 flex flex-row flex-no-wrap justify-between">
                      <div class="m-2">
                          <a href="javascript:orderViewFunc(<%=k.getTime()%>)" class="font-medium">
                              <svg width="50px" height="50px" viewBox="0 0 1024 1024" class="icon" xmlns="http://www.w3.org/2000/svg"><path fill="#000000" d="M128.896 736H96a32 32 0 01-32-32V224a32 32 0 0132-32h576a32 32 0 0132 32v96h164.544a32 32 0 0131.616 27.136l54.144 352A32 32 0 01922.688 736h-91.52a144 144 0 11-286.272 0H415.104a144 144 0 11-286.272 0zm23.36-64a143.872 143.872 0 01239.488 0H568.32c17.088-25.6 42.24-45.376 71.744-55.808V256H128v416h24.256zm655.488 0h77.632l-19.648-128H704v64.896A144 144 0 01807.744 672zm48.128-192l-14.72-96H704v96h151.872zM688 832a80 80 0 100-160 80 80 0 000 160zm-416 0a80 80 0 100-160 80 80 0 000 160z"/></svg>
                              <%=outputFormatter.format(k)%>
                          </a>
                      </div>
                  </div>
                  <%}%>
            </div>
            <%} else {%>
            <div class="text-center w-full mb-4">
                <p class="font-medium mt-6"><%if (languageString.equals("ita")){%>Nessun ordine effettuato<%}if (languageString.equals("eng")){ %>No orders placed<% }%></p>
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
