<%@page import="store.shopping.ProductDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Ellena | Trang chủ</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- Css Styles -->
    <jsp:include page="meta.jsp" flush="true"/>
    <jsp:include page="js-plugins.jsp" flush="true" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Great+Vibes&display=swap" rel="stylesheet">
    
    
</head>

<body>
    <jsp:include page="header.jsp" flush="true"/>
    <!-- Categories Section Begin -->
    <%
        List<ProductDTO> newArrivalList = (List<ProductDTO>) session.getAttribute("NEW_ARRIVAL_LIST");
        List<ProductDTO> trendList = (List<ProductDTO>) session.getAttribute("TREND_LIST");
        List<ProductDTO> saleList = (List<ProductDTO>) session.getAttribute("SALE_LIST");
        List<ProductDTO> bestSellerList = (List<ProductDTO>) session.getAttribute("BEST_SELLER_LIST");

    %>
    <section class="categories">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12 col-lg-6 p-0">
                    <div class="categories__item categories__large__item set-bg" data-setbg="img/categories/category-1.jpg">
                        <div class="categories__text">
                            <h1>Enrich The Beauty</h1>
                            Khám phá bộ sưu tập mới nhất của chúng tôi
                            <p style="font-weight: bold;">The Ellena Project</p>
                            <a href="DiscoverController">Mua ngay</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
                            <div class="categories__item set-bg" data-setbg="img/categories/category-2.jpg">
                                <div class="categories__text">
                                    <h4>Nổi Bật</h4>
                                    <p><%=trendList.size()%> sản phẩm</p>
                                    <a href="trend.jsp">Mua ngay</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
                            <div class="categories__item set-bg" data-setbg="img/categories/category-3.jpg">
                                <div class="categories__text">
                                    <h4>Bán Chạy Nhất</h4>
                                    <p><%=bestSellerList.size()%> sản phẩm</p>
                                    <a href="best-seller.jsp">Mua ngay</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
                            <div class="categories__item set-bg" data-setbg="img/categories/category-4.jpg">
                                <div class="categories__text">
                                    <h4>Mới về</h4>
                                    <p><%=newArrivalList.size()%> sản phẩm</p>
                                    <a href="new-arrival.jsp">Mua ngay</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6 p-0">
                            <div class="categories__item set-bg" data-setbg="img/categories/category-5.jpg">
                                <div class="categories__text">
                                    <h4>Khuyến Mãi</h4>
                                    <p><%=saleList.size()%> sản phẩm</p>
                                    <a href="sale-product.jsp">Mua ngay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories Section End -->
   
    
    <!-- Product Section Begin -->
    <%
        if(newArrivalList.size() > 0){
            %>
            
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="section-title">
                        <h4 id="moi-ve">Hàng mới về</h4>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8">
                    <ul class="filter__controls">
                        <li><a class="show-more mt-3" href="new-arrival.jsp">XEM THÊM</a> <span class="fa fa-arrow-right" style="color:black"></span></li>
                    </ul>
                </div>
            </div>
            <div class="row property__gallery">
                <%
                int size = 8;
                if(newArrivalList.size() < 8) size = newArrivalList.size();
                for (int i = 0; i < size; i++) {
                        ProductDTO product = newArrivalList.get(i);
                %>
                <div class="col-lg-3 col-md-4 col-sm-6 mix">
                    <div class="product__item">
                        <div class="product__item__pic">
                            
                            <%
                                if(product.getColorImage().get("key").size() > 1)
                                {
                            %>
                            <div id="new-product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                <div class="carousel-inner">
                                    <%
                                        for (String img : product.getColorImage().get("key")) {
                                    %>
                                    <div class="carousel-item">
                                        <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                        <img class="d-block" src="<%=img%>" alt="First slide">
                                        </a>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <a class="carousel-control-prev" data-target="#new-product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" data-target="#new-product-<%=product.getProductID()%>" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                            <%
                            }else{
                              %>
                              <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                            <img src="<%=product.getColorImage().get("key").get(0)%>">
                              </a>
                            <%}%>
                            <%
                                if (product.getDiscount() != 0) {
                            %>
                            <div class="label sale">Sale</div>
                            <%}%>
                            <ul class="product__hover">
                                <li><a href="<%=product.getColorImage().get("key").get(0)%>" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="ProductRouteController?productID=<%=product.getProductID()%>"><span class="icon_bag_alt"></span></a></li>
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
                <%}%>
            </div>
        </div>
    </section>
            <%
        }
    %>
    <!-- Product Section End -->
    <!-- Banner Section Begin -->
    <section class="banner set-bg" data-setbg="img/banner/banner-1.jpg">
        <div class="container">
            <div class="row">
                <div class="col-xl-7 col-lg-8 m-auto">
                    <div class="banner__slider owl-carousel">
                        <div class="banner__item">
                            <div class="banner__text">
                                <span>Summer sale</span>
                                <h1>Ưu đãi lên đến 50%</h1>
                                <a href="sale-product.jsp">Mua ngay</a>
                            </div>
                        </div>
                        <div class="banner__item">
                            <div class="banner__text">
                                <span>Happy Daily</span>
                                <h1>Good mood, good day</h1>
                                <a href="CategoryRouteController?category=Áo%20thun">Mua ngay</a>
                            </div>
                        </div>
                        <div class="banner__item">
                            <div class="banner__text">
                                <span>Ellena Collection</span>
                                <h1>Be women, be fashion</h1>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Banner Section End -->

    <!-- Trend Section Begin -->
    <%
        if(trendList.size() > 0){
    %>
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="section-title">
                        <h4 id="Noi-bat">Nổi bật</h4>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8">
                    <ul class="filter__controls">
                        <li><a class="show-more mt-3" href="trend.jsp">XEM THÊM</a> <span class="fa fa-arrow-right" style="color:black"></span></li>
                    </ul>
                </div>
            </div>
            <div class="row property__gallery">
                <%
                    int size = 4;
                    if(trendList.size() < 4) size = trendList.size();
                    for (int i = 0; i < size; i++) {
                        ProductDTO product = trendList.get(i);
                %>
                
                <div class="col-lg-3 col-md-4 col-sm-6 mix">
                    <div class="product__item">
                        <div class="product__item__pic set-bg">
                            <%
                                if(product.getColorImage().get("key").size() > 1)
                                {
                            %>
                            <div id="trend-product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                <div class="carousel-inner">
                                    <%
                                        for (String img : product.getColorImage().get("key")) {
                                    %>
                                    <div class="carousel-item">
                                        <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                        <img class="d-block" src="<%=img%>"  width="100%">
                                        </a>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <a class="carousel-control-prev" data-target="#trend-product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" data-target="#trend-product-<%=product.getProductID()%>" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                            <%}else{
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
                                <li><a href="ProductRouteController?productID=<%=product.getProductID()%>"><span class="icon_bag_alt"></span></a></li>
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
             
                <%}%>
            </div>
        </div>
    </section>
             <%
        }
    %>
    <!-- Trend Section End -->
    <!-- Best-seller Section Begin -->
    <%
        if(bestSellerList.size() > 0){
    %>
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="section-title">
                        <h4 id="Ban-chay-nhat">Bán chạy nhất</h4>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8">
                    <ul class="filter__controls">
                        <li><a class="show-more mt-3" href="best-seller.jsp">XEM THÊM</a> <span class="fa fa-arrow-right" style="color:black"></span></li>
                    </ul>
                </div>
            </div>
            <div class="row property__gallery">
                <%  
                    int size = 4;
                    if(bestSellerList.size() < 4) size = bestSellerList.size();
                    for (int i = 0; i < size; i++) {
                        ProductDTO product = bestSellerList.get(i);
                %>
                
                <div class="col-lg-3 col-md-4 col-sm-6 mix women">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="<%=product.getColorImage().get("key").get(0)%>">
                            <div id="new-product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                <div class="carousel-inner">
                                    <%
                                        for (String img : product.getColorImage().get("key")) {
                                    %>
                                    <div class="carousel-item">
                                        <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                        <img class="d-block" src="<%=img%>"  width="100%">
                                        </a>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <a class="carousel-control-prev" data-target="#new-product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" data-target="#new-product-<%=product.getProductID()%>" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                            <%
                                if (product.getDiscount() != 0) {
                            %>
                            <div class="label sale">Sale</div>
                            <%}%>
                            <ul class="product__hover">
                                <li><a href="<%=product.getColorImage().get("key").get(0)%>" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="ProductRouteController?productID=<%=product.getProductID()%>"><span class="icon_bag_alt"></span></a></li>
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
             
                <%}%>
            </div>
        </div>
    </section>
    <%
        }
    %>        
    <!-- Best-seller Section End -->
    <!-- Sale Section Begin -->
    <%
        if(saleList.size() > 0){
    %>
    <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-4">
                    <div class="section-title">
                        <h4 id="Khuyen-mai">Khuyến mãi</h4>
                    </div>
                </div>
                <div class="col-lg-8 col-md-8">
                    <ul class="filter__controls">
                        <li><a class="show-more mt-3" href="sale-product.jsp">XEM THÊM</a> <span class="fa fa-arrow-right" style="color:black"></span></li>
                    </ul>
                </div>
            </div>
            <div class="row property__gallery">
                <%  
                    int size = 4;
                    if(saleList.size() < 4) size = saleList.size();
                    for (int i = 0; i < size; i++) {
                        ProductDTO product = saleList.get(i);
                %>
                
                <div class="col-lg-3 col-md-4 col-sm-6 mix women">
                    <div class="product__item">
                        <div class="product__item__pic set-bg">
                            <%
                                if(product.getColorImage().get("key").size() > 1)
                                {
                            %>
                            <div id="sale-product-<%=product.getProductID()%>" class="carousel slide" data-ride="carousel" data-interval="false">
                                <div class="carousel-inner">
                                    <%
                                        for (String img : product.getColorImage().get("key")) {
                                    %>
                                    <div class="carousel-item">
                                        <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                        <img class="d-block" src="<%=img%>"  width="100%">
                                        </a>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                                <a class="carousel-control-prev" data-target="#sale-product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next" data-target="#sale-product-<%=product.getProductID()%>" role="button" data-slide="next">
                                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                    <span class="sr-only">Next</span>
                                </a>
                            </div>
                            <%}else{
                                  %>
                                  <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                            <img src="<%=product.getColorImage().get("key").get(0)%>"  width="100%">
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
                                <li><a href="ProductRouteController?productID=<%=product.getProductID()%>"><span class="icon_bag_alt"></span></a></li>
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
                
                <%}%>
            </div>
        </div>
    </section>
    <%
        }
    %> 
    <!-- Sale Section End -->
    
    <!-- Services Section Begin -->
    <section class="services spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="services__item">
                        <i class="fa fa-car"></i>
                        <h6>Miễn Phí Vận Chuyển</h6>
                        <p>Cho đơn hàng dưới 5km</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="services__item">
                        <i class="fa fa-money"></i>
                        <h6>Bảo Đảm Hoàn Tiền</h6>
                        <p>Nếu sản phẩm bị lỗi</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="services__item">
                        <i class="fa fa-support"></i>
                        <h6>Hỗ Trợ Online 24/7</h6>
                        <p>Kết nối bất kỳ lúc nào</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="services__item">
                        <i class="fa fa-headphones"></i>
                        <h6>Thanh Toán An Toàn</h6>
                        <p>100% thanh toán bảo mật</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Services Section End -->

    <jsp:include page="footer.jsp" flush="true" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {
        // Add smooth scrolling to all links
        $("a").on('click', function(event) {

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
                }, 800, function() {

                    // Add hash (#) to URL when done scrolling (default click behavior)
                    window.location.hash = hash;
                });
            } // End if
        });
    });
    </script>
    <!-- Js Plugins -->
    <jsp:include page="js-plugins.jsp" flush="true" />
    <script>
    $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
    </script>
</body>

</html>
