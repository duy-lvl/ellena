<%-- 
    Document   : order-history
    Created on : Jun 27, 2022, 5:45:04 PM
    Author     : giama
--%>

<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page import="store.shopping.CartProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Lịch Sử Đơn Hàng</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <%
            // get cart message
            String message = (String) request.getAttribute("MESSAGE");
            String SUCCESS = "SUCCESS";
            if (message == null) {
                message = "";
            } else if (message == SUCCESS) {
        %>
        <div class="alert alert-success" role="alert">
            <strong>Thành công!</strong> Cảm ơn bạn đã đánh giá sản phẩm.
            <button type="button" class="close" data-toggle="alert">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <%
            }
        %>


        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <span>Lịch sử mua hàng</span>
                        </div>
                    </div>
                </div>
                <!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center; color: red">
                        <%= message%>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <% List<Pair<OrderDTO, List<OrderDetailDTO>>> list = (List<Pair<OrderDTO, List<OrderDetailDTO>>>) request.getAttribute("ORDER_HISTORY");
        %>
        <!-- Shop Cart Section Begin -->
        <%
            if (list != null) {
                if (list.size() > 0) {
        %>
        <section class="shop-cart spad">

            <% for (Pair<OrderDTO, List<OrderDetailDTO>> order : list) {%>
            <div class="container" style="margin-bottom: 20px">
                <article class="card">
                    <h5 class="card-header p-3">
                        Mã đơn hàng: <%=order.getKey().getOrderID()%>
                        <% if ("Chưa xác nhận".equalsIgnoreCase(order.getKey().getStatusName())) {%>
                        <button type="button" class="btn btn-danger" style="float: right; padding: 12px 15px 8px; text-align: center; font-weight: 600" data-toggle="modal" data-target="#<%=order.getKey().getOrderID()%>Modal">HUỶ ĐƠN HÀNG</button>
                        <div class="modal fade" id="<%=order.getKey().getOrderID()%>Modal" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title">Huỷ đơn hàng</h4>
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Bạn có chắc muốn huỷ đơn hàng này?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type='button' class='btn btn-default' data-dismiss="modal">Huỷ</button>
                                        <a href="MainController?action=CancelOrder&orderID=<%=order.getKey().getOrderID()%>&payType=<%=order.getKey().getPayType()%>"><button type="button" class="btn btn-danger">Xác nhận</button></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a style="float: right" class="mr-2" href="MainController?action=CustomerViewOrderDetail&orderID=<%=order.getKey().getOrderID()%>"><button class="primary-btn">CHI TIẾT</button></a>

                        <%}else{%>
                        <a style="float: right" class="mr-2" href="MainController?action=CustomerViewOrderDetail&orderID=<%=order.getKey().getOrderID()%>"><button class="primary-btn">CHI TIẾT</button></a>
                        <p class="mr-4 mt-3" style="float: right; color: #ca1515; font-weight: 500"><%=order.getKey().getStatusName()%></p>
                        <%}%>



                    </h5>
                    <div class="card-body">
                        <%
                            // number format
                            NumberFormat numberFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                            for (int i = 0; i < order.getValue().size(); i++) {
                                if (i % 4 == 0 || i == 0) {
                        %>
                        <div class="d-flex flex-row" style="justify-content: flex-start">
                            <%}%>
                            <div class="order__product__item p-5">
                                <img src="<%= order.getValue().get(i).getImage()%>" alt="product-image" style="width: 80px; float: left">
                                <div class="order__product__item__title">
                                    <a href="ProductRouteController?productID=<%= order.getValue().get(i).getProductID()%>">
                                        <h6 class="mb-3"><%= order.getValue().get(i).getProductName()%></h6>
                                    </a>
                                    <%= order.getValue().get(i).getColor()%>, <%= order.getValue().get(i).getSize()%> x <%= order.getValue().get(i).getQuantity()%><br>
                                    <p style="font-weight: 500; color: black"><%= numberFormat.format(order.getValue().get(i).getPrice())%></p>

                                </div>
                            </div>
                            <%if ((i % 3 == 0 & i != 0) || i == order.getValue().size() - 1) {%>
                        </div>
                        <%}
                            }%>  
                    </div>
                    <div class="d-flex flex-row-reverse order__total mr-4 my-3" style="font-size: 20px">
                        Tổng: <%= numberFormat.format((int) (order.getKey().getTotal()))%>
                    </div>  
                    <%
                        if (order.getKey().getStatusName().equalsIgnoreCase("ĐÃ GIAO")) {
                            Date today = new Date();
                            Date orderDate = order.getKey().getOrderDate();
                            long diffInMillies = today.getTime() - orderDate.getTime();
                            long dateDiff = TimeUnit.MILLISECONDS.toDays(diffInMillies);
                            if(dateDiff <= 45){
                    %>
                    <div class="d-flex flex-row-reverse mr-3 mb-3">
                        <!-- button to rating page -->
                        <a href="RatingController?orderID=<%=order.getKey().getOrderID()%>"><button class="primary-btn"><i class="fa fa-star"></i>Ðánh giá</button></a>
                    </div> 
                    <%}}%>
                </article>
            </div>
            <hr/>
            <%}%>

        </section>
        <!-- Shop Cart Section End -->

        <%      }
        } else {%>
        <div style="text-align: center;">
            <div style="margin-bottom: 20px;">
                <img src="./images/empty-cart.png" alt="Empty cart"/>
            </div>

            <div>
                <h6 style="margin-bottom: 20px;">Bạn chưa có đơn hàng nào. Bắt đầu mua hàng thôi!</h6>
            </div>

            <div class="cart__btn">
                <a href="home.jsp">Start Shopping</a>
            </div>

        </div>    
        <%}%>
        <!-- Search Begin -->
        <div class="search-model">
            <div class="h-100 d-flex align-items-center justify-content-center">
                <div class="search-close-switch">+</div>
                <form class="search-model-form">
                    <input type="text" id="search-input" placeholder="Search here.....">
                </form>
            </div>
        </div>
        <!-- Search End -->

        <jsp:include page="footer.jsp" flush="true" />
    </script>
    <!-- Js Plugins -->
    <jsp:include page="js-plugins.jsp" flush="true" />
</body>
</html>
