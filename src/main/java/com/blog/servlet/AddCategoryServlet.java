package com.blog.servlet;

import com.blog.dao.CategoryDAO;
import com.blog.entities.Category;
import com.blog.entities.User;
import com.blog.handler.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType(("text/html;charset=UTF-8"));
        try(PrintWriter out = resp.getWriter()){

            String categoryName = req.getParameter("categoryName");
            String categoryDesc = req.getParameter("categoryDesc");

            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("currentUser");

            Category newCategory = new Category(categoryName, categoryDesc);

            CategoryDAO dao = new CategoryDAO(ConnectionProvider.getConnection());

            if(dao.addCategory(newCategory)){
                out.println("success");
            }else{
                out.println("error");
            }




        }
    }
}
