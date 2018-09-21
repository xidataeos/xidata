package com.wowo.wowo.Message;

import java.util.List;

public class SystemMsgModel {


    /**
     * skillName : 聊天
     * defaultAvatar : [{"url":"http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/180232Dq9zX-2.png?Expires=1829183681&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=JMEvBrYXu+Xkyomvd4WVASOgUlg="}]
     * demandMoney : 10
     * demandId : demand180232Dq9zX20180128173759
     * demandLocation : [{"latitude":"30.285308","longitude":"120.001467"}]
     * userNick : 婷婷
     * demandDeposit : 0
     * isIdentity : 1
     * userGender : 0
     * demandDec : 表达你对大家的军事技术监督局
     * isVip : 1
     * demandType : 0
     * msg : 优服为您推荐
     * infoId : demand19999999Dq9zX20180205134339
     * isRead : 1
     * messageId : 1517809500980
     * type : demand
     * status : 5
     */

    private String skillName;
    private String demandMoney;
    private String demandId;
    private String userNick;
    private String demandDeposit;
    private String isIdentity;
    private String userGender;
    private String demandDec;
    private String isVip;
    private String demandType;
    private String msg;
    private String infoId;
    private String isRead;
    private String messageId;
    private String type;
    private String status;
    private List<DefaultAvatarBean> defaultAvatar;
    private List<DemandLocationBean> demandLocation;

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public String getDemandMoney() {
        return demandMoney;
    }

    public void setDemandMoney(String demandMoney) {
        this.demandMoney = demandMoney;
    }

    public String getDemandId() {
        return demandId;
    }

    public void setDemandId(String demandId) {
        this.demandId = demandId;
    }

    public String getUserNick() {
        return userNick;
    }

    public void setUserNick(String userNick) {
        this.userNick = userNick;
    }

    public String getDemandDeposit() {
        return demandDeposit;
    }

    public void setDemandDeposit(String demandDeposit) {
        this.demandDeposit = demandDeposit;
    }

    public String getIsIdentity() {
        return isIdentity;
    }

    public void setIsIdentity(String isIdentity) {
        this.isIdentity = isIdentity;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getDemandDec() {
        return demandDec;
    }

    public void setDemandDec(String demandDec) {
        this.demandDec = demandDec;
    }

    public String getIsVip() {
        return isVip;
    }

    public void setIsVip(String isVip) {
        this.isVip = isVip;
    }

    public String getDemandType() {
        return demandType;
    }

    public void setDemandType(String demandType) {
        this.demandType = demandType;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getInfoId() {
        return infoId;
    }

    public void setInfoId(String infoId) {
        this.infoId = infoId;
    }

    public String getIsRead() {
        return isRead;
    }

    public void setIsRead(String isRead) {
        this.isRead = isRead;
    }

    public String getMessageId() {
        return messageId;
    }

    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<DefaultAvatarBean> getDefaultAvatar() {
        return defaultAvatar;
    }

    public void setDefaultAvatar(List<DefaultAvatarBean> defaultAvatar) {
        this.defaultAvatar = defaultAvatar;
    }

    public List<DemandLocationBean> getDemandLocation() {
        return demandLocation;
    }

    public void setDemandLocation(List<DemandLocationBean> demandLocation) {
        this.demandLocation = demandLocation;
    }

    public static class DefaultAvatarBean {
        /**
         * url : http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/180232Dq9zX-2.png?Expires=1829183681&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=JMEvBrYXu+Xkyomvd4WVASOgUlg=
         */

        private String url;

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }

    public static class DemandLocationBean {
        /**
         * latitude : 30.285308
         * longitude : 120.001467
         */

        private String latitude;
        private String longitude;

        public String getLatitude() {
            return latitude;
        }

        public void setLatitude(String latitude) {
            this.latitude = latitude;
        }

        public String getLongitude() {
            return longitude;
        }

        public void setLongitude(String longitude) {
            this.longitude = longitude;
        }
    }
}
