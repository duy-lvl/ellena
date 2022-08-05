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
import store.shopping.ProductDAO;

@WebServlet(name = "UpdateCartItemQuantityController", urlPatterns = {"/UpdateCartItemQuantityController"})
public class UpdateCartItemQuantityController extends HttpServlet {

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
            List<Integer> quantities = new ArrayList<>();
            for (int i = 0; i < cart.size(); i++) {
                quantities.add(Integer.parseInt(request.getParameter("quantity" + (i + 1))));
            }
            boolean checkQuantity = true;
            boolean checkNegativeQuantity = true;
            for (int i = 0; i < cart.size(); i++) {

                ProductDAO dao = new ProductDAO();

                List<String> colorSize = new ArrayList<>();
                colorSize.add(cart.get(i).getColor());
                colorSize.add(cart.get(i).getSize());

                int maxQuantity = dao.getProductDetail(cart.get(i).getProductID()).getColorSizeQuantity().get(colorSize);

                if (quantities.get(i) <= maxQuantity && quantities.get(i) > 0) {
                    cart.get(i).setQuantity(quantities.get(i));

                } else {
                    checkQuantity = false;
                    if (quantities.get(i) < 0) {
                        checkNegativeQuantity = false;
                    }
                }
            }

            if (!checkQuantity) {
                if (!checkNegativeQuantity) {
                    request.setAttribute("QUANTITY_MESSAGE_FAIL", "Số lượng sản phẩm phải lớn hơn 0!");
                } else {
                    request.setAttribute("QUANTITY_MESSAGE_FAIL", "Số lượng sản phẩm không đủ");
                }
            } else {
                request.setAttribute("QUANTITY_MESSAGE_SUCCESS", "Cập nhật giỏ hàng thành công!");
                session.setAttribute("CART", cart);
            }

            url = SUCCESS;
        } catch (Exception e) {
            log("Error at UpdateCartItemQuantityController: " + e.toString());
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
