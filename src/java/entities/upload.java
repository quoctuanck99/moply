/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import InputOutputHandler.IOMaster;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Artist;
import model.Category;
import model.Country;
import model.Language;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Account;
import org.apache.jasper.Constants;

/**
 *
 * @author quoct
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50,
        location = "C:\\Users\\quoct\\Documents\\NetBeansProjects\\Moply\\web\\resources\\audios\\songs") // 50MB

public class upload extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public static final String SAVE_DIRECTORY = "";

    public upload() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        DBContext db = null;
        try {
            db = new DBContext();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(upload.class.getName()).log(Level.SEVERE, null, ex);
        }
        ArrayList<Artist> artists = db.getAllArtists();
        ArrayList<Category> cates = db.getAllCategories();
        ArrayList<Country> countries = db.getAllCountries();
        ArrayList<Language> langs = db.getAllLangguages();
        request.setAttribute("cates", cates);
        request.setAttribute("artists", artists);
        request.setAttribute("langs", langs);
        request.setAttribute("countries", countries);
        Account account = (Account) request.getSession().getAttribute("account");
        request.setAttribute("account", account);
        request.getRequestDispatcher("/view/entities/upload.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        try {
            DBContext d = new DBContext();
            IOMaster iomaster = new IOMaster();
            String name = request.getParameter("songname");
//            System.out.println(".............................................." + name + "..............................................");
            int artistid = Integer.parseInt(request.getParameter("artist"));
            int langid = Integer.parseInt(request.getParameter("language"));
            String composer = request.getParameter("composer");
            int countryid = Integer.parseInt(request.getParameter("country"));
            int kindid = Integer.parseInt(request.getParameter("kind"));
            String lyrics = request.getParameter("lyrics");
//            String uploader = ((Account) request.getSession().getAttribute("account")).getUsername();
            ServletContext context = request.getServletContext();
            String path = context.getRealPath("resources/info/songinfo") + "\\" + d.getIdForNewSong() + ".txt";

            iomaster.writeUTF8Text(path, lyrics);
            saveAudioProcess(request, response);

            d.insertNewSong(name, artistid, langid, composer, countryid, kindid, ((Account) request.getSession().getAttribute("account")).getUsername());
            // Upload thành công.
            request.setAttribute("path", "upload");
            request.setAttribute("songid", d.getIdForNewSong() - 1);
            request.setAttribute("message", "Upload successful!");
            request.getRequestDispatcher("/view/result/resultUpload.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error!");
            request.getRequestDispatcher("/view/result/resultUpload.jsp").forward(request, response);
        }
    }

    private void saveAudioProcess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, ClassNotFoundException, SQLException {
        // Đường dẫn tuyệt đối tới thư mục gốc của web app.
        String appPath = request.getServletContext().getRealPath("");
        appPath = appPath.replace('\\', '/');

        String fullSavePath = appPath + "/" + SAVE_DIRECTORY;

        // Danh mục các phần đã upload lên (Có thể là nhiều file).
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            if (fileName != null && fileName.length() > 0) {
                DBContext d = new DBContext();
                fileName = String.valueOf(d.getIdForNewSong()) + ".mp3";
                part.write(fileName);
            }
        }
    }

    private String extractFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            System.out.println(content + " <<<<<<<<<<<<<<<<<<<<<");
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "";
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
