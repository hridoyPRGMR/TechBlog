package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    //method to inser user to database;
    public boolean saveUser(User user) {
        boolean f=false;
        try {
            //user->database;
            String query = "INSERT INTO users(name,email,password,gender,about) VALUES(?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            
            pstmt.executeUpdate();
            f=true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserByEmailAndPassword(String email,String password){
        User user=null;
        try{
            String query="SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement pstmt=con.prepareStatement(query);
            
            pstmt.setString(1,email);
            pstmt.setString(2,password);
            
            ResultSet set=pstmt.executeQuery();
            
            if(set.next()){
                user=new User();
                //fata get from database
                String name=set.getString("name");
                //set to user object
                user.setName(name);
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return user;
    }
    
    public boolean updateUser(User user){
        boolean f=false;
        try{
            String query="UPDATE users SET name=?,email=?,password=?,gender=?,about=?,profile=? WHERE id=?";
            PreparedStatement pstmt=con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2,user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            pstmt.setString(6, user.getProfile());
            pstmt.setInt(7,user.getId());
            
            pstmt.executeUpdate();
            f=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
