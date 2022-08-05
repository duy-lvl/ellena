<%-- 
    Document   : view-product-images
    Created on : Jun 6, 2022, 2:17:27 PM
    Author     : giama
--%>

<%@page import="java.util.Set"%>
<%@page import="javafx.util.Pair"%>
<%@page import="java.util.List"%>
<%@page import="store.shopping.ProductDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hình ảnh sản phẩm</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
        <jsp:include page="meta.jsp" flush="true" />

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    </head>
    <body>
        <style>

            .img-wrap {
                display: inline-block; 
                width: 280px;
                position: relative;

            }
            .img-wrap .close {
                position: absolute;
                top: 2px;
                right: 17px;
                z-index: 100;

            }

            .nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
                color: #fff;
                background-color: #fbe2d6;
            }
            .add-image-frame{
                width: 280px;
                height: 360px;
                border-radius: 5px;
                border:  2px dashed #d5d5e1;
                color: #c8c9dd;
                font-size: 0.9rem;
                font-weight: 500;
                position: relative;
                background: #dfe3f259;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
            }
            .add-image-frame input{
                display: none;
            }

            .my {
                position:relative; /* This avoids whatever it's absolute inside of it to go off the container */
                height: 440px; /* let's imagine that your login box height is 250px . This height needs to be added, otherwise .img-responsive will be like "Oh no, I need to be vertically aligned?! but from which value I need to be aligned??" */
            }

            .img-responsive {   
                width: 280px;
                height: 360px;
                position:absolute;
                left:50%;
                top:50%;
                margin-top:-140px; /* This needs to be half of the height */
                margin-left:-140px; /* This needs to be half of the width */
            }
            
            .fa-clock-rotate-left::before {
                content: "\f1da";
            }
        </style>
        <%ProductDTO product = (ProductDTO) request.getAttribute("PRODUCT_DETAIL");
            Set<String> colorList = product.getColorImage().keySet();
            String message = (String) request.getAttribute("MESSAGE");
            String activeColor = (String) request.getAttribute("ACTIVE_COLOR");
            if (message != null) {
        %>

        <!-- Pop-up thông báo -->
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
                        <a href="ViewImagesController?productID=<%=product.getProductID()%>&activeColor=<%=activeColor%>"><button type="button" class="btn btn-default">Đóng</button></a>
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
        <div class='main'>
            <div class="row">
                <div class="col-md-12 mb-4">
                    <div class="form-outline">
                        <a href="ManagerShowProductDetailController?productID=<%=product.getProductID()%>"><button style="border: none; background: none" type="button"><i class="fa fa-arrow-left fa-1x" aria-hidden="true"></i></button></a><label class="form-label" for="colorImage">Hình ảnh sản phẩm</label>
                        <ul class="nav nav-pills mb-4">
                            <% int t = 1;

                                for (String color : colorList) {
                            %>
                            <li class='nav-item <%if ((t == 1 && activeColor == null) || color.equalsIgnoreCase(activeColor)) { %> active <%}%>'><a data-toggle="tab" href="#<%= color%>"><%= color%></a></li>
                                <% t++;
                                    } %>                             
                        </ul>

                        <form action="AddImageController" method="post" id="myForm" enctype="multipart/form-data">
                            <div class="tab-content">
                                <% int j = 1;
                                    

                                    for (String color : colorList) {
                                        int imagesNumber = 0;
                                %>
                                <div id="<%= color%>" class="row tab-pane fade <%if ((j == 1 && activeColor == null)  || color.equalsIgnoreCase(activeColor)) { %> active in <%}%>">
                                    <%  for (int k = 0; k < product.getColorImage().get(color).size(); k++) {%>

                                    <div class='col-12 col-md-4 img-wrap'>

                                        <button class="close" type="button" data-toggle="modal" data-target="#<%=color%>Modal<%=k%>">&times;</button>
                                        <img style="height: 360px; width: 280px;" src="<%= product.getColorImage().get(color).get(k)%>"/>
                                    </div>
                                    <div class="modal fade" id="<%=color%>Modal<%=k%>" role="dialog">
                                        <div class="modal-dialog">
                                                
                                            <!-- Modal content-->
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title">Xoá ảnh</h4>
                                                    <button type="button" class="close" data-dismiss="modal">&times;</button>

                                                </div>
                                                <div class="modal-body">
                                                    <p>Bạn có chắc muốn xoá ảnh này?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type='button' class='btn btn-default' data-dismiss="modal">Huỷ</button>
                                                    <a href="DeleteImageController?productID=<%=product.getProductID()%>&imageName=<%= product.getColorImage().get(color).get(k)%>&activeColor=<%=color%>"><button type="button" class="btn btn-danger">Xoá</button></a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>



                                    <%++imagesNumber;%>

                                    <%}%>
                                    <div class="add-image-frame col-12 col-md-4 ml-4" onClick="uploadImage(event)">
                                        <i class="fa fa-file-image-o fa-5x" aria-hidden="true" style="pointer-events: none"></i>
                                        <input accept="image/*" type="file" name="image" onChange="previewImage(event)"/>
                                    </div>
                                </div>
                                <script>
                                    if (<%=imagesNumber%> >= 3) {
                                        document.getElementById("<%=color%>").querySelector(".add-image-frame").style.display = "none";
                                    }


                                </script>
                                <% j++;
                                    }%>

                                <div class="modal fade" id="uploadModal" role="dialog">
                                    <div class="modal-dialog">
                                        <!-- Modal content-->
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h4 class="modal-title">Thêm ảnh</h4>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>
                                            <div class="my modal-body">
                                                <div id="preview"></div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type='button' class='btn btn-default' data-dismiss="modal" onClick="removeImageValue()">Huỷ</button>
                                                <button name="action" value="AddImage" type="submit" form="myForm" class="btn btn-danger">Thêm</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input id="color" type="hidden" name="color" value=""/>
                                <input type="hidden" name="productID" value="<%= product.getProductID()%>"/>
                                <input type="hidden" name="productName" value="<%=product.getProductName()%>"/>
                            </div>
                        </form>
                    </div>
                </div> 
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $("#myModal").modal();
            });
            function uploadImage(e) {
                e.target.querySelector("input").click();
            }

            function previewImage(e) {
                var preview = document.getElementById("preview");
                var color = e.target.parentElement.parentElement.id;
                console.log(e.target.parentElement.parentElement.id);
                document.getElementById("color").value = color;
                console.log(document.getElementById("color").value);
                if (e.target.files) {
                    [].forEach.call(e.target.files, readAndPreview);
                }

                $("#uploadModal").modal();

                function readAndPreview(file) {

                    // Make sure `file.name` matches our extensions criteria
                    if (!/\.(jpe?g|png|gif)$/i.test(file.name)) {
                        return alert(file.name + " is not an image");
                    } // else...


                    var reader = new FileReader();

                    reader.addEventListener("load", function () {

                        var image = new Image(280, 360);
                        image.title = file.name;
                        image.src = this.result;
                        image.setAttribute("class", "img-responsive");

                        preview.appendChild(image);

                    });
                    
                    reader.readAsDataURL(file);

                }
            }
            
            function removeImageValue() {
                document.querySelector("input[name='image']").value = "";
            }
        </script>
    </body>
</html>
