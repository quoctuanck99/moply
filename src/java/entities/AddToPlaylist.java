/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

/**
 *
 * @author quoct
 */
public class AddToPlaylist extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DBContext db = null;
        ArrayList<Playlist> playlists = null;
        Song song = null;
        Account account = (Account) request.getSession().getAttribute("account");
        try {
            db = new DBContext();
            playlists = db.getAllPlaylistsOfAnUser(account.getUsername());
            String songid = request.getParameter("songid");
            song = db.getSong(Integer.parseInt(songid));
            request.setAttribute("playlists", playlists);
            request.setAttribute("song", song);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("/view/entities/addplaylist.jsp").forward(request, response);
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
        DBContext db = null;
        int songid = Integer.parseInt(request.getParameter("songid"));
        int playlistid = Integer.parseInt(request.getParameter("playlistid"));
        Account account = (Account) request.getSession().getAttribute("account");
        try {
            db = new DBContext();
            if (!db.checkPlaylistExceedTheLimit(playlistid)) {
                request.setAttribute("message", "Sorry this playlist has exceeded the limitation!");
                request.getRequestDispatcher("/view/result/generalResult.jsp").forward(request, response);
            } else if (db.checkSongIsInPlaylist(songid, playlistid, account.getUsername())) {
                request.setAttribute("message", "This song has already existed in this playlist!");
                request.setAttribute("url", "playlist");
                request.getRequestDispatcher("/view/result/generalResult.jsp").forward(request, response);
            } else {
                db.insertSongToPlaylist(playlistid, songid);
                response.sendRedirect("play?playlistid=" + playlistid);
            }
        } catch (Exception e) {
            e.printStackTrace();
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
