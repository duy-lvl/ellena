<%-- 
    Document   : header
    Created on : May 31, 2022, 3:20:12 PM
    Author     : giama
--%>

<%@page import="store.shopping.CartProduct"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.user.UserDTO"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header Page</title>
        <jsp:include page="meta.jsp" flush="true"/>

    </head>
    <body>
        <% List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");

            ArrayList<Integer> categoryOrder = new ArrayList();
            for (CategoryDTO cat : listCategory) {
                categoryOrder.add(cat.getOrder());
            }
            Collections.sort(categoryOrder);
        %>

        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__close">+</div>
            <ul class="offcanvas__widget">
                <li><span class="icon_search search-switch"></span></li>
                <li>
                    <% if (user == null) { %>

                    <a href="login.jsp">
                        <%} else { %>

                        <a href="shop-cart.jsp">
                            <%}%>
                            <span class="icon_bag_alt"></span>
                            <% if (cart != null) {
                                    if (cart.size() > 0) {
                            %>
                            <div class="tip"><%= cart.size()%></div>
                            <%
                                    }
                                }
                            %>
                        </a>
                </li>
            </ul>
            <div class="offcanvas__logo">
                <a href="./"><img class="img-fluid" style="height: 38px;" src="img/ellena-logo.png" alt="off-canvas logo"></a>
            </div>
            <div id="mobile-menu-wrap"></div>
            <%if (user != null) {%>
            <div class="offcanvas__auth">
                <a style="font-weight: 500; color: #721c24" href="customer-profile.jsp"><%= user.getFullName().toUpperCase()%></a>
                <ul class="dropdown">
                    <li> <a href="MainController?action=ViewOrderHistory">Đơn hàng <i class="fa fa-shopping-cart text-dark"></i></a></li>
                    <li> <a href="MainController?action=Logout">Đăng xuất <i class="fa fa-sign-out text-dark"></i></a></li>
                </ul>
            </div>
            <% } else {%>
            <div class="offcanvas__auth">
                <a href="login.jsp">Đăng nhập</a>
                <a href="register.jsp">Đăng ký</a>
            </div>
            <%}%>

        </div>
        <!-- Offcanvas Menu End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-2">
                        <div class="header__logo">
                            <a href="./"><img class="img-fluid" style="height: 38px;" src="img/ellena-logo.png" alt="logo"></a>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-7" >
                        <nav class="header__menu">
                            <ul id="menu">
                                <li id="home" class="header__menu_item">
                                    <a href="./">Trang chủ</a></li>
                                <li id="category" class="header__menu_item"><a>Thời trang</a>
                                    <ul class="dropdown">
                                        <%
                                            for (int i : categoryOrder) {
                                                for (CategoryDTO cat : listCategory) {
                                                    if (cat.getOrder() == i) {
                                        %>
                                        <li><a href="CategoryRouteController?category=<%=cat.getCategoryName()%>"><%=cat.getCategoryName()%></a></li>
                                            <%
                                                        }
                                                    }
                                                }%>
                                    </ul>
                                </li>
                                <li id="discover" class="header__menu_item"><a href="DiscoverController">Khám phá</a></li>
                                <li id="contact" class="header__menu_item"><a href="./contact.jsp">Liên hệ</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
                        <div class="header__right">
                            <%if (user != null) {%>
                            <div class="header__right__auth">
                                <a style="font-weight: 500; color: #721c24" href="customer-profile.jsp"><%= user.getFullName().toUpperCase()%></a>
                                <ul class="dropdown">
                                    <li> <a href="MainController?action=ViewOrderHistory">Đơn hàng <i class="fa fa-shopping-cart text-dark"></i></a></li>
                                    <li> <a href="MainController?action=Logout">Đăng xuất <i class="fa fa-sign-out text-dark"></i></a></li>
                                </ul>
                            </div>
                            <% } else {%>
                            <div class="header__right__auth">
                                <a href="login.jsp">Đăng nhập</a>
                                <a href="register.jsp">Đăng ký</a>
                            </div>
                            <%}%>
                            <ul class="header__right__widget">
                                <li><span class="icon_search search-switch"></span></li>
                                <li>
                                    <% if (user == null) { %>

                                    <a href="login.jsp">
                                        <%} else { %>

                                        <a href="shop-cart.jsp">
                                            <%}%>
                                            <span class="icon_bag_alt"></span>
                                            <% if (cart != null) {
                                                    if (cart.size() > 0) {
                                            %>
                                            <div class="tip"><%= cart.size()%></div>
                                            <%
                                                    }
                                                }
                                            %>
                                        </a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="canvas__open">
                    <i class="fa fa-bars"></i>
                </div>
            </div>
        </header>
        <!-- Header Section End -->
        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form action="MainController" class="search-model-form">
                    <input type="text" name="search" id="search-input" placeholder="Tìm kiếm sản phẩm.....">
                    <input type="hidden" name="action" value="search-catalog" />
                </form>
            </div>
        </div>
        <!-- Search End -->
        <script>
            // Add active class to the current button (highlight it)
            var header = document.getElementById("menu");
            var btns = header.querySelectorAll(".header__menu_item");
            var path = window.location.href.toLowerCase();
            var check = true;
            console.log(btns);
            for (var i = btns.length - 1; i > 0; i--) {
                if (path.includes(btns[i].id)) {
                    btns[i].className += " active";
                    check = false;
                }
            }
            if (check)
                btns[0].className += " active";
        </script>
        <!--Start of Tawk.to Script-->
        <script type="text/javascript">
            var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
            (function () {
                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                s1.async = true;
                s1.src = 'https://embed.tawk.to/62986537b0d10b6f3e754a36/1g4hkmp1j';
                s1.charset = 'UTF-8';
                s1.setAttribute('crossorigin', '*');
                s0.parentNode.insertBefore(s1, s0);
            })();
        </script>
        <!--End of Tawk.to Script-->
    </body>
</html>
