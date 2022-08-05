/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javafx.util.Pair;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.StatisticDAO;

/**
 *
 * @author VP
 */
@WebServlet(name = "ManagerStatisticUserController", urlPatterns = {"/ManagerStatisticUserController"})
public class ManagerStatisticUserController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "manager-statistic-user.jsp";
    private static final String MIN_DATE = "2000-01-01";
    private static final String EMPTY = "";
    private static final DecimalFormat df = new DecimalFormat("0.0");
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
            
            double avgAge = dao.getAverageAgeCustomer();
            avgAge = Double.parseDouble(df.format(avgAge));
            
            double purchaseRatio = dao.getPurchaseRatio();
            purchaseRatio = Double.parseDouble(df.format(purchaseRatio));
            
            int totalCtm = dao.getTotalCustomer();
            
            List<Pair<String, Integer>> userGender = dao.getUserGender();
            
            String loyalFrom = request.getParameter("loyalFrom");
            String loyalTo = request.getParameter("loyalTo");
            String s = request.getParameter("numberCustomer");
            int numberCustomer = 100;
            if (s != null && s != "") {
                 numberCustomer = Integer.parseInt(s);
            }
            loyalFrom = checkFromDate(loyalFrom);
            loyalTo = checkToDate(loyalTo);
            List<Pair< Pair<String, String>, Pair<Integer, Integer> >> loyalCustomer = dao.getLoyalCustomer(loyalFrom, loyalTo, numberCustomer);
            
            request.setAttribute("TOTAL_CUSTOMER", totalCtm);
            request.setAttribute("USER_AVG_AGE", avgAge);
            request.setAttribute("PURCHASE_RATIO", purchaseRatio);
            request.setAttribute("USER_GENDER", userGender);
            request.setAttribute("LOYAL_CUSTOMER_LIST", loyalCustomer);
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
