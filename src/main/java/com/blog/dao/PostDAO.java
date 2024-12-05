package com.blog.dao;

import com.blog.entities.Category;
import com.blog.entities.Post;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

    Connection con;

    public PostDAO(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            String query = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(query);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category category = new Category(cid, name, description);
                categories.add(category);
            }

        }catch (Exception e) {
            e.printStackTrace();
        }



        return categories;
    }

    public boolean savePost(Post post){
        boolean flag = false;
        try {
            String query = "insert into posts(pTitle, pContent, pCode, pPic, catId, userId) values(?,?,?,?,?,?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, post.getpTitle());
            ps.setString(2, post.getpContent());
            ps.setString(3, post.getpCode());
            ps.setString(4, post.getpPicture());
            ps.setInt(5, post.getCatId());
            ps.setInt(6, post.getUserId());
            ps.executeUpdate();
            flag = true;


        }catch (Exception e) {
            e.printStackTrace();
        }


        return flag;
    }

    public List<Post> getAllPost(){
        List<Post> pList = new ArrayList<>();
        //fetch all the posts from here
        try{

            PreparedStatement p = con.prepareStatement("select * from posts order by pid desc ");
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPicture = rs.getString("pPic");
                Timestamp date = rs.getTimestamp("pDate");
                int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPicture, date, catId, userId);

                //add all these elements to the list
                pList.add(post);


            }

        }catch (Exception e) {
            e.printStackTrace();
        }
        return pList;
    }

    public List<Post> getPostByCatId(int catId){
        List<Post> id = new ArrayList<>();

        try{

            PreparedStatement p = con.prepareStatement("select * from posts where catId=?");
            p.setInt(1, catId);
            ResultSet rs = p.executeQuery();
            while (rs.next()) {
                int pid = rs.getInt("pid");
                String pTitle = rs.getString("pTitle");
                String pContent = rs.getString("pContent");
                String pCode = rs.getString("pCode");
                String pPicture = rs.getString("pPic");
                Timestamp date = rs.getTimestamp("pDate");
                //int catId = rs.getInt("catId");
                int userId = rs.getInt("userId");
                Post post = new Post(pid, pTitle, pContent, pCode, pPicture, date, catId, userId);

                //add all these elements to the list
                id.add(post);


            }

        }catch (Exception e) {
            e.printStackTrace();
        }

        return id;

    }
}
