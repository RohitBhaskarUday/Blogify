package com.blog.entities;


import java.sql.Timestamp;

public class Post {
    private int pId;
    private String pTitle;
    private String pContent;
    private String pCode;
    private String pPicture;
    private Timestamp pDate;
    private int catId;
    private int userId;

    public Post(int pId, String pTitle, String pContent, String pCode, String pPicture, Timestamp pDate, int catId, int userId) {
        this.pId = pId;
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pPicture = pPicture;
        this.pDate = pDate;
        this.catId = catId;
        this.userId = userId;
    }

    public Post() {
    }

    public Post(String pTitle, String pContent, String pCode, String pPicture, Timestamp pDate, int catId, int userId) {
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pPicture = pPicture;
        this.pDate = pDate;
        this.catId = catId;
        this.userId = userId;
    }


//now getters and setters;
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpTitle() {
        return pTitle;
    }

    public void setpTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    public String getpContent() {
        return pContent;
    }

    public void setpContent(String pContent) {
        this.pContent = pContent;
    }

    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode;
    }

    public String getpPicture() {
        return pPicture;
    }

    public void setpPicture(String pPicture) {
        this.pPicture = pPicture;
    }

    public Timestamp getpDate() {
        return pDate;
    }

    public void setpDate(Timestamp pDate) {
        this.pDate = pDate;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }
}
