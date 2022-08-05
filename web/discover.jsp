<%-- 
    Document   : discover
    Created on : Jun 17, 2022, 11:49:34 PM
    Author     : vankh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Khám phá</title>
        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true" />
    </head>
    <body>
        <%
            // checking if using ShowController or SearchController page count
            boolean searchAll = false;
            String minAmount = request.getAttribute("MIN_AMOUNT").toString();//For storing request param for pagnation
            if (minAmount == null) {
                minAmount = "";
            }
            String maxAmount = request.getAttribute("MAX_AMOUNT").toString();//For storing request param for pagnation
            if (maxAmount == null) {
                maxAmount = "";
            }

            String colorListSearch = "";
            String sizeListSearch = "";

            List<String> colorList = (List<String>) request.getAttribute("LIST_COLORS");
            if (colorList != null) {
                // connect into 1 string to pass param
                for (String item : colorList) {
                    colorListSearch = colorListSearch + item + "-";
                }
            }
            List<String> sizeList = (List<String>) request.getAttribute("LIST_SIZES");
            if (sizeList != null) {
                // connect into 1 string to pass param
                for (String item : sizeList) {
                    sizeListSearch = sizeListSearch + item + "-";
                }
            }


        %>


        <jsp:include page="header.jsp" flush="true" />
        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <span>Khám phá</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Shop Section Begin -->
        <section class="shop spad">
            <div class="container">
                <!--                <form action="MainController" method="POST">-->
                <div class="row">
                    <div class="col-lg-3 col-md-3">
                        <form action="MainController" method="POST">
                            <div class="shop__sidebar">

                                <div class="sidebar__filter">
                                    <div class="section-title">
                                        <h4>Giá</h4>
                                    </div>
                                    <!--                                    <form action="MainController">-->
                                    <div class="filter-range-wrap">

                                        <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                             data-min="100000" data-max="1000000"></div>

                                            <div class="range-slider">
                                                <div class="price-input">
                                                    <p>Price:</p>
                                                    <input type="text" readonly="" id="minamount" name="minAmount">
                                                    <span>₫  - </span>
                                                    <input type="text" readonly="" id="maxamount" name="maxAmount">
                                                    <span>₫</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="search" value="">
                                </div>
                                <div class="sidebar__sizes">
                                    <div class="section-title">
                                        <h4>Màu sắc</h4>
                                    </div>
                                    <div>
                                        <ul style="list-style: none;">
                                            <li>
                                                <input type="checkbox" value="Đen" name="color" id="Đen"/>                                               
                                                <label for="Đen">Đen</label>
                                            </li>
                                            <li>
                                                <input type="checkbox" value="Hồng" name="color" id="Hồng"/>   
                                                <label for="Hồng">Hồng</label>
                                            </li>
                                            <li>
                                                <input type="checkbox" value="Đỏ" name="color" id="Đỏ"/>
                                                <label for="Đỏ">Đỏ</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="Xanh" name="color" id="Xanh"/>
                                                <label for="Xanh">Xanh</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="Xanh nhạt" name="color" id="Xanh nhạt"/>
                                                <label for="Xanh nhạt">Xanh nhạt</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="Trắng" name="color" id="Trắng"/>
                                                <label for="Trắng">Trắng</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="Be" name="color" id="Be"/>
                                                <label for="Be">Be</label>
                                            </li><br>
                                            <div class="section-title">
                                                <h4>Kích cỡ</h4>
                                            </div>
                                            <li>

                                                <input type="checkbox" value="XS" name="size" id="XS"/>
                                                <label for="XS">XS</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="S" name="size" id="S"/>
                                                <label for="S">S</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="M" name="size" id="M"/>
                                                <label for="M">M</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="L" name="size" id="L"/>
                                                <label for="L">L</label>
                                            </li>
                                            <li>

                                                <input type="checkbox" value="XL" name="size" id="XL"/>
                                                <label for="XL">XL</label>
                                            </li>

                                        </ul>
                                    </div>
                                </div>

                          

                            <button class="site-btn" type="submit" name="action" value="filter-all-products">Lọc</button>

                            <!--switch to SearchController page count after submit form-->
                            <%                                searchAll = (boolean) request.getAttribute("SWITCH_SEARCH");
                            %>

                        </form>
                    </div>
                    
                    <%
                        List<ProductDTO> searchCatalog = (List<ProductDTO>) session.getAttribute("SEARCH_CATALOG");
                        if (searchCatalog.size() > 0) {

                    %>
                    <div class="col-lg-9 col-md-9">
                        <div class="row property__gallery">
                            <% for (int i = 0; i < searchCatalog.size(); i++) {
                                    ProductDTO product = searchCatalog.get(i);
                                    Iterator<List<String>> key = product.getColorSizeQuantity().keySet().iterator();
                                    List<String> colorSize = new ArrayList<>();
                                    while (key.hasNext()) {
                                        colorSize = key.next();
                                    }
                            %>
                            <div class="col-lg-4 col-md-6 all mix <%for (String s : colorSize) {%><%= s.replaceAll("\\s", "")%> <%}%>">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg">
                                        <%
                                            if (product.getColorImage().get("key").size() > 1) {
                                        %>
                                        <div id="product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                            <div class="carousel-inner">
                                                <%
                                                    for (String img : product.getColorImage().get("key")) {
                                                %>
                                                <div class="carousel-item">
                                                    <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                                    <img class="d-block" src="<%=img%>">
                                                    </a>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                            <a class="carousel-control-prev" data-target="#product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Previous</span>
                                            </a>
                                            <a class="carousel-control-next" data-target="#product-<%=product.getProductID()%>" role="button" data-slide="next">
                                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                <span class="sr-only">Next</span>
                                            </a>
                                        </div>
                                        <%} else {
                                        %>
                                        <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                        <img src="<%=product.getColorImage().get("key").get(0)%>">
                                        </a>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (product.getDiscount() != 0) {
                                        %>
                                        <div class="label sale">Sale</div>
                                        <%}%>
                                        <ul class="product__hover">
                                            <li><a href="<%=product.getColorImage().get("key").get(0)%>" class="image-popup"><span class="arrow_expand"></span></a></li>
                                            <li><a href="#"><span class="icon_bag_alt"></span></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6><a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                                <%=product.getProductName()%></a></h6>
                                                <%
                                                    if (product.getDiscount() != 0) {
                                                %>
                                        <div class="">
                                            <span class="product__price text-danger">
                                                <%= (int) (product.getPrice() - product.getDiscount()) / 1000%>.000đ <span class="original-price"><s>
                                                        <%=product.getPrice() / 1000%>.000đ </s></span></span>
                                            <span class="product__price text-danger"> -
                                                <%=(int) (product.getDiscount() * 100.0 / product.getPrice())%>%</span>
                                        </div>
                                        <%
                                        } else {
                                        %>
                                        <div class="product__price">
                                            <%=product.getPrice() / 1000%>.000đ</div>
                                            <%}%>
                                    </div>
                                </div>
                            </div>
                            <%}
                            } else {%>
                            <div>Không có kết quả tìm kiếm.</div>
                            <%}%>
                        </div>

                        <!--page nav-->
                        <%
                            if (searchCatalog != null) { //if no product in list, page nav won't display
                        %>
                        <div class="row pagination__option" style="justify-content: center; align-items: center; text-align: center;">

                            <%
                                int currentPage = (int) request.getAttribute("currentPage");
                                int noOfPages = (int) request.getAttribute("noOfPages");
                                int noOfPageLinks = 5; // amount of page links to be displayed
                                int minLinkRange = noOfPageLinks / 2; // minimum link range ahead/behind

                                //                    -------------------------------Calculating the begin and end of pageNav for loop-------------------------------
                                //  int begin = ((currentPage - minLinkRange) > 0 ? ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1) ? (currentPage - minLinkRange) : (noOfPages - noOfPageLinks)) : 0) + 1; (referance)
                                int begin = 0;
                                if ((currentPage - minLinkRange) > 0) {
                                    if ((currentPage - minLinkRange) < (noOfPages - noOfPageLinks + 1) || (noOfPages < noOfPageLinks)) { // add in (noOfPages < noOfPageLinks) in order to prevent negative page link
                                        begin = (currentPage - minLinkRange);
                                    } else {
                                        begin = (noOfPages - noOfPageLinks + 1);
                                    }
                                } else {
                                    begin = 1;
                                }

                                //  int end = (currentPage + minLinkRange) < noOfPages ? ((currentPage + minLinkRange) > noOfPageLinks ? (currentPage + minLinkRange) : noOfPageLinks) : noOfPages; (referance)
                                int end = 0;
                                if ((currentPage + minLinkRange) < noOfPages) {
                                    if ((currentPage + minLinkRange) > noOfPageLinks) {
                                        end = (currentPage + minLinkRange);
                                    } else if (noOfPages < noOfPageLinks) {
                                        end = noOfPages; // in case noOfPageLinks larger than noOfPages and display wrong
                                    } else {
                                        end = noOfPageLinks;
                                    }
                                } else {
                                    end = noOfPages;
                                }
                                //                    -----------------------------------------------------------------------------------------------------------------------------

                                if (searchAll) { //Currently at ShowController

                                    //start of pageNav
                                    if (currentPage != 1) {
                            %>

                            <!-- For displaying 1st page link except for the 1st page -->
                            <a href="DiscoverController?page=1"><i style="margin-right: -4px" class="glyphicon glyphicon-menu-left"></i><i class="glyphicon glyphicon-menu-left"></i></a>

                            <!-- For displaying Previous link except for the 1st page -->
                            <a href="DiscoverController?page=<%= currentPage - 1%>"><i class="glyphicon glyphicon-menu-left"></i></a>
                                <%
                                    }
                                %>

                            <!--For displaying Page numbers. The when condition does not display a link for the current page-->

                            <%  for (int i = begin; i <= end; i++) {
                                    if (currentPage == i) {
                            %>
                            <a class="active" style="background: #ca1515; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                            <%
                            } else {
                            %>
                            <a href="DiscoverController?page=<%= i%>" style="text-decoration: none;"><%= i%></a>
                            <%
                                    }
                                }
                            %>


                            <!--For displaying Next link -->
                            <%
                                if (currentPage < noOfPages) {
                            %>
                            <a href="DiscoverController?page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                            <!-- For displaying last page link except for the last page -->
                            <a href="DiscoverController?page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-right"></i></a>


                            <%
                                }

                                //                end of pageNav
                            %>



                            <%            } else {//Currently at SearchController
                                //                    start of pageNav
                                if (currentPage != 1) {
                            %>

                            <!-- For displaying 1st page link except for the 1st page -->
                            <a href="FilterAllProductsController?listColors=<%= colorListSearch%>&listSizes=<%= sizeListSearch%>&minAmount=<%= minAmount%>&maxAmount=<%= maxAmount%>&page=1"><i style="margin-right: -4px" class="glyphicon glyphicon-menu-left"></i><i class="glyphicon glyphicon-menu-left"></i></a>

                            <!-- For displaying Previous link except for the 1st page -->
                            <a href="FilterAllProductsController?listColors=<%= colorListSearch%>&listSizes=<%= sizeListSearch%>&minAmount=<%= minAmount%>&maxAmount=<%= maxAmount%>&page=<%= currentPage - 1%>" style="text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i></a>
                                <%
                                    }
                                %>

                            <!--For displaying Page numbers. The when condition does not display a link for the current page--> 

                            <%  for (int i = begin; i <= end; i++) {
                                    if (currentPage == i) {
                            %>
                            <a class="active" style="background: #ca1515; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                            <%
                            } else {
                            %>
                            <a href="FilterAllProductsController?listColors=<%= colorListSearch%>&listSizes=<%= sizeListSearch%>&minAmount=<%= minAmount%>&maxAmount=<%= maxAmount%>&page=<%= i%>"><%= i%></a>
                            <%
                                    }
                                }
                            %>


                            <!--For displaying Next link -->
                            <%
                                if (currentPage < noOfPages) {
                            %>
                            <a href="FilterAllProductsController?listColors=<%= colorListSearch%>&listSizes=<%= sizeListSearch%>&minAmount=<%= minAmount%>&maxAmount=<%= maxAmount%>&page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                            <!-- For displaying last page link except for the last page -->
                            <a href="FilterAllProductsController?listColors=<%= colorListSearch%>&listSizes=<%= sizeListSearch%>&minAmount=<%= minAmount%>&maxAmount=<%= maxAmount%>&page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i class="glyphicon glyphicon-menu-right"></i></a>


                            <%
                                    }

                                }
                                //                end of pageNav

                            %>

                        </div>




                        <%                            } //end of the "No product" if statement
%>






                    </div>
                </div>
            </div>
        </section>

        <jsp:include page="footer.jsp" flush="true" />


        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                // Add smooth scrolling to all links
                $("a").on('click', function (event) {

                    // Make sure this.hash has a value before overriding default behavior
                    if (this.hash !== "") {
                        // Prevent default anchor click behavior
                        event.preventDefault();

                        // Store hash
                        var hash = this.hash;

                        // Using jQuery's animate() method to add smooth page scroll
                        // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                        $('html, body').animate({
                            scrollTop: $(hash).offset().top
                        }, 800, function () {

                            // Add hash (#) to URL when done scrolling (default click behavior)
                            window.location.hash = hash;
                        });
                    } // End if
                });
            });
        </script>
        <jsp:include page="js-plugins.jsp" flush="true" />
        <script>
            $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
        </script>

    </body>
</html>
