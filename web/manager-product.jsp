<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý sản phẩm</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/manager.css" type="text/css">

    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            int currentPage = (int) request.getAttribute("currentPage"); // move up from pagination

//            checking if using ShowController or SearchController page count
            boolean searchAll = false;
            String status = request.getAttribute("STATUS") != null ? (String) request.getAttribute("STATUS") : "";//For storing request param for pagnation            

            String searchValue = request.getAttribute("SEARCH") != null ? (String) request.getAttribute("SEARCH") : "";

            String message = (String) request.getAttribute("MESSAGE");
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
        </div> <%}%>




        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div>

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

            <div class="row" style="margin: 0;">
                <h2><b>Danh sách sản phẩm</b></h2>
            </div>

            <!--search bar and add product row-->
            <div class="row">
                <!--search bar-->
                <div class="col-9">
                    <form action="ManagerSearchProductController">
                        <input type="text" name="search" value="<%= searchValue%>" placeholder="Tên sản phẩm">


                        <select name="status">
                            <option value="all" <% if (status.equals("") || status.equals("all")) { %> selected  <% }%>>Chọn trạng thái</option>
                            <option value="true" <% if (status.equals("true")) { %> selected  <% }%>>Kích hoạt</option>
                            <option value="false" <% if (status.equals("false")) { %> selected  <% }%>>Vô hiệu hóa</option>
                        </select>

                        <button type="submit" name="action" value="ManagerSearchProduct" class="btn btn-default" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Tìm kiếm</button>
                        <!--switch to SearchController page count after submit form-->
                        <%
                            searchAll = (boolean) request.getAttribute("SWITCH_SEARCH");
                        %>

                    </form>
                </div>



            </div>
            <div class="row">
                <div class="col-9">
                <a class="btn btn-default" href="add-product.jsp">Thêm sản phẩm mới</a>

                <!--pop up show product under lowStockLimit Start-->
                <div class="modal fade" id="lowStockLimitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog" >
                        <div class="modal-content" >
                            <div class="modal-header">
                                <h4 class="modal-title" id="myModalLabel">Sản phẩm sắp hết hàng</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                            </div>
                            <div>
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên Sản Phẩm</th>
                                            <th>Màu/Size</th>
                                            <th>Mức Cảnh Báo</th>
                                            <th>SL Trong Kho</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<ProductDTO> listLowStockProduct = (List<ProductDTO>) request.getAttribute("LIST_LOW_STOCK_PRODUCT");
                                            for (ProductDTO lowStockProduct : listLowStockProduct) {
                                        %>
                                        <tr>
                                            <td><%= lowStockProduct.getProductID()%></td>
                                            <td><%= lowStockProduct.getProductName()%></td>

                                            <%
                                                Iterator<List<String>> it1 = lowStockProduct.getColorSizeQuantity().keySet().iterator();
                                                List<String> key = new ArrayList<>();
                                                while (it1.hasNext()) {
                                                    for (String n : it1.next()) {
                                                        key.add(n);
                                                    }
                                                }
                                                List<String> colorSize = new ArrayList<>();
                                                colorSize.add(key.get(0));
                                                colorSize.add(key.get(1));
                                            %>

                                            <td><%= key.get(0)%>/<%= key.get(1)%></td>
                                            <td><%= lowStockProduct.getLowStockLimit()%></td>
                                            <td><%= lowStockProduct.getColorSizeQuantity().get(colorSize)%></td>
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

                <!--pop up show product under lowStockLimit End-->
                <!--button with warning number-->

                <button class="btn btn-default" type="button" data-toggle="modal" data-target="#lowStockLimitModal">
                    Sản phẩm sắp hết<%
                    if (listLowStockProduct != null) {
                        if (listLowStockProduct.size() > 0) {
                %>
               
                <%
                        }
                    }
                %>
                <span id="low-stock__tip"><%= listLowStockProduct.size()%></span></button>
                


                </div>
            </div>


            <%  List<ProductDTO> listProduct = (List<ProductDTO>) request.getAttribute("LIST_PRODUCT");
                if (listProduct != null) {
                    if (listProduct.size() > 0) {
            %>  
            <table class="table table-hover table-bordered">
                <colgroup>
                    <col span="1" style="width: 5%;">
                    <col span="1" style="width: 35%;">
                    <col span="1" style="width: 15%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 10%;">
                    <col span="1" style="width: 8%;">
                </colgroup>
                <tr style="background-color: #b57c68">
                    <th>ID</th>
                    <th>Tên Sản phẩm</th>                
                    <th>Loại sản phẩm</th>
                    <th>Giá</th>
                    <th>Giảm giá (%)</th>
                    <th>Trạng thái</th>
                    <th>Chỉnh sửa</th>
                </tr>
                <%
                    for (ProductDTO list : listProduct) {
                %>
                <tr>
                    <td style="font-weight: bold"><%= list.getProductID()%></td>
                    <td><%= list.getProductName()%></td>
                    <td><%= list.getCategoryName()%></td>
                    <td><%= list.getPrice()%></td>
                    <td><%= Math.round(list.getDiscount() * 100 / list.getPrice())%></td>
                    <td>
                        <%
                            if (list.isStatus()) {
                        %>
                        <a class="btn btn-default" href="DeactivateProductController?productID=<%=list.getProductID()%>&search=<%= searchValue%>&status=<%= status%>&page=<%= currentPage%>">Vô hiệu hoá</a> 
                        <%} else {
                        %>
                        <a class="btn btn-default" href="ActivateProductController?productID=<%=list.getProductID()%>&search=<%= searchValue%>&status=<%= status%>&page=<%= currentPage%>">Kích hoạt</a> 
                        <%
                            }
                        %>
                    </td>

                    <!-- Chỉnh sửa chi tiết product-->
                    <td>
                        <a class="btn btn-default" href="ManagerShowProductDetailController?productID=<%=list.getProductID()%>">Chi tiết</a>
                    </td>

                </tr>
                <%         }
                    }
                } else {
                %>
                <div style="text-align: center">Không có kết quả tìm kiếm.</div>
                <%
                    }%>
            </table>



            <!--page nav-->
            <%
                if (listProduct != null) { // if no product in list, page nav won't display
            %>
            <div class="row pagination__option" style="justify-content: center; align-items: center; text-align: center;">

                <%
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
                <a href="ManagerShowProductController?page=1"><i class="glyphicon glyphicon-menu-left"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-left"></i></a>

                <!-- For displaying Previous link except for the 1st page -->
                <a href="ManagerShowProductController?page=<%= currentPage - 1%>"><i class="glyphicon glyphicon-menu-left"></i></a>
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
                <a href="ManagerShowProductController?page=<%= i%>" style="text-decoration: none;"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ManagerShowProductController?page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                <!-- For displaying last page link except for the last page -->
                <a href="ManagerShowProductController?page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-right"></i></a>

                <%
                    }

                    //                end of pageNav
                %>



                <%            } else {//Currently at SearchController
                    //                    start of pageNav
                    if (currentPage != 1) {
                %>

                <!-- For displaying 1st page link except for the 1st page -->
                <a href="ManagerSearchProductController?search=<%= searchValue%>&status=<%= status%>&page=1"><i class="glyphicon glyphicon-menu-left"></i><i style="margin-left: -4px" class="glyphicon glyphicon-menu-left"></i></a>

                <!-- For displaying Previous link except for the 1st page -->
                <a href="ManagerSearchProductController?search=<%= searchValue%>&status=<%= status%>&page=<%= currentPage - 1%>" style="text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i></a>
                    <%
                        }
                    %>

                <!--For displaying Page numbers. The when condition does not display a link for the current page--> 

                <%  for (int i = begin; i <= end; i++) {
                        if (currentPage == i) {
                %>
                <a class="active" style="background: #000000; color: #ffffff"><%= i%></a>  <!-- There is no active class for pagination (currenly hard code) -->
                <%
                } else {
                %>
                <a href="ManagerSearchProductController?search=<%= searchValue%>&status=<%= status%>&page=<%= i%>"><%= i%></a>
                <%
                        }
                    }
                %>


                <!--For displaying Next link -->
                <%
                    if (currentPage < noOfPages) {
                %>
                <a href="ManagerSearchProductController?search=<%= searchValue%>&status=<%= status%>&page=<%= currentPage + 1%>"><i class="glyphicon glyphicon-menu-right"></i></a>

                <!-- For displaying last page link except for the last page -->
                <a href="ManagerSearchProductController?search=<%= searchValue%>&status=<%= status%>&page=<%= noOfPages%>"><i class="glyphicon glyphicon-menu-right"></i><i style="margin-left: -4px"class="glyphicon glyphicon-menu-right"></i></a>

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
//                $("#lowStockLimitModal").modal("hide");
            });
        </script> 


    </body>
</html>
