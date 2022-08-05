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
import store.utils.JavaMailUtils;

/**
 *
 * @author Jason 2.0
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/ForgotPasswordController"})
public class ForgotPasswordController extends HttpServlet {

    private static final String ERROR = "forgot-password.jsp";
    private static final String SUCCESS = "validate-otp.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("userID");
            UserDAO dao = new UserDAO();
            HttpSession session = request.getSession();
            boolean checkDuplicate = dao.checkDuplicate(userID);
            if (checkDuplicate) {// true == there's a valid email in database

                try {
                    JavaMailUtils.sendMail(userID, "validateOTP");
                    
                    session.setAttribute("USER_ID", userID);// pass userID to reset-password.jsp page
                    session.setAttribute("OTP_EXPECTED", JavaMailUtils.getOtpValue());// give expected OTP value to ValidateOtpController
                    session.setAttribute("OTP_CHECK", false);// OTP check for reset-password.jsp page
                    session.setAttribute("INPUT_ATTEMPS", 3);// set number of allow attemps to input OTP
                    session.setAttribute("FROM_PAGE", "forgotPassword");// let ValidateOtpController know where to validate otp from
                    
                    url = SUCCESS;
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else {// false == there's no valid email in database
                request.setAttribute("ERROR", "Bạn nhập sai ID hoặc bạn chưa có tài khoản!");
            }

        } catch (Exception e) {
            log("ERROR at ForgotPasswordController : " + toString());
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
