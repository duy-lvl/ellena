<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo một loại sản phẩm mới</title>
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <div class="sidenav">
            <a href="ShowAccountController" style="color: #873e23; font-weight: bold;"><i class="fa fa-address-card fa-lg"></i>Quản lý tài khoản</a>
            <a href="ShowManagerController"><i class="fa fa-group fa-lg"></i>Quản lý manager</a>
            <a href="ShowCategoryController"><i class="fa fa-cart-plus fa-lg"></i>Quản lý loại sản phẩm</a>
        </div>

        <div class="main">
            <div style="margin: 5% 5%;">
            <h3>Thêm một loại sản phẩm mới</h3>
            <br>
            <form action="AddCategoryController" method="POST">
            <div class="row">
                <div class="col-md-4 mb-4">

                    <div class="form-outline">
                        <label class="form-label" for="categoryName">Tên loại sản phẩm</label>
                        <input type="text" name="categoryName" id="userID" required="" class="form-control form-control-lg" />
                        

                    </div>
                    
                </div>
                
            </div><p style="color: red">${requestScope.ERROR_MESSAGE}</p>
            <div class="row">
                <div class="col-md-4 mb-4">

                    <div class="form-outline">
                        <label class="form-label" for="order">Thứ tự</label>
                        <input type="number" name="order" min=1 id="order" required="" class="form-control form-control-lg" />

                    </div>

                </div>

            </div>     
            <div class="row">
                <div class="col-md-4 mb-4">

                    <div class="form-outline">
                        <button type="submit" name="action" value="AddCategory">Tạo</button>
                        <a href="ShowCategoryController"> <button type="button">Hủy</button></a>
                    </div>

                </div>

            </div>     
        </div>
        </form>
        </div>
    </body>
</html>
