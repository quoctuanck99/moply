/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DB;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Random;
import model.Account;
import model.Artist;
import model.Category;
import model.Country;
import model.Language;
import model.Playlist;
import model.Role;
import model.SearchObject;
import model.Song;

/**
 *
 * @author quoct
 */
public class DBContext {

    Connection connection;
    Random r = new Random();

    public DBContext() throws ClassNotFoundException {
        try {
            String username = "sa";
            String password = "sa";
            String url = "jdbc:sqlserver://localhost:1433;databaseName=moply";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Song getSong(int songid) {
        Song s = new Song();
        String sql = "SELECT        dbo.song.name, dbo.songresource.trackPath, dbo.song.composer,dbo.artist.artistid, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "FROM            dbo.artist INNER JOIN\n"
                + "                         dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + "                         dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "                         dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "WHERE        (dbo.song.songid = ?)\n";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            st.setInt(1, songid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setUploader(rs.getString("uploader"));
                s.setArtistid(rs.getInt("artistid"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public ArrayList<Song> getAllSongs() {
        ArrayList songs = new ArrayList();
        String sql = "SELECT       dbo.song.songid,dbo.song.kindid,  dbo.song.name, dbo.songresource.trackPath, dbo.song.composer, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "FROM            dbo.artist INNER JOIN\n"
                + "                         dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + "                         dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "                         dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "WHERE        (dbo.song.songid = dbo.songresource.songid)";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                s.setKindid(rs.getInt("kindid"));
                songs.add(s);
            }
        } catch (Exception e) {
        }
        return songs;
    }

    public ArrayList<Song> getSongsByKind(int id) {
        ArrayList songs = new ArrayList();
        String sql = "SELECT       dbo.song.songid,dbo.song.kindid,  dbo.song.name, dbo.songresource.trackPath, dbo.song.composer, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "FROM            dbo.artist INNER JOIN\n"
                + "                         dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + "                         dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "                         dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "WHERE        (dbo.song.songid = dbo.songresource.songid) and dbo.song.kindid=?";
        PreparedStatement st = null;
        try {
            st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                s.setKindid(rs.getInt("kindid"));
                songs.add(s);
            }
        } catch (Exception e) {
        }
        return songs;
    }

    public Category getKindById(int id) throws SQLException {
        String sql = "select * from kind where kindid=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("kindid"));
                c.setName(rs.getString("kindname"));
                return c;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<SearchObject> search(String searchText) throws SQLException {
        ArrayList<Song> songs = new ArrayList();
        ArrayList<Artist> artists = new ArrayList();
        ArrayList<SearchObject> results = new ArrayList<>();
        /////Search Songs
        String sql = "DECLARE @query NVARCHAR(max)\n"
                + "SELECT @query =  [dbo].[non_unicode_convert](?)\n"
                + "SELECT song.songid,  song.name, songresource.trackPath, song.composer, artist.name AS singer, artistresource.imgPath, songresource.inforPath, song.uploader \n"
                + "FROM (artist INNER JOIN\n"
                + "artistresource ON artist.artistid = artistresource.artistid INNER JOIN\n"
                + "song ON artist.artistid = song.artistid INNER JOIN\n"
                + "songresource ON song.songid = songresource.songid)\n"
                + "WHERE (song.songid = songresource.songid) and  [dbo].[non_unicode_convert](song.name) LIKE  '%' + @query+ '%'";
        PreparedStatement st = null;
        st = connection.prepareStatement(sql);
        st.setNString(1, searchText);
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                songs.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        ///////////////////search Artists
        String sql2 = "DECLARE @query NVARCHAR(max)\n"
                + "SELECT @query =  [dbo].[non_unicode_convert](?)\n"
                + "select a.artistid,a.name,a.gender,a.dob,a.nationality,country.name,ats.imgPath, ats.inforPath \n"
                + "from artist a, artistresource ats,country\n"
                + "where a.artistid=ats.artistid and a.nationality=country.countryid and  [dbo].[non_unicode_convert](a.name) LIKE  '%' + @query+ '%'";
        st = connection.prepareStatement(sql2);
        st.setNString(1, searchText);
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Artist a = new Artist();
                a.setId(rs.getInt(1));
                a.setName(rs.getString(2));
                a.setGender(rs.getBoolean(3));
                a.setDob(rs.getDate(4));
                Country c = new Country();
                c.setId(rs.getInt(5));
                c.setName(rs.getString(6));
                a.setCountry(c);
                a.setImgPath(rs.getString(7));
                a.setInfoPath(rs.getString(8));
                artists.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        SearchObject s = new SearchObject();
        SearchObject a = new SearchObject();
        s.setKind("songs");
        s.setSearchResult(songs);
        a.setKind("artists");
        a.setSearchResult(artists);
        results.add(s);
        results.add(a);
        return results;
    }

    public Account getAccount(String username, String password) {
        String sql = "select a.username,a.password,ro.roleid,ro.rolename\n"
                + "from account a, role_account ra, Role ro\n"
                + "where a.username=? and a.password=?\n"
                + "and a.username=ra.username\n"
                + "and ro.roleid=ra.roleid";
        PreparedStatement statement;
        try {
            statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                Role role = new Role();
                role.setId(rs.getInt("roleid"));
                role.setName(rs.getString("rolename"));
                a.setRole(role);
                return a;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<Artist> getAllArtists() {
        ArrayList<Artist> artists = new ArrayList();
        String sql = "select a.artistid, a.name, a.dob, a.gender, c.countryid ,c.name as countryname, ats.imgPath, ats.inforPath\n"
                + "from artist a,country c,artistresource ats\n"
                + "where a.artistid=ats.artistid and a.nationality=c.countryid";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Artist a = new Artist();
                a.setId(rs.getInt("artistid"));
                a.setName(rs.getString("name"));
                a.setGender(rs.getBoolean("gender"));
                a.setDob(rs.getDate("dob"));
                Country c = new Country();
                c.setId(rs.getInt("countryid"));
                c.setName(rs.getString("countryname"));
                a.setCountry(c);
                a.setImgPath(rs.getString("imgPath"));
                a.setInfoPath(rs.getString("inforPath"));
                artists.add(a);
            }
        } catch (Exception e) {
        }
        return artists;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> cates = new ArrayList();
        String sql = "select * from kind";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("kindid"));
                c.setName(rs.getString("kindname"));
                cates.add(c);
            }
        } catch (Exception e) {
        }
        return cates;
    }

