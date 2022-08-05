package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.login_with_google.GooglePojo;
import store.login_with_google.GoogleUtils;
import store.user.UserDAO;
import store.user.UserDTO;

@WebServlet(name = "LoginGoogleController", urlPatterns = {"/LoginGoogleController"})
public class LoginGoogleController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //private static final long serialVersionUID = 1L;
    private static final String CONTINUE_SHOPPING_PAGE = "ProductRouteController?productID=";
    private static final String CUSTOMER_PAGE = "ViewHomeController";
    private static final String ERROR = "login.jsp";

    public LoginGoogleController() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String code = request.getParameter("code");
            if (!(code == null || code.isEmpty())) {

                String accessToken = GoogleUtils.getToken(code);
                GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
                //String id = googlePojo.getId();
                String email = googlePojo.getEmail();

                UserDTO loginUser = new UserDTO();
                loginUser.setUserID(email);
                loginUser.setFullName(email);
                loginUser.setRoleID("CM");
                loginUser.setStatus(true);
                UserDAO dao = new UserDAO();
                dao.addUser(loginUser);
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_USER", loginUser);

                int productID = 0;
                if (session.getAttribute("productID") != null) {
                    productID = (int) session.getAttribute("productID");
                }

                if (productID != 0) {
                    url = CONTINUE_SHOPPING_PAGE + productID;
                } else {
                    url = CUSTOMER_PAGE;
                }
            }
        } catch (Exception e) {
            log("Error at LoginGoogleController: " + e.toString());
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
