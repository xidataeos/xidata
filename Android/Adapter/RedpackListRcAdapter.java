package com.wowo.wowo.Adapter;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Activity.FriendsDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.GroupMemberModel;
import com.wowo.wowo.Model.RedPackDetailsModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.List;

import io.rong.imkit.RongIM;

public class RedpackListRcAdapter extends RecyclerView.Adapter<RedpackListRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private String mUserId;
    private List<RedPackDetailsModel.ListBean> list;

    public RedpackListRcAdapter(Context mContext, List<RedPackDetailsModel.ListBean> list , String mUserId) {
        this.list = list;
        this.mContext= mContext;
        this.mUserId= mUserId;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_redpack, parent, false);
        RedpackListRcAdapter.ViewHolder viewHolder = new RedpackListRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
            final RedPackDetailsModel.ListBean model  = list.get(position);
            GlideUtils.loadImageView(mContext,model.getPhoto(),holder.mCiHead);
            holder.mTvName.setText(model.getName());
            holder.mTvTime.setText(model.getRecvTime());
            holder.mTvAsset.setText(model.getAsset()+"");
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
        TextView mTvName,mTvTime,mTvAsset;
        CircleImageView mCiHead;
       ;
        ViewHolder(View itemView) {
            super(itemView);
            mTvTime =  itemView.findViewById(R.id.item_tv_time);
            mTvName = itemView.findViewById(R.id.item_tv_name);
            mCiHead = itemView.findViewById(R.id.item_ci_head);
            mTvAsset= itemView.findViewById(R.id.item_tv_asset);
        }
    }
    }
