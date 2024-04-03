package com.tech.blog.servlets;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Posts;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            int cid=Integer.parseInt(request.getParameter("cid"));
            String pTitle=request.getParameter("postTitle");
            String pContent=request.getParameter("postContent");
            String pCode=request.getParameter("postCode");
            Part part=request.getPart("pic");
            //getting currentuser id
            HttpSession session=request.getSession();
            User user=(User)session.getAttribute("currentUser");
            
            Posts p=new Posts(pTitle,pContent,pCode,part.getSubmittedFileName(),null,cid,user.getId());
            PostDao dao=new PostDao(ConnectionProvider.getConnection());
            
            if(dao.savePost(p)){
                String realPath = request.getServletContext().getRealPath("/");
                String postImagePath = realPath + "blog_pic" + File.separator + part.getSubmittedFileName();
                Helper.saveFile(part.getInputStream(), postImagePath);
                out.println("done");
            }
            else{
                out.println("error");
            }
        }catch(Exception e){
            e.printStackTrace();
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
