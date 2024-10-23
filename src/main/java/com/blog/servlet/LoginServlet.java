package com.blog.servlet;

import com.blog.dao.UserDAO;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.handler.ConnectionProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        try(PrintWriter out = resp.getWriter()){

            //login here
            // fetch the username and details accordingly
            String userEmail = req.getParameter("email");
            String userPassword = req.getParameter("password");

            //after fetching check in the db if the connections exists or not
            UserDAO dao = new UserDAO(ConnectionProvider.getConnection());
            User userValues = dao.getUserByEmailAndPassword(userEmail, userPassword);

            if(userValues!=null){
                //till the browser is not shut the session key would be available.
                HttpSession session = req.getSession();
                //now set the session values
                session.setAttribute("currentUser", userValues);
                resp.sendRedirect("profile.jsp");

            }else{
                //error message
                //out.println("Invalid email or password try again.");

                //we use the message Object to display over the screen.
                Message msg = new Message("Invalid email or password try again.", "error", "alert-danger");
                //we will set the message within the httpsession itself.
                HttpSession session = req.getSession();
                session.setAttribute("msg", msg);

                resp.sendRedirect("loginpage.jsp");

            }


        }
    }
}
