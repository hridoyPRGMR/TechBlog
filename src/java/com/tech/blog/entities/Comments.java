package com.tech.blog.entities;

public class Comments {
    private int cid;
    private int pid;
    private int uid;
    private String comment;
    private User user;

    public Comments(int cid, int pid, int uid, String comment, User user) {
        this.cid = cid;
        this.pid = pid;
        this.uid = uid;
        this.comment = comment;
        this.user = user;
    }

    public Comments(int pid, int uid, String comment, User user) {
        this.pid = pid;
        this.uid = uid;
        this.comment = comment;
        this.user = user;
    }
    
    
    
    public Comments(int cid, int pid, int uid, String comment) {
        this.cid = cid;
        this.pid = pid;
        this.uid = uid;
        this.comment = comment;
    }

    public Comments(int pid, int uid, String comment) {
        this.pid = pid;
        this.uid = uid;
        this.comment = comment;
    }

    public Comments() {
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
}
