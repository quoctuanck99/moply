/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;

/**
 *
 * @author quoct
 */
public class EditPlaylist extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DBContext db =null;
        try {
            db= new DBContext();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditPlaylist.class.getName()).log(Level.SEVERE, null, ex);
        }
        int playlistid=Integer.parseInt(request.getParameter("playlistid"));
        request.setAttribute("playlistid", playlistid);
        Account a = (Account) request.getSession().getAttribute("account");
        try {
            if(db.checkPlaylistPermission(playlistid, a.getUsername())){
                request.getRequestDispatcher("/view/entities/editplaylist.jsp").forward(request, response);
            }else{
                request.getRequestDispatcher("/view/result/resultAccess.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EditPlaylist.class.getName()).log(Level.SEVERE, null, ex);
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
        DBContext db =null;
        Account a = (Account) request.getSession().getAttribute("account");
        try {
            db= new DBContext();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditPlaylist.class.getName()).log(Level.SEVERE, null, ex);
        }
        String playlistname=request.getParameter("playlistname");
        String playlistid=request.getParameter("playlistid");
        try { 
            if(db.checkPlaylistPermission(Integer.parseInt(playlistid), a.getUsername())){
                db.editPlaylist(Integer.parseInt(playlistid), playlistname, a.getUsername());
                response.sendRedirect("playlist");
            }else{
                request.getRequestDispatcher("/view/result/resultAccess.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(EditPlaylist.class.getName()).log(Level.SEVERE, null, ex);
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
