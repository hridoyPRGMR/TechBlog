package com.tech.blog.dao;

import java.sql.*;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int pid, int uid) {
        boolean flag = false;

        if (!isLikedByUser(pid, uid)) {
            String query = "INSERT INTO postlike(pid,uid) VALUES(?,?)";
            try {
                PreparedStatement pstmt = con.prepareStatement(query);
                pstmt.setInt(1, pid);
                pstmt.setInt(2, uid);
                pstmt.executeUpdate();
                flag = true;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return flag;
    }

    public int countLikeOnPost(int pid) {
        int count = 0;
        String query = "SELECT count(*) FROM postlike WHERE pid=?";

        try {
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, pid);
            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                count = set.getInt("count(*)");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean isLikedByUser(int pid, int uid) {
        boolean flag = false;
        String q = "SELECT * FROM postlike WHERE pid=? AND uid=?";

        try {
            PreparedStatement p = con.prepareStatement(q);
            p.setInt(1, pid);
            p.setInt(2, uid);

            ResultSet set = p.executeQuery();
            if (set.next()) {
                flag = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

    public boolean unlikePost(int pid, int uid) {
        boolean flag = false;

        if (isLikedByUser(pid, uid)) {
            String q = "DELETE FROM postlike WHERE pid=? and uid=?";

            try {
                PreparedStatement p = con.prepareStatement(q);
                p.setInt(1, pid);
                p.setInt(2, uid);
                p.executeUpdate();
                flag = true;

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return flag;
    }
}
