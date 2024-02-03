<%@page session="false"%>
<%@page import="com.vino.vino.model.mo.User"%>
<%@page import="com.vino.vino.model.mo.Wine"%>
<%@page import="java.util.List"%>

<%int i = 0;
boolean loggedOn = (Boolean) request.getAttribute("loggedOn");
  User loggedUser = (User) request.getAttribute("loggedUser");
  String applicationMessage = (String) request.getAttribute("applicationMessage");
  String menuActiveLink = "Inserimento vino nel catalogo";

  Wine wine = (Wine) request.getAttribute("wine");
  String action=(wine != null) ? "modify" : "insert";
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

      function StaticFormCheck(){
        var prezzoValue = (document.insModForm.price.value);
        var avalaibilityValue = (document.insModForm.avalaibility.value);
        var alcoolValue = (document.insModForm.alcool.value);

        if(isNaN(prezzoValue)){
          alert("Il campo PREZZO richiede un numero");
          return false;
        }

        if(isNaN(avalaibilityValue)){
          alert("Il campo QUANTITY richiede un numero");
          return false;
        }

        if(isNaN(alcoolValue)){
          alert("Il campo ALCOOL richiede un numero");
          return false;
        }
        return true;
      }

      function submitWine() {
        if (StaticFormCheck()) {
          // alert("campi ok");
          document.insModForm.controllerAction.value = "WineManagement."+status;
          document.insModForm.requestSubmit();
        }
      }

      function goback() {
        document.backForm.requestSubmit();
      }

      function mainOnLoadHandler() {
       // document.insModForm.addEventListener("submit", submitWine);
        document.insModForm.Invia.addEventListener("click", submitWine);
        document.insModForm.backButton.addEventListener("click", goback);
        document.insModForm.price.addEventListener("change", DynamicFormCheck);
        document.insModForm.avalaibility.addEventListener("change", DynamicFormCheck);
        document.insModForm.alcool.addEventListener("change", DynamicFormCheck);

      }
    </script>
  </head>
  <body>
    <%@include file="/include/adminHeader.jsp"%>
    <main class="flex flex-col justify-center items-center pt-8 pb-8">
      <h1 class="my-4 uppercase tracking-wide no-underline hover:no-underline font-medium text-gray-800 text-xl"><%if (languageString.equals("ita")){%>Gestione <%}if (languageString.equals("eng")){ %>Managment<% }%> <%=(action.equals("modify")) ? "Modifica Vino" : "Nuovo Vino"%></h1>
      <section id="insModFormSection" class="w-1/3">
        <form name="insModForm" action="Dispatcher" method="post">
          <div class="field">
            <label for="name"><span class="font-medium"><%if (languageString.equals("ita")){%>Nome<%}if (languageString.equals("eng")){ %>Name<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="name" name="name"
                   value="<%=(action.equals("modify")) ? wine.getName() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="name"><span class="font-medium"><%if (languageString.equals("ita")){%>URL/Path dell'immagine del prodotto<%}if (languageString.equals("eng")){ %>URL/Path of product's image<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="product_image" name="product_image"
                   value="<%=(action.equals("modify")) ? wine.getProductImage() : ""%>"
                   required size="20" maxlength="256"/>
          </div>
          <div class="field">
            <label for="price"><span class="font-medium"><%if (languageString.equals("ita")){%>Prezzo<%}if (languageString.equals("eng")){ %>Price<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="price" name="price"
                   value="<%=(action.equals("modify")) ? wine.getPrice() : ""%>"
                   required size="20" maxlength="8"/>
          </div>
          <div class="field">
            <label for="denominazione"><span class="font-medium"><%if (languageString.equals("ita")){%>Denominazione<%}if (languageString.equals("eng")){ %>Denomination<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="denominazione" name="denominazione"
                   value="<%=(action.equals("modify")) ? wine.getDenominazione() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="annata"><span class="font-medium"><%if (languageString.equals("ita")){%>Annata<%}if (languageString.equals("eng")){ %>Vine's Age<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="annata" name="annata"
                   value="<%=(action.equals("modify")) ? wine.getAnnata() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="avalaibility"><span class="font-medium"><%if (languageString.equals("ita")){%>Quantita<%}if (languageString.equals("eng")){ %>Availability<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="avalaibility" name="avalaibility"
                   value="<%=(action.equals("modify")) ? wine.getAvalaibility() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="vitigni"><span class="font-medium"><%if (languageString.equals("ita")){%>Vitigni<%}if (languageString.equals("eng")){ %>Vines<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="vitigni" name="vitigni"
                   value="<%=(action.equals("modify")) ? wine.getVitigni() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="temperature"><span class="font-medium"><%if (languageString.equals("ita")){%>Temperatura di servizio<%}if (languageString.equals("eng")){ %>Temperature of service<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="temperature" name="temperature"
                   value="<%=(action.equals("modify")) ? wine.getTemperature() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="format"><span class="font-medium"><%if (languageString.equals("ita")){%>Formato<%}if (languageString.equals("eng")){ %>Format<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="format" name="format"
                   value="<%=(action.equals("modify")) ? wine.getFormat() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="alcool"><span class="font-medium">Alcool</span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="alcool" name="alcool"
                   value="<%=(action.equals("modify")) ? wine.getAlcool() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="alcool"><span class="font-medium"><%if (languageString.equals("ita")){%>Categoria<%}if (languageString.equals("eng")){ %>Category<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="category" name="category"
                   value="<%=(action.equals("modify")) ? wine.getCategory() : ""%>"
                   required size="20" maxlength="50"/>
          </div>
          <div class="field">
            <label for="alcool"><span class="font-medium"><%if (languageString.equals("ita")){%>Descrizione<%}if (languageString.equals("eng")){ %>Description<% }%></span></label>
            <input class="shadow appearance-none border border-red rounded w-full py-2 px-3 text-grey-darker mb-4 mt-2" type="text" id="description" name="description"
                   value="<%=(action.equals("modify")) ? wine.getDescription() : ""%>"
                   required size="20" maxlength="2048"/>
          </div>
          <div class="field my-4">
            <input type="button" name ="Invia" class="bg-gray-700 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-20" value="<%if (languageString.equals("ita")){%>Invia<%}if (languageString.equals("eng")){ %>Done<% }%>"/>
            <input type="button" name="backButton" class="bg-red-400 hover:bg-blue-dark text-white font-bold py-2 px-4 rounded-full w-24 ml-2" value="<%if (languageString.equals("ita")){%>Annulla<%}if (languageString.equals("eng")){ %>Back<% }%>"/>
          </div>
          <%if (action.equals("modify")) {%>
          <input type="hidden" name="wine_id" value="<%=wine.getWineId()%>"/>
          <%}%>
          <input type="hidden" name="controllerAction"/>
        </form>
      </section>

      <form name="backForm" method="post" action="Dispatcher">
        <input type="hidden" name="controllerAction" value="AdminManagement.view"/>
      </form>

    </main>
    <%@include file="/include/adminFooter.jsp"%>
  </body>

</html>
