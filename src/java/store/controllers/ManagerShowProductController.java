/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
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
@WebServlet(name = "ManagerShowProductController", urlPatterns = {"/ManagerShowProductController"})
public class ManagerShowProductController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "manager-product.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int page = 1; // page it start counting
        int productPerPage = 8; //number of product per page
        
        try {
            // if there is a page param, take it
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            ProductDAO dao = new ProductDAO();
            List<ProductDTO> listProduct = dao.getAllProduct((page * productPerPage) - productPerPage + 1, productPerPage * page);
            List<ProductDTO> listLowStockProduct = dao.getLowStockProduct();
            
            if (listProduct.size() > 0) {
                
                int noOfProducts = dao.getNumberOfProduct();
                int noOfPages = (int) Math.ceil(noOfProducts * 1.0 / productPerPage);
                
                request.setAttribute("LIST_PRODUCT", listProduct);
                request.setAttribute("LIST_LOW_STOCK_PRODUCT", listLowStockProduct);
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);
                
//                give manager-product.jsp know that we are in ShowProduct
                boolean searchPage = true;
                request.setAttribute("SWITCH_SEARCH", searchPage);
                
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at ManagerShowProductController: " + e.toString());
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
