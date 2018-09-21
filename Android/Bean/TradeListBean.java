package com.wowo.wowo.Bean;

public class TradeListBean {

    private String id;
    private String userId;//交易记录归属人的id
    private String tradeId;//交易单号
    private String tradeTime;//交易时间
    private double asset;//金额
    private double isIncome;//是收入还是支出（1收入，2支出）
    private String  otherSide;//交易对方的id
    private double isMulti;//（红包）单人还是群（0不是红包，1单人，2群）
    private String refund;//（红包）退款
    private String tradeEntity;//交易主体id（红包id，转账id等）
    private String tradeType;//交易类型（转账"001"，红包"002"，合约"003"）
    private double status;//交易状态（1成功，2有退款）
    private String payType;//支付类型（"00"啥也不是，"01"支付宝,"02"微信）
    private String coin;//币种（"001"人民币"002"WOT）
    private String scene;//支付场景（"红包-来自 马云"）
    private String tip;//备注

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTradeId() {
        return tradeId;
    }

    public void setTradeId(String tradeId) {
        this.tradeId = tradeId;
    }

    public String getTradeTime() {
        return tradeTime;
    }

    public void setTradeTime(String tradeTime) {
        this.tradeTime = tradeTime;
    }

    public double getAsset() {
        return asset;
    }

    public void setAsset(double asset) {
        this.asset = asset;
    }

    public double getIsIncome() {
        return isIncome;
    }

    public void setIsIncome(double isIncome) {
        this.isIncome = isIncome;
    }

    public String getOtherSide() {
        return otherSide;
    }

    public void setOtherSide(String otherSide) {
        this.otherSide = otherSide;
    }

    public double getIsMulti() {
        return isMulti;
    }

    public void setIsMulti(double isMulti) {
        this.isMulti = isMulti;
    }

    public String getRefund() {
        return refund;
    }

    public void setRefund(String refund) {
        this.refund = refund;
    }

    public String getTradeEntity() {
        return tradeEntity;
    }

    public void setTradeEntity(String tradeEntity) {
        this.tradeEntity = tradeEntity;
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

    public double getStatus() {
        return status;
    }

    public void setStatus(double status) {
        this.status = status;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }

    public String getCoin() {
        return coin;
    }

    public void setCoin(String coin) {
        this.coin = coin;
    }

    public String getScene() {
        return scene;
    }

    public void setScene(String scene) {
        this.scene = scene;
    }

    public String getTip() {
        return tip;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }
}
