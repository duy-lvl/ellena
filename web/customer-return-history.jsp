<%@page import="java.text.SimpleDateFormat"%>
<%@page import="store.shopping.ReturnDTO"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="java.util.Map"%>
<%@page import="store.shopping.OrderStatusDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí đơn hàng | Manager</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/manager.css" type="text/css">

    </head>
    <body>

        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            //String message = (String) request.getAttribute("MESSAGE");
            String searchValue = request.getAttribute("SEARCH") != null ? (String) request.getAttribute("SEARCH") : "";
            List<UserDTO> userList = (List<UserDTO>) request.getAttribute("USER_LIST");
        %>
        <%
            if (loginUser.getRoleID().equals("EM")) {
        %>

        <div class="sidenav">
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="https://dashboard.tawk.to/login"><i class="fa fa-archive fa-lg"></i>Quản lí Q&A</a>
            <a href="customer-return-history.jsp" style="color: #873e23; font-weight: bold;"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 

        <%
        } else {
        %>

        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="#" style="color: #873e23; font-weight: bold;"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        <%
            }
        %>


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

            <h2><b>Lịch sử đổi/trả</b></h2>
            <form action="SearchReturnedHistoryController" method="POST">
                <input type="text" name="search" value="<%= searchValue%>" id="search-search" placeholder="Nhập tên khách hàng/email/số điện thoại" style="width: 40%;">
                <button type="submit" name="action" value="SearchReturnedHistory" class="btn btn-default" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Tìm kiếm</button>
            </form>

            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                Map<UserDTO, List<OrderDTO>> map = (Map<UserDTO, List<OrderDTO>>) request.getAttribute("RETURNED_ORDERS");
                Map<OrderDTO, List<ReturnDTO>> returnMap = (Map<OrderDTO, List<ReturnDTO>>) request.getAttribute("RETURNED_HISTORY");
                if (userList != null) {
                    if (userList.size() > 0) {
                        int id = 1;
                        for (UserDTO user : userList) {


            %>
            <div style="border: 1px #DDD solid; padding: 2%; border-radius: 5px;">
            <div class="row">
                <div class="col-md-5 mb-4 pb-2">
                    <div class="form-outline">
                        <label class="form-label" for="fullname">Họ và tên</label>
                        <input type="text" readonly="" name="fullname" value="<%= user.getFullName()%>" id="fullname" class="form-control form-control-lg" />
                    </div>
                </div>

                <div class="col-md-5 mb-4 pb-2">
                    <div class="form-outline">
                        <label class="form-label" for="userID">Email</label>
                        <input type="text" readonly="" name="userID" value="<%= user.getUserID()%>" id="userID" class="form-control form-control-lg" />
                    </div>
                </div>

                <div class="col-md-2 mb-4 pb-2">
                    <div class="form-outline">
                        <label class="form-label" for="sex">Giới tính</label>
                        <input type="text" readonly="" name="sex" <% if (user.getSex()) { %> value="Nam" <% } else { %> value="Nữ" <%}%> id="sex" class="form-control form-control-lg" />
                    </div>
                </div>
                <div class="col-md-5 mb-4 pb-2">
                    <div class="form-outline">
                        <label class="form-label" for="address">Địa chỉ</label>
                        <input type="text" readonly="" name="address" value="<%= user.getAddress()%>" id="address" class="form-control form-control-lg" />
                    </div>
                </div>
                <div class="col-md-5 mb-4 pb-2">
                    <div class="form-outline">
                        <label class="form-label" for="phone">Số điện thoại</label>
                        <input type="text" readonly="" name="phone" value="<%= user.getPhone()%>" id="phone" class="form-control form-control-lg" />
                    </div>
                </div>

            </div>
                    
            <%

                List<OrderDTO> listOrder = map.get(user);

                if (listOrder != null) {
                    if (listOrder.size() > 0) {


            %>
            <h3>Số lượng đơn hàng đã đổi/trả: <%= listOrder.size()%></h3>


            <%                for (OrderDTO order : listOrder) {
            %>
            <table class="table table-hover table-responsive">
                <colgroup>
                    <col span="1" style="width: 5%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 35%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 10%;">
                </colgroup>
                <tr style="background-color: #b57c68">
                    <th>ID</th>
                    <th>Ngày đặt hàng</th>                
                    <th>Tổng tiền</th>
                    <th>Tên khách hàng</th>
                    <th>Trạng thái</th>
                    <th>Chi tiết đơn hàng</th>
                    <th>Trạng thái đơn hàng</th>
                </tr>
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
                                        <h4 class="modal-title" id="myModalLabel">Chi tiết đơn hàng</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                    </div>
                                    <form action="MainController" method="POST">
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
                                                                        if (k < order.getStatusID() || (k == 5 && order.getStatusID() != 3 && order.getStatusID() != 1) || (k == 6 && order.getStatusID() != 1) || ((k == 7) && (order.getStatusID() != 6))) {%>
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
                                                        <input type="text" name="trackingID" <%if (order.getTrackingID() != null){%>value="<%= order.getTrackingID()%>"<%} else {%> value=""  <%}%>  id="trackingID" class="form-control form-control-lg" />
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
                                                        <input type="text" <% if (!order.getPayType().equals("COD")) {%>value="<%= order.getTransactionNumber()%>" <%} else {%> value="" <%}%> readonly="" class="form-control form-control-lg"/>
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

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                    </form>

                                </div>
                            </div>
                        </div>
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>

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
                                                        if (orderStatus.getUserName() == null){
                                                    
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
            </table>
            <%
                List<ReturnDTO> returnHistory = returnMap.get(order);
            %>
            <h5><b>Lịch sử đổi/trả: </b></h5>
            <table class="table table-hover">
                <thead>
                    <tr style="background-color: #b57c68">
                        <th>Sản phẩm</th>
                        <th>Đơn giá</th>
                        <th>Số lượng</th>
                        <th>Màu</th>
                        <th>Size</th>
                        <th>Ghi chú</th>
                        <th>Đổi/trả</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (ReturnDTO returnDTO : returnHistory) {
                    %>


                    <tr>
                        <td><%= returnDTO.getProductName()%></td>
                        <td><%= returnDTO.getPrice()%></td>
                        <td><%= returnDTO.getReturnQuantity()%></td>
                        <td><%= returnDTO.getColor()%></td>
                        <td><%= returnDTO.getSize()%></td>
                        <td><%= returnDTO.getNote()%></td>
                        <td><%= returnDTO.getReturnType()%></td>
                    </tr>

                    <%
                        }
                    %>
                </tbody>
            </table>
                <hr>
            <%                   
                

                }
            %>


            <%
                    }
                }
            %>

            <%          }
                    }
                }

            %>
            ${requestScope.MESSAGE}



        </div>

        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
