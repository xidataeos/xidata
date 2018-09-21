package com.wowo.wowo.Model;

import java.util.List;

public class RedPackDetailsModel {
    private RedMultiDetail redMultiDetail;
    private List<ListBean> list;
    private RedMultiRecv redMultiRecv;
    public RedMultiRecv getRedMultiRecv() {
        return redMultiRecv;
    }

    public void setRedMultiRecv(RedMultiRecv redMultiRecv) {
        this.redMultiRecv = redMultiRecv;
    }
    public RedMultiDetail getRedMultiDetail() {
        return redMultiDetail;
    }
    public void setRedMultiDetail(RedMultiDetail redMultiDetail) {
        this.redMultiDetail = redMultiDetail;
    }
    public List<ListBean> getList() {
        return list;
    }
    public void setList(List<ListBean> list) {
        this.list = list;
    }
    public class RedMultiDetail {
        private String id;
        private String fromId;
        private String toId;
        private String sendTransaction;
        private String sendTime;
        private int size;
        private int remain;
        private int asset;
        private double balance;
        private String tip;
        private String photo;
        private String name;
        public void setId(String id) {
            this.id = id;
        }
        public String getId() {
            return id;
        }

        public void setFromId(String fromId) {
            this.fromId = fromId;
        }
        public String getFromId() {
            return fromId;
        }

        public void setToId(String toId) {
            this.toId = toId;
        }
        public String getToId() {
            return toId;
        }

        public void setSendTransaction(String sendTransaction) {
            this.sendTransaction = sendTransaction;
        }
        public String getSendTransaction() {
            return sendTransaction;
        }

        public void setSendTime(String sendTime) {
            this.sendTime = sendTime;
        }
        public String getSendTime() {
            return sendTime;
        }

        public void setSize(int size) {
            this.size = size;
        }
        public int getSize() {
            return size;
        }

        public void setRemain(int remain) {
            this.remain = remain;
        }
        public int getRemain() {
            return remain;
        }

        public void setAsset(int asset) {
            this.asset = asset;
        }
        public int getAsset() {
            return asset;
        }

        public void setBalance(double balance) {
            this.balance = balance;
        }
        public double getBalance() {
            return balance;
        }

        public void setTip(String tip) {
            this.tip = tip;
        }
        public String getTip() {
            return tip;
        }

        public void setPhoto(String photo) {
            this.photo = photo;
        }
        public String getPhoto() {
            return photo;
        }

        public void setName(String name) {
            this.name = name;
        }
        public String getName() {
            return name;
        }

    }
    public static class ListBean {
        private String fromId;
        private String toId;
        private String recvTransaction;
        private String recvTime;
        private double asset;
        private String photo;
        private String name;
        public void setFromId(String fromId) {
            this.fromId = fromId;
        }
        public String getFromId() {
            return fromId;
        }

        public void setToId(String toId) {
            this.toId = toId;
        }
        public String getToId() {
            return toId;
        }

        public void setRecvTransaction(String recvTransaction) {
            this.recvTransaction = recvTransaction;
        }
        public String getRecvTransaction() {
            return recvTransaction;
        }

        public void setRecvTime(String recvTime) {
            this.recvTime = recvTime;
        }
        public String getRecvTime() {
            return recvTime;
        }

        public void setAsset(double asset) {
            this.asset = asset;
        }
        public double getAsset() {
            return asset;
        }

        public void setPhoto(String photo) {
            this.photo = photo;
        }
        public String getPhoto() {
            return photo;
        }

        public void setName(String name) {
            this.name = name;
        }
        public String getName() {
            return name;
        }

    }
    public static class RedMultiRecv {
        private String fromId;
        private String toId;
        private String recvTransaction;
        private String recvTime;
        private double asset;
        public void setFromId(String fromId) {
            this.fromId = fromId;
        }
        public String getFromId() {
            return fromId;
        }

        public void setToId(String toId) {
            this.toId = toId;
        }
        public String getToId() {
            return toId;
        }

        public void setRecvTransaction(String recvTransaction) {
            this.recvTransaction = recvTransaction;
        }
        public String getRecvTransaction() {
            return recvTransaction;
        }

        public void setRecvTime(String recvTime) {
            this.recvTime = recvTime;
        }
        public String getRecvTime() {
            return recvTime;
        }

        public void setAsset(double asset) {
            this.asset = asset;
        }
        public double getAsset() {
            return asset;
        }
    }

}
