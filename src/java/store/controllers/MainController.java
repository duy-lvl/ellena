package store.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class MainController extends HttpServlet {

    private static final String ERROR = "ExceptionHandlerController";
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "Login";
    private static final String REGISTER = "Register";
    private static final String REGISTER_CONTROLLER = "Register";
    private static final String LOGIN_GOOGLE = "LoginGoogle";
    private static final String LOGIN_GOOGLE_CONTROLLER = "LoginGoogleController";
    
    private static final String FILTER_SEARCHED = "filter-searched-products";
    private static final String FILTER_SEARCHED_CONTROLLER = "FilterSearchedProductsController";
    private static final String FILTER_IN_CATEGORY = "filter-in-category";
    private static final String FILTER_IN_CATEGORY_CONTROLLER = "FilterCategoryProductsController";
    private static final String FILTER_ALL_PRODUCTS = "filter-all-products";
    private static final String FILTER_ALL_PRODUCTS_CONTROLLER = "FilterAllProductsController";
    private static final String SEARCH_CATALOG = "search-catalog";
    private static final String SEARCH_CATALOG_CONTROLLER = "SearchCatalogController";
    private static final String SEARCH_CATEGORY = "SearchCategory";
    private static final String SEARCH_CATEGORY_CONTROLLER = "SearchCategoryController";
    
    
    
    
   
    private static final String UPDATE_PASSWORD = "UpdatePassword";
    private static final String UPDATE_PASSWORD_PAGE = "UpdatePasswordController";
    private static final String UPDATE_SEX = "UpdateSex";
    private static final String UPDATE_SEX_PAGE = "UpdateSexController";
    private static final String UPDATE_BIRTHDAY = "UpdateBirthday";
    private static final String UPDATE_BIRTHDAY_PAGE = "UpdateBirthdayController";
    private static final String UPDATE_NAME = "UpdateName";
    private static final String UPDATE_NAME_PAGE = "UpdateNameController";
    private static final String UPDATE_ADDRESS = "UpdateAddress";
    private static final String UPDATE_ADDRESS_PAGE = "UpdateAddressController";
    private static final String UPDATE_PHONE = "UpdatePhone";
    private static final String UPDATE_PHONE_PAGE = "UpdatePhoneController";
    
    
    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    
    
    
    
    private static final String ADD_TO_CART = "AddToCart";
    private static final String ADD_TO_CART_CONTROLLER = "AddToCartController";
    private static final String UPDATE_CART = "UpdateCart";
    private static final String UPDATE_CART_CONTROLLER = "UpdateCartController";
    private static final String CHECKOUT = "Checkout";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    
    
    
    
    
    
    
    
    
    
    private static final String DETELE_CART_ITEM = "DeleteCartItem";
    private static final String DETELE_CART_ITEM_CONTROLLER = "DeleteCartItemController";
    private static final String MOMO_REQUEST = "MomoRequest";
    private static final String MOMO_REQUEST_CONTROLLER = "MomoRequestController";
    private static final String VIEW_ORDER_HISTORY = "ViewOrderHistory";
    private static final String VIEW_ORDER_HISTORY_CONTROLLER = "ViewOrderHistoryController";
    private static final String CUSTOMER_VIEW_ORDER_DETAIL = "CustomerViewOrderDetail";
    private static final String CUSTOMER_VIEW_ORDER_DETAIL_CONTROLLER = "CustomerViewOrderDetailController";
    private static final String CANCEL_ORDER = "CancelOrder";
    private static final String CANCEL_ORDER_CONTROLLER = "CancelOrderController";
    private static final String FORGOT_PASSWORD = "ForgotPassword";
    private static final String FORGOT_PASSWORD_CONTROLLER = "ForgotPasswordController";
    private static final String VALIDATE_OTP = "ValidateOtp";
    private static final String VALIDATE_OTP_CONTROLLER = "ValidateOtpController";
    private static final String RESET_PASSWORD = "ResetPassword";
    private static final String RESET_PASSWORD_CONTROLLER = "ResetPasswordController";
    private static final String UPDATE_RATING = "UpdateRating";
    private static final String UPDATE_RATING_CONTROLLER = "UpdateRatingController";
    private static final String RETURN = "Return";
    private static final String RETURN_CONTROLLER = "ReturnController";
    private static final String UPDATE_ORDER_DETAIL = "UpdateOrderDetail";
    private static final String UPDATE_ORDER_DETAIL_CONTROLLER = "UpdateOrderDetailController";
    private static final String REFUND = "Refund";
    private static final String REFUND_CONTROLLER = "RefundController";
    private static final String REFUND_ORDER = "RefundOrder";
    private static final String REFUND_ORDER_CONTROLLER = "RefundOrderController";
    private static final String SEARCH_RETURN_CUSTOMER = "SearchReturnedHistory";
    private static final String SEARCH_RETURN_CUSTOMER_CONTROLLER = "SearchReturnedHistoryController";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (null != action) {
                switch (action) {
                    case LOGIN:
                        url = LOGIN_CONTROLLER;
                        break;
                    case REGISTER:
                        url = REGISTER_CONTROLLER;
                        break;
                    case LOGIN_GOOGLE:
                        url = LOGIN_GOOGLE_CONTROLLER;
                        break; 
                    case SEARCH_CATEGORY:
                        url = SEARCH_CATEGORY_CONTROLLER;
                        break;
                    case SEARCH_CATALOG:
                        url = SEARCH_CATALOG_CONTROLLER;
                        break;
                    case FILTER_SEARCHED:
                        url = FILTER_SEARCHED_CONTROLLER;
                        break;
                    case FILTER_IN_CATEGORY:
                        url = FILTER_IN_CATEGORY_CONTROLLER;
                        break;
                    case FILTER_ALL_PRODUCTS:
                        url = FILTER_ALL_PRODUCTS_CONTROLLER;
                        break;   
                    case UPDATE_PASSWORD:
                        url = UPDATE_PASSWORD_PAGE;
                        break;
                    case UPDATE_NAME:
                        url = UPDATE_NAME_PAGE;
                        break;
                    case UPDATE_ADDRESS:
                        url = UPDATE_ADDRESS_PAGE;
                        break;
                    case UPDATE_PHONE:
                        url = UPDATE_PHONE_PAGE;
                        break;
                    case UPDATE_SEX:
                        url = UPDATE_SEX_PAGE;
                        break;
                    case UPDATE_BIRTHDAY:
                        url = UPDATE_BIRTHDAY_PAGE;
                        break;
                    case LOGOUT:
                        url = LOGOUT_CONTROLLER;
                        break;
                    case ADD_TO_CART:
                        url = ADD_TO_CART_CONTROLLER;
                        break;
                    case UPDATE_CART:
                        url = UPDATE_CART_CONTROLLER;
                        break;
                    case CHECKOUT:
                        url = CHECKOUT_CONTROLLER;
                        break;
                    case DETELE_CART_ITEM:
                        url = DETELE_CART_ITEM_CONTROLLER;
                        break;
                    case MOMO_REQUEST:
                        url = MOMO_REQUEST_CONTROLLER;
                        break;
                    case VIEW_ORDER_HISTORY:
                        url = VIEW_ORDER_HISTORY_CONTROLLER;
                        break;
                    case CUSTOMER_VIEW_ORDER_DETAIL:
                        url = CUSTOMER_VIEW_ORDER_DETAIL_CONTROLLER;
                        break;
                    case CANCEL_ORDER:
                        url = CANCEL_ORDER_CONTROLLER;
                        break;
                    case FORGOT_PASSWORD:
                        url = FORGOT_PASSWORD_CONTROLLER;
                        break;
                    case VALIDATE_OTP:
                        url = VALIDATE_OTP_CONTROLLER;
                        break;
                    case RESET_PASSWORD:
                        url = RESET_PASSWORD_CONTROLLER;
                        break;
                    case UPDATE_RATING:
                        url = UPDATE_RATING_CONTROLLER;
                        break;
                    case REFUND:
                        url = REFUND_CONTROLLER;
                        break;
                    case RETURN:
                        url = RETURN_CONTROLLER;
                        break;
                    case UPDATE_ORDER_DETAIL:
                        url = UPDATE_ORDER_DETAIL_CONTROLLER;
                        break;
                    case REFUND_ORDER:
                        url = REFUND_ORDER_CONTROLLER;
                        break;
                    case SEARCH_RETURN_CUSTOMER:
                        url = SEARCH_RETURN_CUSTOMER_CONTROLLER;
                        break;
                    default:
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
