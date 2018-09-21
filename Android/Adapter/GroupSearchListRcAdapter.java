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

import com.wowo.wowo.Activity.GroupDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.GroupInfoModel;
import com.wowo.wowo.Model.GroupListModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;

public class GroupSearchListRcAdapter extends RecyclerView.Adapter<GroupSearchListRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private List<GroupInfoModel> list;
    private OnItemClickListener onItemClickListener;
    private int isshowBox;
    private Map<Integer, Boolean> map = new HashMap<>();
    private int checkedPosition = -1;
    public GroupSearchListRcAdapter(Context mContext, List<GroupInfoModel> list) {
        this.list = list;
        this.mContext= mContext;
        this.isshowBox = isshowBox;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_friends, parent, false);
        GroupSearchListRcAdapter.ViewHolder viewHolder = new GroupSearchListRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final GroupInfoModel model = list.get(position);
            holder.mCbChooseFriends.setVisibility(View.GONE);
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
//                if(RongIM.getInstance()!=null){
//                    RongIM.getInstance().startGroupChat(mContext,model.getCid(),model.getName());
//                }
            }
        });
        holder.mTvName.setText(model.getName());
        GlideUtils.loadImageView(mContext,model.getUrlPhoto(),holder.mCiHead);
        holder.mCiHead.setOnClickListener(new View.OnClickListener() {
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


    /**
     * 设置点击事件
     */
    public void setOnItemClickListener(OnItemClickListener onItemClickListener) {
        this.onItemClickListener = onItemClickListener;
    }

    private class MyOnClickListener implements View.OnClickListener {
        private int position;
        private String data;

        public MyOnClickListener(int position, String data) {
            this.position = position;
            this.data = data;
        }

        @Override
        public void onClick(View v) {
            onItemClickListener.onItemClick(v, position, data);
        }
    }
    public interface OnItemClickListener {
        void onItemClick(View view, int position, String data);
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        TextView mTvName;
        CircleImageView mCiHead;
        LinearLayout mLyItem;
        CheckBox mCbChooseFriends;
        ViewHolder(View itemView) {
            super(itemView);
            mLyItem =  itemView.findViewById(R.id.item_friends);
            mTvName = itemView.findViewById(R.id.item_tv_firiendname);
            mCiHead = itemView.findViewById(R.id.item_ci_group);
            mCbChooseFriends= itemView.findViewById(R.id.item_cb_chosefriend);
        }
    }
    }
