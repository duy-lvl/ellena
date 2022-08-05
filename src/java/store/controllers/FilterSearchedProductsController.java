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

/**
 *
 * @author vankh
 */
@WebServlet(name = "FilterSearchedProductsController", urlPatterns = {"/FilterSearchedProductsController"})
public class FilterSearchedProductsController extends HttpServlet {

    public static final String ERROR = "error.jsp";
    public static final String SUCCESS = "search-catalog.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int page = 1; // page it start counting
        int productPerPage = 6; //number of product per page
        int noOfPages = 1;// default number of page, to prevent no product was found

        try {
            
            // if there is a page param, take it
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            ProductDAO dao = new ProductDAO();
            String search = request.getParameter("search");
            HttpSession session = request.getSession();
            int minAmount = Integer.parseInt(request.getParameter("minAmount"));
            int maxAmount = Integer.parseInt(request.getParameter("maxAmount"));
            String[] colors = request.getParameterValues("color");
            // if there is a listColors param, take it
            if (request.getParameter("listColors") != null && !request.getParameter("listColors").equals("")) {
                colors = request.getParameter("listColors").split("-");
            }

            String[] sizes = request.getParameterValues("size");
            // if there is a listSizes param, take it
            if (request.getParameter("listSizes") != null && !request.getParameter("listSizes").equals("")) {
                sizes = request.getParameter("listSizes").split("-");
            }
            
            List<String> colorList = new ArrayList();
            List<String> sizeList = new ArrayList();
            if(colors!=null){
                colorList.addAll(Arrays.asList(colors));
            }
            if(sizes!=null){
                sizeList.addAll(Arrays.asList(sizes));
            }
            
            List<ProductDTO> listProduct = dao.filterSearchedProducts(search, minAmount, maxAmount, colorList, sizeList, (page * productPerPage) - productPerPage , productPerPage * page - 1);   // +0, -1
            
            session.setAttribute("SEARCH_CATALOG", listProduct);
            url = SUCCESS;
            
            int noOfProducts = dao.getNumberOfProduct();
            noOfPages = (int) Math.ceil(noOfProducts * 1.0 / productPerPage);

            request.setAttribute("LIST_COLORS", colorList);
            request.setAttribute("LIST_SIZES", sizeList);
            request.setAttribute("MIN_AMOUNT", minAmount);
            request.setAttribute("MAX_AMOUNT", maxAmount);

            //give manager-product.jsp know that we are in SearchProduct
            boolean searchPage = false;
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("SWITCH_SEARCH", searchPage);

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
