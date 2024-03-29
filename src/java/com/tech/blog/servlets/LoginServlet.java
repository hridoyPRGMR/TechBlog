package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
           //fetch user_name and password from request
           String useremail=request.getParameter("user_email");
           String password=request.getParameter("user_password"); // corrected parameter name
           
           UserDao dao=new UserDao(ConnectionProvider.getConnection());
           
           User u=dao.getUserByEmailAndPassword(useremail, password);
           
           if(u==null){
               Message msg=new Message("Email or Password are incorrect! please try again.","error","alert-danger");
               HttpSession s=request.getSession();
               s.setAttribute("msg", msg);
               
               response.sendRedirect("login.jsp");
               
           }else{
               HttpSession s=request.getSession();
               s.setAttribute("currentUser",u);
               response.sendRedirect("profile.jsp");
           }
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
