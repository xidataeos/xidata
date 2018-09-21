package com.wowo.wowo.Model;

import java.util.List;

public class PicAndNickModel {

    /**
     * defaultAvatar : [{"url":"http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/18786868475bvo0V-IMG_20171204_135956.jpg?Expires=1829120377&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=6TPYffwzYk7M1dAx0ELLb9Q9NKk%3D"}]
     * userNick : Hgggh
     */

    private String userNick;
    private List<DefaultAvatarBean> defaultAvatar;

    public String getUserNick() {
        return userNick;
    }

    public void setUserNick(String userNick) {
        this.userNick = userNick;
    }

    public List<DefaultAvatarBean> getDefaultAvatar() {
        return defaultAvatar;
    }

    public void setDefaultAvatar(List<DefaultAvatarBean> defaultAvatar) {
        this.defaultAvatar = defaultAvatar;
    }

    public static class DefaultAvatarBean {
        /**
         * url : http://infinite-picture.oss-cn-hangzhou.aliyuncs.com/18786868475bvo0V-IMG_20171204_135956.jpg?Expires=1829120377&OSSAccessKeyId=LTAIRbW33ZGSxbNH&Signature=6TPYffwzYk7M1dAx0ELLb9Q9NKk%3D
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
