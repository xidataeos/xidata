package com.wowo.wowo.Model;

public class GroupInfoModel {
    private int id;
    private String cid;

    public String getUrlPhoto() {
        return urlPhoto;
    }

    public void setUrlPhoto(String urlPhoto) {
        this.urlPhoto = urlPhoto;
    }

    private String urlPhoto;
    private int num;
    private String uid;
    private String name;
    private int pub;
    private String brief;
    private String qrcode;
    private int valid;
    private String createTime;
    private String upStringTime;

    public String getShield() {
        return shield;
    }

    public void setShield(String shield) {
        this.shield = shield;
    }

    public String getIsCrewMember() {
        return isCrewMember;
    }

    public void setIsCrewMember(String isCrewMember) {
        this.isCrewMember = isCrewMember;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    private String shield;//是否已屏蔽群消息
    private String isCrewMember;//是否群成员
    private String  nickname;//你在群内的群名片
    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }
    public String getCid() {
        return cid;
    }

    public void setNum(int num) {
        this.num = num;
    }
    public int getNum() {
        return num;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
    public String getUid() {
        return uid;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setPub(int pub) {
        this.pub = pub;
    }
    public int getPub() {
        return pub;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }
    public String getBrief() {
        return brief;
    }

    public void setQrcode(String qrcode) {
        this.qrcode = qrcode;
    }
    public String getQrcode() {
        return qrcode;
    }

    public void setValid(int valid) {
        this.valid = valid;
    }
    public int getValid() {
        return valid;
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
