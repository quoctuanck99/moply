/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author quoct
 */
public class Artist implements Serializable {

    int id;
    String name;
    boolean gender;
    Date dob;
    Country country;
    String imgPath;
    String infoPath;
    public void setCountry(Country country) {
        this.country = country;
    }

    public Country getCountry() {
        return country;
    }

    public Artist() {
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public boolean isGender() {
        return gender;
    }

    public Date getDob() {
        return dob;
    }

   

    public String getImgPath() {
        return imgPath;
    }

    public String getInfoPath() {
        return infoPath;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

   

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public void setInfoPath(String infoPath) {
        this.infoPath = infoPath;
    }

    @Override
    public String toString() {
        return "Artist{" + "id=" + id + ", name=" + name + ", gender=" + gender + ", dob=" + dob + ", country=" + country + ", imgPath=" + imgPath + ", infoPath=" + infoPath + '}';
    }

}
