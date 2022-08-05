/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;
import store.utils.VNCharacterUtils;

/**
 *
 * @author vankh
 */
@WebServlet(name = "FilterCategoryProductsController", urlPatterns = {"/FilterCategoryProductsController"})
public class FilterCategoryProductsController extends HttpServlet {

    public static final String ERROR = "error.jsp";
    public static final String SUCCESS = "category.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            ProductDAO dao = new ProductDAO();
            String category = VNCharacterUtils.removeAccent(request.getParameter("category"));
            HttpSession session = request.getSession();
            int minAmount = Integer.parseInt(request.getParameter("minAmount"));
            int maxAmount = Integer.parseInt(request.getParameter("maxAmount"));
            String[] colors = request.getParameterValues("color");
            String[] sizes = request.getParameterValues("size");
            List<String> colorList = new ArrayList();
            List<String> sizeList = new ArrayList();
            if(colors!=null){
                colorList.addAll(Arrays.asList(colors));
            }
            if(sizes!=null){
                sizeList.addAll(Arrays.asList(sizes));
            }
            
            List<ProductDTO> listProduct = dao.filterCategoryProducts(category, minAmount, maxAmount, colorList, sizeList);
            
            session.setAttribute("SEARCH_CATALOG", listProduct);
            url = SUCCESS;

        } catch (Exception e) {
            log("Error at SearchCatalogController: " + toString());
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
