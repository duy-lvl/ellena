<%-- 
    Document   : manager
    Created on : May 22, 2022, 7:57:21 AM
    Author     : Jason 2.0
--%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="javafx.util.Pair"%>
<%@page import="store.shopping.StatisticDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ | Manager</title>
        <jsp:include page="meta.jsp" flush="true" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2/dist/Chart.min.js"></script>
        <link rel="stylesheet" href="css/statistic-responsive.css" type="text/css">
   
    <style>
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
            /* display: none; <- Crashes Chrome on hover */
            -webkit-appearance: none;
            margin: 0; /* <-- Apparently some margin are still there even though it's hidden */
        }

        input[type=number] {
            -moz-appearance:textfield; /* Firefox */
        }
        .bg-grey{
            background: #ededed;
        }

        .flex-item{
            background: white;
            margin: 1rem;


        }
        .order-status-item{
            border: 1px solid #bfbfbf;
            margin: 1rem;

            padding: 1.25rem;
        }

        .flex-card{
            background: white;
            margin: 0.5rem;

        }
        #order-status{
            flex-basis: 65%;
        }
        #today-statistic{
            flex-basis: 35%;
        }

        #cancel_ratio{
            flex-basis: 40%;
            margin-left: 2rem;
        }
        #pay-type-chart{
            flex-basis: 60%;
            margin-right: 2rem;

        }
        .text-2{
            color: #93a3b1;
        }
        .text-3{
            color:#b57c68;
        }
        .text-4{
            color:#344055;
        }
        #manager__header{
            padding: 0.5rem 1rem;
            text-align: right;
            border-radius: 0.5rem;
            background: transparent;
            font-size: 0.7rem;
        }
        #manager__header h4{
            font-size: 1.75rem;
        }
        .navbar__container{
            background: white;
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap: 0;
            margin: 0 1rem;

        }

        .navbar__item{
            border-radius: 1rem;
            padding: 0.75rem;
            margin:0.5rem;
            background: white;
            text-align: center;

        }

        .navbar__item.active{
            background: #dedede;
            font-weight:700;
        }
        .navbar__item:hover{
            background: #dedede;

        }
        .navbar__item > a{
            color:black;
        }
        .navbar__container> a{
            color:black;
        }
        .flex__container{
            display: flex;
            justify-content: center;
            margin:0.5rem;

        }
        .flex__container span{
            margin:1rem;
            margin-top: 0;
        }
        #user-statistic{
            margin: 1rem;

            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }
        .user__item{
            background: white;
            text-align: center;
            border-radius: 1rem;
         
            padding: 1rem 2rem;
        }
        .user__item > h5{
            margin-top:0.25rem;
            margin-bottom: 3rem;
        }
        .user__item > span{
            font-size: 4rem;
        }


        .table__container{
            width: 100%;
            font-size: 1.25rem;
            border-radius: 1rem;
            box-shadow: 0 3px 10px rgba(0 0 0 / 0.2);
        }

        .table__row{
            display:grid;
            grid-template-columns: 5% 30% 25% 20% 20%;
        }
        .table__row div{
            padding: 1.5rem 0;
            text-align: center;
            font-size:1.25rem;
        }
        .button__container{
            display: grid;
            grid-template-columns: 60% 15% 15% 10%;
        }
        .fa-clock-rotate-left::before {
            content: "\f1da";
        }
        .dropdown-menu{
            right:0;
            left:auto;
        }
    </style>

</head>

