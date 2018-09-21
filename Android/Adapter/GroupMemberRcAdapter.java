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
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.List;

import io.rong.imkit.RongIM;

public class GroupMemberRcAdapter extends RecyclerView.Adapter<GroupMemberRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private String mUserId;
    private List<GroupMemberModel> list;

    public GroupMemberRcAdapter(Context mContext, List<GroupMemberModel> list ,String mUserId) {
        this.list = list;
        this.mContext= mContext;
        this.mUserId= mUserId;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_list_friends, parent, false);
        GroupMemberRcAdapter.ViewHolder viewHolder = new GroupMemberRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
            final GroupMemberModel model  = list.get(position);
            GlideUtils.loadImageView(mContext,model.getPhoto(),holder.mCiHead);
            holder.mTvName.setText(model.getName());
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
                bundle.putString("photo", model.getPhoto());
                if (!mUserId.equals(model.getUid()+"")) {
                    ((BaseActivity) mContext).openActivity(FriendsDetailsActivity.class, bundle);
                }
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
        CheckBox mCbChooseFriends;
        ViewHolder(View itemView) {
            super(itemView);
            mLyItem =  itemView.findViewById(R.id.item_friends);
            mTvName = itemView.findViewById(R.id.item_tv_firiendname);
            mCiHead = itemView.findViewById(R.id.item_ci_group);
            mCbChooseFriends= itemView.findViewById(R.id.item_cb_chosefriend);
            mCbChooseFriends.setVisibility(View.GONE);
        }
    }
    }
