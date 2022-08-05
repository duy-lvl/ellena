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
import store.user.UserDAO;
import store.user.UserDTO;

/**
 *
 * @author vankh
 */
@WebServlet(name = "SearchAccountController", urlPatterns = {"/SearchAccountController"})
public class SearchAccountController extends HttpServlet {

    private static final String ERROR = "admin.jsp";
    private static final String SUCCESS = "admin.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int page = 1; // page it start counting
        int accountPerPage = 8; //number of account per page
        int noOfPages = 1;// default number of page, to prevent no product was found
        
        try {
            String search = request.getParameter("search");
            String roleID = request.getParameter("role");
            String status = request.getParameter("Status");
            
            // if there is a "page" param, take it
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            UserDAO dao = new UserDAO();
            List<UserDTO> listUser = dao.getListUsers(search, roleID, status, (page * accountPerPage) - accountPerPage + 1, accountPerPage * page);

            if (!listUser.isEmpty()) {
                
                int noOfAccounts = dao.getNumberOfUser();
                noOfPages = (int) Math.ceil(noOfAccounts * 1.0 / accountPerPage);
                
                request.setAttribute("LIST_USER", listUser);
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);

                url = SUCCESS;
            }
            //give admin.jsp know that we are in SearchAccountController
            boolean searchPage = false;
            request.setAttribute("noOfPages", noOfPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("SWITCH_SEARCH", searchPage);
            
            
            
        } catch (Exception e) {
            log("Error at SearchAccountController: " + e.toString());
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
