package com.wowo.wowo.Model;

public class GroupMemberModel {
    private String cid;
    private String uid;
    private String nickname;
    private String name;
    private int valid;
    private int shield;
    private String photo;
    private String createTime;
    private String upStringTime;
    public void setCid(String cid) {
        this.cid = cid;
    }
    public String getCid() {
        return cid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
    public String getUid() {
        return uid;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
    public String getNickname() {
        return nickname;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }
    public int getValid() {
        return valid;
    }

    public void setShield(int shield) {
        this.shield = shield;
    }
    public int getShield() {
        return shield;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    public String getPhoto() {
        return photo;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
    public String getCreateTime() {
        return createTime;
    }

    public void setUpStringTime(String upStringTime) {
        this.upStringTime = upStringTime;
    }
    public String getUpStringTime() {
        return upStringTime;
    }
}
