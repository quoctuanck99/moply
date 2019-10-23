/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import static java.security.AccessController.getContext;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

/**
 *
 * @author quoct
 */
public class play extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @praam request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        DBContext db = new DBContext();

        Account account = (Account) request.getSession().getAttribute("account");
        String songid = (String) request.getParameter("songid");
        String playlistid = (String) request.getParameter("playlistid");
        Song song = null;
        Playlist playlist=null;
        ArrayList<Song> randomSongs = null;
        String path = null;

        if (songid != null) {//chỉ chơi 1 bài hát
            song = db.getSong(Integer.parseInt(songid));
            request.setAttribute("song", song);
            randomSongs = db.getRandomSongs(Integer.parseInt(songid), 3);
            ServletContext context = request.getServletContext();
            path = context.getRealPath(song.getInforPath());
            request.setAttribute("info", getInfo(path));
        }
        if (playlistid != null) {//chơi 1 playlist
            if (account != null&&db.checkPlaylistPermission(Integer.parseInt(playlistid), account.getUsername())) {
                //nếu đã đăng nhập và playlist đó thuộc về tài khoản đã đăng nhập
                playlist = db.getPlayListById(Integer.parseInt(playlistid), account.getUsername());
                request.setAttribute("playlist", playlist);
                randomSongs = db.getRandomSongs(0, 3);
            }else if(account==null){
                //ngược lại chưa đăng nhập hoặc tài khoản đó ko sở hữu playlist này
                request.setAttribute("message", "Access denied!");
                request.getRequestDispatcher("/view/result/generalResult.jsp").forward(request, response);
            }
        }
        //get Song Info from file
        request.setAttribute("randomSongs", randomSongs);
        request.setAttribute("account", account);
        request.getRequestDispatcher("/view/entities/play.jsp").forward(request, response);
    }

    public ArrayList<String> getInfo(String path) throws FileNotFoundException, IOException {
        ArrayList<String> info = new ArrayList();
        File fileInfo = new File(path);
        FileInputStream fis = new FileInputStream(fileInfo);
        //Construct BufferedReader from InputStreamReader
        Reader reader = new java.io.InputStreamReader(fis, "utf8");
        BufferedReader br = new BufferedReader(reader);
        String line = null;
        while ((line = br.readLine()) != null) {
            info.add(line);
        }
        br.close();
        return info;
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(play.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(play.class.getName()).log(Level.SEVERE, null, ex);
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
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(play.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(play.class.getName()).log(Level.SEVERE, null, ex);
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
