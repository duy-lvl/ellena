/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.user.UserDAO;
import store.user.UserDTO;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "RegisterAccountController", urlPatterns = {"/RegisterAccountController"})
public class RegisterAccountController extends HttpServlet {

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "register-success.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String userID = (String) session.getAttribute("USER_ID");
            String fullName = (String) session.getAttribute("FULL_NAME");
            String roleID = "CM";
            String password = (String) session.getAttribute("PASSWORD");
            boolean sex = (boolean) session.getAttribute("SEX");
            String address = (String) session.getAttribute("ADDRESS");
            Date birthday =  (Date) session.getAttribute("BIRTHDAY");
            String phone = (String) session.getAttribute("PHONE");

            UserDAO dao = new UserDAO();
            UserDTO user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, true);
            boolean checkInsert = dao.addUser(user);
            if (checkInsert) {
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Bạn đã đăng ký thành công");
            } else {
                request.setAttribute("MESSAGE", "Đăng ký thất bại");
            }

        } catch (Exception e) {
            log("ERROR at RegisterAccountController : " + e.toString());
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
