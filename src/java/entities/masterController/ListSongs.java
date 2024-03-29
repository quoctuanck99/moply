/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities.masterController;

import DB.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Artist;
import model.Song;

/**
 *
 * @author quoct
 */
public class ListSongs extends HttpServlet {

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
        DBContext db = null;
        int pagesize = 8;
        try {
            db = new DBContext();
        } catch (Exception e) {
        }
        ArrayList<Song> songs = new ArrayList<>();
        String page = request.getParameter("page");
        try {
            if (page == null || page.equals("")) {
                page = "1";
            }
            int pageindex = Integer.parseInt(page);
            int totalrow = db.getSongsTotalRow();
            int totalpage = (totalrow % pagesize == 0) ? totalrow / pagesize : totalrow / pagesize + 1;
            songs = db.getAllSongs(pageindex, pagesize);
            request.setAttribute("songs", songs);
            request.setAttribute("totalpage", totalpage);
            request.setAttribute("pageindex", pageindex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("view/entities/masterEntities/listsongs.jsp").forward(request, response);
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
