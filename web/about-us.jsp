<%-- 
    Document   : about-us
    Created on : Jun 20, 2022, 12:53:24 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Giới Thiệu</title>

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
        
        <!-- About us Begin -->
        <div class="container" style="text-align: center;">
            
            
            <div>
                <h6 style=" margin-top: 2%; margin-bottom: 2%; font-weight: bold;">GIỚI THIỆU</h6>
            </div>
            
            <div>
                <span>
                    <p>Thành lập vào tháng 5 năm 2022, chỉ trong vòng 10 tuần, Ellena đã khẳng định được chỗ đứng vững chắc trên thị trường và trở thành thương hiệu thời trang có tốc độ tăng trưởng nhanh nhất tại Việt Nam ; Hàng triệu khách hàng thân thiết; Là nhà bán số 1 về ngành hàng thời trang trên các sàn Thương mại điện tử phổ biến nhất trong nước như: Tiki, Lazada, Shopee, Sendo,… và sắp có mặt tại sàn Thương Mại điện tử lớn nhất Thế Giới Amazon.</p>
                </span>
                <span>
                    <strong>“ELLENA PHÁT TRIỂN MÔ HÌNH SIÊU THỊ THỜI TRANG PHÁI NỮ”</strong>
                </span>
            </div>
            
            
            <div>
                <img src="img/about-us/stock-photo-1.jpg" alt="stock-photo-1" style="width: 860px; height: 580px; margin-top: 2%;"/>
            </div>
            
            <div style=" margin-top: 2%;">
                <span>
                    <p>Trải qua 10 tuần nỗ lực không ngừng nghỉ, Ellena đã định hình nên hệ giá trị của riêng mình. ELLENA đã gửi gắm tình yêu thương vào từng sản phẩm. Để thời trang không chỉ mang vẻ đẹp thẩm mỹ đơn thuần, hay những trải nghiệm mua sắm tuyệt vời, mà còn là sự kết tinh từ sức mạnh của niềm tin, khát khao cống hiến và sự hy sinh thầm lặng của mỗi con người trong đội ngũ với một mục tiêu duy nhất: Đem đến giá trị thật và hạnh phúc đích thực đến tận tay khách hàng.</p>
                </span>
            </div>
            
            <div style=" margin-top: 2%; margin-bottom: 2%;">
                <h6 style="font-weight: bold;">LIÊN HỆ CHĂM SÓC KHÁCH HÀNG</h6>
                <div>Email: Support@ellenafashion.com </div>
            </div>
            
        </div>
        <!-- About us End -->
        
        
        
        
        
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
