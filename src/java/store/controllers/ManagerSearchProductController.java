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
import store.utils.VNCharacterUtils;

/**
 *
 * @author vankh
 */
@WebServlet(name = "ManagerSearchProductController", urlPatterns = {"/ManagerSearchProductController"})
public class ManagerSearchProductController extends HttpServlet {

    public static final String ERROR = "manager-product.jsp";
    public static final String SUCCESS = "manager-product.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int page = 1; // page it start counting
        int productPerPage = 8; //number of product per page
        int noOfPages = 1;// default number of page, to prevent no product was found

        try {
            // if there is a page param, take it
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            ProductDAO dao = new ProductDAO();
            String search = VNCharacterUtils.removeAccent(request.getParameter("search"));
            String status = "all"; // if status is empty then search status is "all"
            if (!request.getParameter("status").equals("")) {
                status = request.getParameter("status");
            }

            List<ProductDTO> listProduct = dao.getListProduct(search, status, (page * productPerPage) - productPerPage + 1, productPerPage * page);
            List<ProductDTO> listLowStockProduct = dao.getLowStockProduct();

            if (listProduct.size() > 0) {
                
                int noOfProducts = dao.getNumberOfProduct();
                noOfPages = (int) Math.ceil(noOfProducts * 1.0 / productPerPage);
                
                request.setAttribute("LIST_PRODUCT", listProduct);
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);
                
                url = SUCCESS;
            }
            
            request.setAttribute("LIST_LOW_STOCK_PRODUCT", listLowStockProduct);
            request.setAttribute("SEARCH", search);
            request.setAttribute("STATUS", status);
            
            //give manager-product.jsp know that we are in SearchProduct
            boolean searchPage = false;
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("SWITCH_SEARCH", searchPage);
            

        } catch (Exception e) {
            log("Error at ManagerShowProductController: " + toString());
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
