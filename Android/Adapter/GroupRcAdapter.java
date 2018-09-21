package com.wowo.wowo.Adapter;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Activity.GroupDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.List;

import io.rong.imkit.RongIM;

public class GroupRcAdapter extends RecyclerView.Adapter<GroupRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private List<GroupInfoModel> list;

    public GroupRcAdapter(Context mContext,List<GroupInfoModel> list) {
        this.list = list;
        this.mContext= mContext;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_gv_group, parent, false);
        GroupRcAdapter.ViewHolder viewHolder = new GroupRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
            final GroupInfoModel model  = list.get(position);
            GlideUtils.loadImageView(mContext,model.getUrlPhoto(),holder.mCiHead);
            holder.mTvName.setText(model.getName());
            holder.mLyItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putString("cid", model.getCid()+"");
                bundle.putString("name",model.getName());
                bundle.putString("num", model.getNum()+"");
                bundle.putString("uid", model.getUid()+"");
                bundle.putString("pub", model.getPub()+"");
                bundle.putString("brief", model.getBrief());
                bundle.putString("qrcode", model.getQrcode());
                ((BaseActivity)mContext).openActivity(GroupDetailsActivity.class,bundle);
//                RongIM.getInstance().startGroupChat(mContext, "002101","群聊1111");

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
        TextView mTvName;
        CircleImageView mCiHead;
        LinearLayout mLyItem;

        ViewHolder(View itemView) {
            super(itemView);
            mLyItem =  itemView.findViewById(R.id.item_gv_group);
            mTvName = itemView.findViewById(R.id.item_tv_name);
            mCiHead = itemView.findViewById(R.id.item_ci_group);
        }
    }
    }
