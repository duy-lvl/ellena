<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="javax.servlet.jsp.tagext.IterationTag"%>
<%@page import="store.shopping.CategoryDTO"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="store.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết sản phẩm</title>
        
        <jsp:include page="meta.jsp" flush="true" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <style>
            
            .dropdown-menu{
                right:0;
                left:auto;
            }
            #product-details{
                margin-bottom: 7rem;
            }
            .nav:after {
                content: none;
            }
            .nav:before {
                content: none;
            }
            .nav-tabs{
                border-bottom: 1px solid #dee2e6;
                margin-bottom:0;
                justify-content: flex-start;
            }
            
            #addColorButton{
                position: absolute;
                top: 1.5rem;
                right:0;
                z-index: 1;
            }
            .fa-clock-rotate-left::before {
                content: "\f1da";
            }
        </style>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String message = (String) request.getAttribute("MESSAGE");
            ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");
            String activeColor = (String) request.getAttribute("ACTIVE_COLOR");
            if (message != null) {
        %>
        <div class="modal fade" id="myModal" role="dialog">
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
                        <a href="ManagerShowProductDetailController?productID=<%=product.getProductID()%>&activeColor=<%=activeColor%>"><button type="button" class="btn btn-default">Đóng</button></a>
                    </div>
                </div>
            </div>
        </div> <%}%>

        <div class="sidenav">
            <a href="ManagerStatisticController"><i class="fa fa-bar-chart fa-lg"></i>Số liệu thống kê</a>
            <a href="ManagerShowProductController" style="color: #873e23; font-weight: bold;"><i class="fa fa-archive fa-lg"></i>Quản lí sản phẩm</a>
            <a href="ShowOrderController"><i class="fa fa-cart-plus fa-lg"></i>Quản lí đơn hàng</a>
            <a href="customer-return-history.jsp"><i class="fa fa-clock-rotate-left fa-lg"></i>Lịch sử đổi/trả</a>
        </div>

        <div class="main">
            <!--Welcome and Logout-->
            <div class="flex-item text-right" id="manager__header">
                <form class="m-0" action="MainController" method="POST">  
                    <h5 class="dropdown">
                        <b>Xin chào, </b>
                            <a  data-toggle="dropdown" role="button"><b class="text-color-dark"><%= loginUser.getFullName()%></b></a>
                        <div  class="dropdown-menu nav-tabs" role="tablist">
                        <button class="dropdown-item btn" role="tab" type="button"><a class="text-dark" href="my-profile.jsp">Thông tin tài khoản</a></button>
                        <input class=" dropdown-item btn" type="submit" name="action" value="Logout"/>
                        </div>
                    </h5>
                </form>
            </div>
            <!-- Chi tiet san phan  -->
            <div id="product-details" class="d-flex flex-column align-items-center">
            
            <div class="col-12 col-md-7">
                 
                <%

                    List<CategoryDTO> listCategory = (List<CategoryDTO>) session.getAttribute("LIST_CATEGORY");

                %>
                
                <form class="mt-0 mb-4" action="ManagerUpdateProductController" method="POST" >
                    <label class="h2 h2 form-label" for="productDetail"><b>Chi tiết sản phẩm</b></label> <br/>
                    <div class="row">
                        <div class="col-md-6 mb-4">

                            <div class="form-outline">
                                <label class="form-label" for="productID">ID sản phẩm</label>
                                <input class="form-control form-control-lg" type="number" name="productID" id="productID" readonly="" value="<%= product.getProductID()%>"/>

                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="status">Trạng thái</label>
                                <select class="form-control form-control-lg" name="status" id="status">
                                    <option value="true" <%if (product.isStatus() == true) {%>selected <%}%>>Active</option>
                                    <option value="false" <%if (product.isStatus() == false) {%>selected <%}%>>Inactive</option>
                                </select>
                            </div>

                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-12 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="productName">Tên sản phẩm</label>
                                <input type="hidden" name="oldProductName" value="<%= product.getProductName()%>"/>
                                <input class="form-control form-control-lg" type="text" name="productName" id="productName" value="<%= product.getProductName()%>"/>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="categoryID">Loại sản phẩm</label>
                                <select class="form-control form-control-lg" name="categoryID" id="categoryID">
                                    <%
                                        for (CategoryDTO category : listCategory) {
                                    %>
                                    <option value="<%= category.getCategoryID()%>" <%if (product.getCategoryName().equalsIgnoreCase(category.getCategoryName())) {%>selected <%}%>><%= category.getCategoryName()%></option>
                                    <%
                                        }
                                    %>
                                </select>

                            </div>
                        </div>
                        <div class="col-md-6 mb-4">

                            <div class="form-outline">
                                <label class="form-label" for="lowStockLimit">Giới hạn số lượng thấp</label>
                                <input class="form-control form-control-lg" min="0" max="500" type="number" name="lowStockLimit" id="lowStockLimit" value="<%= product.getLowStockLimit()%>"/>

                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="price">Giá tiền</label>
                                <input class="form-control form-control-lg" type="number" name="price" value="<%= product.getPrice()%>"/>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="form-outline">
                                <label class="form-label" for="discount">Giảm giá</label>
                                <input class="form-control form-control-lg" type="number" min="0" max="<%= product.getPrice()%>" step="1000" name="discount" id="price" value="<%= product.getDiscount()%>"/>
                            </div>
                        </div>


                    </div>


                    <div class="row">
                        <div class="col-12 mb-4">
                            <div class="form-outline" >
                                <label class="form-label" for="description">Mô tả sản phẩm</label>
                                <textarea class="form-control form-control-lg" name="description" id="productID" style="resize: vertical; overflow: auto; width: 100%; height: 100px;"><%= product.getDescription()%></textarea>
                            </div> 
                        </div>
                    </div>
                            <button class="btn btn-default bg-color-primary " type="submit" name="action" value="ManagerUpdateProduct">Cập nhật</button>
                </form>
            </div>
        
                
             
            </div>
            
            <div class="d-flex flex-column align-items-center">
                <div class="col-md-7 mb-4">
                    <div class="form-outline" >

                        <label class="h2 h2 form-label" for="colorSizeQuantity">Quản lý số lượng</label> <br/>
                       
                            <button id="addColorButton" type="button" class="btn btn-default my-3"  data-toggle="modal" data-target="#editColorModal">Thêm/xóa màu</button>
                       
                        <ul class="mt-2 mb-5 nav nav-tabs">

                            <% Iterator<String> it = product.getColorImage().keySet().iterator();
                                int i = 1;
                                List<String> colorList = new ArrayList<>();
                                while (it.hasNext()) {
                                    String color = it.next();
                                    colorList.add(color);  %>      

                                    <li <%if ((i == 1 && activeColor == null)  || color.equalsIgnoreCase(activeColor)) { %> class="active" <%}%>><a class="p-2 px-4" data-toggle="tab" href="#<%= color%>-size"><%= color%></a></li>

                            <% i++;
                                }%>                             
                        </ul>


                        <div class="tab-content">
                            <%Iterator<List<String>> it1 = product.getColorSizeQuantity().keySet().iterator();
                                int g = 1;
                                List<String> key = new ArrayList<>();
                                while (it1.hasNext()) {
                                    for (String n : it1.next()) {
                                        key.add(n);
                                    }
                                }
                                for (String color : colorList) {
                            %>
                            <div id="<%=color%>-size" class="tab-pane <%if ((g == 1 && activeColor == null) || color.equalsIgnoreCase(activeColor)) { %> in active <%}%>">
                                <form action="UpdateVariantsController" id="update<%=color%>VariantsForm">
                                    <input type="hidden" name="color" value="<%=color%>"/>
                                    <input type="hidden" name="productID" value="<%=product.getProductID()%>"/>
                                    <table class="table table-info">
                                        <tr>
                                            <th>Size</th>
                                            <th>Số lượng</th>
                                        </tr>
                                        <% for (int z = 0; z < key.size(); z += 2) {
                                                if (color.equalsIgnoreCase(key.get(z))) {%>

                                        <tr>

                                            <td><input class="form-control form-control-lg" type="text" name="size" value="<%= key.get(z + 1)%>" readonly maxlength="50" style="width: 100px"/></td>
                                                <% List<String> colorSize = new ArrayList<>();
                                                    colorSize.add(key.get(z));
                                                    colorSize.add(key.get(z + 1));
                                                %>
                                            <td ><input class="form-control form-control-lg" type="number" name="quantity" value="<%= product.getColorSizeQuantity().get(colorSize)%>"></td>

                                            <td class="pl-2">                                        
                                                <button  type="button" style="border: none; background: none;" data-toggle="modal" data-target="#delete<%=color%><%=key.get(z + 1)%>Modal"><i class="fa fa-remove fa-lg"></i></button>
                                            </td>

                                        <div class="modal fade" id="delete<%=color%><%=key.get(z + 1)%>Modal" role="dialog">
                                            <div class="modal-dialog">
                                                <!-- Modal content-->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title">Xoá size</h4>
                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Bạn có chắc muốn xoá size này?</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type='button' class='btn btn-default' data-dismiss="modal">Huỷ</button>
                                                        <a href="DeleteSizeController?productID=<%=product.getProductID()%>&color=<%=color%>&size=<%=key.get(z + 1)%>"><button type="button" class="btn btn-danger">Xoá</button></a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </tr>

                                        <% }
                                            }%>
                                    </table>
                                </form>
                                <button class="my-3" type="button" data-toggle="modal" data-target="#add<%=color%>VariantsModal" style="border: none; background: none"><i class="fa fa-plus-circle fa-lg"></i></button>
                                <div class="row ml-2">
                                    <button type="submit" class="btn btn-default bg-color-primary" name="action" form="update<%=color%>VariantsForm" value="UpdateVariants">Cập nhật</button>
                                </div>
                                <div class="modal fade" id="add<%=color%>VariantsModal" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Thêm size</h4>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="AddVariantsController" id="add<%=color%>VariantsForm">
                                                    <input type="hidden" name="productID" value="<%=product.getProductID()%>"/>
                                                    <input type="hidden" name="color" value="<%=color%>"/>
                                                    <div class="row">
                                                        <div class="col-md-3 mb-4 pb-2 ml-5">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="size">Size</label>
                                                                <input class="form-control form-control-sm" name="size" required="" type="text" placeholder="VD: XL"/>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 mb-4 pb-2 ml-5">
                                                            <div class="form-outline">
                                                                <label class="form-label" for="quantity">Số lượng</label>
                                                                <input class="form-control form-control-lg" name="quantity" required="" type="number" step="1" value="0"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                                <button class="mb-4 ml-5" type="button" onClick="addVariants(event)" style="border: none; background: none"><i style="pointer-events: none" class="fa fa-plus-circle fa-lg"></i></button>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" onClick="checkSize('<%=color%>', event)" name="action" value="AddVariants" class="btn btn-default" form="add<%=color%>VariantsForm">Xác nhận</button>
                                                <button type='button' class='btn btn-default' data-dismiss="modal">Huỷ</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% g++;
                                }%>
                        </div>          
                    </div>
                </div> 
            </div>  
            <div class="d-flex flex-column align-items-center">
                <div class="col-md-7 mb-4">
                    <div class="form-outline" >
                        <label class=" h2 h2 form-label" for="colorImage">Hình ảnh sản phẩm</label><br/>
                        <a class="btn btn-default" href="ViewImagesController?productID=<%=product.getProductID()%>"<button id="add" type="button" onClick="checkImages()">Thêm/xóa ảnh</button></a>
                    </div>
                    <!-- Pop-up chỉnh sửa màu -->
                    <div class="modal fade" id="editColorModal" role="dialog">
                        <div class="modal-dialog">

                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Chỉnh sửa màu</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>

                                </div>
                                <div class="modal-body">
                                    <form action="AddColorsController" id="editColorForm">
                                        <input type="hidden" name="productID" value="<%=product.getProductID()%>"/>
                                        <input type="hidden" name="action" value="AddColors"/>
                                        <% for (String color : colorList) {%>

                                        <div class="row">
                                            <div class="col-md-4 mb-4 pb-2 ml-5">
                                                <div class="form-outline">
                                                    <input class="form-control form-control-lg" readonly required="" type="text" value="<%=color%>"/>
                                                </div>
                                            </div>
                                            <div class="col-md-3 pl-0">
                                                <button type="button" style="border: none; background: none;" data-toggle="modal" data-target="#delete<%=color%>Modal"><i class="fa fa-remove fa-lg"></i></button>
                                            </div>
                                            <div class="inner modal fade" id="delete<%=color%>Modal" role="dialog">
                                                <div class="modal-dialog modal-sm   ">
                                                    <!-- Modal content-->
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h4 class="modal-title">Xoá màu</h4>
                                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <p>Bạn có chắc muốn xoá màu này?</p>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type='button' class='btn btn-default' data-dismiss-modal="innerModal">Huỷ</button>
                                                            <a href="DeleteColorController?productID=<%=product.getProductID()%>&color=<%=color%>"><button type="button" class="btn btn-danger">Xoá</button></a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%}%>
                                    </form>
                                    <button class="mb-4 ml-5" onClick="displayBtn()" type="button" id="addColor" style="border: none; background: none"><i style="pointer-events: none" class="fa fa-plus-circle fa-lg"></i></button>

                                </div>
                                <div class="modal-footer">
                                    <button type="submit" onClick="checkColorForm(event)" style="display: none" form="editColorForm"  class="btn btn-default">Xác nhận</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal" >Đóng</button>
                                </div>
                            </div>

                        </div>
                    </div> 

                </div>
            </div> 
        </div>





        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            }
            );
            $("button[data-dismiss-modal=innerModal]").click(function () {
                $('.inner').modal('hide');
            }
            );
            $("#addColor").click(function () {
                $("#editColorForm").append('<div class="row">\n\
                                                                        <div class="col-md-4 mb-4 pb-2 ml-5">\n\
                                                                        <div class="form-outline">\n\
                                                                        <input class="form-control form-control-lg" name="color" required="" type="text" placeholder="VD: Trắng"/>\n\
                                                                        </div>\n\
                                                                        </div>\n\
                                                                        <div class="col-md-3 pl-0">\n\
                                                                        <button type="button" onClick="removeColor(event)" style="border: none; background: none;" data-toggle="modal"><i style="pointer-events: none" class="fa fa-remove fa-lg"></i></button>\n\
                                                                        </div></div>');
            });


            function addVariants(e) {
                e.target.previousElementSibling.insertAdjacentHTML("beforeend", '<div class="row"><div class="col-md-3 mb-4 pb-2 ml-5"><div class="form-outline"><label class="form-label" for="size">Size</label><input class="form-control form-control-sm" name="size" required="" type="text" placeholder="VD: XL"/></div></div><div class="col-md-4 mb-4 pb-2 ml-5"><div class="form-outline"><label class="form-label" for="quantity">Số lượng</label><input class="form-control form-control-lg" name="quantity" required="" type="number" step="1" value="0"/></div></div><div class="col-md-3 pl-0">\n\
                                                                        <button class="mt-5" type="button" onClick="removeVariant(event)" style="border: none; background: none;" data-toggle="modal"><i style="pointer-events: none" class="fa fa-remove fa-lg"></i></button>\n\
                                                                        </div></div>');
            }

            function removeColor(e) {
                var color = e.target.parentElement.parentElement;
                color.remove();
            }

            function removeVariant(e) {
                var variant = e.target.parentElement.parentElement;
                variant.remove();
            }
            function displayBtn() {
                document.querySelector("button[form='editColorForm']").style.display = "inline-block";
            }

            function checkColorForm(e) {
                var existedColors = document.getElementById("editColorForm").querySelectorAll("input[readonly]");
                var stored = [];
                var form = document.getElementById("editColorForm");

                if (existedColors.list === null) {
                    stored.push(existedColors.value.toLowerCase());
                } else {
                    for (var i = 0; i < existedColors.length; i++) {
                        stored.push(existedColors[i].value.toLowerCase());
                    }
                }

                if (form.color.list === null) {
                    if (stored.includes(form.color.value.toLowerCase())) {
                        e.preventDefault();
                        return alert("Không thể nhập màu trùng nhau!");
                    }
                } else {
                    for (var inputColor of form.color) {
                        if (stored.includes(inputColor.value.toLowerCase())) {
                            e.preventDefault();
                            return alert("Không thể nhập màu trùng nhau!");
                        }
                        stored.push(inputColor.value.toLowerCase());
                    }
                }
            }

            function checkSize(color, e) {
                var sizes = document.getElementById("add" + color + "VariantsForm").size;
                console.log(sizes);
                var existedSizes = document.getElementById("update" + color + "VariantsForm").size;
                var stored = [];

                if (existedSizes.list === null) {
                    stored.push(existedSizes.value.toLowerCase());
                } else {
                    for (var i = 0; i < existedSizes.length; i++) {
                        stored.push(existedSizes[i].value.toLowerCase());
                    }
                }

                if (sizes.list === null) {
                    if (stored.includes(sizes.value.toLowerCase())) {
                        e.preventDefault();
                        return alert("Không thể nhập màu trùng nhau!");
                    }
                } else {
                    for (var inputSize of sizes) {
                        if (stored.includes(inputSize.value.toLowerCase())) {
                            e.preventDefault();
                            return alert("Không thể nhập màu trùng nhau!");
                        }
                        stored.push(inputSize.value.toLowerCase());
                    }
                }
            }
        </script>  

    </body>
</html>
