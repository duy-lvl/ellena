package store.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.OrderDAO;
import store.shopping.OrderDetailDTO;
import store.shopping.ProductDAO;

@WebServlet(name = "UpdateOrderController", urlPatterns = {"/UpdateOrderController"})
public class UpdateOrderController extends HttpServlet {

    private static final String SUCCESS = "SearchOrderController";
    private static final String ERROR = "SearchOrderController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            int statusID = Integer.parseInt(request.getParameter("statusID"));
            String trackingID = request.getParameter("trackingID");
            String modifiedBy = request.getParameter("userID");
            String roleID = request.getParameter("roleID");
            OrderDAO dao = new OrderDAO();
            boolean checkUpdateStatus = dao.updateOrderStatus(orderID, statusID, modifiedBy, roleID);
            if (checkUpdateStatus) {
                //đơn hàng bị huỳ --> cập nhật lại số lượng product
                if (statusID == 5) {
                    List<OrderDetailDTO> orderDetails = dao.getOrderDetail(orderID);
                    boolean check = true;
                    ProductDAO pdao = new ProductDAO();
                    for (OrderDetailDTO orderDetail : orderDetails) {
                        List<String> colorSize = new ArrayList<>();
                            colorSize.add(orderDetail.getColor());
                            colorSize.add(orderDetail.getSize());
                        int maxQuantity = pdao.getProductDetail(orderDetail.getProductID()).getColorSizeQuantity().get(colorSize);

                        check = check && pdao.updateProductQuantity(maxQuantity + orderDetail.getQuantity(), pdao.getProductColorID(orderDetail.getProductID(), orderDetail.getColor()), orderDetail.getSize());

                    }
                }
            }
            boolean checkUpdateTrackingID = dao.updateOrderTrackingID(orderID, trackingID, false);
            boolean checkUpdate = checkUpdateStatus || checkUpdateTrackingID; 
            if (checkUpdate) {
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Cập nhật thành công");
            } else {
                request.setAttribute("MESSAGE", "Cập nhật thất bại");
            }
        } catch (Exception e) {
            log("Error at UpdateOrderController: " + e.toString());
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
