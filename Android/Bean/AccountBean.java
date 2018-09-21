package com.wowo.wowo.Bean;

public class AccountBean {
    private String id;
    private String userId;//用户ID
    private String address;//用户地址
    private String publicKey;//公钥
    private String privateKey;//私钥
    private String password;
    private String salt;
    private double balance;//余额
    private double lockBalance;//不可用余额

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(String publicKey) {
        this.publicKey = publicKey;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public void setPrivateKey(String privateKey) {
        this.privateKey = privateKey;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public double getLockBalance() {
        return lockBalance;
    }

    public void setLockBalance(double lockBalance) {
        this.lockBalance = lockBalance;
    }
}
