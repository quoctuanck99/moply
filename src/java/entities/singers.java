/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import InputOutputHandler.IOMaster;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Account;
import model.Artist;
import model.Song;

/**
 *
 * @author quoct
 */
public class singers extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DBContext db = null;
        int pagesize = 8;
        try {
            db = new DBContext();
        } catch (Exception e) {
        }
        ArrayList<Artist> artists = new ArrayList<>();
        if (request.getParameter("artistid") == null) {
            String page = request.getParameter("page");
            try {
                if (page == null || page.equals("")) {
                    page = "1";
                }
                int pageindex = Integer.parseInt(page);
                int totalrow = db.getArtistsTotalRow();
                int totalpage = (totalrow % pagesize == 0) ? totalrow / pagesize : totalrow / pagesize + 1;
                artists = db.getArtists(pageindex,pagesize);
                request.setAttribute("totalpage", totalpage);
                request.setAttribute("pageindex", pageindex);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            int artistid = Integer.parseInt(request.getParameter("artistid"));
            Artist a = null;
            try {
                a = db.getArtistById(artistid);
                IOMaster iomaster = new IOMaster();
                ServletContext context = request.getServletContext();
                String path = context.getRealPath(a.getInfoPath());
                String bio = iomaster.readUTF8Text(path);
                ArrayList<Song> allSongOfThisArtist = db.getAllSongOfASinger(artistid);
                request.setAttribute("allSongOfThisArtist", allSongOfThisArtist);
                request.setAttribute("bio", bio);
                request.setAttribute("artist", a);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        Account account = (Account) request.getSession().getAttribute("account");
        request.setAttribute("account", account);
        request.setAttribute("artists", artists);
        request.getRequestDispatcher("/view/entities/singers.jsp").forward(request, response);
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
