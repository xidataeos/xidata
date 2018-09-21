package com.wowo.wowo.Adapter;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Activity.ConversationActivity;
import com.wowo.wowo.Activity.FriendsDetailsActivity;
import com.wowo.wowo.Activity.GroupDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;
import com.wowo.wowo.Views.ListView.OnItemClickListener;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;

public class FriendListRcAdapter extends RecyclerView.Adapter<FriendListRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private List<FriendListModel> list;
    private OnItemClickListener onItemClickListener;
    private int isshowBox;
    private Map<Integer, Boolean> map = new HashMap<>();
    private int checkedPosition = -1;
    public FriendListRcAdapter(Context mContext, List<FriendListModel> list ,int isshowBox) {
        this.list = list;
        this.mContext= mContext;
        this.isshowBox = isshowBox;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_friends, parent, false);
        FriendListRcAdapter.ViewHolder viewHolder = new FriendListRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final FriendListModel model = list.get(position);
        GlideUtils.loadImageView(mContext,model.getPhoto(),holder.mCiHead);
        holder.mTvName.setText(model.getName());
        if (isshowBox==0){
            holder.mCbChooseFriends.setVisibility(View.GONE);
        }else{
            holder.mCbChooseFriends.setVisibility(View.VISIBLE);
            holder.mLyItem.setOnClickListener(null);
        }
        holder.mLyItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(RongIM.getInstance()!=null){
                    RongIM.getInstance().startPrivateChat(mContext,model.getUid(),model.getName());
                }
            }
        });
        holder.mCiHead.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putString("name",model.getName());
                bundle.putString("nickname", model.getNickname()+"");
                bundle.putString("uid", model.getUid()+"");
                bundle.putString("fgroup", model.getFgroup());
                bundle.putString("photo", model.getPhoto());
                ((BaseActivity)mContext).openActivity(FriendsDetailsActivity.class,bundle);
            }
        });
        holder.mCbChooseFriends.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked == true) {
                    map.put(position, true);
                    model.setIscheck(true);
                } else {
                    map.remove(position);
                    model.setIscheck(false);
                }
            }
        });
        if (model != null && model.isIscheck()) {
            holder.mCbChooseFriends.setChecked(true);
        } else {
            holder.mCbChooseFriends.setChecked(false);
        }
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
