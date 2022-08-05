/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package store.controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import javafx.util.Pair;
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
 * @author vankh
 */
@MultipartConfig
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    private static final String ERROR = "add-product.jsp";
    private static final String SUCCESS = "ManagerShowProductController";

    private File uploadFolder;

    @Override
    public void init() throws ServletException {
        uploadFolder = new File("D:\\images\\");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productName = request.getParameter("productName").toUpperCase();
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            int lowStockLimit = Integer.parseInt(request.getParameter("lowStockLimit"));
            int price = Integer.parseInt(request.getParameter("price"));
            int discount = Integer.parseInt(request.getParameter("discount"));
            String description = request.getParameter("description");
            String[] color = request.getParameterValues("color");

            String[] variantsCountString = request.getParameterValues("variantsCount");
            int[] variantsCount = new int[variantsCountString.length];
            for (int i = 0; i < variantsCountString.length; i++) {
                variantsCount[i] = Integer.parseInt(variantsCountString[i]);
            }
            List<Pair<String, Integer>> colorVariants = new ArrayList<>();
            for (int i = 0; i < color.length; i++) {
                color[i] = color[i].substring(0, 1).toUpperCase() + color[i].substring(1);//capitalize the string
                colorVariants.add(new Pair<>(color[i], variantsCount[i]));
            }

            String[] size = request.getParameterValues("size");

            String[] quantityString = request.getParameterValues("quantity");
            int[] quantity = new int[quantityString.length];
            for (int i = 0; i < quantityString.length; i++) {
                quantity[i] = Integer.parseInt(quantityString[i]);
            }

            Map<List<String>, Integer> colorSizeQuantity = new HashMap<>();
            int count = 0;
            for (Pair<String, Integer> pair : colorVariants) {
                
                for (int i = 0; i < pair.getValue(); i++) {
                    List<String> colorSize = new ArrayList<>();
                    colorSize.add(pair.getKey()); 
                    colorSize.add(size[count].toUpperCase());
                    colorSizeQuantity.put(colorSize, quantity[count++]);

                }
            }
            String uploadPath = getServletContext().getInitParameter("uploadFolder");
            Map<String, List<String>> colorImage = new HashMap<>();
            for (int i = 0; i < color.length; i++) {
                List<String> images = new ArrayList<>();
                String colorFile = "files" + String.valueOf(i);
                List<Part> fileParts = request.getParts().stream().filter(part -> colorFile.equals(part.getName()) && part.getSize() > 0).collect(Collectors.toList()); // Retrieves <input type="file" name="files" multiple="true">
                for (Part image : fileParts) {
                    String fileNamePrefix = VNCharacterUtils.removeAccent(productName).trim().toLowerCase().replace(" ", "-");
                    fileNamePrefix = fileNamePrefix + "-" + VNCharacterUtils.removeAccent(color[i]).toLowerCase().trim();
                    String fileName = FilenameUtils.getName(image.getSubmittedFileName());
                    String fileNameSuffix = "." + FilenameUtils.getExtension(fileName);
                    File file = File.createTempFile(fileNamePrefix, fileNameSuffix, uploadFolder);
                    images.add("/" + uploadPath + file.getName());
                    image.write(file.getAbsolutePath());
                    
                }
                colorImage.put(color[i], images);
            }

            ProductDTO product = new ProductDTO(1, productName, description, colorImage, colorSizeQuantity, price, discount, lowStockLimit, false, categoryID);
            ProductDAO dao = new ProductDAO();
            boolean check = dao.addProduct(product);
            
            if (check) {
                url = SUCCESS;
                request.setAttribute("MESSAGE", "Thêm sản phẩm thành công");
//                boolean checkInsert = dao.addUser(user);
//                if (checkInsert) {
//                    url = SUCCESS;
//                }
            } else {
                request.setAttribute("MESSAGE", "Đã có lỗi xảy ra!");
                // request.setAttribute("USER_ERROR", userError);
                //for push
            }
        } catch (Exception e) {
            log("Error at AddProductController: " + e.toString());
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
