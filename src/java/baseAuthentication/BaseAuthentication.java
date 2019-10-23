/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package baseAuthentication;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import DB.DBContext;
import model.Account;

/**
 *
 * @author quoct
 */
public abstract class BaseAuthentication extends HttpServlet {

    private boolean isAuthenticated(HttpServletRequest request) throws ClassNotFoundException {
        HttpSession session = request.getSession();
        Account account = (Account) session.getAttribute("account");
        if (account != null) {
            return true;
        } else {
            Cookie[] cookies = request.getCookies();
            if (cookies == null) {
                return false;
            } else {
                String username = null;
                String password = null;
                for (Cookie cooky : cookies) {
                    if (cooky.getName().equals("username")) {
                        username = cooky.getValue();
                    } else if (cooky.getName().equals("password")) {
                        password = cooky.getValue();
                    }
                    if (username != null && password != null) {
                        break;
                    }
                }
                if (username != null && password != null) {
                    DBContext db = new DBContext();
                    Account a = db.getAccount(username, password);
                    if (a == null) {
                        return false;
                    } else {
                        session.setAttribute("account", a);
                        return true;
                    }
                } else {
                    return false;
                }
            }
        }
    }

    protected abstract void processGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    protected abstract void processPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (isAuthenticated(request)) {
                processGet(request, response);
            } else {
                response.sendRedirect("../login?url=" + request.getServletPath().substring(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        try {
            if (isAuthenticated(request)) {
                processPost(request, response);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BaseAuthentication.class.getName()).log(Level.SEVERE, null, ex);
        }
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
