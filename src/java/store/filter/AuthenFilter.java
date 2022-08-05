/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package store.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import store.user.UserDTO;

/**
 *
 * @author giama
 */
@WebFilter(filterName = "AuthenFilter", urlPatterns = {"/*"})
public class AuthenFilter implements Filter {

    private static List<String> CUSTOMER_FUNCTION;
    private static List<String> ADMIN_FUNCTION;
    private static List<String> MANAGER_FUNCTION;
    private static List<String> EMPLOYEE_FUNCTION;
    private static final String EM = "EM";
    private static final String CM = "CM";
    private static final String AD = "AD";
    private static final String MN = "MN";
    private static final String HOME_PAGE = "./";
    private static final boolean debug = true;
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        CUSTOMER_FUNCTION = new ArrayList<>();
        CUSTOMER_FUNCTION.add("");
        CUSTOMER_FUNCTION.add("home.jsp");
        CUSTOMER_FUNCTION.add("ViewHomeController");
        CUSTOMER_FUNCTION.add("contact.jsp");
        CUSTOMER_FUNCTION.add("category.jsp");
        CUSTOMER_FUNCTION.add("new-arrival.jsp");
        CUSTOMER_FUNCTION.add("sale-product.jsp");
        CUSTOMER_FUNCTION.add("trend.jsp");
        CUSTOMER_FUNCTION.add("customer-product-details.jsp");
        CUSTOMER_FUNCTION.add("ProductRouteController");
        CUSTOMER_FUNCTION.add("CheckSizeQuantityController");
        CUSTOMER_FUNCTION.add("shop-cart.jsp");
        CUSTOMER_FUNCTION.add("AddToCartController");
        CUSTOMER_FUNCTION.add("CheckSizeQuantityController");
        CUSTOMER_FUNCTION.add("best-seller.jsp");
        CUSTOMER_FUNCTION.add("DeleteCartItemController");
        CUSTOMER_FUNCTION.add("UpdateCartItemQuantityController");
        CUSTOMER_FUNCTION.add("checkout.jsp");
        CUSTOMER_FUNCTION.add("vnpay.jsp");
        CUSTOMER_FUNCTION.add("ajaxServlet");
        CUSTOMER_FUNCTION.add("CheckoutController");
        CUSTOMER_FUNCTION.add("order-history.jsp");
        CUSTOMER_FUNCTION.add("ViewOrderHistoryController");
        CUSTOMER_FUNCTION.add("CreateRatingFormController");
        CUSTOMER_FUNCTION.add("rating-product.jsp");       
        CUSTOMER_FUNCTION.add("UpdateRatingController");     
        CUSTOMER_FUNCTION.add("customer-profile.jsp");
        CUSTOMER_FUNCTION.add("DiscoverController");
        CUSTOMER_FUNCTION.add("CategoryRouteController");
        CUSTOMER_FUNCTION.add("about-us.jsp");
        CUSTOMER_FUNCTION.add("faq.jsp");
        CUSTOMER_FUNCTION.add("choose-size.jsp");
        CUSTOMER_FUNCTION.add("payment-policy.jsp");
        CUSTOMER_FUNCTION.add("return-policy.jsp");
        CUSTOMER_FUNCTION.add("RatingController");
        CUSTOMER_FUNCTION.add("rating-order.jsp");
        CUSTOMER_FUNCTION.add("rating-product.jsp");
        CUSTOMER_FUNCTION.add("FilterAllProductsController");
        CUSTOMER_FUNCTION.add("SearchCatalogController");
        CUSTOMER_FUNCTION.add("FilterSearchedProductsController");
        
