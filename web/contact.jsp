<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="description" content="Ellena Fashion Shop">
        <meta name="keywords" content="Ellena, fashion, women, shop">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Liên hệ với chúng tôi</title>
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap"
              rel="stylesheet">
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>

        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <span>Liên hệ</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Contact Section Begin -->
        <section class="contact spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="contact__content">
                            <div class="contact__address">
                                <h5>Thông tin liên hệ</h5>
                                <ul>
                                    <li>
                                        <h6><i class="fa fa-map-marker"></i> Địa chỉ</h6>
                                        <p>Long Thạnh Mỹ, Quận 9, TP.HCM</p>
                                    </li>
                                    <li>
                                        <h6><i class="fa fa-phone"></i>Điện thoại</h6>
                                        <p><span>0972483747</span><span>0912345678</span></p>
                                    </li>
                                    <li>
                                        <h6><i class="fa fa-headphones"></i>Hỗ trợ</h6>
                                        <p>Support@ellenafashion.com</p>
                                    </li>
                                </ul>
                            </div>
                            
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="contact__map">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d13964.582071130573!2d106.8156600497741!3d10.835904558682303!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x317520b57cb1c1cf%3A0xff309063917c31f0!2sLong%20Th%E1%BA%A1nh%20M%E1%BB%B9%2C%20District%209%2C%20Ho%20Chi%20Minh%20City%2C%20Vietnam!5e0!3m2!1sen!2s!4v1653875789154!5m2!1sen!2s" 
                                    height="780" style="border:0;" allowfullscreen="" 
                                    loading="lazy" referrerpolicy="no-referrer-when-downgrade">                              
                            </iframe>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Contact Section End -->
        <jsp:include page="footer.jsp" flush="true" />
        <jsp:include page="js-plugins.jsp" flush="true"/>
    </body>
</html>
