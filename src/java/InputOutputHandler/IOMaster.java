/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package InputOutputHandler;

/**
 *
 * @author quoct
 */
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

/**
 *
 * @author Thanh Nhan <JackV at congdongjava.com>
 */
public class IOMaster {

    public IOMaster() {
    }

    public String readUTF8Text(String file) throws FileNotFoundException, UnsupportedEncodingException, IOException {
        FileInputStream fi = new FileInputStream(file);
        InputStreamReader isr = new InputStreamReader(fi, "utf-8");
        BufferedReader br = new BufferedReader(isr);
        String sR = "", sNewLine;

        while ((sNewLine = br.readLine()) != null) {
            sR += sNewLine + "\n";
        }
        fi.close();
        return sR;
    }

    public void writeUTF8Text(String file, String text) throws FileNotFoundException, UnsupportedEncodingException, IOException {
        writeUTF8Text(file, text, false);
    }

    public void writeUTF8Text(String file, String text, boolean append) throws FileNotFoundException, UnsupportedEncodingException, IOException {
        FileOutputStream fo = new FileOutputStream(file, append);
        OutputStreamWriter osw = new OutputStreamWriter(fo, "utf-8");
        osw.write(text);
        osw.flush();
        fo.close();
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

}
