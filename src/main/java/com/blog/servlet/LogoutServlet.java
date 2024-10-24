package com.blog.servlet;

import com.blog.entities.Message;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        try(PrintWriter out = resp.getWriter()){



            HttpSession session = req.getSession();
            session.removeAttribute("currentUser");

            Message message = new Message("Logged out Successfully!", "success", "alert-success");
            session.setAttribute("msg", message);
            resp.sendRedirect("loginpage.jsp");


        }
    }
}
