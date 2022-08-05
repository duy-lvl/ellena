<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo một tài khoản mới</title>
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
    </head>
        <body class="goto-here">

        <section class="vh-100 gradient-custom">
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">
                    <div class="col-12 col-lg-9 col-xl-7">
                        <div class="card shadow-2-strong card-registration" style="border-radius: 15px;">
                            <div class="card-body p-4 p-md-5">
                                <h3 class="mb-4 pb-2 pb-md-0 mb-md-5">Tạo tài khoản mới</h3>
                                <form action="AddAccountController" class="info" method="POST" accept-charset="utf-8">

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="email">Email</label>
                                                <input type="email" name="userID" id="firstName" required="" class="form-control form-control-lg" />
                                                <p style="color: red">${requestScope.USER_ERROR.userID}</p>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="row">
                                        <div class="col-md-12 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="fullName">Họ và tên</label>
                                                <input type="text" name="fullName" id="firstName" required="" class="form-control form-control-lg" />
                                                

                                            </div>

                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="password">Mật khẩu</label>
                                                <input type="password" name="password" required="" id="password" class="form-control form-control-lg" />

                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <div class="form-outline">
                                                <label class="form-label" for="confirm">Xác nhận mật khẩu</label>
                                                <input type="password" name="confirm" required="" id="confirm" class="form-control form-control-lg" />

                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12 mb-4">
                                            <div class="form-outline">
                                                <label class="form-label" for="password">Quyền</label>
                                                <select name="roleID" class="form-control form-control-lg">
                                                    <option value="AD" required="">Quản trị viên</option>
                                                    <option value="MN">Quản lý</option>
                                                    <option value="EM">Nhân viên</option>
                                                </select>

                                            </div>
                                    </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-4 d-flex align-items-center">

                                            <div class="form-outline datepicker w-100">
                                                <label for="birthdayDate" class="form-label">Sinh nhật</label>
                                                <input type="date" name="birthday" required="" class="form-control form-control-lg" id="birthdayDate" />

                                            </div>

                                        </div>
                                        <div class="col-md-6 mb-4">

                                            <h6 class="mb-2 pb-1">Giới tính: </h6>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" required="" name="sex" id="femaleGender"
                                                       value="False" />
                                                <label class="form-check-label" for="femaleGender">Nữ</label>
                                            </div>

                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="sex" id="maleGender"
                                                       value="True" />
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
                                        <button class="primary-btn" type="submit" >Tạo một tài khoản mới</button>
                                        <a href="ShowAccountController"><button class="primary-btn" type="button">Hủy</button></a>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </body>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/jquery.countdown.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.nicescroll.min.js"></script>
    <script src="js/main.js"></script>  
</html>
