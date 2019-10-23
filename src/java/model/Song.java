/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;

/**
 *
 * @author quoct
 */
public class Song implements Serializable {
    String songid;
    String composer;
    String trackPath;
    String imgPath;
    String inforPath;
    String uploader;
    String name;
    int kindid;
    String artistname;
    int artistid;

    public void setKindid(int kindid) {
        this.kindid = kindid;
    }

    public int getKindid() {
        return kindid;
    }
    

    public String getSongid() {
        return songid;
    }

    public void setSongid(String songid) {
        this.songid = songid;
    }

    public void setArtistid(int artistid) {
        this.artistid = artistid;
    }

    public int getArtistid() {
        return artistid;
    }

    public void setUploader(String uploader) {
        this.uploader = uploader;
    }

    public String getUploader() {
        return uploader;
    }

    public Song() {
    }

    public String getName() {
        return name;
    }

    public String getArtistname() {
        return artistname;
    }

    public String getComposer() {
        return composer;
    }

    public String getTrackPath() {
        return trackPath;
    }

    public String getImgPath() {
        return imgPath;
    }

    public String getInforPath() {
        return inforPath;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setArtistname(String artistname) {
        this.artistname = artistname;
    }

    public void setComposer(String composer) {
        this.composer = composer;
    }

    public void setTrackPath(String trackPath) {
        this.trackPath = trackPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public void setInforPath(String inforPath) {
        this.inforPath = inforPath;
    }

    @Override
    public String toString() {
        return "Song{" + "name=" + name + ", artistname=" + artistname + ", composer=" + composer + ", trackPath=" + trackPath + ", imgPath=" + imgPath + ", inforPath=" + inforPath + '}';
    }

}
