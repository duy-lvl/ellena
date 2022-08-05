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
import store.momo.Environment;
import store.momo.RefundMoMoResponse;
import store.momo.RefundTransaction;
import store.shopping.OrderDAO;
import store.shopping.OrderDTO;
import store.user.UserDTO;

/**
 *
 * @author giama
 */
@WebServlet(name = "CancelOrderController", urlPatterns = {"/CancelOrderController"})
public class CancelOrderController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "ViewOrderHistoryController";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");

            int orderID = Integer.parseInt(request.getParameter("orderID"));

            OrderDAO dao = new OrderDAO();
            OrderDTO order = dao.getOrder(orderID);

            if (order.getUserID().trim().equalsIgnoreCase(user.getUserID())) {
                boolean check;
                String payType = request.getParameter("payType");
                if ("COD".equals(payType)) {
                    check = dao.updateOrderStatus(orderID, 5, "System", "");
                } else {
                    check = dao.updateOrderStatus(orderID, 6, "System", "");
                    if ("Momo".equalsIgnoreCase(payType)) {
                        String requestId = String.valueOf(System.currentTimeMillis());
                        String orderId = String.valueOf(System.currentTimeMillis());
                        Environment environment = Environment.selectEnv("dev");
                        RefundMoMoResponse refundMoMoResponse = RefundTransaction.process(environment, orderId, requestId, Long.toString(order.getTotal()), Long.valueOf(order.getTransactionNumber()), "");
                        if (refundMoMoResponse.getResultCode() == 0) {
                            dao.updateOrderStatus(orderID, 7, "System", "");
                        }
                    }
                }

                if (check) {
                    request.setAttribute("MESSAGE", "Huỷ đơn hàng thành công!");
                    url = SUCCESS;
                }
            }

        } catch (Exception e) {
            log("Error at CancelOrderController: " + e.toString());
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
