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

import com.wowo.wowo.Activity.FriendsDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.FriendListModel;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.rong.imkit.RongIM;

public class FriendSearchListRcAdapter extends RecyclerView.Adapter<FriendSearchListRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private List<UserModel> list;
    private OnItemClickListener onItemClickListener;
    private Map<Integer, Boolean> map = new HashMap<>();
    private int checkedPosition = -1;
    public FriendSearchListRcAdapter(Context mContext, List<UserModel> list) {
        this.list = list;
        this.mContext= mContext;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_friends, parent, false);
        FriendSearchListRcAdapter.ViewHolder viewHolder = new FriendSearchListRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final UserModel model = list.get(position);
        GlideUtils.loadImageView(mContext,model.getUrlPhoto(),holder.mCiHead);
        holder.mTvName.setText(model.getName());
        holder.mCbChooseFriends.setVisibility(View.GONE);
        holder.mLyItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putString("name",model.getName());
                bundle.putString("uid", model.getUserId()+"");
                bundle.putString("photo", model.getPhoto());
                ((BaseActivity)mContext).openActivity(FriendsDetailsActivity.class,bundle);
            }
        });
        holder.mCiHead.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putString("name",model.getName());
                bundle.putString("uid", model.getUserId()+"");
                bundle.putString("photo", model.getPhoto());
                ((BaseActivity)mContext).openActivity(FriendsDetailsActivity.class,bundle);
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
