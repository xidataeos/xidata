package com.wowo.wowo.Adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wowo.wowo.Bean.ByUserBean;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CommonUtils;
import com.wowo.wowo.Views.Countdown.CountdownView;

import java.util.HashMap;
import java.util.List;

public class MessageRemindAdapter extends RecyclerView.Adapter<MessageRemindAdapter.ViewHolder>{
    private Context mContext;
    private List<ByUserBean> list;
    public MessageRemindAdapter(Context mContext){
        this.mContext= mContext;
    }
    public void setData(List<ByUserBean> list ){
        this.list = list;

    }
    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.message_remind_item, parent, false);
        MessageRemindAdapter.ViewHolder viewHolder = new MessageRemindAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull final ViewHolder holder, final int position) {
        final ByUserBean bean = list.get(position);
        holder.message_remind_time.setText("会议开始时间:"+bean.getmStarttime());
        holder.message_remind_title.setText(bean.getmName());
        holder.message_remind_linear.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                click.setOnclick(bean.getmId());
            }
        });
    }
    private itemClick click;
    public void setItemClick(itemClick click){
        this.click = click;
    }
    public interface itemClick{
        void setOnclick(int mId);
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
        TextView message_remind_title;//标题
        TextView message_remind_time;//时间
        LinearLayout message_remind_linear;
        ViewHolder(View itemView) {
            super(itemView);
            message_remind_title =  itemView.findViewById(R.id.message_remind_title);
            message_remind_time =  itemView.findViewById(R.id.message_remind_time);
            message_remind_linear = itemView.findViewById(R.id.message_remind_linear);

        }
    }
}
