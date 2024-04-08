package com.tech.blog.servlets;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class LikeServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String operation=request.getParameter("operation");
            int uid=Integer.parseInt(request.getParameter("uid"));
            int pid=Integer.parseInt(request.getParameter("pid"));  
            
            LikeDao ld=new LikeDao(ConnectionProvider.getConnection());
            
            if(operation.equals("like")){
                if(ld.insertLike(pid, uid)){
                    out.println("ok");
                }
            }
            
            if(operation.equals("unlike")){
                if(ld.unlikePost(pid, uid)){
                    out.println("ok");
                }
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
