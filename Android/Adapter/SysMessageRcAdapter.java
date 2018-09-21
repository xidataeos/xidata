package com.wowo.wowo.Adapter;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;


import com.lljjcoder.style.citylist.Toast.ToastUtils;

import com.wowo.wowo.Activity.FriendsDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendInfoModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.List;

import io.rong.imlib.model.Conversation;

public class SysMessageRcAdapter extends RecyclerView.Adapter<SysMessageRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private String mId;
    private List<Conversation> list;
    private UserModel  userModel ;

    public SysMessageRcAdapter(Context mContext, List<Conversation> list ,String mId) {
        this.list = list;
        this.mContext= mContext;
        this.mId = mId;
        userModel = SharedPreferencesManager.getInstance().getUserData(mContext);
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_sysmess, parent, false);
        SysMessageRcAdapter.ViewHolder viewHolder = new SysMessageRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
            final Conversation model  = list.get(position);
        SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<FriendInfoModel>>(){ //通过ID获取群资料
            @Override
            public void onNext(BaseResponse<FriendInfoModel> baseResponse){
                FriendInfoModel model = baseResponse.data;
                GlideUtils.loadImageView(mContext,model.getPhoto(),holder.mIvPic);
                holder.mTvTitle.setText(model.getName()+"  好友请求");
                if (model.getIsFriend().equals("0")){//不是好友
                    holder. mBtAgree.setText("接受");
                }else{
                    holder. mBtAgree.setText("已添加");
                    holder. mBtAgree.setOnClickListener(null);
                }
            }
        };
        RetrofitAPIManager.getInstance().getFriendInfo(new ProgressSubscriber<BaseResponse<FriendInfoModel>>(listener,(BaseActivity)mContext,0),userModel.getUserId(),model.getTargetId());
            holder. mBtAgree.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
               SubscriberOnNextListener listener = new SubscriberOnNextListener<BaseResponse<List<String>>>(){
                    @Override
                    public void onNext(BaseResponse<List<String>> baseResponse) {
                        holder. mBtAgree.setText("已添加");
                        holder. mBtAgree.setOnClickListener(null);
                        ToastUtils.showShortToast(mContext,"同意添加好友");
                    }
                };
                RetrofitAPIManager.getInstance().getFriendAdd(new ProgressSubscriber<BaseResponse<String>>(listener,(BaseActivity)mContext,0),mId,model.getTargetId(),"","");
            }
        });
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        TextView mTvTitle;
        Button mBtAgree;
        CircleImageView mIvPic;
        LinearLayout mLyItem;
        ViewHolder(View itemView) {
            super(itemView);
            mLyItem =  itemView.findViewById(R.id.item_sys);
            mIvPic=  itemView.findViewById(R.id.item_ci_sys);
            mTvTitle = itemView.findViewById(R.id.sys_tv_firiendname);
            mBtAgree= itemView.findViewById(R.id.sys_bt_agree);
        }
    }}
