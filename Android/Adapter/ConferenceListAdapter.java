package com.wowo.wowo.Adapter;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Activity.ConferenceDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.TextView.JustifyTextView;
import com.wowo.wowo.Model.ConferenceListModel;

import java.util.List;



public class ConferenceListAdapter extends BaseAdapter{
    private Context mContext;
    private List<ConferenceListModel> models;
    private Bundle bundle;
    public ConferenceListAdapter(Context mContext, List<ConferenceListModel> models){
        this.mContext = mContext;
        this.models = models;
    }
    @Override
    public int getCount() {
        return models.size();
    }

    @Override
    public Object getItem(int position) {
        return models.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        final ViewHolder holder;
        final ConferenceListModel model = (ConferenceListModel) getItem(position);
        if (convertView==null){
            holder = new ViewHolder();
            convertView = View.inflate(mContext, R.layout.item_list_conference,null);
            holder.mLItem= (LinearLayout) convertView.findViewById(R.id.item_ly_conference);
            holder.mIvHead = (ImageView) convertView.findViewById(R.id.item_list_con_img);
            holder.mTvTitle = (TextView) convertView.findViewById(R.id.item_list_con_title);
            holder.mTvTime = (TextView) convertView.findViewById(R.id.item_list_con_time);
            holder.mTvAddress = (TextView) convertView.findViewById(R.id.item_list_con_address);
            convertView.setTag(holder);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }
        GlideUtils.loadImageView(mContext,model.getMImg(),holder.mIvHead);
        holder.mTvTitle.setText(model.getMName());
        holder.mTvTime.setText("时间： "+model.getMStarttime()+" -- "+ model.getMStoptime());
        holder.mTvAddress.setText("地址： "+model.getMAddress());
        holder. mLItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putInt("mId", model.getMId());
                ((BaseActivity) mContext).openActivity(ConferenceDetailsActivity.class, bundle);
            }
        });

        return convertView;
    }
    class ViewHolder{
        LinearLayout mLItem;
        ImageView mIvHead;
        TextView mTvTitle,mTvTime,mTvAddress;
    }
}
