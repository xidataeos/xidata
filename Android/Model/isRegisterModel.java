package com.wowo.wowo.Model;

import java.util.List;

/**

 */
public class isRegisterModel {

    /**
     * defaultAvatar : [{"url":"http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/180232Dq9zX-pic.png?Expires=1830246123&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=XWAOGOUbpD%2FdUgU5HYIkrED7TIY%3D"}]
     * userNick : 时光鸡1
     * phone : 180
     * userGender : 1
     * userId : 35gsf
     * status : 1
     */

    private String userNick;
    private String phone;
    private String userGender;
    private String userId;
    private String status;
    private List<DefaultAvatarBean> defaultAvatar;

    public String getUserNick() {
        return userNick;
    }

    public void setUserNick(String userNick) {
        this.userNick = userNick;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public static class DefaultAvatarBean {
        /**
         * url : http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/180232Dq9zX-pic.png?Expires=1830246123&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=XWAOGOUbpD%2FdUgU5HYIkrED7TIY%3D
         */

        private String url;

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }
}
