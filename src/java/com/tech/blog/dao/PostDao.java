package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Posts;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;

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
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean savePost(Posts p) {
        boolean f = false;
        try {
            String query = "INSERT INTO posts(pTitle,pContent,pCode,pPic,catId,userId) VALUES(?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, p.getPostTitle());
            pstmt.setString(2, p.getPostContent());
            pstmt.setString(3, p.getPostCode());
            pstmt.setString(4, p.getPostPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Posts> getAllPost() {
        List<Posts> list = new ArrayList<>();
        // fetch all posts
        try {
            String query = "SELECT * FROM posts ORDER BY pid DESC";
            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pId = set.getInt("pid");
                String title = set.getString("pTitle");
                String content = set.getString("pContent");
                String code = set.getString("pCode");
                String pic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                // Create a Posts object
                Posts p = new Posts(pId, title, content, code, pic, date, catId, userId);

                // Add the Posts object to the list
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Posts> getPostByCatId(int catId) {
        List<Posts> list = new ArrayList<>();
        try {
            String query = "SELECT * FROM posts WHERE catId=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, catId);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pId = set.getInt("pid");
                String title = set.getString("pTitle");
                String content = set.getString("pContent");
                String code = set.getString("pCode");
                String pic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userId = set.getInt("userId");

                // Create a Posts object
                Posts p = new Posts(pId, title, content, code, pic, date, catId, userId);

                // Add the Posts object to the list
                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
