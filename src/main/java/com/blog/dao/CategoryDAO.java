package com.blog.dao;

import com.blog.entities.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CategoryDAO {

    Connection con;

    public CategoryDAO(Connection con) {
        this.con = con;
    }

    public boolean addCategory(Category category) {

        try {
            String  q = "INSERT INTO categories (name, description) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, category.getName());
            ps.setString(2, category.getDescription());

            int row = ps.executeUpdate();
            if (row > 0) {
                return true;
            }


        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return false;
    }
}
