package com.blog.servlet;


import com.blog.dao.PostDAO;
import com.blog.entities.Post;
import com.blog.entities.User;
import com.blog.handler.ConnectionProvider;
import com.blog.handler.Handler;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet("/AddPostServlet")
public class AddPostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType(("text/html;charset=UTF-8"));
        try(PrintWriter out = resp.getWriter()){
            //here we fetch the data from the form in the user input


            int cid = Integer.parseInt(req.getParameter("cid"));
            String pTitle = req.getParameter("pTitle");
            String pContent = req.getParameter("pContent");
            String pCode = req.getParameter("pCode");
            Part file = req.getPart("pic");
            String picName = file.getSubmittedFileName();
            String pDate = req.getParameter("pDate");


            //getting to extract the current user ID
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("currentUser");



            //now lets post this to our database first/
            Post post = new Post(pTitle, pContent, pCode, picName, null, cid, user.getId() );
            //we have all the data in the above space which we have to save them.


            //now we will create the post dao to save the values
            PostDAO dao = new PostDAO(ConnectionProvider.getConnection());

            if(dao.savePost(post)){
                    out.println("done.");
                    String path = req.getServletContext().getRealPath("/") + "blog-images"+ File.separator + picName;
                    Handler.saveFile(file.getInputStream(), path);
            }else {
                out.println("failed.");
            }







        }
    }
}
