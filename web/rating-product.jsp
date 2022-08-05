<%-- 
    Document   : order-history
    Created on : Jun 27, 2022, 5:45:04 PM
    Author     : giama
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="store.user.UserDTO"%>
<%@page import="store.shopping.OrderDetailDTO"%>
<%@page import="store.shopping.OrderDTO"%>
<%@page import="javafx.util.Pair"%>
<%@page import="store.shopping.CartProduct"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Đánh Giá Sản Phẩm</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

        <jsp:include page="meta.jsp" flush="true"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            * {
                box-sizing: border-box;
            }
            form {
                width: 80%; 
                padding: 3rem;
                margin: 0 auto!important;
            }
            form span{
                font-size: 1.75rem;
                font-weight: 600;
            }
            form h2{
                margin-bottom: 2rem;
                font-weight: 600;
            }
            textarea{
                font-size: 1.5rem!important;
                width: 100%;
                padding:1rem;
                border-radius: 1rem;
                border: 2px solid #000; 
            }
            button{
                font-size:1.5rem!important;
                font-weight: 600!important;
            }
            .rating {
                display: flex;         
                overflow: hidden;
                justify-content: flex-end;
                flex-direction: row-reverse;
                position: relative;
            }

            .rating-0 {
                filter: grayscale(100%);
            }

            .rating > input {
                display: none;
            }

            .rating > label {
                cursor: pointer;
                width: 40px;
                height: 40px;
                margin-top: auto;
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23e3e3e3' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: center;
                background-size: 76%;
                transition: 0.3s;
            }

            .rating > input:checked ~ label,
            .rating > input:checked ~ label ~ label {
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23fcd93a' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
            }

            .rating > input:not(:checked) ~ label:hover,
            .rating > input:not(:checked) ~ label:hover ~ label {
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' width='126.729' height='126.73'%3e%3cpath fill='%23d8b11e' d='M121.215 44.212l-34.899-3.3c-2.2-.2-4.101-1.6-5-3.7l-12.5-30.3c-2-5-9.101-5-11.101 0l-12.4 30.3c-.8 2.1-2.8 3.5-5 3.7l-34.9 3.3c-5.2.5-7.3 7-3.4 10.5l26.3 23.1c1.7 1.5 2.4 3.7 1.9 5.9l-7.9 32.399c-1.2 5.101 4.3 9.3 8.9 6.601l29.1-17.101c1.9-1.1 4.2-1.1 6.1 0l29.101 17.101c4.6 2.699 10.1-1.4 8.899-6.601l-7.8-32.399c-.5-2.2.2-4.4 1.9-5.9l26.3-23.1c3.8-3.5 1.6-10-3.6-10.5z'/%3e%3c/svg%3e");
            }


            #rating-1:checked ~ .emoji-wrapper > .emoji {
                transform: translateY(-100px);
            }

            #rating-2:checked ~ .emoji-wrapper > .emoji {
                transform: translateY(-200px);
            }

            #rating-3:checked ~ .emoji-wrapper > .emoji {
                transform: translateY(-300px);
            }

            #rating-4:checked ~ .emoji-wrapper > .emoji {
                transform: translateY(-400px);
            }

            #rating-5:checked ~ .emoji-wrapper > .emoji {
                transform: translateY(-500px);
            }

        </style>
           
       
    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>        
        <%
            UserDTO user = (UserDTO)session.getAttribute("LOGIN_USER");
        %>
        <!-- Breadcrumb Begin -->
        <div class="breadcrumb-option">
            <div class="container">
                <!--Message row-->
                <div class="row">
                    <div class="col-12" style="text-align: center; color: red">
                  
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="breadcrumb__links">
                            <a href="./"><i class="fa fa-home"></i> Trang chủ</a>
                            <a href="MainController?action=ViewOrderHistory&userID=<%=user.getUserID()%>">Lịch sử mua hàng</a>                     
                            <span>Đánh giá sản phẩm</span>
                        </div>
                    </div>
                </div>
              
            </div>
        </div>
        <!-- Breadcrumb End -->
        <%
            /*String productID = "10";
            String productName = "ÁO SƠ MI GIẤU NÚT";
            String productImage = "/images/ao-so-mi-giau-nut-trang.jpg";
            String orderID = "1";*/
            String productID = (String)request.getAttribute("PRODUCT_ID");
            String productName = (String)request.getAttribute("PRODUCT_NAME");
            String productImage = (String)request.getAttribute("PRODUCT_IMAGE");
            String orderID = (String)request.getAttribute("ORDER_ID");
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String rateDate = dateFormat.format(new Date());
            
        %>
        <form action="MainController" method="POST">
            <h2 class="text-center">Đánh giá sản phẩm</h2>
            <h5 class="text-center"><%=productName%></h5>
            <div class="row my-3">
                <img class="mx-auto" width="150px" src="<%=productImage%>" alt="Product Image"/>
            </div>
            <input type="hidden" name="productID" value=<%=productID%>>
            <input type="hidden" name="orderID" value=<%=orderID%>>
            <input type="hidden" name="rateDate" value=<%=rateDate%>>
            <div class="row my-3">
                <div class="col-md-2 my-auto offset-1 text-right">
                    <span>Đánh giá</span>
                </div>
                <div class="rating col-md-8">
                    <input type="radio" name="rating" id="rating-5" value="5" checked="checked">
                    <label for="rating-5"></label>
                    <input type="radio" name="rating" id="rating-4" value="4">
                    <label for="rating-4"></label>
                    <input type="radio" name="rating" id="rating-3" value="3">
                    <label for="rating-3"></label>
                    <input type="radio" name="rating" id="rating-2" value="2">
                    <label for="rating-2"></label>
                    <input type="radio" name="rating" id="rating-1" value="1">
                    <label for="rating-1"></label>
                </div>
            </div>
            <div class="row my-3">
                <div class="col-md-2 offset-1 text-right">
                    <span>Nhận xét</span>
                </div>
                <div class="col-md-7">
                    <textarea class="form-control mt-1" name="content" rows="7" placeholder="Nhận xét của bạn(tối đa 200 ký tự)"></textarea>
                </div>
            </div>
            <div class="row my-5">
                <div class="col-md-2 offset-1">                
                </div>
                <div class="col-md-7">
                 <button type="submit" name="action" value="UpdateRating" class="btn btn-danger text-white mx-auto">Gủi đánh giá</button>
                </div>
            </div>
           
        </form>
        
        <!-- Search End -->

        <jsp:include page="footer.jsp" flush="true" />
    </script>
    <!-- Js Plugins -->
    <jsp:include page="js-plugins.jsp" flush="true" />
</body>
</html>
