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
import store.shopping.OrderDAO;
import store.shopping.ProductDAO;
import store.user.UserDTO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "RefundOrderController", urlPatterns = {"/RefundOrderController"})
public class RefundOrderController extends HttpServlet {

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
            //String note = request.getParameter("note");
            String note = request.getParameterValues("note")[0] + request.getParameterValues("note")[1];
            int oldQuantity = Integer.parseInt(request.getParameter("oldQuantity"));
            //newQuantity: số sản phẩm trả lại
            int newQuantity = oldQuantity - Integer.parseInt(request.getParameter("newQuantity"));
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int productID = Integer.parseInt(request.getParameter("productID"));
            int orderDetailID = Integer.parseInt(request.getParameter("orderDetailID"));
            int price = Integer.parseInt(request.getParameter("price"));
            
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            ProductDAO pdao = new ProductDAO();
            OrderDAO odao = new OrderDAO();
            List<String> colorSize = new ArrayList<>();
                colorSize.add(color);
                colorSize.add(size);

            int maxQuantity = pdao.getProductDetail(productID).getColorSizeQuantity().get(colorSize);
            //update order
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            boolean check = odao.refundProduct(orderID, orderDetailID, oldQuantity, newQuantity, loginUser.getUserID(), loginUser.getRoleID(), maxQuantity, price, note);
            //nhập product cũ vào lại kho
            if (!note.equals("Sản phẩm bị lỗi/hỏng")) {
                check = check && pdao.updateProductQuantity(maxQuantity + oldQuantity - newQuantity, pdao.getProductColorID(productID, color), size);
            }
            if (check) {
                url = SUCCESS;
                request.setAttribute("UPDATE_MESSAGE", "Cập nhật thành công!");
            }
        } catch (Exception e) {
            log("Error at RefundOrderController: " + e.toString());
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
