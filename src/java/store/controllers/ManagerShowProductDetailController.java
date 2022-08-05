/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;

/**
 *
 * @author vankh
 */
@WebServlet(name = "ManagerShowProductDetailController", urlPatterns = {"/ManagerShowProductDetailController"})
public class ManagerShowProductDetailController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "manager-product-details.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            ProductDAO dao = new ProductDAO();
            String activeColor = request.getParameter("activeColor");
            if ("null".equals(activeColor)) {
                activeColor = null;
            }
            int id = Integer.parseInt(request.getParameter("productID"));
            ProductDTO product = dao.getProductDetail(id);
            if (product != null) {
                request.setAttribute("PRODUCT_DETAIL", product);
                if (activeColor != null)
                    request.setAttribute("ACTIVE_COLOR", activeColor);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at ManagerShowProductDetailController: " + e.toString());
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