        ADMIN_FUNCTION = new ArrayList<>();
        ADMIN_FUNCTION.add("admin.jsp");
        ADMIN_FUNCTION.add("add-account.jsp");
        ADMIN_FUNCTION.add("add-category.jsp");
        ADMIN_FUNCTION.add("view-category.jsp");
        ADMIN_FUNCTION.add("view-manager.jsp");
        ADMIN_FUNCTION.add("my-profile.jsp");
        ADMIN_FUNCTION.add("ShowManagerController");
        ADMIN_FUNCTION.add("ShowCategoryController");
        ADMIN_FUNCTION.add("ShowAccountController");
        ADMIN_FUNCTION.add("SearchAccountController");
        ADMIN_FUNCTION.add("AddAccountController");
        ADMIN_FUNCTION.add("UpdateAccountController");
        ADMIN_FUNCTION.add("DeactivateAccountController");
        ADMIN_FUNCTION.add("ActivateAccountController");
        ADMIN_FUNCTION.add("SearchManagerController");
        ADMIN_FUNCTION.add("SearchCategoryController");
        ADMIN_FUNCTION.add("DeactivateCategoryController");
        ADMIN_FUNCTION.add("ActivateCategoryController");
        ADMIN_FUNCTION.add("UpdateCategoryController");
        ADMIN_FUNCTION.add("AddCategoryController");
        

        MANAGER_FUNCTION = new ArrayList<>();
        MANAGER_FUNCTION.add("manager-product.jsp");
        MANAGER_FUNCTION.add("manager-statistic.jsp");
        MANAGER_FUNCTION.add("manager-statistic-user.jsp");
        MANAGER_FUNCTION.add("my-profile.jsp");
        MANAGER_FUNCTION.add("ManagerStatisticController");
        MANAGER_FUNCTION.add("ManagerStatisticUserController");
        MANAGER_FUNCTION.add("ManagerShowProductController");
        MANAGER_FUNCTION.add("ManagerSearchProductController");
        MANAGER_FUNCTION.add("ManagerShowProductDetailController");
        MANAGER_FUNCTION.add("manager-product-details.jsp");
        MANAGER_FUNCTION.add("add-product.jsp");
        MANAGER_FUNCTION.add("add-variant.jsp");
        MANAGER_FUNCTION.add("AddProductController");
        MANAGER_FUNCTION.add("view-product-images.jsp");
        MANAGER_FUNCTION.add("ManagerShowOrderController");
        MANAGER_FUNCTION.add("ShowOrderController");
        MANAGER_FUNCTION.add("UpdateOrderController");
        MANAGER_FUNCTION.add("SearchOrderController");
        MANAGER_FUNCTION.add("manager-order.jsp");
        MANAGER_FUNCTION.add("return.jsp");
        MANAGER_FUNCTION.add("ReturnController");
        MANAGER_FUNCTION.add("UpdateTrackingIdController");
        MANAGER_FUNCTION.add("UpdateOrderDetailController");
        MANAGER_FUNCTION.add("RefundOrderController");
        MANAGER_FUNCTION.add("customer-return-history.jsp");
        MANAGER_FUNCTION.add("SearchReturnedHistoryController");
        MANAGER_FUNCTION.add("ManagerSearchProductController");
        MANAGER_FUNCTION.add("ManagerUpdateProductController");
        MANAGER_FUNCTION.add("DeactivateProductController");
        MANAGER_FUNCTION.add("ActivateProductController");
        MANAGER_FUNCTION.add("UpdateVariantsController");
        MANAGER_FUNCTION.add("DeleteColorController");
        MANAGER_FUNCTION.add("DeleteSizeController");
        MANAGER_FUNCTION.add("ViewImagesController");
        MANAGER_FUNCTION.add("AddColorsController");
        MANAGER_FUNCTION.add("AddVariantsController");
        MANAGER_FUNCTION.add("AddImageController");
        MANAGER_FUNCTION.add("DeleteImageController");
        
