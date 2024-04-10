package com.tech.blog.dao;

import com.tech.blog.entities.Comments;
import java.sql.*;
import java.util.ArrayList;

public class CommentDao {

    Connection con;

    public CommentDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Comments>getComments(){
        ArrayList<Comments>list=new ArrayList<>();
        String q="SELECT * FROM postcomment";
        
        try{
            Statement st=con.createStatement();
            ResultSet set=st.executeQuery(q);
            
            while(set.next()){
                int cid=set.getInt("cid");
                int pid=set.getInt("pid");
                int uid=set.getInt("uid");
                String comment=set.getString("comment");
                
                Comments cmnt=new Comments(cid,pid,uid,comment);
                list.add(cmnt);
            }
            st.close();
            set.close();
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }

    public boolean insertComment(int pid, int uid, String comment) {
        boolean flag = false;
        String query = "INSERT INTO postcomment(pid,uid,comment) VALUES(?,?,?)";
        
        
        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            pstmt.setInt(2, uid);
            pstmt.setString(3, comment);
            pstmt.executeUpdate();
            flag = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }
    
    public int countCommentOnPost(int pid){
        int comment=0;
        String q="SELECT count(*) FROM postcomment WHERE pid=?";
        
        try{
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setInt(1,pid);
            ResultSet set=pstmt.executeQuery();
            
            if(set.next()){
                comment=set.getInt("count(*)");
            }
            
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return comment;
    }
}
