package com.wowo.wowo.Model;



public class UserModel {
    private String id;
    private int uid;
    private String tel;
    private String verifyCode;
    private String createTime;
    private int isReg;
    private int loginType;
    private String name;
    private String userId;
    private String invitationCode;
    private String invitationCodeSu;
    private String photo;
    private String age;
    private String sex;
    private String rcToken;
    private String token;

    public String getUrlPhoto() {
        return urlPhoto;
    }

    public void setUrlPhoto(String urlPhoto) {
        this.urlPhoto = urlPhoto;
    }

    private String urlPhoto;
    public void setId(String id) {
        this.id = id;
    }
    public String getId() {
        return id;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
    public int getUid() {
        return uid;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
    public String getTel() {
        return tel;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }
    public String getVerifyCode() {
        return verifyCode;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }
    public String getCreateTime() {
        return createTime;
    }

    public void setIsReg(int isReg) {
        this.isReg = isReg;
    }
    public int getIsReg() {
        return isReg;
    }

    public void setLoginType(int loginType) {
        this.loginType = loginType;
    }
    public int getLoginType() {
        return loginType;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserId() {
        return userId;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }
    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCodeSu(String invitationCodeSu) {
        this.invitationCodeSu = invitationCodeSu;
    }
    public String getInvitationCodeSu() {
        return invitationCodeSu;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
    public String getPhoto() {
        return photo;
    }

    public void setAge(String age) {
        this.age = age;
    }
    public String getAge() {
        return age;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
    public String getSex() {
        return sex;
    }

    public void setRcToken(String rcToken) {
        this.rcToken = rcToken;
    }
    public String getRcToken() {
        return rcToken;
    }

    public void setToken(String token) {
        this.token = token;
    }
    public String getToken() {
        return token;
    }
}
