package com.blog.dao;
import com.blog.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// this class interacts with the database
public class UserDAO {

    private Connection con;

    //we need connection for this kind of classes.
    public UserDAO(Connection con) {
        this.con = con;
    }

    //Method to insert data into database.
    public boolean saveUser(User user){
        boolean flag = false;
        try{
            //user to database
            String query = "insert into user(name, email, password, gender, about) values(?,?,?,?,?)";
            //store into the PreparedStatement object
            PreparedStatement pstmt =  this.con.prepareStatement(query);
            //set the values of ? inside the query.
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getGender());
            pstmt.setString(5,user.getAbout());
            //now execute
            pstmt.executeUpdate();
            flag=true;
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return flag;

    }

    //get user by user-email and user-password
    public User getUserByEmailAndPassword(String email, String password){
        User user = null;
        try{
            //our query to the database
            String query = "select * from user where email = ? and password = ?";
            //store into this object
            PreparedStatement pstmt = this.con.prepareStatement(query);
            //now set the values of the ?
            pstmt.setString(1,email);
            pstmt.setString(2,password);

            //now execute
            ResultSet set = pstmt.executeQuery();

            //now extract the output from that set
            if(set.next()){
                // created the obj
                user = new User();
                //from db the name
                user.setEmail(set.getString("email"));
                //user id
                user.setId(set.getInt("id"));
                // setting the name
                user.setName(set.getString("name"));
                //user password
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        }catch (Exception e){
            e.printStackTrace();
        }


        return user;
    }

    public boolean updateUser(User user){
         boolean flag = false;
        try{
            String query = "update user set name=?, email=?, password=?, about=?, profile=? where id=?";

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1,user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3,user.getPassword());
            pstmt.setString(4,user.getAbout());
            pstmt.setString(5,user.getProfile());
            pstmt.setInt(6,user.getId());

            pstmt.executeUpdate();
            flag=true;

        }catch (Exception e){
            e.printStackTrace();
        }

        return flag;

    }

    public User getUserByUserId(int userId){
        User user = null;
        try{
            String q = "select * from user where id = ?";
            PreparedStatement pq = this.con.prepareStatement(q);
            pq.setInt(1,userId);

            ResultSet set = pq.executeQuery();

            if(set.next()){
                user = new User();
                user.setEmail(set.getString("email"));
                //user id
                user.setId(set.getInt("id"));
                // setting the name
                user.setName(set.getString("name"));
                //user password
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
        }catch (Exception e){
            e.printStackTrace();
        }

        return user;
    }


}
