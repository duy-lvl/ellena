<%-- 
    Document   : forgot-password
    Created on : Jun 5, 2022, 12:22:19 AM
    Author     : Jason 2.0
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quên Mật Khẩu</title>
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>

        <!--Forgot password begin-->
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5" style="text-align: center;">Đặt lại mật khẩu</h3>
                                <form action="MainController" method="post">
                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="userID">Tên đăng nhập</label>
                                                <input type="text" name="userID" class="form-control" placeholder="example@email.com" id="username">                                                

                                            </div>

                                        </div>

                                    </div>
                                    <!--ERROR message-->
                                    <p style="color: red">${requestScope.ERROR}</p>

                                    <div>
                                        <button class="primary-btn" type="submit" name="action" value="ForgotPassword" >Gửi mail xác nhận mã OTP</button>
                                    </div>

                                </form>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--Forgot password end-->                            

        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true" />
    </body>
</html>
