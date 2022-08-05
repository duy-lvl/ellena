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
   <script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3"></script>
<script src="https://cdn.jsdelivr.net/npm/hammerjs@2.0.8"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@0.7.7"></script>
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
        border-radius: 0.5rem;   
    }
    
    
    .order-status-item{
       border: 1px solid #bfbfbf;
       margin: 1rem;
       border-radius: 1rem;
       padding: 1.25rem;
       
    }
    
    
    .flex-card{
        background: white;
        margin: 0.5rem;
        border-radius: 0.5rem;
    }
    #order-status{
        flex-basis: 65%;
    }
    #today-statistic{
        flex-basis: 35%;
    }
    #graph-dropdơwn{
        width: max-content;
        margin-left: auto; 
        margin-right: 0;
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
        background: white;
        border-radius: 0.5rem;
        
    }
    .navbar__container{
        background: white;
        border-radius: 1rem;
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
    .navbar__container> a{
        color:black;
    }
    .dropdown-menu{
        right:0;
        left:auto;
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
    .fa-clock-rotate-left::before {
        content: "\f1da";
    }
    </style>
    
</head>

<body>
    <%!
        public String addDot(Integer number){
        String str = String.format("%,d", number);
        return str;
    }
    %>
    <!--GET LOGIN USER-->
    <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            //Min date used for the default time range
            String MIN_DATE = "2000-01-01";
            
        %>
       
    <div class="wrapper d-flex align-items-stretch">
        <!-- SIDE NAV BAR-->
        <nav class="side-nav bg-color-primary d-flex flex-column p-3 shadow"> 
            <a class="pt-5" href="ManagerStatisticController" style="color: #873e23; font-weight: bold;"><i style="color: #873e23;" class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </nav>
        
        <%
            StatisticDTO today = (StatisticDTO)request.getAttribute("ORDER_STATISTIC_TODAY");                    
        %>
        <div id="content" class="p-3 px-5 bg-grey">
            <!--WELCOME USER-->
            <div class="flex-item text-right" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h4 class="dropdown">
                        <b>Xin chào, </b>
                        <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                            <a class="text-dark" href="my-profile.jsp"><button class="dropdown-item btn" role="tab" type="button">Thông tin tài khoản</button></a>
                            <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h4>
                </form>
            </div>
            <!--Nav bar-->
            <div class="navbar__container">
                <div class="navbar__item active">
                    <span>Đơn hàng</span>
                </div>
                <a href="ManagerStatisticUserController"><div class="navbar__item">
                    <span>Người dùng</span>
                    </div></a>
            </div>
            
            
            <div class="d-flex mb-4">
                <div class="flex-item bg-white" id="order-status">
                    <h4 class="my-4 text-center"><b>Tình trạng đơn hàng</b></h4>
                    <div class="d-flex">
                    <div class="order-status-item" id="cancel_ratio">
                        <%
                            double cancelRatio = (double)request.getAttribute("CANCEL_RATIO");
                            double refundRatio = (double)request.getAttribute("REFUND_RATIO");
                            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                            String cancelOrderFrom = (String)request.getParameter("cancelOrderFrom");
                            if(cancelOrderFrom == null){
                                cancelOrderFrom = MIN_DATE;
                            }
                            String cancelOrderTo = (String)request.getParameter("cancelOrderTo");
                            if(cancelOrderTo == null){
                                cancelOrderTo = (dateFormat.format(new Date()));
                            }
                            String payTypeFrom = (String)request.getParameter("payTypeFrom");
                            if(payTypeFrom == null){
                                payTypeFrom = MIN_DATE;
                            }
                            String payTypeTo= (String)request.getParameter("payTypeTo");
                            if(payTypeTo == null){
                                payTypeTo = (dateFormat.format(new Date()));
                            }
                            String getStatisticFrom = (String)request.getParameter("getStatisticFrom");
                            if(getStatisticFrom == null){
                                getStatisticFrom = MIN_DATE;
                            }
                            String getStatisticTo= (String)request.getParameter("getStatisticTo");
                            if(getStatisticTo == null){
                                getStatisticTo = (dateFormat.format(new Date()));
                            }                          
                            %>
                            <h6 class="text-center"><b>Tỷ lệ hủy/hoàn đơn</b></h6>
                        <div class="text-right" >
                            <button type="button" class="btn btn-default mt-3" data-toggle="modal" data-target="#order__modal__1">
                            Chọn thời gian
                          </button>

                          <!-- Modal -->
                          <div class="modal fade" id="order__modal__1" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                              <span aria-hidden="true">&times;</span>
                                          </button>
                                      </div>
                                      <form action="ManagerStatisticController" method="post">
                                          <div class="modal-body">
                                              <div class="date-picker text-center">
                                                  <b>Từ</b>
                                                  <input class="date mr-5" data-provide="datepicker" type="date" name="cancelOrderFrom" value="<%=cancelOrderFrom%>" />                                        
                                                  <b>đến</b>
                                                  <input class="date" data-provide="datepicker" type="date"  name="cancelOrderTo" value="<%=cancelOrderTo%>"/> 
                                              </div>
                                          </div>
                                          <div class="modal-footer">
                                              <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                              <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                          </div>
                                      </form>   
                                  </div>
                              </div>
                          </div>
                            
                        </div>
                        <div class="card my-3">
                            <div class="d-flex flex-row align-items-center">
                                <div class="flex-item m-0 ml-2">
                                    <span class="h5">Tỷ lệ hủy</span>
                                </div>
                                <div class="flex-item ml-auto">
                                    <h3 class = "text-4"><b><%=(int)(cancelRatio*100)%>%</b></h3>                            
                                </div>
                            </div>
                        </div>
                        <div class="card ">
                            <div class="d-flex flex-row align-items-center">
                                <div class="flex-item m-0 ml-2">
                                    <span class="h5">Tỷ lệ hoàn</span>
                                </div>
                                <div class="flex-item ml-auto">
                                    <h3 class="text-2"><b>
                                            <%=(int)(refundRatio*100)%>%
                                        </b></h3>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="order-status-item" id="pay-type-chart">
                        <%
                            List<Pair<String, Integer>> payType = (List<Pair<String, Integer>>)request.getAttribute("PAY_TYPE");
                        %>
                        <h6 class="text-center"><b>Hình thức thanh toán</b></h6>
                        <div class="text-right" >
                            <button type="button" class="btn btn-default my-3" data-toggle="modal" data-target="#order__modal__2">
                            Chọn thời gian
                          </button>

                          <!-- Modal -->
                          <div class="modal fade" id="order__modal__2" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                              <span aria-hidden="true">&times;</span>
                                          </button>
                                      </div>
                                      <form action="ManagerStatisticController" method="post">
                                          <div class="modal-body">
                                              <div class="date-picker text-center">
                                                  <b>Từ</b>
                                                  <input class="date mr-5" data-provide="datepicker" type="date" name="payTypeFrom" value="<%=payTypeFrom%>"/>                                        
                                                  <b>đến</b>
                                                  <input class="date" data-provide="datepicker" type="date"  name="payTypeTo" value="<%=payTypeTo%>"/> 
                                              </div>
                                          </div>
                                          <div class="modal-footer">
                                              <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                              <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                          </div>
                                      </form>   
                                  </div>
                              </div>
                          </div>
                            
                        </div>
                        <canvas id="pay-type"></canvas>
                    </div>
                    </div>
                </div>
                <!--STATISTIC DATE -->
                <div class="flex-item" id="today-statistic">
                    <h4 class="my-4 text-center"><b>Doanh số theo ngày</b></h4>
                    <div class="d-flex flex-column justify-content-around px-5">
                        <div class="text-right mr-2" >
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#statistic__modal">
                            Chọn thời gian
                          </button>

                          <!-- Modal -->
                          <div class="modal fade" id="statistic__modal" tabindex="-1" role="dialog">
                              <div class="modal-dialog" role="document">
                                  <div class="modal-content">
                                      <div class="modal-header">
                                          <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                              <span aria-hidden="true">&times;</span>
                                          </button>
                                      </div>
                                      <form action="ManagerStatisticController" method="post">
                                          <div class="modal-body">
                                              <div class="date-picker text-center">
                                                  <b>Từ</b>
                                                  <input class="date mr-5" data-provide="datepicker" type="date" name="getStatisticFrom" value="<%=getStatisticFrom%>"/>                                        
                                                  <b>đến</b>
                                                  <input class="date" data-provide="datepicker" type="date"  name="getStatisticTo" value="<%=getStatisticTo%>"/> 
                                              </div>
                                          </div>
                                          <div class="modal-footer">
                                              <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                              <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                          </div>
                                      </form>   
                                  </div>
                              </div>
                          </div>
                            
                        </div>
                        <div class="flex-card card pr-2">
                            <div class="row no-gutters">
                                <div class="col-4 text-center">
                                    <img class="" height="50px" src="img/shopping-cart.png" alt="Đơn hàng" />
                                </div>
                                <div class="col-8 text-right">
                                    <h3 class="mt-2 mb-0 mr-5 text-3"><b>
                                            <%=today.getOrderQuantity()%>
                                        </b></h3>
                                    <p class="mb-2 mr-5">Đơn hàng</p>
                                </div>
                            </div>
                        </div>
                        <div class="flex-card card pr-2">
                            <div class="row no-gutters">
                                <div class="col-4 text-center">
                                    <img class="mt-4" height="50px" src="img/coins.png" alt="Đơn hàng" />
                                </div>
                                <div class="col-8 text-right">
                                    <h3 class="mt-2 mb-0 mr-5 text-2"><b>
                                            <%=addDot(today.getIncome())%>
                                        </b></h3>
                                    <p class="mb-2 mr-5">Doanh thu(VNĐ)</p>
                                </div>
                            </div>
                        </div>
                        <div class="flex-card card  pr-2">
                            <div class="row no-gutters">
                                <div class="col-4 text-center">
                                    <img class="mt-4" height="50px" src="img/clothes.png" alt="Đơn hàng" />
                                </div>
                                <div class="col-8 text-right">
                                    <h3 class="mt-2 mb-0 mr-5 text-4"><b>
                                            <%=today.getProductQuantity()%>
                                        </b></h3>
                                    <p class="mb-2 mr-5">Sản phẩm</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- INCOME GRAPH -->
            <%
                    Map<String, StatisticDTO> orderStatistic7Day = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_7DAY");
                    Map<String, StatisticDTO> orderStatistic4Week = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_30DAY");
                    Map<String, StatisticDTO> orderStatistic1Year = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_1YEAR");
                    Map<String, StatisticDTO> orderStatisticCustom = (Map<String, StatisticDTO>) request.getAttribute("ORDER_STATISTIC_CUSTOM");
                    List<Pair<String, StatisticDTO>> bestSeller = (List<Pair<String, StatisticDTO>>) request.getAttribute("BEST_SELLER");
                    List<Pair<String, StatisticDTO>> bestIncome = (List<Pair<String, StatisticDTO>>) request.getAttribute("BEST_INCOME");  
                    List<Pair<String, Integer>> userGender = (List<Pair<String, Integer>>) request.getAttribute("USER_GENDER"); 
                    Set<String> set7day = orderStatistic7Day.keySet();
                    Set<String> set4week = orderStatistic4Week.keySet();
                    Set<String> set1year = orderStatistic1Year.keySet();
                    Set<String> setCustom = null;
                    List<String> list7day = new ArrayList<String>(set7day);
                    List<String> list4week = new ArrayList<String>(set4week);
                    List<String> list1year = new ArrayList<String>(set1year);
                    List<String> listCustom = null;
                    Collections.sort(list7day);
                    Collections.sort(list4week);
                    Collections.sort(list1year);
                    
                    if(orderStatisticCustom != null){
                        setCustom = orderStatisticCustom.keySet();
                        listCustom = new ArrayList<String>(setCustom);
                        Collections.sort(listCustom);
                    }
                    
      
                    String sellerFrom = (String)request.getParameter("sellerFrom");
                    if(sellerFrom == null){
                        sellerFrom = MIN_DATE;
                    }
                    String sellerTo = (String)request.getParameter("sellerTo");
                    if(sellerTo == null){
                        sellerTo = (dateFormat.format(new Date()));
                    }
                    String incomeFrom = (String)request.getParameter("incomeFrom");
                    if(incomeFrom == null){
                        incomeFrom = MIN_DATE;
                    }
                    String incomeTo = (String)request.getParameter("incomeTo");
                    if(incomeTo == null){
                        incomeTo = (dateFormat.format(new Date()));
                    }

                %>
            <div class="flex-item p-3 tab-content mb-4">
                <div class="container-fluid nav-item p-0 pr-4">
                    <h4 class="my-3 text-center"><b> Số lượng đơn hàng, doanh thu và sản phẩm bán được</b></h4>
                    <div class="dropdown" id="graph-dropdơwn">
                        <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Chọn thời gian
                        </button>
                        <div class="dropdown-menu">
                            <%
                                String getGraphFrom = (String)request.getParameter("getGraphFrom");
                                String getGraphTo = (String)request.getParameter("getGraphTo");
                                if(getGraphFrom != null && getGraphTo != null && getGraphFrom != "" && getGraphTo != ""){
                            %>
                                 <button class="dropdown-item " role="tab" type="button" data-toggle="tab" data-target="#chart4">
                                 [<%=getGraphFrom%>]-[<%=getGraphTo%>]</button>
                            <%
                                }
                            %>
                            <button class="dropdown-item " role="tab" type="button" data-toggle="tab" data-target="#chart1">7
                                ngày</button>
                            <button class="dropdown-item" role="tab" type="button" data-toggle="tab" data-target="#chart2">30
                                ngày</button>
                            <button class="dropdown-item" role="tab" type="button" data-toggle="tab" data-target="#chart3">12
                                tháng</button>
                            <button class="dropdown-item" type="button" data-toggle="modal" data-target="#graph__modal">
                                Tùy chỉnh
                            </button>

                            
                        </div>
                      </div>
                <!-- Modal -->
                            <div class="modal fade" id="graph__modal" tabindex="-1" role="dialog">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form action="ManagerStatisticController" method="post">
                                            <div class="modal-body">
                                                <div class="date-picker text-center">
                                                    <b>Từ</b>
                                                    <input class="date mr-5" data-provide="datepicker" type="date" name="getGraphFrom" />                                        
                                                    <b>đến</b>
                                                    <input class="date" data-provide="datepicker" type="date"  name="getGraphTo" /> 
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                                <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                            </div>
                                        </form>   
                                    </div>
                                </div>
                            </div>  
                </div>
                <%
                    if(getGraphFrom == null || getGraphTo == null || getGraphFrom == "" || getGraphTo == ""){
                        %>
                        <div id="chart1" class="col-10 tab-pane fade active in m-auto" role="tabpanel">
                            <canvas id="7DayChart"></canvas>
                        </div>
                        <%
                    }else {
                    %>
                    <div id="chart4" class="col-10 tab-pane fade active in m-auto" role="tabpanel">
                        <canvas id="custom-chart"></canvas>
                    </div>
                    <div id="chart1" class="col-10 tab-pane fade in m-auto" role="tabpanel">
                        <canvas id="7DayChart"></canvas>
                    </div>
                    <%
                }                    
                %>
                    <div id="chart2" class="col-10 tab-pane fade m-auto" role="tabpanel">
                        <canvas id="4WeekChart"></canvas>
                    </div>
                    <div id="chart3" class="col-10 tab-pane fade m-auto" role="tabpanel">
                        <canvas id="1YearChart"></canvas>
                    </div>
                
            </div>    
            <!--BEST SELLER-->
            <div class="flex-item rounded color-bg p-3 mb-4">          
                <h4 class="my-3 text-center"><b>Sản phẩm bán chạy nhất</b></h4>                  
                <div class="text-right">
                    <button type="button" class="btn btn-default mt-3" data-toggle="modal" data-target="#best-seller__modal">
                        Chọn thời gian
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="best-seller__modal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="ManagerStatisticController" method="post">
                                    <div class="modal-body">
                                        <div class="date-picker text-center">
                                            <b>Từ</b>
                                            <input class="date mr-5" data-provide="datepicker" type="date" name="sellerFrom" value="<%=sellerFrom%>" />                                        
                                            <b>đến</b>
                                            <input class="date" data-provide="datepicker" type="date" name="sellerTo" value="<%=sellerTo%>" /> 
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                        <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                    </div>
                                </form>   
                            </div>
                        </div>
                    </div>

                </div>
                <div class="row p-4">
                    <%
                        if(bestSeller.size() > 0){
                        int cnt = 1;
                         for(Pair<String, StatisticDTO> p : bestSeller){
                          %>
                            <a href="ManagerShowProductDetailController?productID=<%=p.getValue().getOrderQuantity()%>" class="card ml-4 p-0 col-12 col-sm border-0 shadow rounded">
                                <div class="card-block text-center">
                                    <div class="color-<%=2+(cnt+1)%3%> text-white p-2 mb-3">
                                        <h3><b><%=p.getValue().getIncome()%></b></h3>
                                        <span>Sản phẩm bán được</span>
                                    </div>
                                    <div class="px-3 ">
                                        <h6 class="card-title mb-2"><b><%cnt++;%><%=p.getKey()%></b></h6>
                                        <p class="card-text mb-0">Mã sản phẩm: <%=p.getValue().getOrderQuantity()%></p>
                                    </div>
                                </div>
                            </a>

                            <%
                        }
                        }else{
                        %>
                        <h6 class="text-center"><b>Không có dữ liệu</b></h6>
                        <%
                        }
                    %>
                </div>
            </div>
            <!--BEST INCOME-->    
            <div class="flex-item rounded color-bg p-3 mb-4">
                <h4 class="my-3 text-center"><b>Sản phẩm có doanh thu cao nhất</b></h4>
                <div class="text-right">
                    <button type="button" class="btn btn-default mt-3" data-toggle="modal" data-target="#best-income__modal">
                        Chọn thời gian
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="best-income__modal" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Chọn thời gian</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <form action="ManagerStatisticController" method="post">
                                    <div class="modal-body">
                                        <div class="date-picker text-center">
                                            <b>Từ</b>
                                            <input class="date mr-5" data-provide="datepicker" type="date" name="incomeFrom" value="<%=incomeFrom%>" />                                        
                                            <b>đến</b>
                                            <input class="date" data-provide="datepicker" type="date" name="incomeTo" value="<%=incomeTo%>" /> 
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy bỏ</button>
                                        <button class="btn bg-color-primary border-0" type="submit">Áp dụng</button>
                                    </div>
                                </form>   
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="row p-4">
                    <%
                        if(bestIncome.size() > 0){
                        int cnt = 1;
                        for(Pair<String, StatisticDTO> p : bestIncome){
                            %>
                            <a href="ManagerShowProductDetailController?productID=<%=p.getValue().getOrderQuantity()%>" class="card ml-4 p-0 col-12 col-sm rounded border-0 shadow">
                                <div class="card-block text-center">
                                    <div class="color-<%=2+(cnt+1)%3%> text-white p-2 mb-3">
                                        <h4><b><%=addDot(p.getValue().getProductQuantity())%>đ</b></h4>
                                        <span>Doanh thu</span>
                                    </div>
                                        <div class="px-3 ">
                                    <h6 class="card-title mb-2"><b><%cnt++;%><%=p.getKey()%></b></h6>
                                    <p class="card-text mb-0">Mã sản phẩm: <%=p.getValue().getOrderQuantity()%></p>
                                        </div>
                                </div>
                            </a>
                            <%
                        }}else{
                        %>
                        <h6 class="text-center"><b>Không có dữ liệu</b></h6>
                        <%
                        }
                    %>
                </div>
               
            </div>
        </div>              
    </div>
        
    <!--Pay type chart-->                
    <script>
        var canvas = document.getElementById('pay-type');
        var ctx = canvas.getContext('2d');

        var gradient1 = '#344055';
        var gradient2 = '#93a3b1';
        var gradient3 = '#b57c68';
        var ctx = document.getElementById("pay-type");
        var myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: [
        <%for (Pair<String, Integer> p : payType) {%>
            "<%=p.getKey()%>",
        <%}%>
            ],
            datasets: [{
                    label: 'Hình thức thanh toán',
                    data: [<%for (Pair<String, Integer> p : payType) {%>
            "<%=p.getValue()%>",
        <%}%>],
                    backgroundColor: [gradient1, gradient2, gradient3]           
                }]
        },      
        });
    </script>              
    <!-- CUSTOM CHART -->
    <%
    if(getGraphFrom != null && getGraphTo != null && getGraphFrom != "" && getGraphTo != ""){
    %>
    <script type="text/javascript">
        var canvas = document.getElementById('custom-chart');
        var ctx = canvas.getContext('2d');

        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        <%
            String type = "bar";
            
        %>
        var gradient1 = '#344055';
        var gradient2 = '#93a3b1';
        var gradient3 = '#b57c68';
        var ctx = document.getElementById("custom-chart");
        var myChart = new Chart(ctx, {
        type: '<%=type%>',
        data: {
            labels: [<%for (String key : listCustom) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Đơn hàng',
                    data: [<%for (String key : listCustom) {
                                        %>
                        "<%=orderStatisticCustom.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient1,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Doanh thu(VNĐ)',
                    data: [<%for (String key : listCustom) {
                                        %>
                        "<%=orderStatisticCustom.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient2,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Số sản phẩm',
                    data: [<%for (String key : listCustom) {
                                        %>
                        "<%=orderStatisticCustom.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient3,
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            },
            legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
            },
            plugins: {
	zoom: {
		// Container for pan options
		pan: {
			// Boolean to enable panning
			enabled: true,

			// Panning directions. Remove the appropriate direction to disable
			// Eg. 'y' would only allow panning in the y direction
			// A function that is called as the user is panning and returns the
			// available directions can also be used:
			//   mode: function({ chart }) {
			//     return 'xy';
			//   },
			mode: 'xy',

			rangeMin: {
				// Format of min pan range depends on scale type
				x: null,
				y: null
			},
			rangeMax: {
				// Format of max pan range depends on scale type
				x: null,
				y: null
			},

			// On category scale, factor of pan velocity
			speed: 20,

			// Minimal pan distance required before actually applying pan
			threshold: 10,

			// Function called while the user is panning
			onPan: function({chart}) { console.log(`I'm panning!!!`); },
			// Function called once panning is completed
			onPanComplete: function({chart}) { console.log(`I was panned!!!`); }
		},

		// Container for zoom options
		zoom: {
			// Boolean to enable zooming
			enabled: true,

			// Enable drag-to-zoom behavior
			drag: true,

			// Drag-to-zoom effect can be customized
			// drag: {
			// 	 borderColor: 'rgba(225,225,225,0.3)'
			// 	 borderWidth: 5,
			// 	 backgroundColor: 'rgb(225,225,225)',
			// 	 animationDuration: 0
			// },

			// Zooming directions. Remove the appropriate direction to disable
			// Eg. 'y' would only allow zooming in the y direction
			// A function that is called as the user is zooming and returns the
			// available directions can also be used:
			//   mode: function({ chart }) {
			//     return 'xy';
			//   },
			mode: 'xy',

			rangeMin: {
				// Format of min zoom range depends on scale type
				x: null,
				y: null
			},
			rangeMax: {
				// Format of max zoom range depends on scale type
				x: null,
				y: null
			},

			// Speed of zoom via mouse wheel
			// (percentage of zoom on a wheel event)
			speed: 0.1,

			// Minimal zoom distance required before actually applying zoom
			threshold: 2,

			// On category scale, minimal zoom level before actually applying zoom
			sensitivity: 3,

			// Function called while the user is zooming
			onZoom: function({chart}) { console.log(`I'm zooming!!!`); },
			// Function called once zooming is completed
			onZoomComplete: function({chart}) { console.log(`I was zoomed!!!`); }
		}
	}
}
        }
         
       
    });
    
    </script>
    <%}
    %>
    <script type="text/javascript">
        var canvas = document.getElementById('7DayChart');
        var ctx = canvas.getContext('2d');

        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        var gradient1 = '#344055';
        var gradient2 = '#93a3b1';
        var gradient3 = '#b57c68';
        var ctx = document.getElementById("7DayChart");
        var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%for (String key : list7day) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Đơn hàng',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient1,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Doanh thu(VNĐ)',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient2,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Số sản phẩm',
                    data: [<%for (String key : list7day) {
                                        %>
                        "<%=orderStatistic7Day.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient3,
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            },
            legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
            }
        }
    });
    </script>
    <script type="text/javascript">
    var canvas = document.getElementById('4WeekChart');
    var ctx = canvas.getContext('2d');

    // Create a linear gradient
    // The start gradient point is at x=20, y=0
    // The end gradient point is at x=220, y=0
        var gradient1 = '#344055';
        var gradient2 = '#93a3b1';
        var gradient3 = '#b57c68';
    var ctx = document.getElementById("4WeekChart");
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [<%for (String key : list4week) {
                            %>
                "<%=key%>",
                <%}%>
            ],
            datasets: [{
                    label: 'Đơn hàng',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getOrderQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient1,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Doanh thu(VNĐ)',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getIncome()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient2,
                    borderColor: [

                    ],
                    borderWidth: 1
                },
                {
                    label: 'Số sản phẩm',
                    data: [<%for (String key : list4week) {
                                        %>
                        "<%=orderStatistic4Week.get(key).getProductQuantity()%>",
                        <%}%>
                    ],
                    backgroundColor: gradient3,
                    borderColor: [

                    ],
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {

                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }],
                xAxes: [{

                }]
            },
                legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
            }
        }
    });
    </script>
    <script type="text/javascript">
        var canvas = document.getElementById('1YearChart');
        var ctx = canvas.getContext('2d');

        // Create a linear gradient
        // The start gradient point is at x=20, y=0
        // The end gradient point is at x=220, y=0
        var gradient1 = '#344055';
        var gradient2 = '#93a3b1';
        var gradient3 = '#b57c68';
        
        
        var ctx = document.getElementById("1YearChart");
        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: [<%for (String key : list1year) {
                                %>
                    "<%=key%>",
                    <%}%>
                ],
                datasets: [{
                        label: 'Đơn hàng',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getOrderQuantity()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient1,
                        borderColor: [

                        ],
                        borderWidth: 1
                    },
                    {
                        label: 'Doanh thu(VNĐ)',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getIncome()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient2,
                        borderColor: [

                        ],
                        borderWidth: 1
                    },
                    {
                        label: 'Số sản phẩm',
                        data: [<%for (String key : list1year) {
                                            %>
                            "<%=orderStatistic1Year.get(key).getProductQuantity()%>",
                            <%}%>
                        ],
                        backgroundColor: gradient3,
                        borderColor: [

                        ],
                        borderWidth: 1
                    }
                ]
            },
        
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }],
                    xAxes: [{

                    }]
                },
                legend:{
                    onClick:function(t,e){
                    var index =e.datasetIndex,o=this.chart;
                    for(n=0,i=(o.data.datasets||[]).length;n<i;++n){
                        if(n!=index){
                        a=o.getDatasetMeta(n);
                        a.hidden=true;
                    }else{
                        a=o.getDatasetMeta(n);
                        a.hidden=false;
                    }
                    o.update();
                    }
                    
                }
                }
            }             
            
        });
    </script>
    
</body>

</html>
