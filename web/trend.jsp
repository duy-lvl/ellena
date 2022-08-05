<%-- 
    Document   : trend.jsp
    Created on : Jun 8, 2022, 10:05:54 AM
    Author     : VP
--%>

<%@page import="store.shopping.ProductDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sản phẩm nổi bật</title>

       <!-- Google Font -->
       <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
       <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
             rel="stylesheet">

       <!-- Css Styles -->
       <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <span>Nổi bật</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
        List<ProductDTO> trendList = (List<ProductDTO>) session.getAttribute("TREND_LIST");
    %>
     <section class="product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-md-5">
                    <div class="section-title">
                        <h4 id="noi-bat">Sản phẩm nổi bật tháng này</h4>
                    </div>
                </div>
            </div>
            <div class="row property__gallery">
                <% for(ProductDTO product : trendList){
                    
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
                                        <img class="d-block" src="<%=img%>" height="100%" width="100%">
                                        </a>
                                    </div>
                                    <%
                                        }
                                    %>                        
                                </div>
                                <a class="carousel-control-prev"  data-target="#trend-product-<%=product.getProductID()%>" role="button" data-slide="prev">
                                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                  <span class="sr-only">Previous</span>
                                </a>
                                <a class="carousel-control-next"  data-target="#trend-product-<%=product.getProductID()%>" role="button" data-slide="next">
                                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                  <span class="sr-only">Next</span>
                                </a>
                              </div>
                                  <%}else{
                                  %>
                                  <a href="ProductRouteController?productID=<%=product.getProductID()%>">
                                  <img src="<%=product.getColorImage().get("key").get(0)%>" height="100%" width="100%">
                                  </a>
                                  <%
                                   }
                                  %>

                                  <%
                                if(product.getDiscount() != 0){
                                    %>
                                 <div class="label sale">Sale</div>   
                            <%}%>
                            <ul class="product__hover">
                                <li><a href="<%=product.getColorImage().get("key").get(0)%>" class="image-popup"><span class="arrow_expand"></span></a></li>
                                <li><a href="ProductRouteController?productID=<%=product.getProductID()%>"><span class="icon_bag_alt"></span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h6><a href="ProductRouteController?productID=<%=product.getProductID()%>"><%=product.getProductName()%></a></h6>
                            <%
                                if(product.getDiscount() != 0){
                                    %>
                           
                            <div class="">
                                <span class = "product__price text-danger"><%= (int)(product.getPrice()-product.getDiscount())/1000%>.000đ <span class="original-price"><s>   <%=product.getPrice()/1000%>.000đ  </s></span></span>
                                  
                                <span class = "product__price text-danger"> -<%=(int)(product.getDiscount()*100.0/product.getPrice())%>%</span>
                            </div>
                            <%
                                }else{
                                %>
                            <div class="product__price"> <%=product.getPrice()/1000%>.000đ</div>
                            <%}%>
                        </div>
                    </div>
                </div>
                   
                <%}%>
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp" flush="true" />

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
    <!-- Js Plugins -->
    <jsp:include page="js-plugins.jsp" flush="true"/>
    <script>
        $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
    </script>
    </body>
</html>
