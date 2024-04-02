package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@WebServlet("/editServlet")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");
            String about = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setAbout(about);
            String oldImage = user.getProfile();
            user.setProfile(imageName);

            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            
            if (dao.updateUser(user)) {
                
                String realPath = request.getServletContext().getRealPath("/");
                
                String profileImagePath = realPath + "img" + File.separator + imageName;
                String oldImagePath = realPath + "img" + File.separator + oldImage;

                Helper.deleteFile(oldImagePath);

                if (Helper.saveFile(part.getInputStream(), profileImagePath)) {
                    Message msg = new Message("Profile Updated", "success", "alert-success");
                    session.setAttribute("msg", msg);
                } else {
                    Message msg = new Message("Something Wrong", "error", "alert-danger");
                    session.setAttribute("msg", msg);
                }

            } else {
                Message msg = new Message("Something Went Wrong", "error", "alert-danger");
                session.setAttribute("msg", msg);
            }
            response.sendRedirect("profile.jsp");
            
        } catch (Exception e) {
            e.printStackTrace(out);
        } finally {
            if (out != null) {
                out.close();
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
        return "Edit Servlet";
    }
}
