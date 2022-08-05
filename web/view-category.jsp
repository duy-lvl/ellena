<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý loại sản phẩm</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
         <link rel="stylesheet" href="css/manager.css" type="text/css">
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            String status = request.getParameter("status");
            if (search == null) {
                search = "";
            }
            if (status == null) {
                status = "";
            }
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
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
            <a href="ShowAccountController"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="ShowCategoryController" style="color: #873e23; font-weight: bold;"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>
        
        
        <div class="main">
           <div class="flex-item text-right" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h5 class="dropdown">
                        <b>Xin chào, </b>
                        <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                        <button class="dropdown-item btn" role="tab" type="button"><a class="text-dark" href="my-profile.jsp">Thông tin tài khoản</a></button>
                        <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h5>
                </form>
            </div>
            <h3><b>Quản lý loại sản phẩm</b></h3>
            <form action="MainController" method="POST">
                <input type="text" name="search" value="<%= search%>" placeholder="Tìm kiếm loại sản phẩm">
                Trạng thái
                <select name="status">
                    <option value="all">Tất cả</option>
                    <option value="true">Active</option>
                    <option value="false">Inactive</option>
                </select>
                <button type="submit" name="action" value="SearchCategory" class="btn btn-default" style="width: 15%; padding: 0.5% 0.1%;"><i class="fa fa-search fa-lg"></i>Search</button>
            </form>   
            <a class="btn btn-default" href="add-category.jsp">Tạo loại sản phẩm mới</a>
            <%
            List<CategoryDTO> listCategory = (List<CategoryDTO>) request.getAttribute("LIST_CATEGORY");
            if (listCategory != null) {
                if (listCategory.size() > 0) {
            %>      
            <table class="table table-hover table-bordered">
                <tr style="background-color: #b57c68">
                <th>ID</th>
                <th>Tên loại sản phẩm</th>                
                <th>Thứ tự</th>
                <th>Trạng thái</th>
                <th>Chỉnh sửa</th>
            </tr>
            <%  
                int id = 1;
                for (CategoryDTO category : listCategory) {
            %>
                <tr>
                    <td><%= category.getCategoryID()%></td>
                    <td><%= category.getCategoryName()%></td>
                    <td><%= category.getOrder()%></td>
                    <td>
                        <%
                            if (category.isStatus()) {
                        %>
                            <a class="btn btn-default" href="DeactivateCategoryController?categoryID=<%=category.getCategoryID()%>&search=<%= search %>">Vô hiệu hoá</a>
                        <%} else {
                        %>
                            <a class="btn btn-default" href="ActivateCategoryController?categoryID=<%=category.getCategoryID()%>&search=<%= search %>">Kích hoạt</a>
                        <%
                            }
                        %>
                    </td>
                    <!-- Chỉnh sửa chi tiết account-->
                <td>
                    <div class="modal fade" id="myModal<%=id%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog" id="<%=id%>" >
                            <div class="modal-content" >
                                <div class="modal-header">
                                    <h4 class="modal-title" id="myModalLabel">Chỉnh sửa loại sản phẩm</h4>
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                </div>
                                <div class="modal-body">
                                    <form action="UpdateCategoryController">

                                        <div class="row">
                                            <div class="col-md-6 mb-4 pb-2">
                                                 <div class="form-outline">
                                                    <label class="form-label" for="categoryID">ID</label>
                                                    <input type="number" name="categoryID" value="<%= category.getCategoryID()%>" readonly="" id="categoryID" class="form-control form-control-lg" />

                                                </div>

                                            </div>
                                            <div class="col-md-6 mb-4 pb-2">

                                                <div class="form-outline">
                                                    <label class="form-label" required="" for="order">Thứ tự</label>
                                                    <input type="number" name="order" value="<%= category.getOrder()%>" id="order" class="form-control form-control-lg" />
                                                </div>
                                            </div>        

                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 mb-4">

                                               <div class="form-outline">
                                                    <label class="form-label" for="categoryName">Tên loại sản phẩm</label>
                                                    <input type="text" name="categoryName" value="<%= category.getCategoryName()%>" maxlength="50" id="categoryName" class="form-control form-control-lg" />

                                                </div>

                                            </div>

                                        </div>
                                        <input type="hidden" name="search" value="<%= search%>">
                                        <input type="hidden" name="status" value="<%= status%>">
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-default" type="submit" name="action" value="UpdateCategory">Cập nhật</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                </div>
                                </form>

                            </div>
                        </div>
                    </div>
                    <button class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal<%=id++%>">Chỉnh sửa</button>

                    <!-- Modal -->
                    </td>
                </tr>
            <% } } }else{
                        %>
                        <div style="text-align: center">Không có kết quả tìm kiếm.</div>
                <%
                        }%>
        </table>
        </div>
        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
        </script>
    </body>
</html>
