/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;
import store.utils.VNCharacterUtils;

/**
 *
 * @author giama
 */
@WebServlet(name = "ManagerUpdateProductController", urlPatterns = {"/ManagerUpdateProductController"})
public class ManagerUpdateProductController extends HttpServlet {
    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "ManagerShowProductDetailController";
    
    private File uploadFolder;

    @Override
    public void init() throws ServletException {
        uploadFolder = new File("D:\\images\\");
    }
    
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
            int productID = Integer.parseInt(request.getParameter("productID"));
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            int lowStockLimit = Integer.parseInt(request.getParameter("lowStockLimit"));
            int price = Integer.parseInt(request.getParameter("price"));
            int discount = Integer.parseInt(request.getParameter("discount"));
            String description = request.getParameter("description");
            String oldProductName = request.getParameter("oldProductName");
            String productName = request.getParameter("productName").toUpperCase();
            ProductDTO product = new ProductDTO(productID, productName, description, price, discount, lowStockLimit, status, categoryID);
            ProductDAO dao = new ProductDAO();
            boolean check = dao.updateProduct(product);
            if (check) {
                if (!productName.equals(oldProductName)) {
                    oldProductName = VNCharacterUtils.removeAccent(oldProductName).toLowerCase().trim().replace(" ", "-");
                    productName = VNCharacterUtils.removeAccent(productName).toLowerCase().trim().replace(" ", "-");
                    List<Integer> productColorIDs = dao.getProductColorIDList(productID);
                    List<String> images = dao.getProductImages(productColorIDs);
                    List<String> newImages = new ArrayList<>();
                    for (String image: images) {
                        newImages.add(image.replace(oldProductName, productName));
                        
                    }
                    for (int i = 0; i < images.size(); i++) {
                        Path source = Paths.get("D:\\"+ images.get(i));
                        Files.move(source, source.resolveSibling(newImages.get(i)));
                    }
                    dao.updateImages(newImages, images);
                }
                request.setAttribute("MESSAGE", "Cập nhật thành công.");
                url = SUCCESS;
            }
        } catch (NumberFormatException | SQLException e) {
            log("Error at ManagerUpdateProductController: " + e.toString());
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
