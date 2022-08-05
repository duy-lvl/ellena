package store.controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.user.UserDAO;
import store.user.UserDTO;
import store.user.UserError;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
@WebServlet(name = "AddAccountController", urlPatterns = {"/AddAccountController"})
public class AddAccountController extends HttpServlet {

    private static final String ERROR = "add-account.jsp";
    private static final String SUCCESS = "ShowAccountController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");
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
                userError.setUserID("Email đã được sử dụng!");
            }
            if (!password.equals(confirm)) {
                check = false;
                userError.setConfirm("Mật khẩu và xác nhận mật khẩu khác nhau!");
            }

            if (check) {
                UserDTO user = new UserDTO(userID, fullName, password, sex, roleID, address, birthday, phone, true);
                boolean checkInsert = dao.addUser(user);
                if (checkInsert) {
                    url = SUCCESS;
                }

            } else {
                request.setAttribute("USER_ERROR", userError);

            }
        } catch (Exception e) {
            log("Error at AddAccountController: " + e.toString());
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
