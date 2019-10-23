/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author quoct
 */
public class SearchObject {
    String kind;
    ArrayList searchResult=new ArrayList();

    public SearchObject() {
    }

    public String getKind() {
        return kind;
    }

    public ArrayList getSearchResult() {
        return searchResult;
    }

    public void setKind(String kind) {
        this.kind = kind;
    }

    public void setSearchResult(ArrayList searchResult) {
        this.searchResult = searchResult;
    }

}
