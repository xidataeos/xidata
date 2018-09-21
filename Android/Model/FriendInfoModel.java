package com.wowo.wowo.Model;

public class FriendInfoModel {
    private String mid;
    private String fid;
    private String myGroup;
    private String fGroup;
    private String myNickname;
    private String fNickname;
    private int valid;
    private String name;
    private String photo;
    private String brief;
    private String sex;
    private String isFriend;
    private String nickname;

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getIsFriend() {
        return isFriend;
    }

    public void setIsFriend(String isFriend) {
        this.isFriend = isFriend;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }
    public String getMid() {
        return mid;
    }

    public void setFid(String fid) {
        this.fid = fid;
    }
    public String getFid() {
        return fid;
    }

    public void setMyGroup(String myGroup) {
        this.myGroup = myGroup;
    }
    public String getMyGroup() {
        return myGroup;
    }

    public void setFGroup(String fGroup) {
        this.fGroup = fGroup;
    }
    public String getFGroup() {
        return fGroup;
    }

    public void setMyNickname(String myNickname) {
        this.myNickname = myNickname;
    }
    public String getMyNickname() {
        return myNickname;
    }

    public void setFNickname(String fNickname) {
        this.fNickname = fNickname;
    }
    public String getFNickname() {
        return fNickname;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }
    public int getValid() {
        return valid;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    public String getPhoto() {
        return photo;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }
    public String getBrief() {
        return brief;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
    public String getSex() {
        return sex;
    }
}
