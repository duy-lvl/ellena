/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.user.UserDAO;
import store.user.UserDTO;

/**
 *
 * @author giama
 */
@WebServlet(name = "UpdateAccountController", urlPatterns = {"/UpdateAccountController"})
public class UpdateAccountController extends HttpServlet {

    private static final String ERROR = "SearchAccountController";
    private static final String SUCCESS = "SearchAccountController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String password = "*********";
            String roleID = request.getParameter("roleID");
            String from = request.getParameter("from");
            boolean sex = Boolean.parseBoolean(request.getParameter("sex"));
            String address = request.getParameter("address");
            Date birthday = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthday"));
            String phone = request.getParameter("phone");
            boolean check = true;
            UserDAO dao = new UserDAO();
            if (check) {
                UserDTO user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, true);
                boolean checkUpdate = dao.updateAccount(user);
                if (checkUpdate) {
                    url = SUCCESS;
                    if (from != null) {
                        url = "ShowManagerController";
                    }
                    request.setAttribute("MESSAGE", "Cập nhật thành công!");
                }
            } else {
                request.setAttribute("MESSAGE", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            log("Error at UpdateAccountController: " + e.toString());
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
