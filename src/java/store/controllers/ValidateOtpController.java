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

/**
 *
 * @author Jason 2.0
 */
@WebServlet(name = "ValidateOtpController", urlPatterns = {"/ValidateOtpController"})
public class ValidateOtpController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String WRONG_OTP = "validate-otp.jsp";
    private static final String OUT_OF_ATTEMPS_RESET_PASSWORD = "forgot-password.jsp";
    private static final String SUCCESS_RESET_PASSWORD = "reset-password.jsp";
    private static final String OUT_OF_ATTEMPS_REGISTER = "register.jsp";
    private static final String SUCCESS_REGISTER = "RegisterAccountController"; // go to "addUser" controller

    private static final String FORGOT_PASSWORD = "forgotPassword";
    private static final String REGISTER = "register";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            HttpSession session = request.getSession();
            int otpExpectedValue = (int) session.getAttribute("OTP_EXPECTED");
            int otpInputValue = Integer.parseInt(request.getParameter("otpInputValue"));
            int inputAttempts = (int) session.getAttribute("INPUT_ATTEMPS");
            String fromPage = (String) session.getAttribute("FROM_PAGE");

            if (inputAttempts > 0) {//check inputAttempts

                switch (fromPage) {
                    case FORGOT_PASSWORD:
                        if (otpInputValue == otpExpectedValue) {//check OTP for reset password
                            url = SUCCESS_RESET_PASSWORD;
                            session.setAttribute("OTP_CHECK", true);
                        } else {
                            url = WRONG_OTP;
                            request.setAttribute("ERROR", "Sai mã OTP! Bạn còn " + inputAttempts + " lượt nhập mã OTP còn lại!");
                            session.setAttribute("INPUT_ATTEMPS", --inputAttempts);
                        }
                        break;
                    case REGISTER:
                        if (otpInputValue == otpExpectedValue) {//check OTP for register new account
                            url = SUCCESS_REGISTER;
                            session.setAttribute("OTP_CHECK", true);
                        } else {
                            url = WRONG_OTP;
                            request.setAttribute("ERROR", "Sai mã OTP! Bạn còn " + inputAttempts + " lượt nhập mã OTP còn lại!");
                            session.setAttribute("INPUT_ATTEMPS", --inputAttempts);
                        }
                        break;
                }

            } else {

                switch (fromPage) {
                    case FORGOT_PASSWORD:
                        url = OUT_OF_ATTEMPS_RESET_PASSWORD;
                        request.setAttribute("ERROR", "Hết lượt nhập mã OTP!");
                        break;
                    case REGISTER:
                        url = OUT_OF_ATTEMPS_REGISTER;
                        request.setAttribute("MESSAGE", "Hết lượt nhập mã OTP!");
                        break;
                }
            }

        } catch (Exception e) {
            log("Error at ValidateOtpController : " + toString());
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
