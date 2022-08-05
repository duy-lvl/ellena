/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.ProductDAO;

/**
 *
 * @author giama
 */
@WebServlet(name = "AddVariantsController", urlPatterns = {"/AddVariantsController"})
public class AddVariantsController extends HttpServlet {
    private static final String ERROR = "ManagerShowProductDetailController";
    private static final String SUCCESS = "ManagerShowProductDetailController";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int productID = Integer.parseInt(request.getParameter("productID"));
            String color = request.getParameter("color");
            ProductDAO dao = new ProductDAO();
            int productColorID = dao.getProductColorID(productID, color);
            String[] sizes = request.getParameterValues("size");
            String[] stringQuantities = request.getParameterValues("quantity");
            int[] quantites = new int[stringQuantities.length];
            for (int i = 0; i < stringQuantities.length; i++) {
                quantites[i] = Integer.parseInt(stringQuantities[i]);
            }
            boolean check = dao.addVariants(productColorID, sizes, quantites);
            request.setAttribute("ACTIVE_COLOR", color);
            if (check) {
                request.setAttribute("MESSAGE", "Cập nhật thành công.");
                url = SUCCESS;
            } else {
                request.setAttribute("MESSAGE", "Cập nhật thất bại.");
            }
        } catch (NumberFormatException | SQLException e) {
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
