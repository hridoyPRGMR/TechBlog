package com.tech.blog.servlets;

import com.tech.blog.dao.CommentDao;
import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CommentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {   
            
            int pid=Integer.parseInt(request.getParameter("pid"));
            int uid=Integer.parseInt(request.getParameter("uid"));
            String comment = request.getParameter("comment");

            CommentDao cd=new CommentDao(ConnectionProvider.getConnection());
            
            if(cd.insertComment(pid, uid, comment)){
                out.println("ok");
            }
            
            
        } catch (Exception e) {
            // Handle any exceptions that may occur
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing comment.");
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
        return "CommentServlet";
    }
}