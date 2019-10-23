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
public class Playlist {
    int id;
    String name;
    ArrayList<Song> songsList;

    public ArrayList<Song> getSongsList() {
        return songsList;
    }

    public void setSongList(ArrayList<Song> songList) {
        this.songsList = songList;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Playlist() {
    }

}
