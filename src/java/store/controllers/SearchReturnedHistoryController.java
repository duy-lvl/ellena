package store.controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.shopping.ReturnDTO;
import store.user.UserDAO;
import store.user.UserDTO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "SearchReturnedHistoryController", urlPatterns = {"/SearchReturnedHistoryController"})
public class SearchReturnedHistoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String SUCCESS = "customer-return-history.jsp";
    private static final String ERROR = "customer-return-history.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String search = request.getParameter("search");
            List<UserDTO> userList = new UserDAO().getReturnedCustomer(search);
            Collections.reverse(userList);
            request.setAttribute("SEARCH", search);
            request.setAttribute("USER_LIST", userList);
            Map<UserDTO, List<OrderDTO>> userMap = new HashMap<>();
            Map<OrderDTO, List<ReturnDTO>> returnMap = new HashMap<>();
            OrderDAO dao = new OrderDAO();
            for (UserDTO user : userList) {
                userMap.put(user, dao.getReturnedOrder(user.getUserID()));
                for (OrderDTO order : userMap.get(user)) {
                    List<ReturnDTO> returnList = dao.getOrderReturnHistory(order.getOrderID());
                    returnMap.put(order, returnList);
                    //request.setAttribute("RETURN_LIST", returnList);
                }
            }
            
            request.setAttribute("RETURNED_HISTORY", returnMap);
            request.setAttribute("RETURNED_ORDERS", userMap);
            if (!userList.isEmpty()) {
                url = SUCCESS;
            } else {
                if (!search.isEmpty()) {
                    request.setAttribute("MESSAGE", "Không có kết quả tìm kiếm");
                }
            }

        } catch (Exception e) {
            log("Error at SearchReturnedCustomerController: " + e.toString());
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
