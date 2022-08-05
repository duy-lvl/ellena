<%-- 
    Document   : register
    Created on : May 18, 2022, 6:01:30 PM
    Author     : giama
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đăng ký tài khoản mới</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        
    </head>

    <body class="goto-here">
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


        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Đăng ký tài khoản</h3>
                                <form action="MainController" class="info" method="POST">

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="email">Email<p style="display: inline; color: red;">*</p></label>
                                                <input type="email" name="userID" id="email" required="" class="form-control form-control-lg" />
                                                <p style="color: red">${requestScope.USER_ERROR.userID}</p>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="fullName">Họ và tên<p style="display: inline; color: red;">*</p></label>
                                                <input type="text" name="fullName" id="firstName" required="" class="form-control form-control-lg" />


                                            </div>

                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="password">Mật khẩu<p style="display: inline; color: red;">*</p></label>
                                                <input type="password" name="password" required="" id="password" class="form-control form-control-lg" />

                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="confirm">Xác nhận mật khẩu<p style="display: inline; color: red;">*</p></label>
                                                <input type="password" name="confirm" required="" id="confirm" class="form-control form-control-lg" />

                                            </div>
                                        </div>
                                    </div>
                                    <p style="color: red">${requestScope.USER_ERROR.confirm}</p>
                                    <p style="color: red">${requestScope.USER_ERROR.password}</p>

                                    <div class="row">
                                        <div class="col-md-6 mb-4 d-flex align-items-center">

                                            <div class="form-outline datepicker w-100">
                                                <label for="birthdayDate" class="form-label">Sinh nhật<p style="display: inline; color: red;">*</p></label>
                                                <input type="date" name="birthday" required="" class="form-control form-control-lg" id="birthdayDate" />

                                            </div>

                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <p class="mb-2 pb-1 text-dark" style="display: inline"><b>Giới tính</b><p style="display: inline; color: red;">*</p></p>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" required="" name="sex" id="femaleGender"
                                                       value="false" />
                                                <label class="form-check-label" for="femaleGender">Nữ</label>
                                            </div>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sex" id="maleGender"
                                                       value="true" />
                                                <label class="form-check-label" for="maleGender">Nam</label>
                                            </div>



                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-4 pb-2">

                                            <div class="form-outline">
                                                <label class="form-label" for="address">Địa chỉ</label>
                                                <input type="text" name="address" id="address" class="form-control form-control-lg" />

                                            </div>

                                        </div>
                                        <div class="col-md-6 mb-4 pb-2">

                                            <div class="form-outline">
                                                <label class="form-label" required="" for="phoneNumber">Số điện thoại</label>
                                                <input type="tel" id="phoneNumber" name="phone" class="form-control form-control-lg" />

                                            </div>

                                        </div>
                                    </div>


                                    <div>
                                        <button class="site-btn" type="submit" name="action" value="Register" >Đăng ký</button>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%  String message = (String) request.getAttribute("MESSAGE");
                if (message != null) {
            %>

            <!-- Pop-up thông báo -->
            <div class="modal fade in show" id="myModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Thông báo</h4>
                        </div>
                        <div class="modal-body">
                            <p><%=message%></p>
                        </div>
                        <div class="modal-footer">
                            <a href="./"><button type="button" class="btn btn-default">Đóng</button></a>
                        </div>
                    </div>

                </div>
            </div> 
            <%}%>
            

        </section>

    </body>
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
</html>
