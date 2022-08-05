/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.controllers;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.apache.commons.io.FilenameUtils;
import store.shopping.ProductDAO;
import store.shopping.ProductDTO;
import store.utils.VNCharacterUtils;

/**
 *
 * @author giama
 */
@MultipartConfig
@WebServlet(name = "AddImageController", urlPatterns = {"/AddImageController"})
public class AddImageController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "ViewImagesController";

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
            ProductDAO dao = new ProductDAO();
            int productID = Integer.parseInt(request.getParameter("productID"));    
            String color = request.getParameter("color");
            ProductDTO product = dao.getProductDetail(productID);
            if (product.getColorImage().get(color).size() < 3) {
                String productName = request.getParameter("productName");
                int productColorID = dao.getProductColorID(productID, color);
                color = VNCharacterUtils.removeAccent(color).toLowerCase().trim();
                String uploadPath = getServletContext().getInitParameter("uploadFolder");
                List<Part> images = request.getParts().stream().filter(part -> "image".equals(part.getName()) && part.getSize() > 0).collect(Collectors.toList()); // Retrieves <input type="file" name="files" multiple="true">
                String fileNamePrefix = VNCharacterUtils.removeAccent(productName).trim().toLowerCase().replace(" ", "-");
                for (Part image : images) {
                    fileNamePrefix = fileNamePrefix + "-" + color;
                    String fileName = FilenameUtils.getName(image.getSubmittedFileName());
                    String fileNameSuffix = "." + FilenameUtils.getExtension(fileName);
                    File file = File.createTempFile(fileNamePrefix, fileNameSuffix, uploadFolder);
                    image.write(file.getAbsolutePath());

                    boolean check = dao.addImage(productColorID, "/" + uploadPath + file.getName());

                    if (check) {
                        url = SUCCESS;
                        request.setAttribute("MESSAGE", "Thêm ảnh thành công!");
                        request.setAttribute("ACTIVE_COLOR", request.getParameter("color"));
                    } else {
                        file.delete();
                    }
                }
            } else {
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Số lượng ảnh quá giới hạn cho phép!");
                request.setAttribute("ACTIVE_COLOR", request.getParameter("color"));
            }

        } catch (IOException | NumberFormatException | SQLException | ServletException e) {
            log("Error at AddImageController: " + e.toString());
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
