/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.user.UserDAO;
import store.user.UserError;
import store.utils.JavaMailUtils;

/**
 *
 * @author giama
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/Register"})
public class RegisterController extends HttpServlet {

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "validate-otp.jsp";
    private static final String EMAIL_PATTERN = "^(?=.{1,64}@)[A-Za-z0-9_-]+(\\.[A-Za-z0-9_-]+)*@ [^-][A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,})$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = "CM";
            String password = request.getParameter("password");
            String confirm = request.getParameter("confirm");
            boolean sex = Boolean.parseBoolean("sex");
            String address = request.getParameter("address");
            Date birthday = (Date) new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthday"));
            String phone = request.getParameter("phone");

            UserError userError = new UserError();
            boolean check = true;
            UserDAO dao = new UserDAO();
            boolean checkDuplicate = dao.checkDuplicate(userID);
            if (checkDuplicate) {
                check = false;
                userError.setUserID("Email đã được dùng!");
            } else if (Pattern.matches(EMAIL_PATTERN, userID)) {
                check = false;
                userError.setUserID("Email không hợp lệ!");
            }
            
            
            if (!password.equals(confirm)) {
                check = false;
                userError.setConfirm("Mật khẩu và xác nhận mật khẩu khác nhau!");
            }else if (password.length() <= 8){
                check = false;
                userError.setPassword("Mật khẩu phải dài hơn 8 kí tự!");
            }

            if (check) {
                JavaMailUtils.sendMail(userID, "validateOTP");
                session.setAttribute("OTP_EXPECTED", JavaMailUtils.getOtpValue());// give expected OTP value to ValidateOtpController
                session.setAttribute("OTP_CHECK", false);// OTP check for register-success.jsp page
                session.setAttribute("INPUT_ATTEMPS", 3);// set number of allow attemps to input OTP
                session.setAttribute("FROM_PAGE", "register");// let ValidateOtpController know where to validate otp from
                
                // pass input session for addUser later
                session.setAttribute("USER_ID", userID);
                session.setAttribute("FULL_NAME", fullName);
                session.setAttribute("PASSWORD", password);
                session.setAttribute("SEX", sex);
                session.setAttribute("ADDRESS", address);
                session.setAttribute("BIRTHDAY", birthday);
                session.setAttribute("PHONE", phone);
                
                url = SUCCESS;

            } else {
                request.setAttribute("USER_ERROR", userError);

            }
        } catch (Exception e) {
            log("Error at RegisterController: " + e.toString());
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
