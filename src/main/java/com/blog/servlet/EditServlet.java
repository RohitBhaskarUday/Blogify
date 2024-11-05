package com.blog.servlet;

import com.blog.dao.UserDAO;
import com.blog.entities.Message;
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
import java.sql.Connection;

@MultipartConfig // this just denotes that the servlet gets multimedia like audio, video images and text
@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        try(PrintWriter out = resp.getWriter()){

            //fetch the data from the edited profile.jsp
            String id = req.getParameter("id");
            String userName = req.getParameter("user_name");
            String userEmail = req.getParameter("user_email");
            String userPassword = req.getParameter("user_password");
            String userAbout = req.getParameter("user_about");
            //for profile pic
            Part filePart = req.getPart("image");
            // this will get the name of the image.
            String imageName = filePart.getSubmittedFileName();

            //get the user from the session
            HttpSession session = req.getSession();
            User user =(User) session.getAttribute("currentUser");

            //Now change the details inside the user object
            user.setName(userName);
            user.setEmail(userEmail);
            user.setPassword(userPassword);
            user.setAbout(userAbout);

            String oldFile = user.getProfile();
            user.setProfile(imageName);

            //now we have to update in database so let's create the db connection
            UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
            boolean result =dao.updateUser(user);

            if(result){

                //this felt too much
                String path = req.getServletContext().getRealPath("/") + "pictures"+ File.separator + user.getProfile();

                String oldPathFile = req.getServletContext().getRealPath("/") + "pictures"+ File.separator + oldFile;

                if(!oldFile.equals("default.png")){
                    Handler.deleteFile(oldPathFile);
                }


                if(Handler.saveFile(filePart.getInputStream(), path) ){
                    out.println("updated.");
                    //we use the message Object to display over the screen.
                    Message msg = new Message("Profile has been updated. ", "success", "alert-success");
                    //we will set the message within the httpsession itself.
                    session.setAttribute("msg", msg);
                }else{

                    //we use the message Object to display over the screen.
                    Message msg = new Message("FYI! Image not updated ", "error", "alert-danger");
                    //we will set the message within the httpsession itself.
                    session.setAttribute("msg", msg);

                }
            }else{
                //we use the message Object to display over the screen.
                Message msg = new Message("Something went wrong! ", "error", "alert-danger");
                //we will set the message within the httpsession itself.
                session.setAttribute("msg", msg);

            }

            resp.sendRedirect("profile.jsp");


        }

    }
}
