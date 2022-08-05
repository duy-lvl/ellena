<%@page import="javafx.util.Pair"%>
<%@page import="java.util.Collection"%>
<%@page import="store.shopping.RatingDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <% ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Ellena Fashion Shop">
        <meta name="keywords" content="Ellena, fashion, creative, shop">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title><%= product.getProductName()%></title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            .color-nav::before{
                content:none!important;
            }
            .color-nav::after{
                content:none!important;
            }
            .color-nav a{
                border: 1px solid #ddd!important;
            }
            
            .sizes__container{
                all:unset;
            }
            .sizes__container {
                display: inline-block;
                list-style-type: none;
                padding: 0;
            }

            .sizes__container li {
                float: left;
                margin-right:1rem;
                width: 5rem;
                height: 4rem;
               
                position: relative;
            }

            .sizes__container label,
            .sizes__container input {
                display: block;
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
            }

            .sizes__container input[type="radio"] {
                opacity: 0.01;
                z-index: 100;
            }
           

            .sizes__container input[type="radio"]:checked+label,
            .Checked+label {
                background: #ca1515;
                color:white;
            }

            .sizes__container label {
                padding: 5px;
                border-radius: 0.5rem;
                border: 1px solid #CCC;
                cursor: pointer;
                z-index: 90;
                text-align: center;
            }

            .sizes__container label:hover {
                background: #DDD;
            }
            .color-nav>li{
                margin: 0!important;
                
            }
            .color-nav>li>a{
                border-radius: 0.5rem!important;
                color:#000;
                padding: 0.75rem 1.5rem!important;
                margin-right: 1rem!important;
            }
            
            .color-nav>li.active>a{
                background: #ca1515!important;
                color: white!important;
            }
            .out-of-stock{
                color:#ddd;
            }
            .out-of-stock:hover{
                background: #fff!important;
                cursor: default;
            }
            
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" flush="true"/>

        <!-- Breadcrumb -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i>Trang Chủ</a>
                            <a href="CategoryRouteController?category=<%= product.getCategoryName()%>"><%= product.getCategoryName()%></a>
                            <span><%= product.getProductName()%></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <% session.setAttribute("productID", product.getProductID());
            String failureMsg = (String) request.getAttribute("QUANTITY_MESSAGE");
            String successMsg = (String) request.getAttribute("ADD_TO_CART_MESSAGE");
            if (successMsg != null) {
        %>

        <!-- Add to cart SUCCESS message pop-up -->
        <div class="alert alert-success add-to-cart-notify" id="add-to-cart-notify" style="text-align: center; margin-bottom: 0;">
            <%= successMsg%>
            <button type="button" class="close" data-dismiss="alert">x</button>
            <input type="hidden" id="add-to-cart-message" value="<%= successMsg%>"/>
        </div>

        <%}
            if (failureMsg != null) {
        %>

        <!-- Add to cart FAIL message pop-up -->
        <div class="alert alert-danger add-to-cart-notify" id="add-to-cart-notify" style="text-align: center; margin-bottom: 0;">
            <%= failureMsg%>
            <button type="button" class="close" data-dismiss="alert">x</button>
            <input type="hidden" id="quantity-message" value="<%= failureMsg%>"/>
        </div>

        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p><%=successMsg%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div> 
        <%}%>
        
        <!-- Product Details Section Begin -->
        <section class="product-details spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="product__details__pic">
                            <div class="product__details__pic__left product__thumb nice-scroll">
                                <% Collection<List<String>> values = product.getColorImage().values();
                                    int z = 1;
                                    for (List<String> v : values) {
                                        for (String image : v) {
                                %>                                       
                                <a class="pt <%if (z == 1) {%> active <%}%>" href="#product-<%= z%>">
                                    <img src="<%= image%>" alt="<%= product.getProductName()%>">
                                </a>
                                <% z++;
                                        }
                                    }%>
                            </div>
                            <div class="product__details__slider__content">
                                <div class="product__details__pic__slider owl-carousel">
                                    <%
                                        int q = 1;
                                        for (List<String> v : values) {
                                            for (String image : v) {
                                    %>   
                                    <img data-hash="product-<%= q%>" class="product__big__img" src="<%=image%>" alt="<%= product.getProductName()%>">
                                    <% q++;
                                            }
                                        }%>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% int[] ratingDetails = (int[]) request.getAttribute("PRODUCT_RATING_DETAILS");%>
                    <div class="col-lg-6">
                        <div class="product__details__text">
                            <h3><%= product.getProductName()%></h3>
                            <div class="rating">
                                <% int averageStar = (int) Math.ceil(ratingDetails[0]);
                                    for (int s = 1; s <= averageStar; s++) { %>
                                <i class="fa fa-star"></i>
                                <%}
                                    if (averageStar != 5) {
                                        for (int i = 0; i < 5 - averageStar; i++) {
                                %>
                                <i class="fa fa-star-o"></i>
                                <%}
                                    }%>
                                <span>(<%= ratingDetails[1]%> đánh giá)</span>
                            </div>
                            <%

                                if (product.getDiscount() != 0) {
                            %>
                            <div class="product__details__price"><%= (int) (product.getPrice() - product.getDiscount()) / 1000%>.000đ<span><%=product.getPrice() / 1000%>.000đ </span></div>
                            <%
                            } else {
                            %>
                            <div class="product__details__price">
                                <%=product.getPrice() / 1000%>.000đ</div>
                                <%}%>
                            <p><%= product.getDescription()%></p>

                            <div class="product__details__widget border-0">
                                <ul>
                                    <li>
                                        <ul class="mt-2 mb-5 nav nav-tabs color-nav justify-content-start">

                                            <% Iterator<String> it = product.getColorImage().keySet().iterator();
                                                int i = 1;
                                                List<String> colorList = new ArrayList<>();
                                                while (it.hasNext()) {
                                                    String color = it.next();
                                                    colorList.add(color);  %>      

                                            <li <%if (i == 1) { %> class="active" <%}%>><a class="p-2 px-4" data-toggle="tab" href="#<%= color%>-size"><%= color%></a></li>

                                            <% i++;
                                                }%>                             
                                        </ul>

                                    </li>
                                    <li>
                                        <div class="tab-content">
                                            <%
                                                Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                                                
                                                int g = 1;
                                                List<String> key = new ArrayList<>();
                                                List<Integer> quantity = new ArrayList<>();
                                                while (it1.hasNext()) {
                                                    List<String> colorSize = it1.next();
                                                    for (String n : colorSize) {
                                                        key.add(n);
                                                    }
                                                    quantity.add(product.getColorSizeQuantity().get(colorSize));
                                                }
                                                int k = 1; 
                                                for (String color : colorList) {
                                            %>

                                            <div id="<%=color%>-size" class="tab-pane <%if (g == 1) { %> in active <%}%>">
                                                <form action="AddToCartController" id="get<%=color%>SizeForm">
                                                    <div class="sizes__container">
                                                        <input type="hidden" name="color" value="<%=color%>"/>
                                                        <% 
                                                            for (int a = 0; a < key.size(); a += 2) {
                                                            if (color.equalsIgnoreCase(key.get(a)) ) {
                                                                if(quantity.get(a/2) > 0){
                                                        %>                                          
                                                            <li>
                                                                <input type="radio" id="size<%= k%>" required="" name="size" value="<%= key.get(a + 1)%>" />
                                                                <label for="size<%= k %>"><%= key.get(a + 1)%></label>
                                                            </li>
                                                        <% }else{
                                                        %>
                                                            <li >
                                                                <input type="radio" id="size<%= k%>" required="" name="size" value="<%= key.get(a + 1)%>" disabled/>
                                                                <label class="out-of-stock" for="size<%= k %>"><%= key.get(a + 1)%></label>
                                                            </li>
                                                        <%
                                                            }
                                                            k++;}
                                                        }%>
                                                    </div>
                                                    <div class="product__details__button">
                                                        <div class="quantity">
                                                            <span>Số lượng</span>
                                                            <div class="pro-qty">
                                                                <input class="m-0" name="quantity" id="quantity" type="number" value="1">
                                                            </div>
                                                        </div>
                                                        <button type="submit" form="get<%=color%>SizeForm" class="cart-btn" id="add-to-cart-hyperlink">
                                                                Thêm vào giỏ hàng
                                                        </button>
                                                    </div>
                                                </form>
                                            </div>



                                            <% g++;
                                                }%>
                                        </div>

                                    </li>
                                    <li style="margin-top: 4%;">
                                        <span>Giảm giá:</span>
                                        <p><%= (int) (product.getDiscount() * 100.0 / product.getPrice())%>%</p>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="product__details__tab">
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab">MÔ TẢ SẢN PHẨM</a>
                                </li>                              
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab">ĐÁNH GIÁ (<%= ratingDetails[1]%>)</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                    <h6>MÔ TẢ SẢN PHẨM</h6>
                                    <p><%= product.getDescription()%></p>
                                </div>

                                <div class="tab-pane" id="tabs-2" role="tabpanel">
                                    <h6>ĐÁNH GIÁ (<%= ratingDetails[1]%>)</h6>
                                    <% List<RatingDTO> ratingList = (List<RatingDTO>) request.getAttribute("RATING_LIST");
                                    if(ratingList.size()>0){
                                        for (RatingDTO rating : ratingList) {
                                    %>
                                    <hr>
                                    <p style="font-weight: bold"><%= rating.getFullName()%></p>
                                    <div class="rating">
                                        <% for (int t = 1; t <= rating.getStar(); t++) { %>
                                        <i class="fa fa-star"></i>
                                        <%}
                                            if (rating.getStar() != 5) {

                                                for (int a = 0; a < 5 - rating.getStar(); a++) {
                                        %>
                                        <i class="fa fa-star-o"></i>
                                        <%}
                                            }%>
                                    </div>
                                    <p><%= rating.getContent()%></p>
                                    <%}}else{%>
                                    <div><i>Hiện tại không có đánh giá cho sản phẩm này.</i></div>
                                    <%}%>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
        <script>
            var colors = document.getElementById('colors');
            var numElems = colors.getElementsByTagName('input');
            for (var c = 0; c < numElems.length; c++) {
                var colorButton = document.getElementById(numElems[c].id);
                colorButton.addEventListener('click', function handleClick() {
                    document.getElementById('sizeQuantityForm').submit();
                });
            }


            function sendQuantity() {
                //                $.post("AddToCartController", {quantity: document.getElementById('quantity').value});
                document.getElementById('quantity').value = document.getElementById('_quantity').value;
                document.getElementById('getSizeForm').submit();
            }


        </script>
        <jsp:include page="footer.jsp" flush="true"/>

        <jsp:include page="js-plugins.jsp" flush="true"/>

    </body>
</html>
