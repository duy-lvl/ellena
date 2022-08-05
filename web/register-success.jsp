<%-- 
    Document   : register-success
    Created on : Jul 21, 2022, 4:39:43 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng Ký Thành Công</title>
        <jsp:include page="meta.jsp" flush="true"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body onload="redirect()">
        <jsp:include page="header.jsp" flush="true"/>

        <%
            boolean otpCheck = (boolean) session.getAttribute("OTP_CHECK");
            String userID = (String) session.getAttribute("USER_ID");
            if (userID == null || otpCheck != true) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        
        <!--register-success begin-->
        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5" style="text-align: center;">Đăng ký tài khoản thành công!</h3>
                                <div id="pageInfo" style="text-align: center; color: red;"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--register-success end-->
        
        
        <!--auto redirect after reset password-->
        <script language="JavaScript" type="text/javascript">
            var seconds = 5;
            var url = "LogoutController";

            function redirect() {
                if (seconds <= 0) {
                    // redirect to new url after counter  down.
                    window.location = url;
                } else {
                    seconds--;
                    document.getElementById("pageInfo").innerHTML = "Chuyển về trang Home trong " + seconds + " giây.";
                    setTimeout("redirect()", 1000);
                }
            }
        </script>
<!--        <script>
            redirect();// redirect to login.jsp page (don't know how it automatically run after reset password)
        </script>-->
        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true" />
        
    </body>
</html>
