<%-- 
    Document   : login
    Created on : May 17, 2022, 12:43:51 PM
    Author     : giama
--%>

<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Nhâp</title>
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <!-- Page Preloder -->
        <div id="preloder">
            <div class="loader"></div>
        </div>

        <!-- Offcanvas Menu Begin -->
        <div class="offcanvas-menu-overlay"></div>
        <div class="offcanvas-menu-wrapper">
            <div class="offcanvas__close">+</div>
            <div class="offcanvas__logo">
                <a href="./"><img class="img-fluid" style="height: 38px;" src="img/ellena-logo.png" alt=""></a>
            </div>
            <div id="mobile-menu-wrap"></div>          
        </div>
        <!-- Offcanvas Menu End -->

        <!-- Header Section Begin -->
        <header class="header">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-2">
                        <div class="header__logo">
                            <a href="./"><img class="img-fluid" style="height: 38px;" src="img/ellena-logo.png" alt=""></a>
                        </div>

                    </div>
                </div>
            </div>
        </header>
        <!-- Header Section End -->
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Đăng nhập</h3>
                                <form action="MainController" method="post">
                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="userID">Tên đăng nhập</label>
                                                <input type="text" name="userID" class="form-control" placeholder="example@email.com" id="username">                                                

                                            </div>

                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label for="password">Mật khẩu</label> 
                                                <div class="d-inline-block float-right">
                                                <a href="forgot-password.jsp">Quên mật khẩu?</a>  
                                                </div>
                                                <input type="password" required="" name="password" class="form-control" placeholder="*********" id="password">

                                            </div>
                                             

                                        </div>

                                    </div>
                                    <p style="color: red">${requestScope.ERROR}</p>
                                    <div>
                                        <button class="site-btn" type="submit" name="action" value="Login" >Đăng nhập</button>
                                    </div>

                                </form>
                                <p class="my-3">Hoặc đăng nhập bằng
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/Ellena/LoginGoogleController&response_type=code
                                       &client_id=772482426218-2l2bv33430edm3s1v7g12kul82kb5bmd.apps.googleusercontent.com&approval_prompt=force"><image style="width: 98px; height: 39px;" src="./images/google-login.png" alt="Log in with Google"/></a>  </p>
                               
                                  
                                    <!--<a href="https://www.facebook.com/dialog/oauth?client_id=893226585410442&redirect_uri=http://localhost:8080/Ellena/LoginFacebookController"><image style="width: 98px; height: 39px;" src="./images/facebook-login.png" alt="Log in with Facebook"/></a>-->
                              
                                <p class="mb-0">Chưa có tài khoản?     <a href="register.jsp">Đăng ký ngay</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--Start of Tawk.to Script-->
        <script type="text/javascript">
            var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
            (function () {
                var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
                s1.async = true;
                s1.src = 'https://embed.tawk.to/62986537b0d10b6f3e754a36/1g4hkmp1j';
                s1.charset = 'UTF-8';
                s1.setAttribute('crossorigin', '*');
                s0.parentNode.insertBefore(s1, s0);
            })();
        </script>
        <!--End of Tawk.to Script-->

        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true"/>
    </body>
</html>
