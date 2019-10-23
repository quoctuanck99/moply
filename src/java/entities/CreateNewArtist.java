/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import DB.DBContext;
import InputOutputHandler.IOMaster;
import static entities.upload.SAVE_DIRECTORY;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Account;
import model.Country;

/**
 *
 * @author quoct
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50,
        location = "C:\\Users\\quoct\\Documents\\NetBeansProjects\\Moply\\web\\resources\\img\\artistimg") // 50MB
public class CreateNewArtist extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DBContext db = null;
        try {
            db = new DBContext();
        } catch (Exception e) {
        }
        ArrayList<Country> countries = db.getAllCountries();
        Account account = (Account) request.getSession().getAttribute("account");
        request.setAttribute("account", account);
        request.setAttribute("countries", countries);
        request.getRequestDispatcher("/view/entities/createartist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        DBContext d = null;

        IOMaster iomaster = new IOMaster();
        String name = request.getParameter("artistname");
        boolean gender = ((String) request.getParameter("gender")).equals("1") ? true : false;
        Date dob = Date.valueOf(request.getParameter("dob"));
        int nationality = Integer.parseInt(request.getParameter("nationality"));
        String bio = request.getParameter("bio");

        try {
            d = new DBContext();
            ServletContext context = request.getServletContext();
            String path = context.getRealPath("/resources/info/artistinfo") + "\\" + d.getIdForNewArtist() + ".txt";

            iomaster.writeUTF8Text(path, bio);
            saveImageProcess(request, response);

            d.insertNewArtist(name, gender, dob, nationality);
            request.setAttribute("path", "singers");
            request.setAttribute("artistid", d.getIdForNewArtist() - 1);
            request.setAttribute("message", "Create Artist successful!");
            request.getRequestDispatcher("/view/result/resultUpload.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("message", "Error!");
            request.getRequestDispatcher("/view/result/resultUpload.jsp").forward(request, response);
            e.printStackTrace();
        }

    }

    private void saveImageProcess(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, ClassNotFoundException, SQLException {
        // Đường dẫn tuyệt đối tới thư mục gốc của web app.
        String appPath = request.getServletContext().getRealPath("");
        appPath = appPath.replace('\\', '/');

        String fullSavePath = appPath + "/" + SAVE_DIRECTORY;

        // Danh mục các phần đã upload lên (Có thể là nhiều file).
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            if (fileName != null && fileName.length() > 0) {
                DBContext d = new DBContext();
                fileName = String.valueOf(d.getIdForNewArtist()) + ".jpg";
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
