/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.shopping.CategoryDAO;
import store.shopping.CategoryDTO;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;

/**
 *
 * @author giama
 */
public class ViewHomeController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "home.jsp";
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
            HttpSession session = request.getSession();
            if (session != null) {
                CategoryDAO cateDao = new CategoryDAO();
                ProductDAO  prodDao = new ProductDAO();
                List<CategoryDTO> listCategory = cateDao.getListCategory("", "true");
                List<ProductDTO> trendList = prodDao.getTrendList();
                List<ProductDTO> bestSellerList = prodDao.getBestSellerList();
                List<ProductDTO> saleList = prodDao.getSaleList();
                List<ProductDTO> newList = prodDao.getNewArrivalList();
                session.setAttribute("TREND_LIST", trendList);
                session.setAttribute("BEST_SELLER_LIST", bestSellerList);
                session.setAttribute("SALE_LIST", saleList);
                session.setAttribute("NEW_ARRIVAL_LIST", newList);
                session.setAttribute("LIST_CATEGORY", listCategory);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at ViewHomeController: " + e.toString());
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
