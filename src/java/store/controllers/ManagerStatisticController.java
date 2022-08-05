/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javafx.util.Pair;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.StatisticDAO;
import store.shopping.StatisticDTO;

/**
 *
 * @author VP
 */
@WebServlet(name = "ManagerStatisticController", urlPatterns = {"/ManagerStatisticController"})
public class ManagerStatisticController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "manager-statistic.jsp";
    private static final String MIN_DATE = "2000-01-01";
    private static final String EMPTY = "";
    protected String checkFromDate(String date){
        if(date == null || date == EMPTY){
            return MIN_DATE;
        }
        return date;
    }
    
    protected String checkToDate(String date){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String TODAY = dateFormat.format(new Date());
        if(date == null || date == EMPTY){
            return TODAY;
        }
        return date;
    }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            StatisticDAO dao = new StatisticDAO();
            Map<String, StatisticDTO> orderStatistic7Day = dao.getStatisticOrder7Day();
            Map<String, StatisticDTO> orderStatistic30Day = dao.getStatisticOrder30Day();
            Map<String, StatisticDTO> orderStatistic1Year = dao.getStatisticOrder1Year();
            String cancelOrderFrom = request.getParameter("cancelOrderFrom");
            String cancelOrderTo = request.getParameter("cancelOrderTo");
            String payTypeFrom = request.getParameter("payTypeFrom");
            String payTypeTo = request.getParameter("payTypeTo");
            String getStatisticFrom = request.getParameter("getStatisticFrom");
            String getStatisticTo = request.getParameter("getStatisticTo");
            String getGraphFrom = request.getParameter("getGraphFrom");
            String getGraphTo = request.getParameter("getGraphTo");
            String sellerFrom = request.getParameter("sellerFrom");
            String sellerTo = request.getParameter("sellerTo");
            String incomeFrom = request.getParameter("incomeFrom");
            String incomeTo = request.getParameter("incomeTo");
            
            cancelOrderFrom = checkFromDate(cancelOrderFrom);
            cancelOrderTo = checkToDate(cancelOrderTo);
            payTypeFrom = checkFromDate(payTypeFrom);
            payTypeTo = checkToDate(payTypeTo);
            getStatisticFrom = checkFromDate(getStatisticFrom);
            getStatisticTo = checkToDate(getStatisticTo);
            sellerFrom = checkFromDate(sellerFrom);
            sellerTo = checkToDate(sellerTo);
            incomeFrom = checkFromDate(incomeFrom);
            incomeTo = checkToDate(incomeTo);
            
            Integer cancelledOrder = dao.getCancelledOrder(cancelOrderFrom, cancelOrderTo);
            Integer refundOrder = dao.getRefundOrder(cancelOrderFrom, cancelOrderTo);
            Integer totalOrder = dao.getTotalOrder(cancelOrderFrom, cancelOrderTo);
            List<Pair<String, Integer>> payType = dao.getPayTypeCount(payTypeFrom, payTypeTo);
            Double cancelRatio = (double)cancelledOrder / (double)totalOrder;
            Double refundRatio = (double)refundOrder / (double)totalOrder;
            
            List<Pair<String, StatisticDTO>> bestSeller = dao.getBestSeller(sellerFrom, sellerTo);
            List<Pair<String, StatisticDTO>> bestIncome = dao.getBestIncome(incomeFrom, incomeTo);
            List<Pair<String, Integer>> userGender = dao.getUserGender();
            StatisticDTO today = dao.getStatisticOrder(getStatisticFrom, getStatisticTo);
            if(getGraphFrom != null && getGraphTo != null){
                Map<String, StatisticDTO> orderStatisticCustom = dao.getStatisticCustom(getGraphFrom, getGraphTo);
                request.setAttribute("ORDER_STATISTIC_CUSTOM", orderStatisticCustom);
            }
    
            request.setAttribute("ORDER_STATISTIC_7DAY", orderStatistic7Day);
            request.setAttribute("ORDER_STATISTIC_30DAY", orderStatistic30Day);
            request.setAttribute("ORDER_STATISTIC_1YEAR", orderStatistic1Year);
            request.setAttribute("ORDER_STATISTIC_TODAY", today);
            request.setAttribute("BEST_SELLER", bestSeller);
            request.setAttribute("BEST_INCOME", bestIncome);
            request.setAttribute("CANCEL_RATIO", cancelRatio);
            request.setAttribute("REFUND_RATIO", refundRatio);
            request.setAttribute("PAY_TYPE", payType);

            url = SUCCESS;
            
        } catch (Exception e) {
            log("Error at ManagerStatisticController: " + e.toString());
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
