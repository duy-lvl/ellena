<%-- 
    Document   : customer-profile.jsp
    Created on : Jul 4, 2022, 9:56:36 PM
    Author     : vankh
--%>

<%@page import="store.user.UserError"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile của tôi</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    </head>
    <body>
        <jsp:include page="header.jsp" flush="true" />
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
        %>

        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-4 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <img class="rounded-circle mt-5" width="150px" height="150px" src="img/profile-pic.jpg">
                        <br>
                        <span class="font-weight-bold"><%= loginUser.getFullName()%></span>
                        <span class="text-black-50"><%= loginUser.getUserID()%></span>

                    </div>
                </div>
                <div class="col-md-8 centered">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile</h4>
                        </div>

                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Tên</label><div><%= loginUser.getFullName()%></div></div>
                            <div class="modal fade" id="myModal3" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi tên</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController" method="POST">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newName">Tên mới</label>
                                                            <input type="text" name="newName" required="" id="newName" maxlength="100" value="<%= loginUser.getFullName()%>" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateName">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal3"></i>
                        </div>
                        <% if (!loginUser.getPassword().isEmpty()) { %>
                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Mật khẩu</label><div>**********</div></div>
                            <div class="modal fade" id="myModal1" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi mật khẩu</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="currentPassword">Mật khẩu hiện tại</label>
                                                            <input type="password" name="currentPassword" required="" id="currentPassword" maxlength="100" class="form-control form-control-lg" />
                                                            <p style="color: red">${requestScope.USER_ERROR.password}</p>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newPassword">Mật khẩu mới</label>
                                                            <input type="password" name="newPassword" required="" id="newPassword" class="form-control form-control-lg" />
                                                            <p style="color: red">${requestScope.USER_ERROR.confirm}</p>
                                                        </div>

                                                    </div>

                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="confirmNewPassword">Nhập lại mật khẩu mới</label>
                                                            <input type="password" name="confirmNewPassword" required="" id="confirmNewPassword" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdatePassword">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal1"></i>
                        </div>
                        <%}%>
                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Giới tính</label><div><%= loginUser.getSex() == true ? "Nam" : "Nữ"%></div></div>                            
                            <div class="modal fade" id="myModal5" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi địa chỉ</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">
                                                        <div class="form-outline">
                                                            <input  type="radio" <% if (loginUser.getSex()) { %>checked<%} %> id="Nam" name="newSex"  value="true"/>
                                                            <label class="form-label" for="Nam">Nam</label><br>
                                                            <input  type="radio" <% if (!loginUser.getSex()) { %>checked<%}%> id="Nữ" name="newSex"  value="false"/>
                                                            <label class="form-label" for="Nữ">Nữ</label>                                                    
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateSex">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal5" ></i>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Ngày sinh</label><div><% if(loginUser.getBirthday() == null){%><i>Bạn chưa điền thông tin này</i><%}else {%><%= loginUser.getBirthday() %><% }%></div></div>                            
                            <div class="modal fade" id="myModal6" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi ngày sinh</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">
                                                        <div class="form-outline">
                                                            <label class="form-label" for="newBirthday">Ngày sinh</label>
                                                            <input type="date" name="newBirthday" id="newBirthday" class="form-control form-control-lg" value="<%= loginUser.getBirthday()%>"/>
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateBirthday">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal6" ></i>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Số điện thoại</label><div><% if(!loginUser.getPhone().isEmpty()){ %><%= loginUser.getPhone()%><% }else{ %><i>Bạn chưa có thông tin này.</i><% } %></div></div>
                            <div class="modal fade" id="myModal4" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi số điện thoại</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <form action="MainController" method="POST">
                                            <div class="modal-body">

                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newPhone">Số điện thoại mới</label>
                                                            <input type="text" name="newPhone" id="newPhone" required="" maxlength="20" value="<%= loginUser.getPhone()%>" class="form-control form-control-lg" />
                                                        </div>

                                                    </div>

                                                </div>

                                            </div>
                                            <div class="modal-footer">
                                                <button class="btn btn-default" type="submit" name="action" value="UpdatePhone">Cập nhật</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                            </form>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal4"></i>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-11"><label class="labels">Địa chỉ</label><div><% if(!loginUser.getAddress().isEmpty()){ %><%= loginUser.getAddress()%><% }else{ %><i>Bạn chưa có thông tin này.</i><% } %></div></div>                            
                            <div class="modal fade" id="myModal2" role="dialog" aria-labelledby="myModalLabel">
                                <div class="modal-dialog">
                                    <div class="modal-content" >
                                        <div class="modal-header">
                                            <h4 class="modal-title" id="myModalLabel">Thay đổi địa chỉ</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>

                                        </div>
                                        <div class="modal-body">
                                            <form action="MainController">
                                                <div class="row">
                                                    <div class="col-md-12 mb-4">

                                                        <div class="form-outline">
                                                            <label class="form-label" for="newAddress">Địa chỉ mới</label>
                                                            <input type="text" name="newAddress" required="" id="newAddress" value="<%= loginUser.getAddress()%>" class="form-control form-control-lg" />                                                    
                                                        </div>

                                                    </div>

                                                </div>

                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-default" type="submit" name="action" value="UpdateAddress">Cập nhật</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <i class="fa fa-edit" data-toggle="modal" data-target="#myModal2" ></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" flush="true" />
    <jsp:include page="js-plugins.jsp" flush="true" />
    <% UserError userError = (UserError) request.getAttribute("USER_ERROR");
        if (userError != null) { %>
    <script>

        $(document).ready(function () {
            $("#myModal1").modal();
        });

    </script>                                                
    <% }%> 
</body>
</html>
