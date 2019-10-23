/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package TagHandler;

import java.io.IOException;
import java.io.StringWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException; 

import javax.servlet.jsp.JspException; 
import javax.servlet.jsp.JspWriter; 
import javax.servlet.jsp.tagext.TagSupport; 

/**
 *
 * @author quoct
 */
public class PagingTag extends TagSupport {

    private int totalpage;
    private int pageindex;
    private int gap;

    public void setTotalpage(int totalpage) {
        this.totalpage = totalpage;
    }

    public void setPageindex(int pageindex) {
        this.pageindex = pageindex;
    }

    public void setGap(int gap) {
        this.gap = gap;
    }

    StringWriter sw = new StringWriter();

    public static String link(String text, String url) {
        return "<a href=\"" + url + "\">" + text + "</a>";
    }

    public static String label(String text) {
        return "<a href=\"#\" class=\"active\">" + text + "</span>";
    }

    public static String pager(int gap, int pageindex, int totalpage) {
        pageindex = pageindex > totalpage ? totalpage : pageindex;
        String result = "<div class=\"pagination\"> " /*+ pageindex + " over " + totalpage*/;
        result += "<br/>";
        if (pageindex > gap + 1) {
            result += link("&laquo;", "?page=" + (pageindex - gap));
        }
        for (int i = gap; i > 0; i--) {
            int page = pageindex - i;
            if (page > 0) {
                result += link("" + page, "?page=" + page);
            }
        }
        result += label("" + pageindex);
        for (int i = 1; i <= gap; i++) {
            int page = pageindex + i;
            if (page <= totalpage) {
                result += link("" + page, "?page=" + page);
            }
        }

        if (pageindex + gap < totalpage) {
            result += link("&raquo;", "?page=" + (pageindex + gap));
        }
        result += "</div>";
        return result;

    }

    public int doStartTag() throws JspException {
        JspWriter out = pageContext.getOut();
        try {
            out.print(pager(gap, pageindex, totalpage));
        } catch (Exception e) {
// TODO: handle exception 
        }

        return SKIP_BODY;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    public int add(int num1, int num2) {
        return num1 + num2;
    }
}