<body>
    <%!
        public String addDot(Integer number) {
            String str = String.format("%,d", number);
            return str;
        }
    %>
    <!--GET LOGIN USER-->
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setHeader("Expires", "0"); // Proxies.
        UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        double avgAge = (double) request.getAttribute("USER_AVG_AGE");
        double purchaseRatio = (double) request.getAttribute("PURCHASE_RATIO");
        int totalCustomer = (int) request.getAttribute("TOTAL_CUSTOMER");
        List<Pair<String, Integer>> userGender = (List<Pair<String, Integer>>) request.getAttribute("USER_GENDER");
        List<Pair< Pair<String, String>, Pair<Integer, Integer>>> loyalCustomer = (List<Pair< Pair<String, String>, Pair<Integer, Integer>>>) request.getAttribute("LOYAL_CUSTOMER_LIST");

        String MIN_DAY = "2000-01-01";
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        String loyalFrom = (String) request.getParameter("loyalFrom");
        if (loyalFrom == null) {
            loyalFrom = MIN_DAY;
        }
        String loyalTo = (String) request.getParameter("loyalTo");
        if (loyalTo == null) {
            loyalTo = (dateFormat.format(new Date()));
        }
        int numberCustomer = 100;
        String s = (String) request.getParameter("numberCustomer");
        if (s != null && s != "") {
            numberCustomer = Integer.parseInt(s);
        }
    %>

    <div class="wrapper d-flex align-items-stretch">
        <!-- SIDE NAV BAR-->
        <nav class="side-nav bg-color-primary d-flex flex-column p-3 shadow"> 
            <a class="pt-5" href="ManagerStatisticController" style="color: #873e23; font-weight: bold;"><i style="color: #873e23;" class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </nav>

        <div id="content" class="p-3 px-5 bg-grey">
            <!--WELCOME USER-->
            <div class="flex-item" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h4 class="dropdown">
                        <b>Xin chào, </b>
                        <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                            <button class="dropdown-item btn" role="tab" type="button"><a class="text-dark" href="my-profile.jsp">Thông tin tài khoản</a></button>
                            <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h4>
                </form>
            </div>
            <!--Nav bar-->
            <div class="navbar__container">
                <a href="ManagerStatisticController">
                    <div class="navbar__item">
                        <span>Đơn hàng</span>
                    </div>
                </a>
                <div class="navbar__item active">
                    <span>Người dùng</span>
                </div>
            </div>

            <div class="" id="user-statistic">
                <div class="user__item">
                    <h5><b>Số lượng người dùng</b></h5>
                    <span class="text-2"><b><%=totalCustomer%></b></span>
                </div>
                <div class="user__item">
                    <h5 class="mb-2"><b>Giới tính</b></h5>
                    <canvas id="user-gender"></canvas>
                </div>
                <div class="user__item">
                    <h5><b>Độ tuổi trung bình</b></h5>
                    <span class="text-3"><b><%=avgAge%></b></span>
                </div>

                <div class="user__item">
                    <h5><b>Tỷ lệ đặt hàng</b></h5>
                    <span class="text-4"><b><%=purchaseRatio%>%</b></span>
                </div>
            </div>

            <div class="flex-item p-5" id="table">
                <h4 class="mb-0 text-center"><b>Top khách hàng thân thiết</b></h4>
                <div class="text-right" >
                    <form class="my-3" action="ManagerStatisticUserController" method="post">
                        <div class ="button__container">
                            <div></div>
                            <div class="dropdown">    
                                <button type="button" class="btn btn-default dropdown-toggle my-3" data-toggle="dropdown">
                                    Chọn thời gian
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <div class="dropdown-item date-picker text-center">
                                        <b>Từ</b>
                                        <input class="date mr-5" data-provide="datepicker" type="date" name="loyalFrom" value="<%=loyalFrom%>" />                                        
                                        <b>đến</b>
                                        <input class="date" data-provide="datepicker" type="date"  name="loyalTo" value="<%=loyalTo%>"/> 
                                    </div>                                
                                </div>
                            </div>
                            <div class="dropdown">
                                <button type="button" class="btn btn-default dropdown-toggle my-3" data-toggle="dropdown" >
                                    Chọn số lượng
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <div class="dropdown-item">
                                        <input type="number" min="1"  name="numberCustomer" value="<%=numberCustomer%>"> 
                                        <span>người</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="p-3">
                                <button class="btn btn-default" type="submit">Áp dụng</button>
                            </div>
                        </div>
                        <!-- Modal -->


                    </form> 
                </div>
                <div class= "table__container">
                    <div class="color-2 table__header">
                        <div class="table__row">
                            <div>STT</div>
                            <div>Mã khách hàng</div>
                            <div>Tên</div>                              
                            <div>Giá trị mua hàng</div>
                            <div>Số đơn hàng</div>
                        </div>
                    </div>

                    <div class="table__body">
                        <%
                            int count = 1;
                            for (Pair< Pair<String, String>, Pair<Integer, Integer>> p : loyalCustomer) {
                        %>
                        <div class="table__row">
                            <div><%=count++%></div>
                            <div><%=p.getKey().getKey()%></div>
                            <div><%=p.getKey().getValue()%></div>
                            <div><%=p.getValue().getKey()%></div>
                            <div><%=p.getValue().getValue()%></div>
                        </div>    
                        <%}%>
                    </div>
                </div>
            </div>
        </div>

    </div>

</body>
<script>
    var canvas = document.getElementById('user-gender');
    var ctx = canvas.getContext('2d');
    var gradient1 = "#344055";
    var gradient2 = "#93a3b1";
    var gradient3 = "#b57c68";
    var myChart = new Chart(ctx, {
    type: 'doughnut',
            data: {
            labels: [
    <%for (Pair<String, Integer> p : userGender) {%>
            "<%=p.getKey()%>",
    <%}%>
            ],
                    datasets: [{
                    label: 'Số lượng',
                            data: [<%for (Pair<String, Integer> p : userGender) {%>
                            "<%=p.getValue()%>",
    <%}%>],
                            backgroundColor: [gradient1, gradient2]
                    }]
            },
    });
</script>
</html>
