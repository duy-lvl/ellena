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


@WebServlet(name = "ShowAccountController", urlPatterns = {"/ShowAccountController"})
public class ShowAccountController extends HttpServlet {

    private static final String ERROR = "admin.jsp";
    private static final String SUCCESS = "admin.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int page = 1; // page it start counting
        int accountPerPage = 8; //number of account per page
        
        try {
            UserDAO dao = new UserDAO();
            
            // if there is a "page" param, take it
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            
            List<UserDTO> listUser = dao.getAllUsers((page * accountPerPage) - accountPerPage + 1, accountPerPage * page);
            if (!listUser.isEmpty()) {
                
                int noOfAccounts = dao.getNumberOfUser();
                int noOfPages = (int) Math.ceil(noOfAccounts * 1.0 / accountPerPage);
                
                request.setAttribute("LIST_USER", listUser);
                request.setAttribute("noOfPages", noOfPages);
                request.setAttribute("currentPage", page);
                
                //give admin.jsp know that we are in ShowAccountController
                boolean searchPage = true;
                request.setAttribute("SWITCH_SEARCH", searchPage);
                
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at ShowAccountController: " + e.toString());
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
