package com.wowo.wowo.Bean;

import java.util.List;

public class NewsFragmentBean {
    private int type;//布局显示类型
    private List<String> imageArr;//图片
    private String title;//标题
    private String route;//来头
    private String describe;//描述

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public List<String> getImageArr() {
        return imageArr;
    }

    public void setImageArr(List<String> imageArr) {
        this.imageArr = imageArr;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRoute() {
        return route;
    }

    public void setRoute(String route) {
        this.route = route;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }
}
