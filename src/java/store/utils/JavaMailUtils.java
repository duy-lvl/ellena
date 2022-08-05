/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package store.utils;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import store.shopping.CartProduct;
import store.shopping.OrderDTO;

/**
 *
 * @author Jason 2.0
 */
public class JavaMailUtils {
//    ---------------------------Email account---------------------------------------

    public static final String EMAIL_ACCOUNT = "tongductrung2017@gmail.com"; // NOTE : THIS IS MY ACCOUNT FOR TESTING, PLEASE DO NOT MESS WITH IT!!!
    public static final String EMAIL_PASSWORD = "crwgapvouhwaovvu";
//    ------------------------------------------------------------------------------------
    private static int otpOut = 0;

    public static final String VALIDATE_OTP = "validateOTP";
    public static final String ORDER_CONFIRM = "OrderConfirm";

    public static void sendMail(String recepient, String mailType) throws Exception {
        System.out.println("Preparing to send email");
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", true);
        properties.put("mail.smtp.starttls.enable", true);
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_ACCOUNT, EMAIL_PASSWORD);
            }

        });

        switch (mailType) {
            case VALIDATE_OTP:
                Message message = validateOTP(session, EMAIL_ACCOUNT, recepient);
                Transport.send(message);
                System.out.println("Message sent successfully");// print out console might not be needed for final product
                break;

            default:
                System.out.println("ERROR, no mail was sent!!");// print out console might not be needed for final product
                break;
        }

    }

    public static int getOtpValue() {
        return otpOut;
    }

    private static Message validateOTP(Session session, String myAccountEmail, String recepient) {
        try {
//            Random number for OTP validation
            Random rand = new Random();
            int otpValue = rand.nextInt(1255650);
            otpOut = otpValue;

            String otpMail = "<!doctype html>\n"
                    + "<html>\n"
                    + "\n"
                    + "<head>\n"
                    + "  <title>\n"
                    + "  </title>\n"
                    + "  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                    + "  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                    + "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
                    + "  <style type=\"text/css\">\n"
                    + "    #outlook a {\n"
                    + "      padding: 0;\n"
                    + "    }\n"
                    + "\n"
                    + "    body {\n"
                    + "      margin: 0;\n"
                    + "      padding: 0;\n"
                    + "      -webkit-text-size-adjust: 100%;\n"
                    + "      -ms-text-size-adjust: 100%;\n"
                    + "    }\n"
                    + "\n"
                    + "    table,\n"
                    + "    td {\n"
                    + "      border-collapse: collapse;\n"
                    + "      mso-table-lspace: 0pt;\n"
                    + "      mso-table-rspace: 0pt;\n"
                    + "    }\n"
                    + "\n"
                    + "    img {\n"
                    + "      border: 0;\n"
                    + "      height: auto;\n"
                    + "      line-height: 100%;\n"
                    + "      outline: none;\n"
                    + "      text-decoration: none;\n"
                    + "      -ms-interpolation-mode: bicubic;\n"
                    + "    }\n"
                    + "\n"
                    + "    p {\n"
                    + "      display: block;\n"
                    + "      margin: 13px 0;\n"
                    + "    }\n"
                    + "  </style>\n"
                    + "  <link href=\"https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,700\" rel=\"stylesheet\" type=\"text/css\">\n"
                    + "  <style type=\"text/css\">\n"
                    + "    @import url(https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,700);\n"
                    + "  </style>\n"
                    + "  <style type=\"text/css\">\n"
                    + "    @media only screen and (min-width:480px) {\n"
                    + "      .mj-column-per-100 {\n"
                    + "        width: 100% !important;\n"
                    + "        max-width: 100%;\n"
                    + "      }\n"
                    + "    }\n"
                    + "  </style>\n"
                    + "  <style media=\"screen and (min-width:480px)\">\n"
                    + "    .moz-text-html .mj-column-per-100 {\n"
                    + "      width: 100% !important;\n"
                    + "      max-width: 100%;\n"
                    + "    }\n"
                    + "  </style>\n"
                    + "  <style type=\"text/css\">\n"
                    + "    @media only screen and (max-width:480px) {\n"
                    + "      table.mj-full-width-mobile {\n"
                    + "        width: 100% !important;\n"
                    + "      }\n"
                    + "\n"
                    + "      td.mj-full-width-mobile {\n"
                    + "        width: auto !important;\n"
                    + "      }\n"
                    + "    }\n"
                    + "  </style>\n"
                    + "</head>\n"
                    + "\n"
                    + "<body style=\"word-spacing:normal;background-color:#fafbfc;\">\n"
                    + "  <div style=\"background-color:#fafbfc;\">\n"
                    + "    <div style=\"margin:0px auto;max-width:600px;\">\n"
                    + "      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%;\">\n"
                    + "        <tbody>\n"
                    + "          <tr>\n"
                    + "            <td style=\"direction:ltr;font-size:0px;padding:20px 0;padding-bottom:20px;padding-top:20px;text-align:center;\">\n"
                    + "              <div class=\"mj-column-per-100 mj-outlook-group-fix\" style=\"font-size:0px;text-align:left;direction:ltr;display:inline-block;vertical-align:middle;width:100%;\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:middle;\" width=\"100%\">\n"
                    + "                  <tbody>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:25px;word-break:break-word;\">\n"
                    + "                        <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"border-collapse:collapse;border-spacing:0px;\">\n"
                    + "                          <tbody>\n"
                    + "                            <tr>\n"
                    + "                              <td align=\"center\" height=\"115\" style=\"font-family:Helvetica,Arial,sans-serif; font-size:24px;\">\n"
                    + "                                 <a href=\"http://localhost:8080/Ellena/\"  style=\"text-decoration: none; color: #000;\"><h1>ELLENA</h1></a>\n"
                    + "                              </td>\n"
                    + "                            </tr>\n"
                    + "                          </tbody>\n"
                    + "                        </table>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                  </tbody>\n"
                    + "                </table>\n"
                    + "              </div>\n"
                    + "            </td>\n"
                    + "          </tr>\n"
                    + "        </tbody>\n"
                    + "      </table>\n"
                    + "    </div>\n"
                    + "    <div style=\"background:#ffffff;background-color:#ffffff;margin:0px auto;max-width:600px;\">\n"
                    + "      <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"background:#ffffff;background-color:#ffffff;width:100%;\">\n"
                    + "        <tbody>\n"
                    + "          <tr>\n"
                    + "            <td style=\"direction:ltr;font-size:0px;padding:20px 0;padding-bottom:20px;padding-top:20px;text-align:center;\">\n"
                    + "              <div class=\"mj-column-per-100 mj-outlook-group-fix\" style=\"font-size:0px;text-align:left;direction:ltr;display:inline-block;vertical-align:middle;width:100%;\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"vertical-align:middle;\" width=\"100%\">\n"
                    + "                  <tbody>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:10px 25px;padding-right:25px;padding-left:25px;word-break:break-word;\">\n"
                    + "                        <div style=\"font-family:open Sans Helvetica, Arial, sans-serif;font-size:16px;line-height:1;text-align:center;color:#000000;\"><span>Xin chào,</span></div>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:10px 25px;padding-right:25px;padding-left:25px;word-break:break-word;\">\n"
                    + "                        <div style=\"font-family:open Sans Helvetica, Arial, sans-serif;font-size:16px;line-height:1;text-align:center;color:#000000;\">Vui lòng sử dụng mã xác minh dưới đây trên trang web Ellena:</div>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:10px 25px;word-break:break-word;\">\n"
                    + "                        <div style=\"font-family:open Sans Helvetica, Arial, sans-serif;font-size:24px;font-weight:bold;line-height:1;text-align:center;color:#000000;\">" + otpValue + "</div>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:10px 25px;padding-right:16px;padding-left:25px;word-break:break-word;\">\n"
                    + "                        <div style=\"font-family:open Sans Helvetica, Arial, sans-serif;font-size:16px;line-height:1;text-align:center;color:#000000;\">Nếu bạn không yêu cầu xác thực OTP này, bạn có thể bỏ qua email này hoặc cho chúng tôi biết.</div>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                    <tr>\n"
                    + "                      <td align=\"center\" style=\"font-size:0px;padding:10px 25px;padding-right:25px;padding-left:25px;word-break:break-word;\">\n"
                    + "                        <div style=\"font-family:open Sans Helvetica, Arial, sans-serif;font-size:16px;line-height:1;text-align:center;color:#000000;\">Xin cảm ơn! <br />Đội ngũ Ellena</div>\n"
                    + "                      </td>\n"
                    + "                    </tr>\n"
                    + "                  </tbody>\n"
                    + "                </table>\n"
                    + "              </div>\n"
                    + "            </td>\n"
                    + "          </tr>\n"
                    + "        </tbody>\n"
                    + "      </table>\n"
                    + "    </div>\n"
                    + "  </div>\n"
                    + "</body>\n"
                    + "\n"
                    + "</html>";

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
            message.setSubject("Xác thực OTP", "utf-8");
            message.setContent(otpMail, "text/html; charset=UTF-8");
            return message;
        } catch (MessagingException ex) {
            Logger.getLogger(JavaMailUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void sendOrderMail(String recepient, String mailType, OrderDTO orderDetail, List<CartProduct> cartDetail) throws Exception {
        System.out.println("Preparing to send email");
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", true);
        properties.put("mail.smtp.starttls.enable", true);
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_ACCOUNT, EMAIL_PASSWORD);
            }

        });

        switch (mailType) {
            case ORDER_CONFIRM:
                Message message = orderConfirm(session, EMAIL_ACCOUNT, recepient, orderDetail, cartDetail);
                Transport.send(message);
                System.out.println("Message sent successfully");// print out console might not be needed for final product
                break;

            default:
                System.out.println("ERROR, no mail was sent!!");// print out console might not be needed for final product
                break;
        }

    }

    private static Message orderConfirm(Session session, String myAccountEmail, String recepient, OrderDTO orderDetail, List<CartProduct> cartDetail) {
        String firstPart = "<!DOCTYPE html>\n"
                + "<html>\n"
                + "<head>\n"
                + "    <meta charset=\"utf-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
                + "    <meta http-equiv=\"Content-Type\" content=\"text/html charset=UTF-8\" />\n"
                + "    <title>test</title>\n"
                + "</head>\n"
                + "<body>\n"
                + "    <!-- initial whole site table -->\n"
                + "    <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"background-color:#ddd;padding:0;margin:0;border-collapse:collapse;border-spacing:0\" align=\"center\">\n"
                + "        <tr>\n"
                + "            <td align=\"center\" valign=\"top\">\n"
                + "                <!-- main table -->\n"
                + "                <table width=\"650\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"padding:0;margin:0\" align=\"center\">\n"
                + "                    <tr> <!-- 1st row : Shop Logo-->\n"
                + "                        <td bgcolor=\"#fff\" align=\"center\" valign=\"top\">\n"
                + "                            <!-- Contents within the 1st row of main table -->\n"
                + "                            <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"background-color:#fff;padding:0;margin:0\" align=\"center\">\n"
                + "                                <tr>\n"
                + "                                    <td align=\"center\" valign=\"top\">\n"
                + "                                        <!-- A smaller table inside for Shop logo and border-bottom -->\n"
                + "                                        <table width=\"90%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"background-color:#fff;background-repeat:repeat;padding:0;margin:0;\" align=\"center\">\n"
                + "                                            <tr>\n"
                + "                                                <td align=\"center\" height=\"115\" style=\"font-family:Helvetica,Arial,sans-serif; font-size:24px;\">\n"
                + "                                                    <a href=\"http://localhost:8080/Ellena/\"  style=\"text-decoration: none; color: #000;\"><h1>ELLENA</h1></a>\n"
                + "                                                </td>\n"
                + "                                            </tr>\n"
                + "                                        </table>\n"
                + "                                    </td>\n"
                + "                                </tr>\n"
                + "                            </table>\n"
                + "                        </td>\n"
                + "                    </tr>\n"
                + "                    <tr><!-- 2nd row : Main body (order detail)-->\n"
                + "                        <td bgcolor=\"#fff\" align=\"center\" valign=\"top\">\n"
                + "                            <!-- Contents within the 2nd row of main table (wrap table) -->\n"
                + "                            <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"background-color:#fff;\" align=\"center\">\n"
                + "                                <tr> <!-- Main -->\n"
                + "                                    <td bgcolor=\"#fff\" valign=\"top\" align=\"center\" style=\"padding-top:15px;padding-bottom:15px;\"> <!-- (padding from the navbar) -->\n"
                + "                                        <!-- Main body content table -->\n"
                + "                                        <table width=\"100%\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"background-color:#fff; border-top: 1px solid #000;\" align=\"left\">\n"
                + "                                            <tr>\n"
                + "                                                <td valign=\"top\" align=\"left\" style=\"padding:0px 20px 0px 20px\"> <!-- have all content to shift into the center 20px left and right -->\n"
                + "                                                    <!-- Main content Begin -->\n"
                + "                                                    <!-- Main title --> \n"
                + "                                                    <font size=\"5\" style=\"font-family:Helvetica,Arial,sans-serif;font-weight:600;color:#333;line-height:1.1em\">\n"
                + "                                                        <p> Đơn hàng đã được đặt thành công! </p>\n"
                + "                                                    </font>\n"
                + "                                                    <!-- Main content body -->\n"
                + "                                                    <font size=\"3\" style=\"font-family:Helvetica,Arial,sans-serif;color:#000;line-height:1.5em\">\n"
                + "                                                        <!-- Main content table -->\n"
                + "                                                        <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n"
                + "                                                            <tr> <!-- CustomerName row -->\n"
                + "                                                                <td><p>" + orderDetail.getFullName() + " ơi,</p></td>\n"
                + "                                                            </tr>\n"
                + "                                                            <tr> <!-- Message row -->\n"
                + "                                                                <td>\n"
                + "                                                                    <p> Đơn hàng của bạn hiện đang trong quá trình xác nhận, Shop sẽ thông báo cho bạn sau khi đơn hàng đã được xác nhận. </p>\n"
                + "                                                                </td>\n"
                + "                                                            </tr>\n"
                + "                                                            <tr> <!-- orderID row --> \n"
                + "                                                                <td>Mã đơn hàng: <b>" + orderDetail.getOrderID() + "</b></td>\n"
                + "                                                            </tr>\n"
                + "                                                            <tr> <!-- trackingID row -->\n"
                + "                                                                <td>Mã vận đơn: <b>Đơn hàng hiện đang trong quá trình xác nhận</b></td>\n"
                + "                                                            </tr> \n"
                + "                                                            <tr> <!-- orderAddress row -->\n"
                + "                                                                <td>Đơn hàng sẽ được vận chuyển đến: <b>" + orderDetail.getAddress() + "</b></td>\n"
                + "                                                            </tr> \n"
                + "                                                            <tr><!-- orderDetail products row -->\n"
                + "                                                                <td style=\"padding-top: 20px;\">\n"
                + "                                                                    <!-- product start -->\n"
                + "                                                                    <table cellpadding=\"0\" cellspacing=\"0\" width=\"100%\"> <!-- order detail table -->\n"
                + "                                                                        <tr style=\"font-weight: bold;\"> <!-- titles -->\n"
                + "                                                                            <td width=\"30%\">Sản phẩm</td>\n"
                + "                                                                            <td width=\"20%\">Màu/Size</td>\n"
                + "                                                                            <td width=\"20%\">Đơn giá</td>\n"
                + "                                                                            <td width=\"10%\">Số lượng</td>\n"
                + "                                                                            <td width=\"20%\">Thành tiền</td>\n"
                + "                                                                        </tr>\n"
                + "                                                                        <tr> <!-- seperator -->\n"
                + "                                                                            <td width=\"100%\" style=\"border-top: 1px solid #000;\" colspan=\"5\"></td>\n"
                + "                                                                        </tr>\n";

        // number format
        NumberFormat numberFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

        // adding each product to html string and calculate total
        int total = 0;
        for (CartProduct product : cartDetail) {
            total += (product.getPrice() - product.getDiscount()) * product.getQuantity();
            firstPart += "                                                                        <tr> <!-- product -->\n"
                    + "                                                                            <td width=\"30%\">" + product.getProductName() + "</td>\n"
                    + "                                                                            <td width=\"20%\">" + product.getColor() + " / " + product.getSize() + "</td>\n"
                    + "                                                                            <td width=\"20%\">" + numberFormat.format((int) ((product.getPrice() - product.getDiscount()))) + "</td>\n"
                    + "                                                                            <td width=\"10%\">" + product.getQuantity() + "</td>\n"
                    + "                                                                            <td width=\"20%\">" + numberFormat.format((int) (((product.getPrice() - product.getDiscount()) * product.getQuantity()))) + "</td>\n"
                    + "                                                                        </tr>\n";
        }

        String orderConfirmMail = firstPart + "                                            <tr><td style=\"border-top:1px solid #000;\" width=\"100%\" colspan=\"5\"></td></tr> <!-- seperator -->\n"
                + "                                                                        <tr> <!-- order total -->\n"
                + "                                                                            <td width=\"80%\" colspan=\"4\"><b>Tổng tiền</b></td>\n"
                + "                                                                            <td width=\"20%\"><b>" + numberFormat.format(total) + "</b></td>\n"
                + "                                                                        </tr>\n"
                + "                                                                    </table>\n"
                + "                                                                    <!-- product end -->\n"
                + "                                                                </td>\n"
                + "                                                            </tr>\n"
                + "                                                        </table>\n"
                + "                                                    </font>\n"
                + "                                                </td>\n"
                + "                                            </tr>\n"
                + "                                        </table>\n"
                + "                                    </td>\n"
                + "                                </tr>\n"
                + "                                <!-- Credits rows-->\n"
                + "                                <tr> \n"
                + "                                    <td style=\"border-top:1px solid #000;\" width=\"100%\">\n"
                + "                                        <p style=\"text-align:center;\">Trân trọng Đội ngũ ELLENA</p>\n"
                + "                                        <p style=\"text-align:center;\">Mọi thắc mắc xin vui lòng liên hệ: <a href=\"mailto:Support@ellenafashion.com\">Support@ellenafashion.com</a></p>\n"
                + "                                    </td>\n"
                + "                                </tr>\n"
                + "                                <tr>\n"
                + "                                    <td><p style=\"text-align:center;\">Copyright © 2022 Ellena Inc., All rights reserved.</p></td>\n"
                + "                                </tr>\n"
                + "                            </table>\n"
                + "                        </td>\n"
                + "                    </tr>\n"
                + "                </table>\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "        <tr></tr>\n"
                + "        <tr></tr>\n"
                + "        <tr></tr>\n"
                + "    </table>\n"
                + "</body>\n"
                + "</html>";

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(myAccountEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
            message.setSubject("ELLENA đã nhận đơn hàng " + orderDetail.getOrderID(), "utf-8");
            message.setContent(orderConfirmMail, "text/html; charset=UTF-8");
            return message;
        } catch (MessagingException ex) {
            Logger.getLogger(JavaMailUtils.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

}
