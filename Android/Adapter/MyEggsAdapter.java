package com.wowo.wowo.Adapter;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wowo.wowo.R;
import com.wowo.wowo.Utils.CommonUtils;
import com.wowo.wowo.Views.Countdown.CountdownView;

import java.util.HashMap;
import java.util.List;

public class MyEggsAdapter extends RecyclerView.Adapter<MyEggsAdapter.ViewHolder>{
    private Context mContext;
    private List<Integer> list;
    private HashMap<Integer,Boolean> map;
    public MyEggsAdapter(Context mContext){
        this.mContext= mContext;
    }
    public void setData(List<Integer > list ){
        this.list = list;
        map = new HashMap<>();
        for (int i = 0; i < list.size(); i++) {
            map.put(i,false);
        }
    }
    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.my_eggs_item, parent, false);
        MyEggsAdapter.ViewHolder viewHolder = new MyEggsAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull final ViewHolder holder, final int position) {
        int type = list.get(position);
        if (type == 1){
            holder.eggs_data_relative.setVisibility(View.GONE);
            holder.eggs_countdown.setVisibility(View.GONE);
            holder.eggs_time.setTextColor(mContext.getResources().getColor(R.color.gray_light));
            holder.eggs_input_number.setVisibility(View.GONE);
            holder.eggs_money.setVisibility(View.VISIBLE);
            holder.eggs_money.setText("+100");
            holder.eggs_countdown.stop();
            holder.eggs_details.setVisibility(View.GONE);
        }else if (type == 2){
            holder.eggs_data_relative.setVisibility(View.GONE);
            holder.eggs_countdown.setVisibility(View.VISIBLE);
            holder.eggs_time.setTextColor(mContext.getResources().getColor(R.color.main_color));
            holder.eggs_input_number.setVisibility(View.VISIBLE);
            holder.eggs_money.setVisibility(View.INVISIBLE);
            holder.eggs_input_number.setText("已投入  1234");
            long value = CommonUtils.getStringToDate(CommonUtils.changeweek("2018-09-10 12:20:32"),"yyyy-MM-dd HH:mm:ss")-System.currentTimeMillis();//订单时间+24小时-当前时间
            holder.eggs_countdown.start(value);
            holder.eggs_details.setVisibility(View.GONE);
        }else if (type == 3){
            holder.eggs_data_relative.setVisibility(View.VISIBLE);
            holder.eggs_countdown.setVisibility(View.GONE);
            holder.eggs_time.setTextColor(mContext.getResources().getColor(R.color.gray_light));
            holder.eggs_input_number.setVisibility(View.GONE);
            holder.eggs_money.setVisibility(View.VISIBLE);
            holder.eggs_money.setText("+25000");
            holder.eggs_countdown.stop();
            if (map.get(position)){
                holder.eggs_details.setVisibility(View.VISIBLE);
                holder.eggs_data_img.setBackgroundResource(R.mipmap.bihe);
            }else{
                holder.eggs_details.setVisibility(View.GONE);
            }
        }
        holder.eggs_data_relative.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (map.get(position)){
                    holder.eggs_details.setVisibility(View.GONE);
                    holder.eggs_data_img.setBackgroundResource(R.mipmap.zhankai);
                    map.put(position,false);
                }else{
                    holder.eggs_details.setVisibility(View.VISIBLE);
                    holder.eggs_data_img.setBackgroundResource(R.mipmap.bihe);
                    map.put(position,true);
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
        TextView eggs_title;//标题
        TextView eggs_money;//收入--支出
        TextView eggs_time;//时间
        CountdownView eggs_countdown;//倒计时
        RelativeLayout eggs_data_relative;//游戏数据点击
        TextView eggs_input_number;//投入数量
        LinearLayout eggs_details;//详情
        ImageView eggs_data_img;//数据图片箭头
        ViewHolder(View itemView) {
            super(itemView);
            eggs_title =  itemView.findViewById(R.id.eggs_title);
            eggs_money =  itemView.findViewById(R.id.eggs_money);
            eggs_time =  itemView.findViewById(R.id.eggs_time);
            eggs_countdown =  itemView.findViewById(R.id.eggs_countdown);
            eggs_data_relative =  itemView.findViewById(R.id.eggs_data_relative);
            eggs_input_number =  itemView.findViewById(R.id.eggs_input_number);
            eggs_details = itemView.findViewById(R.id.eggs_details);
            eggs_data_img = itemView.findViewById(R.id.eggs_data_img);
        }
    }
}
