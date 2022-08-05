/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
import javafx.util.Pair;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.shopping.OrderDetailDTO;
import store.shopping.RatingDAO;
import store.shopping.RatingDTO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "RatingController", urlPatterns = {"/RatingController"})
public class RatingController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "rating-order.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDAO dao = new OrderDAO();
            RatingDAO rDao = new RatingDAO();
            Pair<OrderDTO, List<OrderDetailDTO>> order = dao.getOrderDetails(orderID);
            List<RatingDTO> listRating = rDao.getProductRatingPerOrder(orderID);
            if (order!=null) {
                request.setAttribute("ORDER_DETAILS", order);
                request.setAttribute("PRODUCT_RATING_LIST", listRating);
                url = SUCCESS;
            }
            
        } catch (Exception e) {
            log("ERROR at RatingController : " + e.toString());
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
