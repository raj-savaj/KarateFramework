package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DbHandler {
    
    private static String connectionUrl = "jdbc:postgresql://192.168.20.22:5432/xchange?currentSchema=management_service";
    private static String userName = "admin";
    private static String passWord = "simon";

    public static JSONObject getCountryCount(){
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionUrl,userName,passWord)){
            ResultSet rs = connect.createStatement().executeQuery("SELECT COUNT(*) as count FROM country");
            rs.next();
            json.put("count", rs.getString("count"));
        } catch (SQLException e){
            e.printStackTrace();
        }
        return json;
    }
}
