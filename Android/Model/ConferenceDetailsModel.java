package com.wowo.wowo.Model;

public class ConferenceDetailsModel {
    private int mUplimit;
    private String mPrice;
    private String mVideo;
    private String mStopapply;
    private int mPageview;
    private int mApplicantcount;
    private int mId;
    private String userName;

    public String getmImg() {
        return mImg;
    }

    public void setmImg(String mImg) {
        this.mImg = mImg;
    }

    private String mImg;
    private int uId;
    private String mAddress;
    private String mStarttime;
    private String mName;
    private String mStoptime;
    private String mDesc;

    public String getCrewCid() {
        return crewCid;
    }

    public void setCrewCid(String crewCid) {
        this.crewCid = crewCid;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    private String crewCid;
    private String cName;
    public void setMUplimit(int mUplimit) {
        this.mUplimit = mUplimit;
    }
    public int getMUplimit() {
        return mUplimit;
    }

    public void setMPrice(String mPrice) {
        this.mPrice = mPrice;
    }
    public String getMPrice() {
        if (mPrice.equals("0.0")){
            mPrice= "免费";
        }
        return mPrice;
    }

    public void setMVideo(String mVideo) {
        this.mVideo = mVideo;
    }
    public String getMVideo() {
        return mVideo;
    }

    public void setMStopapply(String mStopapply) {
        this.mStopapply = mStopapply;
    }
    public String getMStopapply() {
        return mStopapply;
    }

    public void setMPageview(int mPageview) {
        this.mPageview = mPageview;
    }
    public int getMPageview() {
        return mPageview;
    }

    public void setMApplicantcount(int mApplicantcount) {
        this.mApplicantcount = mApplicantcount;
    }
    public int getMApplicantcount() {
        return mApplicantcount;
    }

    public void setMId(int mId) {
        this.mId = mId;
    }
    public int getMId() {
        return mId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getUserName() {
        return userName;
    }


    public void setUId(int uId) {
        this.uId = uId;
    }
    public int getUId() {
        return uId;
    }

    public void setMAddress(String mAddress) {
        this.mAddress = mAddress;
    }
    public String getMAddress() {
        return mAddress;
    }

    public void setMStarttime(String mStarttime) {
        this.mStarttime = mStarttime;
    }
    public String getMStarttime() {
        return mStarttime;
    }

    public void setMName(String mName) {
        this.mName = mName;
    }
    public String getMName() {
        return mName;
    }

    public void setMStoptime(String mStoptime) {
        this.mStoptime = mStoptime;
    }
    public String getMStoptime() {
        return mStoptime;
    }

    public void setMDesc(String mDesc) {
        this.mDesc = mDesc;
    }
    public String getMDesc() {
        return mDesc;
    }
}