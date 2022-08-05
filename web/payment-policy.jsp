<%-- 
    Document   : payment-policy
    Created on : Jun 21, 2022, 10:40:42 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Chính sách thanh toán</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Css Styles -->
        <jsp:include page="meta.jsp" flush="true"/>
    </head>
    <body>
        <!-- Header begin -->
        <jsp:include page="header.jsp" flush="true"/>
        <!-- Header end -->

        <!-- Payment policy Begin -->
        <div class="container" style="margin-top: 2%; margin-bottom: 2%;">
            <!--Title-->
            <h3 style="text-align: center;">QUY ĐỊNH VỀ HÌNH THỨC THANH TOÁN VÀ VẬN CHUYỂN</h3>

            <div>
                <div>
                    <h6 style="margin-top: 2%; margin-bottom: 1%; font-weight: bold;">ELLENA HIỆN ĐANG HỖ TRỢ CÁC PHƯƠNG THỨC THANH TOÁN SAU ĐÂY:</h6>
                    <ul style="list-style-type: none;">
                        <li>
                            <strong>Thanh toán bằng tiền mặt khi nhận hàng (COD):</strong> Khách hàng nhận hàng và thanh toán tiền trực tiếp với nhân viên giao hàng.
                        </li>
                        <li>
                            <strong>Thanh toán qua thẻ ATM có đăng ký thanh toán trực tuyến (miễn phí thanh toán):</strong> Để sử dụng phương thức thanh toán này, tài khoản ngân hàng của quý khách cần đăng ký dịch vụ Internet Banking với ngân hàng. Ellena hiện hỗ trợ thanh toán cho phần lớn các ngân hàng tại Việt Nam:
                        </li>
                        <li>
                            <strong>Thanh toán qua thẻ Visa/Master:</strong> Phí thanh toán tùy thuộc vào từng loại thẻ quý khách dùng và ngân hàng phát hành thẻ. Vui lòng liên hệ với ngân hàng phát hành thẻ để biết rõ phí thanh toán phát sinh.
                        </li>
                        <li>
                            <strong>Quý khách có thể chuyển khoản qua tài khoản sau:</strong>
                            <ul style="list-style-type: none;">
                                <li>
                                    <ul style="list-style-type: none">

                                        <li>
                                            - Tên tài khoản: CÔNG TY CỔ PHẦN ELLENA
                                        </li>
                                        <li>
                                            - Số tài khoản: <i>060113161259....</i>
                                        </li>
                                        <li>
                                            - Chi nhánh: Ngân Hàng TMCP Sài Gòn Thương Tín - Sacombank CN Gò Vấp - PGD Phan Huy Ích
                                        </li>
                                    </ul>
                                </li>



                            </ul>
                        </li>
                    </ul>

                    <h6 style="margin-top: 2%; margin-bottom: 1%; font-weight: bold;">CHI PHÍ VẬN CHUYỂN TẠI ELLENA.VN TÍNH THẾ NÀO?</h6>
                    <p>Ellena áp dụng phí giao hàng cho tất cả các đơn hàng có giá trị dưới 500.000đ. Với đơn hàng từ 500.000đ trở lên, khách hàng sẽ được miễn phí hoàn toàn chi phí vận chuyển toàn quốc.</p>
                    <p>Phí Ship đối với đơn hàng dưới 500.000đ:</p>
                    <ul style="list-style-type: none;">
                        <li>
                            Khu vực nội thành HCM: Quận 1, 2, 3, 4, 5, 6, 7, 8, 10, 11, Tân Bình, Tân Phú, Phú Nhuận, Bình Thạnh, Gò Vấp: Miễn phí vận chuyển khi gửi từ CN HCM. Chuyển từ CN tỉnh phí ship 20.000 VNĐ.
                        </li>
                        <li>
                            Khu vực ngoại thành HCM: Quận 9, 12, Thủ Đức, Bình Tân, Hóc Môn, Bình Chánh, Nhà Bè,Củ Chi: phí 10.000 VNĐ khi gửi từ CN HCM. Chuyển từ CN tỉnh phí ship 20.000 VNĐ.
                        </li>
                        <li>
                            Các tỉnh thành khác: phí 20.0000 VNĐ.
                        </li>
                        <li>
                            Khu vực ĐẢO: Phí 30.000VNĐ -  Quý khách phải chuyển khoản trước cho ELLENA, sau đó ELLENA sẽ lên đơn hàng và chuyển hàng cho quý khách.
                        </li>
                    </ul>
                </div>
            </div>

        </div>
        <!-- Payment policy End -->



        <!-- Footer begin -->
        <jsp:include page="footer.jsp" flush="true" />
        <!-- Footer end -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                // Add smooth scrolling to all links
                $("a").on('click', function (event) {

                    // Make sure this.hash has a value before overriding default behavior
                    if (this.hash !== "") {
                        // Prevent default anchor click behavior
                        event.preventDefault();

                        // Store hash
                        var hash = this.hash;

                        // Using jQuery's animate() method to add smooth page scroll
                        // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                        $('html, body').animate({
                            scrollTop: $(hash).offset().top
                        }, 800, function () {

                            // Add hash (#) to URL when done scrolling (default click behavior)
                            window.location.hash = hash;
                        });
                    } // End if
                });
            });
        </script>
        <!-- Js Plugins -->
        <jsp:include page="js-plugins.jsp" flush="true" />
        <script>
            $(".carousel-inner").children(".carousel-item:first-child").addClass("active");
        </script>
    </body>
</html>
