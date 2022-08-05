package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.shopping.OrderDetailDTO;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;
import store.shopping.ReturnDTO;

@WebServlet(name = "ReturnController", urlPatterns = {"/ReturnController"})
public class ReturnController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String SUCCESS = "return.jsp";
    private static final String ERROR = "manager-order.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDAO odao = new OrderDAO();
            OrderDTO order = odao.getOrder(orderID);
            request.setAttribute("ORDER", order);
            ProductDAO pdao = new ProductDAO();
            List<ProductDTO> productList = new ArrayList<>();
            List<OrderDetailDTO> orderDetailList = odao.getOrderDetail(orderID);
            for (int i = 0; i < orderDetailList.size(); i++) {
                productList.add(pdao.getProductDetail(orderDetailList.get(i).getProductID()));
            }
            List<ReturnDTO> returnList = odao.getOrderReturnHistory(orderID);
            request.setAttribute("RETURN_LIST", returnList);
            url = SUCCESS;
            request.setAttribute("PRODUCT_LIST", productList);
        } catch (Exception e) {
            log("Error at ReturnController: " + e.toString());
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
