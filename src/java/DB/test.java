package DB;

import java.sql.SQLException;
import java.util.ArrayList;
import model.*;

/**
 *
 * @author quoct
 */
public class test {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        DBContext db = new DBContext();
        db.deletePlaylist(5);
    }
}
