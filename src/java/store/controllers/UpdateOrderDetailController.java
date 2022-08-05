package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.CartProduct;
import store.shopping.OrderDAO;
import store.shopping.ProductDAO;
import store.user.UserDTO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "UpdateOrderDetailController", urlPatterns = {"/UpdateOrderDetailController"})
public class UpdateOrderDetailController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String SUCCESS = "ReturnController";
    private static final String ERROR = "ReturnController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String note = request.getParameterValues("note")[0] + request.getParameterValues("note")[1];
            int oldQuantity = Integer.parseInt(request.getParameter("oldQuantity"));
            //newQuantity: số sản phẩm cũ sau khi đổi
            int newQuantity = oldQuantity - Integer.parseInt(request.getParameter("newQuantity"));
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int orderDetailID = Integer.parseInt(request.getParameter("orderDetailID"));
            String[] sizeColor = request.getParameter("sizeColor").split("/");
            String color = sizeColor[0];
            String size = sizeColor[1];
            //kiểm tra maxQuantity
            ProductDAO pdao = new ProductDAO();
            List<String> colorSize = new ArrayList<>();
            colorSize.add(color);
            colorSize.add(size);

            int maxQuantity = pdao.getProductDetail(productID).getColorSizeQuantity().get(colorSize);
            if (maxQuantity == 0 || maxQuantity < newQuantity) {
                request.setAttribute("UPDATE_MESSAGE", "Cập nhật thất bại!");
                return;
            }
            String oldSize = request.getParameter("oldSize");
            String oldColor = request.getParameter("oldColor");

            note += ": " + oldColor + "/" + oldSize + " --> " + color + "/" + size;
            int price = Integer.parseInt(request.getParameter("price"));
            CartProduct itemNew = new CartProduct(productID, color, size, price, oldQuantity - newQuantity);
            CartProduct itemOld = new CartProduct(productID, oldColor, oldSize, price, oldQuantity);

            OrderDAO dao = new OrderDAO();
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            boolean check = dao.returnProduct(orderID, orderDetailID, oldQuantity, newQuantity, itemOld, itemNew, loginUser.getUserID(), loginUser.getRoleID(), maxQuantity, note);
            if (check) {
                //nhập product cũ vào lại kho
                if (!note.equals("Sản phẩm bị lỗi/hỏng")) {
                    //thêm cũ
                    List<String> colorSizeOld = new ArrayList<>();
                        colorSizeOld.add(oldColor);
                        colorSizeOld.add(oldSize);
                    int maxQuantityOld = pdao.getProductDetail(productID).getColorSizeQuantity().get(colorSizeOld);

                    check = check && pdao.updateProductQuantity(maxQuantityOld + oldQuantity - newQuantity, pdao.getProductColorID(productID, oldColor), oldSize);

                }
                //trừ mới
                List<String> colorSizeNew = new ArrayList<>();
                    colorSizeNew.add(color);
                    colorSizeNew.add(size);
                int maxQuantityNew = pdao.getProductDetail(productID).getColorSizeQuantity().get(colorSizeNew);

                check = check && pdao.updateProductQuantity(maxQuantityNew - (oldQuantity - newQuantity), pdao.getProductColorID(productID, color), size);
            }
            if (check) {
                url = SUCCESS;
                request.setAttribute("UPDATE_MESSAGE", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            log("Error at UpdateOrderDetailController: " + e.toString());
            request.setAttribute("UPDATE_MESSAGE", "Cập nhật thất bại!");
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
