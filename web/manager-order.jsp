<%@page import="java.text.SimpleDateFormat"%>
<%@page import="store.shopping.OrderStatusDTO"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/manager.css" type="text/css">
        <style>
            /* The container <div> - needed to position the dropdown content */
            .dropdown {
              position: relative;
              display: inline-block;
            }

            /* Dropdown Content (Hidden by Default) */
            .dropdown-content {
              display: none;
              position: absolute;
              background-color: #f1f1f1;
              min-width: 160px;
              box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
              z-index: 1;
            }

            /* Links inside the dropdown */
            .dropdown-content a {
              color: black;
              padding: 12px 16px;
              text-decoration: none;
              display: block;
            }

            /* Change color of dropdown links on hover */
            .dropdown-content a:hover {background-color: #ddd;}

            /* Show the dropdown menu on hover */
            .dropdown:hover .dropdown-content {display: block;}

            /* Change the background color of the dropdown button when the dropdown content is shown */
            .dropdown:hover .dropbtn {background-color: #3e8e41;}
        </style>
    </head>
    <body>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String message = (String) request.getAttribute("MESSAGE");
            String searchValue = request.getAttribute("SEARCH") != null ? (String) request.getAttribute("SEARCH") : "";
            String sOrderStatusID = request.getAttribute("STATUS_ID") != null ? (String) request.getAttribute("STATUS_ID") : "";
            int orderStatusID = 0;
            if (!sOrderStatusID.isEmpty()) {
                orderStatusID = Integer.parseInt(sOrderStatusID);
            }
            String dateFrom = request.getAttribute("DATE_FROM") != null ? (String) request.getAttribute("DATE_FROM") : "";
            String dateTo = request.getAttribute("DATE_TO") != null ? (String) request.getAttribute("DATE_TO") : "";
            if (dateFrom.equals("") || dateTo.equals("")) {
                dateFrom = dateTo = "";
            }
//            checking if using ShowController or SearchController page count
            boolean searchAll = false;
            int currentPage = (int) request.getAttribute("currentPage");
            if (message != null) {
        %>
        <!-- Pop-up thông báo cập nhật thành công -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p><%=message%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div>
        <!--Hết pop-up cập nhật thành công-->
        <%
            }
            String updateTrackingIdMsg = (String) request.getAttribute("UPDATE_TRACKING_ID_MESSAGE");
            if (updateTrackingIdMsg != null) {
        %>
        <!-- Pop-up thông báo cập nhật tracking Id -->
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <%
                            if (updateTrackingIdMsg.contains("\n")) {
                                String msg[] = updateTrackingIdMsg.split("\n");
                                for (String string : msg) {
                        %>
                        <p style="color: red;"><%=string%></p> 


                        <%
                            }
                        } else {

                        %>

                        <p <% if (!updateTrackingIdMsg.equals("Cập nhật thành công")) {%>style="color: red;"<%} else {%>style="color: green;"<%}%>><%=updateTrackingIdMsg%></p>
                        <%}%>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div>
        <!--Hết pop-up cập nhật tracking Id-->
        <%}
            if (loginUser.getRoleID().equals("MN")) {
        %>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        <%} else {%>
        <div class="sidenav">
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="https://dashboard.tawk.to/login"><i class="fa fa-archive fa-lg"></i>Quản lí Q&A</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 

        <%}%>
        <div class="main">

            <div class="flex-item text-right" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h4 class="dropdown">
                        <b>Xin chào, </b>
                        <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                            <button class="dropdown-item btn" role="tab" type="button"><a class="text-dark" href="my-profile.jsp">Thông tin tài khoản</a></button>
                            <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h4>
                </form>
            </div>
            <h2><b>Danh sách đơn hàng</b></h2>
            <form action="SearchOrderController" method="POST">
                <input type="text" name="search" value="<%= searchValue%>" id="search-search" placeholder="Tên khách hàng">

                <select name="search-statusID" id="search-statusID">

                    <%
                        OrderDTO orderDTO = new OrderDTO();
                    %>
                    <option class="p-1" value="" <%if (orderStatusID == 0) {%> selected <%}%>>Tất cả trạng thái</option>

                    <%
                        for (int i = 1; i <= 8; i++) {
                    %>
                    <option value="<%= i%>" <% if (i == orderStatusID) { %> selected  <% }%>>
                        <%= orderDTO.getStatus(i)%>
                    </option>
                    <%}%>
                </select>
                Từ
                <input type="date" name="dateFrom" id="search-dateFrom" value="<%= dateFrom%>"/>
                đến
                <input type="date" name="dateTo" id="search-dateTo" value="<%= dateTo%>"/>
                <button type="submit" name="action" value="SearchOrder" class="btn btn-default" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Tìm kiếm</button>
                <!--switch to SearchController page count after submit form-->
                <%
                    searchAll = (boolean) request.getAttribute("SWITCH_SEARCH");
                %>
            </form>   
            <div class="row">
                <div class="col-md-2">
                    <!--Pop-up cập nhật Tracking ID-->
                    <div class="modal fade" id="myModalTrackingId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog" id="UpdateTrackingId" >
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel"><b>Cập nhật Tracking ID</b></h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                </div>
                                <form action="UpdateTrackingIdController" method="POST">
                                    <div class="modal-body">
                                        <div class="row">

                                            <div class="col-md-12">
                                                <label>ID đơn hàng và Tracking ID tương ứng</label>
                                            </div>
                                            <div class="col-md-12">
                                                <textarea required="" placeholder="ID đơn hàng  Tracking ID" cols="30" rows="20" name="orderTrackingIdList"></textarea>
                                            </div>
                                        </div>

                                        <input type="hidden" name="search" id="update-search" value="<%= searchValue%>"/>
                                        <input type="hidden" name="dateFrom" id="update-dateFrom" value="<%= dateFrom%>"/>
                                        <input type="hidden" name="dateTo" id="update-dateTo" value="<%= dateTo%>"/>
                                        <input type="hidden" name="search-statusID" id="update-statusID" value="<%= sOrderStatusID%>"/>
                                        <input type="hidden" name="page" value="<%= currentPage%>"/>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-default">Cập nhật</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModalTrackingId">Cập nhật tracking ID</button>
                    <!--Hết pop-up cập nhật Tracking ID-->
                </div>
                <div class="col-md-2">
                    <%
                        int countCXN = (int)request.getAttribute("NUMBER_OF_STATUS_1");
                        int countCHT = (int)request.getAttribute("NUMBER_OF_STATUS_6");
                    %>
                    <div class="dropdown">
                        <button class="btn btn-default" style="cursor: default;"<% if (countCHT + countCXN == 0) {%> data-toggle="tooltip" title="Hiện tại không có thông báo mới" <%}%>> 
                            <i class="fa fa-lg fa-bell"></i>
                            <% if (countCHT + countCXN > 0) {%><span id="low-stock__tip"><%= countCHT + countCXN%></span><%}%>
                        </button>
                        <div class="dropdown-content">
                            <% if (countCXN > 0) { %>
                            <div>
                                <form style="margin: 0;" action="SearchOrderController" method="POST">
                                    <input type="hidden" name="search-statusID" value="1"/>
                                    <input type="hidden" name="search" value=""/>
                                    <input type="hidden" name="dateFrom" value=""/>
                                    <input type="hidden" name="dateTo" value=""/>
                                    <button class="btn btn-default" type="submit">
                                        Hiện tại có <%= countCXN%> đơn hàng đang chờ xác nhận
                                    </button>
                                </form>
                            </div>
                            
                                
                            <%} 
                                if (countCHT > 0) {
                            %>
                            <div>
                                <form style="margin: 0;" action="SearchOrderController" method="POST">
                                    <input type="hidden" name="search-statusID" value="6"/>
                                    <input type="hidden" name="search" value=""/>
                                    <input type="hidden" name="dateFrom" value=""/>
                                    <input type="hidden" name="dateTo" value=""/>
                                    <button class="btn btn-default" type="submit">
                                        Hiện tại có <%= countCHT%> đơn hàng đang chờ hoàn tiền
                                    </button>
                                </form>
                            </div>
                            
                            <%}%>
                        </div>
                    </div>
                    
                    
                </div>

            </div>



            <br>${requestScope.EMPTY_LIST_MESSAGE}
            <%
                List<OrderDTO> listOrder = (List<OrderDTO>) request.getAttribute("LIST_ORDER");
                if (listOrder != null) {
                    if (listOrder.size() > 0) {


            %>
            <table class="table table-hover table-bordered table-responsive">
                <colgroup>
                    <col span="1" style="width: 5%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 35%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 8%;">
                </colgroup>
                <tr style="background-color: #b57c68">
                    <th>ID</th>
                    <th>Ngày đặt hàng</th>                
                    <th>Tổng tiền</th>
                    <th>Tên khách hàng</th>
                    <th>Trạng thái</th>
                    <th>Cập nhật trạng thái</th>
                    <th>Trạng thái đơn hàng</th>
                </tr>

                <%            int id = 1;
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                    for (OrderDTO order : listOrder) {
                %>

                <tr>
                    <td style="font-weight: bold"><%= order.getOrderID()%></td>
                    <td><%= sdf.format(order.getOrderDate())%></td>
                    <td><%= order.getTotal()%></td>
                    <td><%= order.getUserName()%></td>
                    <td><%= order.getStatusName()%></td>

                    <!--pop-up xem chi tiết và chỉnh trạng thái đơn hàng-->
                    <td>
                        <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" id="<%=id%>" >
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel"><b>Chỉnh sửa đơn hàng</b></h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <form action="UpdateOrderController" method="POST">
                                        <div class="modal-body" >

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="orderID">ID đơn hàng</label>
                                                        <input type="text" readonly="" name="orderID" value="<%= order.getOrderID()%>" id="orderID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="statusID">Trạng thái</label>
                                                        <select class="form-control form-control-lg" name="statusID">
                                                            <%
                                                                for (int k = 1; k <= 8; k++) {
                                                            %>
                                                            <option value="<%= k%>" 
                                                                    <%if (order.getStatusID() == k) {%>
                                                                    selected 
                                                                    <%}
                                                                        if (k == 8 || order.getStatusID() == 5 || k < order.getStatusID() || (k == 5 && order.getStatusID() != 3 && order.getStatusID() != 1) || (k == 6 && order.getStatusID() != 1) || ((k == 7) && (order.getStatusID() != 6))) {%>
                                                                    disabled 
                                                                    <%}%> >
                                                                <%= order.getStatus(k)%>
                                                            </option>
                                                            <%}%>
                                                        </select> 
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-12 mb-4">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullName">User name</label>
                                                        <input type="text" name="fullName" value="<%= order.getUserName()%>" readonly="" id="userID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>

                                            </div>

                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="orderDate">Ngày đặt hàng</label>
                                                        <input type="text" readonly="" name="orderDate" value="<%= sdf.format(order.getOrderDate())%>" id="orderDate" class="form-control form-control-lg" />

                                                    </div>

                                                </div>


                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="total">Tổng tiền</label>
                                                        <input type="text" readonly="" name="total" value="<%= order.getTotal()%>" id="total" class="form-control form-control-lg" />

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="row">

                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="payType">Hình thức thanh toán</label>
                                                        <input type="text" name="payType" readonly="" value="<%= order.getPayType()%>" id="payType" class="form-control form-control-lg" />
                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">

                                                    <div class="form-outline">
                                                        <label class="form-label" for="trackingID">Tracking ID</label>
                                                        <input type="text" name="trackingID" <%if (order.getTrackingID() != null) {%>value="<%= order.getTrackingID()%>"<%} else {%> value=""  <%}%>  id="trackingID" class="form-control form-control-lg" />
                                                    </div>

                                                </div>
                                                <!--thêm icon edit ở đây-->

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4">
                                                    <label class="form-label" for="">Chi tiết đơn hàng</label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullname">Người nhận</label>
                                                        <input type="text" value="<%= order.getFullName()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>
                                                </div>

                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="fullname">Số điện thoại</label>
                                                        <input type="text" value="<%= order.getPhone()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-12 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="address">Địa chỉ giao hàng</label>
                                                        <input type="text" value="<%= order.getAddress()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="email">Email</label>
                                                        <input type="text" value="<%= order.getEmail()%>" readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                                <div class="col-md-6 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="transactionNumber">Mã giao dịch</label>
                                                        <input type="text" <% if (order.getTransactionNumber() != null) {%>value="<%= order.getTransactionNumber()%>" <%} else {%> value="" <%}%> readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-12 mb-4 pb-2">
                                                    <div class="form-outline">
                                                        <label class="form-label" for="note">Ghi chú</label>
                                                        <input type="text" <% if (order.getNote() != null) {%> value="<%= order.getNote()%>" <%} else {%>value=""<%}%> readonly="" class="form-control form-control-lg"/>
                                                    </div>

                                                </div>
                                            </div>
                                            <table border="1">
                                                <thead>
                                                    <tr>
                                                        <th>Sản phẩm</th>
                                                        <th>Đơn giá</th>
                                                        <th>Số lượng</th>
                                                        <th>Size</th>
                                                        <th>Màu</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (OrderDetailDTO orderDetail : order.getOrderDetail()) {
                                                    %>

                                                    <tr>
                                                        <td><%= orderDetail.getProductName()%></td>
                                                        <td><%= orderDetail.getPrice()%></td>
                                                        <td><%= orderDetail.getQuantity()%></td>
                                                        <td><%= orderDetail.getSize()%></td>
                                                        <td><%= orderDetail.getColor()%></td>
                                                    </tr>

                                                    <%
                                                        }
                                                    %>
                                                </tbody>
                                            </table>
                                        </div>
                                        <input type="hidden" name="page" value="<%= currentPage%>"/>
                                        <input type="hidden" name="payType" value="<%= order.getPayType()%>"/>
                                        <input type="hidden" name="userID" value="<%= loginUser.getUserID()%>"/>
                                        <input type="hidden" name="roleID" value="<%= loginUser.getRoleID()%>"/>
                                        <input type="hidden" name="search" id="update-search" value="<%= searchValue%>"/>
                                        <input type="hidden" name="dateFrom" id="update-dateFrom" value="<%= dateFrom%>"/>
                                        <input type="hidden" name="dateTo" id="update-dateTo" value="<%= dateTo%>"/>
                                        <input type="hidden" name="search-statusID" id="update-statusID" value="<%= sOrderStatusID%>"/>
                                        <a class="ml-4 btn btn-secondary" <% if (order.getStatusID() != 4 && order.getStatusID() != 8) {%> href="#" style="cursor: default;" <%} else {%> href="ReturnController?orderID=<%= order.getOrderID()%>" <%}%>>
                                            Đổi / trả 
                                        </a>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateOrder">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>

                    </td>
                    <!--Pop-up lịch sử trạng thái đơn hàng-->
                    <td>
                        <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog" id="<%=id%>" >
                                <div class="modal-content" >
                                    <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Trạng thái đơn hàng</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <div>
                                        <table class="table table-hover table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>Trạng thái</th>
                                                    <th>Ngày</th>
                                                    <th>Chỉnh sửa bởi</th>
                                                    <th>Email</th>
                                                    <th>RoleID</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (OrderStatusDTO orderStatus : order.getUpdateStatusHistory()) {
                                                %>
                                                <tr>
                                                    <td><%= orderStatus.getStatusName()%></td>
                                                    <td><%= orderStatus.getUpdateDate()%></td>
                                                    <%
                                                        if (orderStatus.getUserName() == null) {

                                                    %>
                                                    <td><%= orderStatus.getUserID()%></td>
                                                    <td></td>
                                                    <td></td>

                                                    <%} else {%>
                                                    <td><%= orderStatus.getUserName()%></td>
                                                    <td><%= orderStatus.getUserID()%></td>
                                                    <td><%= orderStatus.getRoleID()%></td>
                                                    <%}%>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>
                    </td>
                </tr>

                <%
                            }
                        }
                    }
                %>
            </table>

            <!--page nav-->
            <%
                if (listOrder != null) { //if no order in list, page nav won't display


            %>
            <div class="row pagination__option" style="justify-content: center; align-items: center; text-align: center;">

                <%                    int noOfPages = (int) request.getAttribute("noOfPages");
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
                <a href="ShowOrderController?page=1"><i class="glyphicon glyphicon-menu-left"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-left"></i></a>

                <!-- For displaying Previous link except for the 1st page -->
                <a href="ShowOrderController?page=<%= currentPage - 1%>"><i class="glyphicon glyphicon-menu-left"></i></a>
                    <%
                        }
                    %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page-->

                <%  for (int i = begin; i <= end; i++) {
                        if (currentPage == i) {
                %>
                <a class="active" style="background: #b57c68; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                <%
                } else {
                %>
                <a href="ShowOrderController?page=<%= i%>" style="text-decoration: none;"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ShowOrderController?page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                <!-- For displaying last page link except for the last page -->
                <a href="ShowOrderController?page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-right"></i></a>

                <%
                    }

                    //                end of pageNav
                %>



                <%            } else {//Currently at SearchController
                    //                    start of pageNav
                    if (currentPage != 1) {
                %>

                <!-- For displaying 1st page link except for the 1st page -->
                <a href="SearchOrderController?search=<%= searchValue%>&search-statusID=<%= sOrderStatusID%>&dateFrom=<%= dateFrom%>&dateTo=<%= dateTo%>&page=1"><i class="glyphicon glyphicon-menu-left"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-left"></i></a>

                <!-- For displaying Previous link except for the 1st page -->
                <a href="SearchOrderController?search=<%= searchValue%>&search-statusID=<%= sOrderStatusID%>&dateFrom=<%= dateFrom%>&dateTo=<%= dateTo%>&page=<%= currentPage - 1%>" style="text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i></a>
                    <%
                        }
                    %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page--> 

                <%  for (int i = begin; i <= end; i++) {
                        if (currentPage == i) {
                %>
                <a class="active" style="background: #b57c68; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                <%
                } else {
                %>
                <a href="SearchOrderController?search=<%= searchValue%>&search-statusID=<%= sOrderStatusID%>&dateFrom=<%= dateFrom%>&dateTo=<%= dateTo%>&page=<%= i%>"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="SearchOrderController?search=<%= searchValue%>&search-statusID=<%= sOrderStatusID%>&dateFrom=<%= dateFrom%>&dateTo=<%= dateTo%>&page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                <!-- For displaying last page link except for the last page -->
                <a href="SearchOrderController?search=<%= searchValue%>&search-statusID=<%= sOrderStatusID%>&dateFrom=<%= dateFrom%>&dateTo=<%= dateTo%>&page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-right"></i></a>

                <%
                        }

                    }
                    //                end of pageNav

                %>

            </div>
            <%                } //end of the "No product" if statement
%>


        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