    public int getMaxCateId() throws SQLException {
        String sql = "select max(kindid) as maxid from kind";

        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("maxid");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public ArrayList<Category> getRandomCategories(int quantity) throws SQLException {
        ArrayList<Category> cates = new ArrayList<>();
        int[] indexes = new int[quantity];
        int max = getMaxCateId();
        for (int i = 0; i < quantity; i++) {
            int temp = r.nextInt(max);
            while (!checkDupId(indexes, temp)) {
                temp = r.nextInt(max);
            }
            indexes[i] = temp;
        }
        String sql = "select * from kind where (";
        for (int i = 0; i < indexes.length; i++) {
            if (i == 0) {
                sql += " kindid=" + indexes[i];
            } else if (i == indexes.length - 1) {
                sql += " or kindid=" + indexes[i] + ")";
            } else {
                sql += " or kindid=" + indexes[i];
            }
        }
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("kindid"));
                c.setName(rs.getString("kindname"));
                cates.add(c);
            }
        } catch (Exception e) {
        }
        return cates;
    }

    public ArrayList<Country> getAllCountries() {
        ArrayList<Country> countries = new ArrayList();
        String sql = "select * from country";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Country c = new Country();
                c.setId(rs.getInt("countryid"));
                c.setName(rs.getString("name"));
                countries.add(c);
            }
        } catch (Exception e) {
        }
        return countries;
    }

    public ArrayList<Language> getAllLangguages() {
        ArrayList<Language> languages = new ArrayList();
        String sql = "select * from language";
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Language c = new Language();
                c.setId(rs.getInt("langid"));
                c.setLanguage(rs.getString("langname"));
                languages.add(c);
            }
        } catch (Exception e) {
        }
        return languages;
    }

    public Artist getArtistById(int artistid) throws SQLException {
        Artist a = new Artist();
        String sql = "select a.artistid,a.name,a.gender,a.dob,a.nationality,country.name,ats.imgPath, ats.inforPath \n"
                + "from artist a, artistresource ats,country\n"
                + "where a.artistid=ats.artistid and a.artistid=? and a.nationality=country.countryid";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, artistid);
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                a.setId(rs.getInt(1));
                a.setName(rs.getString(2));
                a.setGender(rs.getBoolean(3));
                a.setDob(rs.getDate(4));
                Country c = new Country();
                c.setId(rs.getInt(5));
                c.setName(rs.getString(6));
                a.setCountry(c);
                a.setImgPath(rs.getString(7));
                a.setInfoPath(rs.getString(8));
            }
        } catch (Exception e) {
        }

        return a;
    }

    public int getIdForNewSong() throws SQLException {
        String sql = "select max(songid) as maxid from song";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        int result = 0;
        while (rs.next()) {
            result = rs.getInt("maxid") + 1;
        }
        return result;
    }

    public int getIdForNewArtist() throws SQLException {
        String sql = "select max(artistid) as maxid from artist";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        int result = 0;
        while (rs.next()) {
            result = rs.getInt("maxid") + 1;
        }
        return result;
    }

    public ArrayList<Song> getAllSongOfASinger(int id) throws SQLException {
        ArrayList<Song> songs = new ArrayList();
        String sql = "SELECT       dbo.song.songid,  dbo.song.name, dbo.songresource.trackPath, dbo.song.composer, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "              FROM            dbo.artist INNER JOIN\n"
                + "               dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + "                dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "               dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "                WHERE        (dbo.song.songid = dbo.songresource.songid) and dbo.artist.artistid=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                songs.add(s);
            }
        } catch (Exception e) {
        }
        return songs;
    }

    public ArrayList<Song> getRandomSongs(int songid, int quantity) throws SQLException {
        ArrayList<Song> songs = new ArrayList<>();
        int[] indexes = new int[quantity];
        for (int i = 0; i < quantity; i++) {
            int temp = r.nextInt(getIdForNewSong() - 1);
            while (!checkDupId(indexes, temp) || (temp == songid && songid != -1)) {
                temp = r.nextInt(getIdForNewSong() - 1);
            }
            indexes[i] = temp;
        }
        String sql = "	SELECT dbo.song.songid,  dbo.song.name, dbo.songresource.trackPath, dbo.song.composer, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "  FROM dbo.artist INNER JOIN\n"
                + "  dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + "  dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "  dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "  WHERE (dbo.song.songid = dbo.songresource.songid) and (";
        for (int i = 0; i < indexes.length; i++) {
            if (i == 0) {
                sql += "song.songid=" + indexes[i];
            } else if (i == quantity - 1) {
                sql += " or song.songid=" + indexes[i] + ")";
            } else {
                sql += " or song.songid=" + indexes[i];
            }
        }
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                songs.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return songs;
    }

    public ArrayList<Artist> getRandomArtists() throws SQLException {
        ArrayList<Artist> artists = new ArrayList<>();
        int[] indexes = new int[8];
        for (int i = 0; i < 8; i++) {
            int temp = r.nextInt(getIdForNewArtist() - 1);
            while (!checkDupId(indexes, temp)) {
                temp = r.nextInt(getIdForNewArtist() - 1);
            }
            indexes[i] = temp;
        }
        String sql = "select a.artistid,a.name,a.gender,a.dob,a.nationality as countryid,country.name as countryname,ats.imgPath, ats.inforPath \n"
                + "from artist a, artistresource ats,country\n"
                + "where a.artistid=ats.artistid and a.nationality=country.countryid \n and (";
        for (int i = 0; i < indexes.length; i++) {
            if (i == 0) {
                sql += " ats.artistid=" + indexes[i];
            } else if (i == 7) {
                sql += " or ats.artistid=" + indexes[i] + ")";
            } else {
                sql += " or ats.artistid=" + indexes[i];
            }
        }
        PreparedStatement st;
        try {
            st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Artist a = new Artist();
                a.setId(rs.getInt("artistid"));
                a.setName(rs.getString("name"));
                a.setGender(rs.getBoolean("gender"));
                a.setDob(rs.getDate("dob"));
                Country c = new Country();
                c.setId(rs.getInt("countryid"));
                c.setName(rs.getString("countryname"));
                a.setCountry(c);
                a.setImgPath(rs.getString("imgPath"));
                a.setInfoPath(rs.getString("inforPath"));
                artists.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return artists;
    }

    public void insertNewSong(String name, int artistid, int langid, String composer, int countryid, int kindid, String uploader) throws SQLException {
        int songid = getIdForNewSong();
        String sql = "insert into song(songid,name,artistid,langid,composer,countryid,kindid,uploader)\n"
                + "values(" + songid + ",?,?,?,?,?,?,?)";
        String sql2 = "insert into songresource(songid,trackPath,inforPath)\n"
                + "values(?,?,?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, name);
        st.setInt(2, artistid);
        st.setInt(3, langid);
        st.setString(4, composer);
        st.setInt(5, countryid);
        st.setInt(6, kindid);
        st.setString(7, uploader);
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        st = connection.prepareStatement(sql2);
        st.setInt(1, songid);
        System.out.println("......................" + songid);
        st.setString(2, "resources/audios/songs/" + songid + ".mp3");
        st.setString(3, "resources/info/songinfo/" + songid + ".txt");
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void insertNewArtist(String name, boolean gender, Date dob, int nationality) throws SQLException {
        int artistid = getIdForNewArtist();
        String sql = "insert into artist(artistid,name,gender,dob,nationality)\n"
                + "values(" + artistid + ",?,?,?,?)";
        String sql2 = "insert into artistresource(artistid,imgPath,inforPath)\n"
                + "values(?,?,?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setString(1, name);
        st.setBoolean(2, gender);
        st.setDate(3, dob);
        st.setInt(4, nationality);
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        st = connection.prepareStatement(sql2);
        st.setInt(1, artistid);
        st.setString(2, "resources/img/artistimg/" + artistid + ".jpg");
        st.setString(3, "resources/info/artistinfo/" + artistid + ".txt");
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //////////////////
    public boolean checkDupId(int[] a, int indexes) {
        for (int i = 0; i < a.length; i++) {
            if (a[i] == indexes) {
                return false;
            }
        }
        return true;
    }

    public ArrayList<Artist> getArtists(int pageindex, int pagesize) throws SQLException {
        ArrayList<Artist> artists = new ArrayList();
        String sql = "SELECT \n"
                + "artistid, name, dob, gender, countryid ,name as countryname, imgPath, inforPath\n"
                + "FROM\n"
                + "(SELECT ROW_NUMBER() OVER (Order by a.artistid asc) \n"
                + "as rownum,a.artistid, a.name, a.dob, a.gender, c.countryid ,c.name as countryname, ats.imgPath, ats.inforPath\n"
                + "FROM  artist a,country c,artistresource ats\n"
                + "where a.artistid=ats.artistid and a.nationality=c.countryid) tblHuman \n"
                + "WHERE rownum >= ((?- 1)*? +1)  AND rownum <= ? * ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, pageindex);
        st.setInt(2, pagesize);
        st.setInt(3, pageindex);
        st.setInt(4, pagesize);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Artist a = new Artist();
                a.setId(rs.getInt("artistid"));
                a.setName(rs.getString("name"));
                a.setGender(rs.getBoolean("gender"));
                a.setDob(rs.getDate("dob"));
                Country c = new Country();
                c.setId(rs.getInt("countryid"));
                c.setName(rs.getString("countryname"));
                a.setCountry(c);
                a.setImgPath(rs.getString("imgPath"));
                a.setInfoPath(rs.getString("inforPath"));
                artists.add(a);
            }
        } catch (Exception e) {
        }
        return artists;
    }

    public ArrayList<Song> getAllSongs(int pageindex, int pagesize) throws SQLException {
        ArrayList<Song> songs = new ArrayList<>();
        String sql = "SELECT \n"
                + "songid,kindid, name, trackPath, composer, singer, imgPath, inforPath, uploader\n"
                + "FROM\n"
                + "(SELECT ROW_NUMBER() OVER (Order by song.songid asc) \n"
                + "as rownum,dbo.song.songid,dbo.song.kindid,  dbo.song.name, dbo.songresource.trackPath, dbo.song.composer, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader\n"
                + "from dbo.artist INNER JOIN\n"
                + "dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid INNER JOIN\n"
                + " dbo.song ON dbo.artist.artistid = dbo.song.artistid INNER JOIN\n"
                + "dbo.songresource ON dbo.song.songid = dbo.songresource.songid\n"
                + "WHERE (dbo.song.songid = dbo.songresource.songid)) tbl\n"
                + "WHERE rownum >= ((?- 1)*? +1)  AND rownum <= ? * ?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setInt(1, pageindex);
        st.setInt(2, pagesize);
        st.setInt(3, pageindex);
        st.setInt(4, pagesize);

        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                s.setKindid(rs.getInt("kindid"));
                songs.add(s);
            }
        } catch (Exception e) {
        }
        return songs;
    }

    public int getArtistsTotalRow() throws SQLException {
        String sql = "select count(*) as totalrows from artist";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("totalrows");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    public int getSongsTotalRow() throws SQLException {
        String sql = "select count(*) as totalrows from song";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("totalrows");
            }
        } catch (Exception e) {
        }
        return 0;
    }

    /////////////////////
    public ArrayList<Playlist> getAllPlaylistsOfAnUser(String username) throws SQLException {
        ArrayList<Playlist> ps = new ArrayList<>();
        String sql = "select * from playlist\n"
                + "where username=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setString(1, username);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Playlist p = new Playlist();
                p.setId(rs.getInt("playlistid"));
                p.setName(rs.getString("playlistname"));
                ps.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ps;
    }

    public Playlist getPlayListById(int id, String username) throws SQLException {
        Playlist playlist = new Playlist();
        ArrayList<Song> songs = new ArrayList<>();
        String sql = "SELECT        dbo.playlist.playlistname,dbo.song.songid, dbo.song.name, dbo.songresource.trackPath, dbo.song.composer,dbo.artist.artistid, dbo.artist.name AS singer, dbo.artistresource.imgPath, dbo.songresource.inforPath, dbo.song.uploader \n"
                + "FROM dbo.artist INNER JOIN \n"
                + "dbo.artistresource ON dbo.artist.artistid = dbo.artistresource.artistid \n"
                + "INNER JOIN \n"
                + "dbo.song ON dbo.artist.artistid = dbo.song.artistid \n"
                + "INNER JOIN \n"
                + "dbo.songresource ON dbo.song.songid = dbo.songresource.songid \n"
                + "INNER JOIN \n"
                + "dbo.playlist_song on dbo.song.songid=dbo.playlist_song.songid\n"
                + "INNER JOIN \n"
                + "dbo.playlist on dbo.playlist.playlistid=dbo.playlist_song.playlistid\n"
                + "WHERE        \n"
                + "dbo.playlist_song.playlistid=? and dbo.playlist.username=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setInt(1, id);
        st.setString(2, username);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Song s = new Song();
                s.setSongid(rs.getString("songid"));
                s.setName(rs.getString("name"));
                s.setComposer(rs.getString("composer"));
                s.setArtistname(rs.getString("singer"));
                s.setImgPath(rs.getString("imgPath"));
                s.setInforPath(rs.getString("inforPath"));
                s.setTrackPath(rs.getString("trackPath"));
                s.setUploader(rs.getString("uploader"));
                if (playlist.getName() == null) {
                    playlist.setName(rs.getString("playlistname"));
                }
                songs.add(s);
            }
            playlist.setId(id);
            playlist.setSongList(songs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return playlist;
    }

    public void insertSongToPlaylist(int playlistid, int songid) throws SQLException {
        String sql = "insert into playlist_song\n"
                + "values(?,?)";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setInt(1, playlistid);
        st.setInt(2, songid);
        /*here*/
        try {
            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public boolean checkSongIsInPlaylist(int songid, int playlistid, String username) throws SQLException {
        String sql = "select * from \n"
                + "playlist,playlist_song \n"
                + "where playlist.playlistid=playlist_song.playlistid\n"
                + "and playlist_song.songid=?\n"
                + "and playlist_song.playlistid=?\n"
                + "and username=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setInt(1, songid);
        st.setInt(2, playlistid);
        st.setString(3, username);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public boolean checkPlaylistPermission(int playlistid, String username) throws SQLException {
        String sql = "select * from playlist\n"
                + "where username = ? and playlistid=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setString(1, username);
        st.setInt(2, playlistid);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public boolean checkPlaylistExceedTheLimit(int playlistid) throws SQLException {
        String sql = "select count(songid) as num\n"
                + "from playlist_song \n"
                + "where playlistid=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setInt(1, playlistid);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return rs.getInt("num") < 10 ? true : false;
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void createNewPlaylist(String name, String username) throws SQLException {
        String sql = "declare @maxid int \n"
                + "set @maxid=\n"
                + "(select count(playlistid) as s from playlist) \n"
                + " print(@maxid)\n"
                + " insert into playlist(playlistid,playlistname,username)\n"
                + " values(@maxid+1,?,?)";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setString(1, name);
        st.setString(2, username);
        /*here*/
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePlaylist(int playlistid) throws SQLException {
        String sql = "delete from playlist_song where playlistid=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, playlistid);
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        sql = "delete from playlist where playlistid=?";
        st = connection.prepareStatement(sql);
        st.setInt(1, playlistid);
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void editPlaylist(int playlistid, String name, String username) throws SQLException {
        String sql = "update playlist\n"
                + "set playlistname=? \n"
                + "where playlistid=? and username=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setString(1, name);
        st.setInt(2, playlistid);
        st.setString(3, username);
        /*here*/
        try {
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean checkPermission(String username, String servletpath) throws SQLException {
        String sql = "select ra.username\n"
                + "from role_account ra, role_feature rf\n"
                + "where username=?\n"
                + "and ra.roleid=rf.roleid \n"
                + "and rf.servletpath=?";
        PreparedStatement st = connection.prepareStatement(sql);
        //set somethings???
        st.setString(1, username);
        st.setString(2, servletpath);
        /*here*/
        try {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (Exception e) {
        }
        return false;
    }
}


///////////////////
