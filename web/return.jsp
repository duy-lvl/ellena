<%@page import="java.text.SimpleDateFormat"%>
<%@page import="store.shopping.ReturnDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đổi/Trả Sản Phẩm</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
         <link rel="stylesheet" href="css/manager.css" type="text/css">
    </head>
    <body>
        <%
            String updateMsg = (String) request.getAttribute("UPDATE_MESSAGE");
            if (updateMsg != null) {
        %>
        <div class="modal fade" id="myModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Thông báo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p><%=updateMsg%></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                    </div>
                </div>

            </div>
        </div>
        <%
            }
        %>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            OrderDTO order = (OrderDTO) request.getAttribute("ORDER");
            List<ProductDTO> productList = (List<ProductDTO>) request.getAttribute("PRODUCT_LIST");
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
            if (loginUser.getRoleID().equals("EM")) {    
        %>
        
        <div class="sidenav">
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="https://dashboard.tawk.to/login"><i class="fa fa-archive fa-lg"></i>Quản lí Q&A</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        
        <%  } else {%>
        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div> 
        <%  }%>

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
            
            <h3>Chọn sản phẩm muốn đổi/trả</h3>
            <div>

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
                            <input type="text" readonly="" name="statusID" value="<%= order.getStatus(order.getStatusID()) %>" id="statusID" class="form-control form-control-lg" />
                        </div>

                    </div>
                    <div class="col-md-12 mb-4">

                        <div class="form-outline">
                            <label class="form-label" for="fullName">User name</label>
                            <input type="text" name="fullName" value="<%= order.getUserName()%>" readonly="" id="userID" class="form-control form-control-lg" />
                        </div>

                    </div>
                        
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
                            <div class="col-md-6 mb-4 pb-2">

                        <div class="form-outline">
                            <label class="form-label" for="payType">Hình thức thanh toán</label>
                            <input type="text" name="payType" readonly="" value="<%= order.getPayType()%>" id="payType" class="form-control form-control-lg" />
                        </div>

                    </div>
                    <div class="col-md-6 mb-4 pb-2">

                        <div class="form-outline">
                            <label class="form-label" for="trackingID">Tracking ID</label>
                            <input type="text" readonly="" name="trackingID" <%if (order.getTrackingID() != null){%>value="<%= order.getTrackingID()%>"<%} else {%> value=""  <%}%>  id="trackingID" class="form-control form-control-lg" />
                        </div>

                    </div>
                </div>
                <table class="table table-hover table-bordered">
                    <colgroup>
                    <col span="1" style="width: 25%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 12%;">
                    <col span="1" style="width: 14%;">
                    <col span="1" style="width: 14%;">
                </colgroup>
                    <thead>
                        <tr style="background-color: #b57c68">
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Màu</th>
                            <th>Size</th>
                            <th>Đổi</th>
                            <th>Trả</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int id = 1;
                            int count = 0;
                            for (OrderDetailDTO orderDetail : order.getOrderDetail()) {
                        %>

                        <tr>
                            <td><%= orderDetail.getProductName()%></td>
                            <td>
                                <%
                                    if (productList.get(count).getPrice() != orderDetail.getPrice()) {
                                %>
                                <s><%= productList.get(count).getPrice()%>₫</s><br>
                                    <%}%>
                                    <%= orderDetail.getPrice()%>₫
                            </td>
                            <td><%= orderDetail.getQuantity()%></td>
                            <td><%= orderDetail.getColor()%></td>
                            <td><%= orderDetail.getSize()%></td>
                            <!--Pop-up đổi hàng-->
                            <td>
                                <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" id="<%=id%>" >
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="myModalLabel">Chỉnh sửa</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                            </div>
                                            <form action="UpdateOrderDetailController" method="POST">
                                                <div class="modal-body">
                                                    <div>
                                                        <span>Số lượng</span>
                                                        <input type="number" min="1" max="<%= orderDetail.getQuantity()%>" required="" name="newQuantity" value="1">
                                                    </div>
                                                    <span>Đổi thành</span><br>
                                                    <span>Chọn phân loại:</span>
                                                    <select name="sizeColor" required="">
                                                        <option hidden>Chọn phân loại</option>
                                                        <%
                                                            ProductDTO product = productList.get(count);
                                                            product.getProductID();
                                                            product.getProductName();
                                                            Iterator<List<String>> colorSizeIt = product.getColorSizeQuantity().keySet().iterator();
                                                            while (colorSizeIt.hasNext()) {
                                                                List<String> colorSize = colorSizeIt.next();
                                                                if (product.getColorSizeQuantity().get(colorSize) > 0) {
                                                        %>
                                                        <option value="<%= colorSize.get(0) + "/" + colorSize.get(1)%>"><%= colorSize.get(0) + "/" + colorSize.get(1)%></option>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                    </select><br> 
                                                    <span>Lý do:</span><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Sản phẩm bị lỗi/hỏng" id="note1" checked="">
                                                        Sản phẩm bị lỗi/hỏng
                                                    </label><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Đổi size" id="note2">
                                                        Đổi size
                                                    </label><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Đổi màu" id="note3">
                                                        Đổi màu
                                                    </label><br>
                                                    <label>
                                                        <div style="float:left;">
                                                            <input type="radio" name="note" value="Khác" id="note4"> Khác: 
                                                        </div>
                                                        <div style="float:left;">
                                                            <input type="text" id="note5" name="note" value="" placeholder="Nhập lí do"/>
                                                        </div>
                                                        <div style="clear:both;"></div>
                                                    </label>
                                                </div>
                                                <input type="hidden" name="oldColor" value="<%= orderDetail.getColor()%>"/>
                                                <input type="hidden" name="oldSize" value="<%= orderDetail.getSize()%>"/>
                                                <input type="hidden" name="price" value="<%= orderDetail.getPrice()%>"/>
                                                <input type="hidden" name="oldQuantity" value="<%= orderDetail.getQuantity()%>"/>
                                                <input type="hidden" name="orderID" value="<%= order.getOrderID()%>"/>
                                                <input type="hidden" name="productID" value="<%= orderDetail.getProductID()%>"/>
                                                <input type="hidden" name="orderDetailID" value="<%= orderDetail.getOrderDetailID()%>"/>
                                                <div class="modal-footer">
                                                    <button class="btn btn-default" <% if (order.getStatusID() != 4 && order.getStatusID() != 8) {%> disabled="" <%}%> type="submit" name="action" value="UpdateOrderDetail">Cập nhật</button>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>
                            </td>
                            <!--Pop-up trả hàng-->
                            <td>
                                <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog" id="<%=id%>" >
                                        <div class="modal-content" >
                                            <div class="modal-header">
                                                <h4 class="modal-title" id="myModalLabel">Chỉnh sửa</h4>
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                            </div>
                                            <form action="RefundOrderController" method="POST">
                                                <div class="modal-body">
                                                    <div>
                                                        <span>Số lượng trả lại</span>
                                                        <input type="number" min="1" max="<%= orderDetail.getQuantity()%>" required="" name="newQuantity" value="1">
                                                    </div>
                                                    <span>Lý do:</span><br>
                                                    <label>
                                                        <input type="radio" name="note" value="Sản phẩm bị lỗi/hỏng" id="note1" checked="">
                                                        Sản phẩm bị lỗi/hỏng
                                                    </label><br>
                                                    
                                                    <label>
                                                        <div style="float:left;">
                                                            <input type="radio" name="note" value="Khác: " id="note4"> Khác: 
                                                        </div>
                                                        <div style="float:left;">
                                                            <input type="text" id="note5" name="note" value="" placeholder="Nhập lí do"/>
                                                        </div>
                                                        <div style="clear:both;"></div>
                                                    </label>
                                                </div>
                                                <input type="hidden" name="price" value="<%= orderDetail.getPrice()%>"/>
                                                <input type="hidden" name="color" value="<%= orderDetail.getColor()%>"/>
                                                <input type="hidden" name="size" value="<%= orderDetail.getSize()%>"/>
                                                <input type="hidden" name="oldQuantity" value="<%= orderDetail.getQuantity()%>"/>
                                                <input type="hidden" name="orderID" value="<%= order.getOrderID()%>"/>
                                                <input type="hidden" name="productID" value="<%= orderDetail.getProductID()%>"/>
                                                <input type="hidden" name="orderDetailID" value="<%= orderDetail.getOrderDetailID()%>"/>
                                                <div class="modal-footer">
                                                    <button class="btn btn-default" <% if (order.getStatusID() != 4 && order.getStatusID() != 8) {%> disabled="" <%}%> type="submit" name="action" value="RefundOrder">Cập nhật</button>
                                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chi tiết</button>
                            </td>
                        </tr>

                        <%
                            count++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                List<ReturnDTO> returnList = (List<ReturnDTO>) request.getAttribute("RETURN_LIST");
                if (returnList.size() > 0) {
            %>
            
            <h5>Lịch sử đổi/trả: </h5>
            <table class="table table-hover table-bordered">
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
                        for (ReturnDTO returnDTO : returnList) {
                    %>


                    <tr>
                        <td><%= returnDTO.getProductName()%></td>
                        <td><%= returnDTO.getPrice()%>₫</td>
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
            <%}%>
        </div>
        <script>
            function getNoteValue() {
                document.getElementById('note4').value = document.getElementById('note5').value;
            }
            $(document).ready(function () {
                $("#myModal").modal();
            });

        </script>
    </body>
</html>
