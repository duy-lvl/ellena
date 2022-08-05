/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;

/**
 *
 * @author DuyLVL
 */
@WebServlet(name = "UpdateTrackingIdController", urlPatterns = {"/UpdateTrackingIdController"})
public class UpdateTrackingIdController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "SearchOrderController";
    private static final String SUCCESS = "SearchOrderController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {

            boolean checkUpdate = true;
            int count = 0;
            String updateMsg = "";
            OrderDAO dao = new OrderDAO();
            
            String orderTrackingIDs = request.getParameter("orderTrackingIdList").trim();//
            while (orderTrackingIDs.contains("\t\t") || orderTrackingIDs.contains("  ") || orderTrackingIDs.contains("\r\n\t\r\n")) {
                orderTrackingIDs = orderTrackingIDs.replace("\t\t", "\t").replace("  ", " ").replace("\r\n\t\r\n", "\r\n");
            }
            String[] orderId_trackingIds = orderTrackingIDs.split("\r\n");
            for (int i = 0; i < orderId_trackingIds.length; i++) {
                
                String[] orderId_trackingId = orderId_trackingIds[i].split("\t| ");
                if (orderId_trackingId[0].equals("")) {
                    //checkUpdate = false;
                    continue;
                }
                if (orderId_trackingId.length < 2){
                    updateMsg += "\nXảy ra lỗi ở đơn hàng #" + orderId_trackingId[0];
                    checkUpdate = false;
                    continue;
                }
                boolean check = dao.updateOrderTrackingID(Integer.parseInt(orderId_trackingId[0]), orderId_trackingId[1], true);
                if (!check) {
                    updateMsg += "\nXảy ra lỗi ở đơn hàng #" + orderId_trackingId[0];
                }
                checkUpdate = checkUpdate && check;
                count++;

            }
            if (count > 0 && checkUpdate) {
                updateMsg = "Cập nhật thành công";
                url = SUCCESS;
            }
            if (updateMsg.equals("")) {
                updateMsg = "Cập nhật thất bại";
            }
            request.setAttribute("UPDATE_TRACKING_ID_MESSAGE", updateMsg);
        } catch (Exception e) {
            log("Error at UpdateTrackingIdController: " + e.toString());
            request.setAttribute("UPDATE_TRACKING_ID_MESSAGE", "Cập nhật thất bại");
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