        EMPLOYEE_FUNCTION = new ArrayList<>();
        EMPLOYEE_FUNCTION.add("ShowOrderController");
        EMPLOYEE_FUNCTION.add("UpdateOrderController");
        EMPLOYEE_FUNCTION.add("SearchOrderController");
        EMPLOYEE_FUNCTION.add("manager-order.jsp");
        EMPLOYEE_FUNCTION.add("return.jsp");
        EMPLOYEE_FUNCTION.add("ReturnController");
        EMPLOYEE_FUNCTION.add("RefundController");
        EMPLOYEE_FUNCTION.add("UpdateOrderDetailController");
        EMPLOYEE_FUNCTION.add("RefundOrderController");
        EMPLOYEE_FUNCTION.add("customer-return-history.jsp");
        EMPLOYEE_FUNCTION.add("SearchReturnedHistoryController");
        EMPLOYEE_FUNCTION.add("my-profile.jsp");
        EMPLOYEE_FUNCTION.add("UpdateTrackingIdController");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("NewFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("NewFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        try {
            request.setCharacterEncoding("UTF-8");
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            if (res.getStatus() == 404) {
                res.sendRedirect("error.jsp");
            } else {
                HttpSession session = req.getSession();
                if (session == null) {
                    request.setAttribute("ERROR", "Session timeout!");
                    res.sendRedirect(HOME_PAGE);
                } else {
                    UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                    String uri = req.getRequestURI();
                    int index = uri.lastIndexOf("/");
                    String resource = uri.substring(index + 1);
                    if (loginUser == null) {
                        if (uri.equals("/Ellena/") || uri.contains("google") || uri.contains(".jpg") || uri.contains(".gif") || uri.contains(".png")
                                || uri.contains("css") || uri.contains("fonts") || uri.contains("scss") || uri.contains("Ellena/js")
                                || uri.contains("sass") || uri.contains("error.jsp") || uri.contains("ViewHomeController")
                                || uri.contains("register.jsp") || uri.contains("login.jsp") || uri.contains("MainController") || uri.contains("footer.jsp")
                                || uri.contains("home.jsp") || uri.contains("meta.jsp") || uri.contains("contact.jsp") || uri.contains("category.jsp")
                                || uri.contains("header.jsp") || uri.contains("new-arrival.jsp") || uri.contains("trend.jsp") || uri.contains("sale-product.jsp") || uri.contains("best-seller.jsp")
                                || uri.contains("customer-product-details.jsp") || uri.contains("ProductRouteController") || uri.contains("DiscoverController")
                                || uri.contains("CategoryRouteController") || uri.contains("CheckSizeQuantityController") || uri.contains("discover.jsp")
                                || uri.contains("search-catalog.jsp") || uri.contains("LoginGoogleController") || uri.contains("AddToCartController")
                                || uri.contains("about-us.jsp") || uri.contains("faq.jsp") || uri.contains("choose-size.jsp") || uri.contains("payment-policy.jsp") || uri.contains("return-policy.jsp")
                                || uri.contains("forgot-password.jsp") || uri.contains("ForgotPasswordController") || uri.contains("validate-otp.jsp") || uri.contains("ValidateOtpController")
                                || uri.contains("reset-password.jsp") || uri.contains("ResetPasswordController") || uri.contains("LogoutController") 
                                || uri.contains("FilterAllProductsController") || uri.contains("SearchCatalogController") || uri.contains("FilterSearchedProductsController")
                                || uri.contains("RegisterAccountController")) {
                            chain.doFilter(request, response);
                        } else if (!ADMIN_FUNCTION.contains(resource) && !CUSTOMER_FUNCTION.contains(resource) && !MANAGER_FUNCTION.contains(resource)) {
                            res.sendError(404);
                        } else {
                            res.sendRedirect(HOME_PAGE);
                        }

                    } else {
                        if (uri.contains(".jpg") || uri.contains(".gif") || uri.contains(".png")
                                || uri.contains("css") || uri.contains("fonts") || uri.contains("scss") || uri.contains("Ellena/js")
                                || uri.contains("sass") || uri.contains("error.jsp") || uri.contains("MainController")
                                || uri.contains("meta.jsp")) {
                            chain.doFilter(request, response);
                        } else {

                            String roleID = loginUser.getRoleID();
                            if (AD.equals(roleID) && ADMIN_FUNCTION.contains(resource)) {
                                chain.doFilter(request, response);
                            } else if (CM.equals(roleID) && CUSTOMER_FUNCTION.contains(resource)) {
                                chain.doFilter(request, response);
                            } else if (MN.equals(roleID) && MANAGER_FUNCTION.contains(resource)) {
                                chain.doFilter(request, response);
                            } else if (EM.equals(roleID) && EMPLOYEE_FUNCTION.contains(resource)) {
                                chain.doFilter(request, response);
                            }else {
                                if (CM.equals(roleID))
                                    res.sendRedirect(HOME_PAGE);
                                else
                                    res.sendRedirect("error.jsp");
                            }

                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("NewFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("NewFilter()");
        }
        StringBuffer sb = new StringBuffer("NewFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
