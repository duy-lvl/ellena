<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="store.shopping.CartProduct"%>
<%@page import="store.shopping.Cart"%>
<%@page import="store.shopping.OrderError"%>
<%@page import="store.user.UserDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Thanh Toán</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cookie&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
        <!-- Css Styles -->
        <jsp:include page="meta.jsp" flush="true"/>

    </head>
    <body>
        <jsp:include page="header.jsp" flush="true"/>
        <% List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            Cart c = (Cart) session.getAttribute("CART_INFO");
            OrderError orderError = (OrderError) request.getAttribute("ORDER_ERROR");
            if (orderError == null) {
                orderError = new OrderError();
            }
            String cartMessage = (String) request.getAttribute("CART_MESSAGE");
            if(cartMessage == null){
                cartMessage = "";
            }
            // number format
            NumberFormat numberFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        %>
        
        <!-- Checkout Section Begin -->
        <section class="checkout spad">
            <div class="container">
                <p style="color:red"><%= cartMessage %></p>
                <form action="MainController" class="checkout__form" method="POST">
                    <div class="row">
                        <div class="col-lg-12">
                            <h5>Địa chỉ nhận hàng</h5>
                            <div class="row">

                                <div class="col-lg-12">
                                    <div class="checkout__form__input">
                                        <p>Họ tên <span>*</span></p>
                                        <input type="text" name="fullname" value="<%= c.getFullName()%>" placeholder="Họ và Tên" required="">
                                    </div>
                                    <div class="checkout__form__input">
                                        <p>Tỉnh / thành phố <span>*</span></p>
                                        <div class="col-lg-6 col-md-6 col-sm-6" style="padding: 0; padding-right: 15px;">
                                            <select style="width: 100%; height: 50px; margin: 0 4% 25px 0; padding: 1px 2px 1px 20px;" name="calc_shipping_provinces">
                                                <option value="">Tỉnh / Thành phố</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6" style="padding: 0; padding-left: 15px;">
                                            <select style="width: 100%; height: 50px; margin: 0 4% 25px 0; padding: 1px 2px 1px 20px;" name="calc_shipping_district">
                                                <option value="">Quận / Huyện</option>
                                            </select>
                                        </div>
                                        <input class="billing_address_1" name="" type="hidden" value="">
                                        <input class="billing_address_2" name="" type="hidden" value="">
                                        
                                    </div>
                                    <div class="checkout__form__input" style="color: red;">
                                           <%= orderError.getShippingProvinces()%>
                                    </div>
                                    <div class="checkout__form__input">
                                        <p>Địa chỉ <span>*</span></p>
                                        <input type="text" name="address" placeholder="Số nhà, tên đường, phường/ xã" required="" value="<%= c.getAddress() %>">
                                       
                                    </div>


                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="checkout__form__input">
                                        <p>Số điện thoại <span>*</span></p>
                                        <input type="text" name="phone" value="<%= c.getPhone()%>" placeholder="Số điện thoại liên lạc" required="">
                                        
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6">
                                    <div class="checkout__form__input">
                                        <p>Email <span>*</span></p>
                                        <input type="text" name="email" value="<%= c.getEmail()%>" placeholder="Email liên lạc/xác nhận đơn hàng">
                                        <div class="row">
                                            <p style="color: red"><%= orderError.getEmail()%></p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">

                                    <div class="checkout__form__input">
                                        <p>Ghi chú</p>
                                        <input type="text" name="note" placeholder="Note about your order, e.g, special note for delivery" value="<%= c.getNote() %>">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="checkout__order">
                                <h5>Đơn hàng của bạn</h5>
                                <div class="checkout__order__product">

                                    <div class="row product-details" style="padding-top: 20px;">
                                        <div class="col-md-6" style="font-weight: bold; margin-bottom: 10px;">
                                            Sản phẩm
                                        </div>
                                        <div class="col-md-2" style="font-weight: bold;">
                                            Đơn giá
                                        </div>
                                        <div class="col-md-2" style="font-weight: bold;">
                                            Số lượng
                                        </div>
                                        <div class="col-md-2" style="font-weight: bold;">
                                            Thành tiền
                                        </div>

                                        <%  int total = 0;
                                            int subtotal = 0;
                                            for (CartProduct item : cart) {
                                                total += (item.getPrice()  - item.getDiscount()) * item.getQuantity();
                                                subtotal += item.getPrice() * item.getQuantity();
                                        %>
                                        <div class="col-md-6" style="margin-bottom: 10px;">
                                            <div class="row">
                                                <div class="col-md-9">
                                                    <img style="width: 40px;" src="<%= item.getImage()%>" alt="product-image"/>
                                                    <span><%= item.getProductName()%></span>
                                                </div>
                                                <div class="col-md-3">
                                                    <span><%= item.getColor()%>/ <%= item.getSize()%></span>
                                                </div>
                                            </div>

                                        </div>


                                        <div class="col-md-2">
                                            <%= numberFormat.format(item.getPrice() - item.getDiscount()) %>
                                        </div>
                                        <div class="col-md-2">
                                            <%= item.getQuantity()%>
                                        </div>
                                        <div class="col-md-2">
                                            <%= numberFormat.format((int) (((item.getPrice() - item.getDiscount()) * item.getQuantity()))) %>
                                        </div>        



                                        <% }%>
                                    </div>

                                </div>
                                <div>

                                </div>
                                <div class="checkout__order__total">
                                    <ul>
                                <%  
                                    if (subtotal > total) {
                                %>
                                <li>Tổng tiền hàng <span><%= numberFormat.format((int) (subtotal)) %> </span></li>
                                <li>Giảm giá <span>-<%= numberFormat.format((int) ((subtotal - total))) %> </span></li>
                                <%  }%>
                                        <li>Tổng thanh toán 
                                            <span><%= numberFormat.format((int) (total)) %> </span>
                                        </li>
                                        <input type="hidden" name="total" value="<%= ((int) (total / 1000)) * 1000%>"/>
                                        <% session.setAttribute("TOTAL", ((int) (total / 1000)) * 1000); %>
                                    </ul>
                                </div>
                                <div class="checkout__order__widget">

                                    <label for="COD">
                                        COD
                                        <input type="radio" id="COD" name="payType" checked="" value="COD">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="VNPay">
                                        VNPay
                                        <input type="radio" id="VNPay" name="payType" value="VNPay">
                                        <span class="checkmark"></span>
                                    </label>
                                    <label for="Momo">
                                        Momo
                                        <input type="radio" id="Momo" name="payType" value="Momo">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <button type="submit" name="action" value="Checkout" class="site-btn">Đặt hàng</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <!-- Checkout Section End -->

        <jsp:include page="footer.jsp" flush="true" />
        <jsp:include page="js-plugins.jsp" flush="true" />


        <script src='https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js'></script>

        <script>//<![CDATA[
            if (address_2 = localStorage.getItem('address_2_saved')) {
                $('select[name="calc_shipping_district"] option').each(function () {
                    if ($(this).text() == address_2) {
                        $(this).attr('selected', '')
                    }
                })
                $('input.billing_address_2').attr('value', address_2)
            }
            if (district = localStorage.getItem('district')) {
                $('select[name="calc_shipping_district"]').html(district)
                $('select[name="calc_shipping_district"]').on('change', function () {
                    var target = $(this).children('option:selected')
                    target.attr('selected', '')
                    $('select[name="calc_shipping_district"] option').not(target).removeAttr('selected')
                    address_2 = target.text()
                    $('input.billing_address_2').attr('value', address_2)
                    district = $('select[name="calc_shipping_district"]').html()
                    localStorage.setItem('district', district)
                    localStorage.setItem('address_2_saved', address_2)
                })
            }
            $('select[name="calc_shipping_provinces"]').each(function () {
                var $this = $(this),
                        stc = ''
                c.forEach(function (i, e) {
                    e += +1
                    stc += '<option value=' + e + '>' + i + '</option>'
                    $this.html('<option value="">Tỉnh / Thành phố</option>' + stc)
                    if (address_1 = localStorage.getItem('address_1_saved')) {
                        $('select[name="calc_shipping_provinces"] option').each(function () {
                            if ($(this).text() == address_1) {
                                $(this).attr('selected', '')
                            }
                        })
                        $('input.billing_address_1').attr('value', address_1)
                    }
                    $this.on('change', function (i) {
                        i = $this.children('option:selected').index() - 1
                        var str = '',
                                r = $this.val()
                        if (r != '') {
                            arr[i].forEach(function (el) {
                                str += '<option value="' + el + '">' + el + '</option>'
                                $('select[name="calc_shipping_district"]').html('<option value="">Quận / Huyện</option>' + str)
                            })
                            var address_1 = $this.children('option:selected').text()
                            var district = $('select[name="calc_shipping_district"]').html()
                            localStorage.setItem('address_1_saved', address_1)
                            localStorage.setItem('district', district)
                            $('select[name="calc_shipping_district"]').on('change', function () {
                                var target = $(this).children('option:selected')
                                target.attr('selected', '')
                                $('select[name="calc_shipping_district"] option').not(target).removeAttr('selected')
                                var address_2 = target.text()
                                $('input.billing_address_2').attr('value', address_2)
                                district = $('select[name="calc_shipping_district"]').html()
                                localStorage.setItem('district', district)
                                localStorage.setItem('address_2_saved', address_2)
                            })
                        } else {
                            $('select[name="calc_shipping_district"]').html('<option value="">Quận / Huyện</option>')
                            district = $('select[name="calc_shipping_district"]').html()
                            localStorage.setItem('district', district)
                            localStorage.removeItem('address_1_saved', address_1)
                        }
                    })
                })
            })
            //]]>

        </script>




    </body>
</html>
