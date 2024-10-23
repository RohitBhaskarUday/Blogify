package com.blog.handler;
import java.sql.*;
public class ConnectionProvider {

    private static Connection con; //by default static values are null
    public static Connection getConnection() {

        try{

            if(con==null){
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blogapplication","root","Bhaskar@$123");

            }

        }catch (ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

        return con;
    }
}
