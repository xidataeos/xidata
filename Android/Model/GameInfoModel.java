package com.wowo.wowo.Model;

public class GameInfoModel {

    private int id;
    private String name;
    private String gameStartTime;
    private String gameStopTime;
    private int maxPrice;
    private int dealerGain;
    private int userGain;
    private int lastUserGain;
    private int nowPrice;
    private int bonusCount;
    private int gameCountNumber;
    private int gamePutCountNumber;
    private int gameUserCountPutEgg;
    public void setId(int id) {
        this.id = id;
    }
    public int getId() {
        return id;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getName() {
        return name;
    }

    public void setGameStartTime(String gameStartTime) {
        this.gameStartTime = gameStartTime;
    }
    public String getGameStartTime() {
        return gameStartTime;
    }

    public void setGameStopTime(String gameStopTime) {
        this.gameStopTime = gameStopTime;
    }
    public String getGameStopTime() {
        return gameStopTime;
    }

    public void setMaxPrice(int maxPrice) {
        this.maxPrice = maxPrice;
    }
    public int getMaxPrice() {
        return maxPrice;
    }

    public void setDealerGain(int dealerGain) {
        this.dealerGain = dealerGain;
    }
    public int getDealerGain() {
        return dealerGain;
    }

    public void setUserGain(int userGain) {
        this.userGain = userGain;
    }
    public int getUserGain() {
        return userGain;
    }

    public void setLastUserGain(int lastUserGain) {
        this.lastUserGain = lastUserGain;
    }
    public int getLastUserGain() {
        return lastUserGain;
    }

    public void setNowPrice(int nowPrice) {
        this.nowPrice = nowPrice;
    }
    public int getNowPrice() {
        return nowPrice;
    }

    public void setBonusCount(int bonusCount) {
        this.bonusCount = bonusCount;
    }
    public int getBonusCount() {
        return bonusCount;
    }

    public void setGameCountNumber(int gameCountNumber) {
        this.gameCountNumber = gameCountNumber;
    }
    public int getGameCountNumber() {
        return gameCountNumber;
    }

    public void setGamePutCountNumber(int gamePutCountNumber) {
        this.gamePutCountNumber = gamePutCountNumber;
    }
    public int getGamePutCountNumber() {
        return gamePutCountNumber;
    }

    public void setGameUserCountPutEgg(int gameUserCountPutEgg) {
        this.gameUserCountPutEgg = gameUserCountPutEgg;
    }
    public int getGameUserCountPutEgg() {
        return gameUserCountPutEgg;
    }
}
