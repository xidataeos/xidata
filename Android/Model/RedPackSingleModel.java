package com.wowo.wowo.Model;

public class RedPackSingleModel {
    private String id;
    private String fromId;
    private String toId;
    private String sendTransaction;
    private String recvTransaction;
    private   String sendTime;
    private   String recvTime;
    private int hasRecv;
    private int asset;
    private String tip;
    private String fromPhoto;
    private String fromName;
    private String toPhoto;
    private String toName;
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

    public void setRecvTransaction(String recvTransaction) {
        this.recvTransaction = recvTransaction;
    }
    public String getRecvTransaction() {
        return recvTransaction;
    }

    public void setSendTime(  String sendTime) {
        this.sendTime = sendTime;
    }
    public   String getSendTime() {
        return sendTime;
    }

    public void setRecvTime(  String recvTime) {
        this.recvTime = recvTime;
    }
    public   String getRecvTime() {
        return recvTime;
    }

    public void setHasRecv(int hasRecv) {
        this.hasRecv = hasRecv;
    }
    public int getHasRecv() {
        return hasRecv;
    }

    public void setAsset(int asset) {
        this.asset = asset;
    }
    public int getAsset() {
        return asset;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }
    public String getTip() {
        return tip;
    }

    public void setFromPhoto(String fromPhoto) {
        this.fromPhoto = fromPhoto;
    }
    public String getFromPhoto() {
        return fromPhoto;
    }

    public void setFromName(String fromName) {
        this.fromName = fromName;
    }
    public String getFromName() {
        return fromName;
    }

    public void setToPhoto(String toPhoto) {
        this.toPhoto = toPhoto;
    }
    public String getToPhoto() {
        return toPhoto;
    }

    public void setToName(String toName) {
        this.toName = toName;
    }
    public String getToName() {
        return toName;
    }

}
