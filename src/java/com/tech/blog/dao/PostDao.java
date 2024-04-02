package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Posts;
import java.util.ArrayList;
import java.sql.*;

public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getCategories() {
        ArrayList<Category> list = new ArrayList<>();
        
        try {
            String q = "SELECT * FROM categories";
            Statement st = this.con.createStatement(); 
            ResultSet set = st.executeQuery(q);
            
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                
                Category category = new Category(cid, name, description);
                list.add(category);
            }
            
            st.close();
            set.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Posts p){
        boolean f=false;
        try{
            String query="INSERT INTO posts(pTitle,pContent,pCode,pPic,catId,userId) VALUES(?,?,?,?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(query);
            pstmt.setString(1,p.getPostTitle());
            pstmt.setString(2, p.getPostContent());
            pstmt.setString(3, p.getPostCode());
            pstmt.setString(4, p.getPostPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
            
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
}
