package com.blog.servlet;

import com.blog.dao.UserDAO;
import com.blog.entities.User;
import com.blog.handler.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@MultipartConfig
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet RegisterServlet</title>");
//            out.println("</head>");
//            out.println("<body>");

            //fetch all form data from the registration form.
            String check = request.getParameter("check");
            String password = request.getParameter("user_password");
            if(check==null|| check.isEmpty()){
                out.println("You have not checked the Terms & Conditions");
            } else if (password==null|| password.isEmpty()) {
                out.println("Please enter the password");

            } else{

                //get all the data from the form over here.
                String name = request.getParameter("user_name");
                String user_email = request.getParameter("user_email");
                //String password = request.getParameter("user_password");
                String gender = request.getParameter("gender");
                String about = request.getParameter("about");

                User userData = new User(name, user_email, password, gender, about, null );
                //now create the UserDAO object to send data into the database and insert all of this.
                UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
                //in order to pass all this data you need to pass the User object
                if(dao.saveUser(userData)){
                    //saved
                    out.println("Registered Successfully!");
                }else{
                    out.println("Something went wrong while adding data");
                }


            }


//            out.println("</body>");
//            out.println("</html>");


        }

    }


}
