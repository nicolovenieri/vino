<footer>
    <% if (languageString.equals("ita")){%>
    <section class="container mx-auto bg-white py-8 border-t border-gray-400">
        <div class="container flex px-3 py-8 ">
            <div class="w-full mx-auto flex justify-around items-start">
                <div class="w-1/3 order-1 px-3 md:px-0">
                    <h3 class="font-bold text-gray-900">Collegamenti utili</h3>
                    <ul class="items-center pt-3">
                        <li class="flex flex-col font-medium text-gray-700">
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Spedizione</a>
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Garanzia</a>
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">FAQ</a>
                        </li>
                    </ul>
                </div>
                <div class="w-1/3 order-2">
                    <h3 class="font-bold text-gray-900">Info</h3>
                    <p class="pt-3"><p>Qui si puo avere il vino BUONO nella botte GRANDE</p></p>
                </div>
                <div class="flex w-1/3 order-3 lg:justify-end lg:text-right">
                    <div class="px-3 md:px-0">
                        <h3 class="font-bold text-gray-900">I nostri Social</h3>
                        <ul class="items-center pt-3">
                            <li class="flex flex-col font-medium text-gray-700">
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Facebook</a>
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Instagram</a>
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Twitter</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <% } if (languageString.equals("eng")){%>
    <section class="container mx-auto bg-white py-8 border-t border-gray-400">
        <div class="container flex px-3 py-8 ">
            <div class="w-full mx-auto flex justify-around items-start">
                <div class="w-1/3 order-1 px-3 md:px-0">
                    <h3 class="font-bold text-gray-900">Useful links</h3>
                    <ul class="items-center pt-3">
                        <li class="flex flex-col font-medium text-gray-700">
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Shipping</a>
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Warranty</a>
                            <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">FAQ</a>
                        </li>
                    </ul>
                </div>
                <div class="w-1/3 order-2">
                    <h3 class="font-bold text-gray-900">About</h3>
                    <p class="pt-3"><p>Life is too short to drink bad wine</p></p>
                </div>
                <div class="flex w-1/3 order-3 lg:justify-end lg:text-right">
                    <div class="px-3 md:px-0">
                        <h3 class="font-bold text-gray-900">Our Social</h3>
                        <ul class="items-center pt-3">
                            <li class="flex flex-col font-medium text-gray-700">
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Facebook</a>
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Instagram</a>
                                <a class="inline-block no-underline hover:text-black hover:underline py-1" href="#">Twitter</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <%} %>
    <% if (languageString.equals("ita")){%>
    <div class="text-center w-full py-2 m-0">
        <p class="font-bold text-green-600">Lingua</p>
        <p class="font-bold text-red-600"> Italiana</p>
    </div>
    <% } if (languageString.equals("eng")){%>
    <div class="text-center w-full py-2 m-0">
        <p class="font-bold text-blue-600">English </p>
        <p class="font-bold text-red-600">Language</p>
    </div>
    <%} %>
    <div class="bg-gray-100 text-center w-full py-2 m-0">
        <p class="font-bold text-gray-400">Venieri Nicolo, Matteo Ferla &copy; 2024</p>
    </div>
</footer>