package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.Cart;
import store.shopping.CartDAO;
import store.shopping.CartProduct;
import store.shopping.CartProductDAO;
import store.user.UserDTO;

@WebServlet(name = "DeleteCartItemController", urlPatterns = {"/DeleteCartItemController"})
public class DeleteCartItemController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "shop-cart.jsp";
    private static final String SUCCESS = "shop-cart.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            List<CartProduct> cart = (List<CartProduct>) session.getAttribute("CART");
            int productID = Integer.parseInt(request.getParameter("productID"));
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            CartDAO cdao = new CartDAO();
            CartProductDAO cpdao = new CartProductDAO();
            Cart c = cdao.getCartByUserID(user.getUserID());
            cpdao.deleteACartItem(c.getId(), productID, size, color);
            
            boolean check = cart.remove(new CartProduct(productID, color, size));
            if (!check) {
                request.setAttribute("REMOVE_CART_ITEM_MESSAGE", "Xóa sản phầm thất bại");
            } else {
                url = SUCCESS;
                session.setAttribute("CART", cart);
            }
        } catch (Exception e) {
            log("Error at DeteleCartItemController: " + e.toString());
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
