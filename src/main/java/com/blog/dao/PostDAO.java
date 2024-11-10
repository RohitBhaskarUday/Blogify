package com.blog.dao;

import com.blog.entities.Category;
import com.blog.entities.Post;

import java.sql.*;
import java.util.ArrayList;

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
}
