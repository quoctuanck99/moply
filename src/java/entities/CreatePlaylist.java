/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author quoct
 */
public class CreatePlaylist extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/entities/createplaylist.jsp").forward(request, response);
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
        String playlistname = request.getParameter("playlistname");
        Account account = (Account) request.getSession().getAttribute("account");
        String messageResult=null;
        DBContext db = null;
        try {
            db = new DBContext();
            if (account == null) {
                messageResult = "Access denied!";
            } else {
                db.createNewPlaylist(playlistname, account.getUsername());
                messageResult="Create playlist successfully!";
                request.setAttribute("url", "playlist");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("message", messageResult);
        request.getRequestDispatcher("/view/result/generalResult.jsp").forward(request, response);
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
