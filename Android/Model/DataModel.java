package com.wowo.wowo.Model;

public class DataModel {
    private boolean success;
    private String message;
    private String status;
    private String  data;
    public void setSuccess(boolean success) {
        this.success = success;
    }
    public boolean getSuccess() {
        return success;
    }

    public void setMessage(String message) {
        this.message = message;
    }
    public String getMessage() {
        return message;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getStatus() {
        return status;
    }

    public void setData(String data) {
        this.data = data;
    }
    public String getData() {
        return data;
    }
}
