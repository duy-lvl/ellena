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
import javax.servlet.http.HttpSession;
import store.user.UserDAO;
import store.user.UserDTO;
import store.user.UserError;
    
@WebServlet(name = "UpdatePasswordController", urlPatterns = {"/UpdatePasswordController"})
public class UpdatePasswordController extends HttpServlet {

    private static final String ERROR = "my-profile.jsp";
    private static final String SUCCESS = "my-profile.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            String userID = loginUser.getUserID();
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmNewPassword = request.getParameter("confirmNewPassword");
            boolean check = true;
            UserDAO dao = new UserDAO();          
            UserError userError = new UserError();
            
            if(!currentPassword.equals(loginUser.getPassword())){
                check = false;
                userError.setPassword("Mật khẩu bạn nhập không đúng!");
            }
            
            if (!newPassword.equals(confirmNewPassword)) {
                check = false;
                userError.setConfirm("Mật khẩu và xác nhận mật khẩu khác nhau!");
            }
            
             if (newPassword.length() <= 8){
                check = false;
                userError.setConfirm("Mật khẩu phải dài hơn 8 kí tự!");
            }
            
            if (check) {
                boolean checkUpdate = dao.updatePassword(newPassword, userID);
                if (checkUpdate) {
                    url = SUCCESS;
                    if("CM".equalsIgnoreCase(loginUser.getRoleID())) url = "customer-profile.jsp";
                    UserDTO user = dao.getUserByID(userID);
                    session.setAttribute("LOGIN_USER", user);
                    request.setAttribute("MESSAGE", "Cập nhật thành công!");
                }

            } else {
                request.setAttribute("USER_ERROR", userError);
                request.setAttribute("MESSAGE", "Cập nhật thất bại!");

            }
        } catch (Exception e) {
            log("Error at UpdatePasswordController: " + e.toString());
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
