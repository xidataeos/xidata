package com.wowo.wowo.Adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import io.rong.imkit.RongContext;
import io.rong.imkit.model.UIConversation;
import io.rong.imkit.widget.adapter.ConversationListAdapter;
import io.rong.imkit.widget.provider.IContainerItemProvider;
import io.rong.imlib.model.Conversation;


public class SysteamListAdapterEx extends ConversationListAdapter {
    private Context context;
    private static final String TAG= SysteamListAdapterEx.class.getSimpleName();
    public SysteamListAdapterEx(Context context) {
//       this.context=context;
        super(context);
    }

    @Override
    protected View newView(Context context, int position, ViewGroup group) {
        this.context=context;
        View view = LayoutInflater.from(group.getContext()).inflate(R.layout.item_list_sysmess, group, false);
        SysteamListAdapterEx.ViewHolder holder = new SysteamListAdapterEx.ViewHolder(view);
        view.setTag(holder);
        return view;
//        return super.newView(context, position, group);
    }

    @Override
    protected void bindView(View v, int position, UIConversation data) {
        SysteamListAdapterEx.ViewHolder holder = (SysteamListAdapterEx.ViewHolder)v.getTag();
        Log.e(TAG, "bindView: " );
        if (data != null) {
            if (data.getIconUrl()!=null){
                GlideUtils.loadImageView(context,data.getIconUrl().toString(),holder.mIvPic);
            }
            holder.mTvTitle.setText(data.getConversationSenderId()+"请求加好友"+data.getConversationTargetId());
        }
//        super.bindView(v, position, data);
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
    }
}
