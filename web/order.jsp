<%-- 
    Document   : order
    Created on : Jun 29, 2022, 8:14:06 PM
    Author     : giama
--%>

<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Chi Tiết Đơn Hàng</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Css Styles -->
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <%
            // get cart message
            String message = (String) request.getAttribute("CART_MESSAGE");
            if (message == null) {
                message = "";
            }
        %>
        <style>
            .track{
                position: relative;
                background-color: #ddd;
                height: 7px;
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                margin-bottom: 60px;
                margin-top: 50px
            }
            .track .step{
                -webkit-box-flex: 1;
                -ms-flex-positive: 1;
                flex-grow: 1;
                width: 25%;
                margin-top: -18px;
                text-align: center;
                position: relative
            }
            .track .step.active:before{
                background: #ca1515;
            }
            .track .step::before{
                height: 7px;
                position: absolute;
                content: "";
                width: 100%;
                left: 0;
                top: 18px
            }
            .track .step.active .icon{
                background: #ca1515;
                color: #fff
            }
            .track .icon{
                display: inline-block;
                width: 40px;
                height: 40px;
                line-height: 40px;
                position: relative;
                border-radius: 100%;
                background: #ddd
            }
            .track .step.active .text{
                font-weight: 400;
                color: #000
            }
            .track .text{
                display: block;
                margin-top: 7px
            }

            .form-control[readonly] {
                background-color: white
            }
        </style>
        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center;">
                        <%= message%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./index.html"><i class="fa fa-home"></i> Trang chủ</a>
                            <span>Giỏ hàng</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->
        <% 
            // number format
            NumberFormat numberFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            Pair<OrderDTO, List<OrderDetailDTO>> order = (Pair<OrderDTO, List<OrderDetailDTO>>) request.getAttribute("ORDER_DETAILS");
        %>
        <!-- Shop Cart Section Begin -->
        <section class="shop-cart spad">
            <div class="container">
                <div class="row" style="margin-bottom: 50px">
                    <div class="col-lg-12">
                        <article class="card">
                            <header class="card-header"> Theo dõi đơn hàng 
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
                                <%}%>
                            </header>
                            <div class="card-body">
                                <h6 class="mb-2" style="font-size: 18px; color: #ca1515">Mã đơn hàng: <%=order.getKey().getOrderID()%></h6>
                                <article class="card">
                                    <div class="card-body row">
                                        <div class="col"> <strong>Trạng thái:</strong> <br> <%=order.getKey().getStatusName()%> </div>
                                        <div class="col"> <strong>Mã vận đơn:</strong> <br>  <% if (order.getKey().getTrackingID() == null) {%>N/A<%} else {%>
                                            <%=order.getKey().getTrackingID()%>
                                            <%}%> </div>
                                    </div>
                                </article>
                                <div class="track">
                                    <div class="step active"> <span class="icon pl-2"> <i class="fa fa-check"></i> </span> <span class="text"><p class="m-0">Đặt hàng</p><p><%=order.getKey().getStatus().get(1)%></p></span></div>


                                    <%if (order.getKey().getStatus().containsKey(5)) {%>
                                    <div class="step active"> <span class="icon pl-2"> <i class="fa fa-times"></i> </span> <span class="text"><p class="m-0">Đơn hàng đã bị huỷ</p><p><%=order.getKey().getStatus().get(1)%></p></span></div>
                                    <%} else if (order.getKey().getStatus().containsKey(6)) {%>
                                    <div class="step active"> <span class="icon pl-3"> <i class="fa fa-spinner"></i> </span> <span class="text"><p class="m-0">Đơn hàng đã bị huỷ/Chờ hoàn tiền</p><p><%=order.getKey().getStatus().get(6)%></p></span></div>
                                    <div class="step <%if (order.getKey().getStatus().containsKey(7)) {%>active<%}%>"> <span class="icon pl-3"> <i class="fa fa-money"></i> </span> <span class="text"><p class="m-0">Đã hoàn tiền</p><p><% if (order.getKey().getStatus().get(7) != null) {%>
                                                <%=order.getKey().getStatus().get(7)%><%}%></p></span></div>
                                                <%} else {%>
                                    <div class="step <%if (order.getKey().getStatus().containsKey(2)) {%>active<%}%>"> <span class="icon pl-3"> <i class="fa fa-user"></i> </span> <span class="text"><p class="m-0">Đơn hàng được xác nhận</p><p><%if (order.getKey().getStatus().containsKey(2)) {%><%=order.getKey().getStatus().get(2)%><%}%></p></span></div>
                                    <div class="step <%if (order.getKey().getStatus().containsKey(3)) {%>active<%}%>"> <span class="icon pl-3"> <i class="fa fa-truck"></i> </span> <span class="text"><p class="m-0">Đang giao hàng</p><p><%if (order.getKey().getStatus().containsKey(3)) {%><%=order.getKey().getStatus().get(3)%><%}%></p></span></div>
                                    <div class="step <%if (order.getKey().getStatus().containsKey(4)) {%>active<%}%>"> <span class="icon pl-3"> <i class="fa fa-cube"></i> </span> <span class="text"><p class="m-0">Giao hàng thành công</p><p><%if (order.getKey().getStatus().containsKey(4)) {%><%=order.getKey().getStatus().get(4)%><%}%></p></span> </div>
                                    <%if (order.getKey().getStatus().containsKey(8)) {%><div class="step active"> <span class="icon pl-3"> <i class="fa fa-exchange"></i> </span> <span class="text"><p class="m-0">Đổi/trả hàng</p><p><%=order.getKey().getStatus().get(8)%></p></span> </div><%}%>
                                    <%}%>
                                </div>
                            </div>
                            <hr/>
                            <div class="row mt-5 ml-5">
                                <div class="col-lg-12">
                                    <div class="shop__cart__table mb-20">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Sản phẩm</th>
                                                    <th>Giá</th>                 
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (OrderDetailDTO orderDetail : order.getValue()) {
                                                %>

                                                <tr>
                                                    <td class="cart__product__item">
                                                        <img src="<%= orderDetail.getImage()%>" alt="product-image" style="width: 80px;">
                                                        <div class="cart__product__item__title">
                                                            <a href="ProductRouteController?productID=<%= orderDetail.getProductID()%>">
                                                                <h6 class="mb-3"><%= orderDetail.getProductName()%></h6>
                                                            </a>    
                                                            <%= orderDetail.getColor()%>, <%= orderDetail.getSize()%> <%if (orderDetail.getQuantity() != 0) {%> x <%= orderDetail.getQuantity()%> 
                                                            <%} else {%> 
                                                            <br/>
                                                            <%= orderDetail.getReturnStatus()%>: <%= orderDetail.getNote()%>
                                                            <%}%>

                                                        </div>
                                                    </td>

                                                    <td class="cart__price">
                                                        <%= numberFormat.format(orderDetail.getPrice()) %>
                                                    </td>
                                                    <%}%>
                                                <tr>
                                                    <td></td>


                                                    <td colspan="2" class="cart__total" style="font-size: 24px">Tổng: <%= numberFormat.format((int) (order.getKey().getTotal())) %></td>
                                                </tr>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </article>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-7">
                        <div class="card">
                            <div class="card-header">Thông tin người nhận</div>
                            <div class="card-body pl-5">
                                <div class="row pt-5">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="fullName">Họ và tên</label>
                                            <input type="text" class="form-control form-control-sm" name="fullname" value="${requestScope.ORDER_DETAILS.getKey().getFullName()}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-7">
                                        <div class="form-group">
                                            <div class="form-row">
                                                <div class="col">
                                                    <label for="address">Địa chỉ</label>
                                                    <input type="text" name="address" class="form-control form-control-sm" value="${requestScope.ORDER_DETAILS.getKey().getAddress()}" readonly>
                                                </div>                  
                                            </div>
                                        </div>                                
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-4">
                                        <div class="form-group">
                                            <label for="phone">SDT</label>
                                            <input type="text" name="phone"class="form-control form-control-sm" value="${requestScope.ORDER_DETAILS.getKey().getPhone()}" readonly>
                                        </div>
                                    </div>
                                    <div class="col-lg-7">
                                        <div class="form-group">
                                            <label for="email">Email</label>
                                            <input type="text" name="email" class="form-control form-control-sm" value="${requestScope.ORDER_DETAILS.getKey().getEmail()}" readonly>
                                        </div>
                                    </div>    
                                </div>
                                <div class="row">
                                    <div class="col-lg-11">

                                        <div class="form-group">
                                            <label for="note">Ghi chú</label>
                                            <textarea type="text" name="note" class="form-control form-control-sm" rows="4" value="${requestScope.ORDER_DETAILS.getKey().getNote()}" readonly></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



            </div>

        </section>
        <!-- Shop Cart Section End -->
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
