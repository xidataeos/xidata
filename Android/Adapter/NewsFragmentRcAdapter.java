package com.wowo.wowo.Adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.wowo.wowo.Model.FindNewsModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Utils.LogUtil;

import java.util.List;

public class NewsFragmentRcAdapter extends RecyclerView.Adapter<NewsFragmentRcAdapter.ViewHolder>{
    private Context mContext;
    private List<FindNewsModel> list;

    public NewsFragmentRcAdapter(Context mContext, List<FindNewsModel> list) {
        this.list = list;
        this.mContext= mContext;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.news_fragment_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final FindNewsModel model  = list.get(position);
        int type = model.getType();
        initView(holder,type,model);
            holder.item_click.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                LogUtil.e("TAG","点击Item3:"+list.get(position).getnId());
                onClick.click(model.getnId());
            }
        });
    }
    private OnClick onClick;
    public void setOnClick(OnClick onClick){
        this.onClick = onClick;
    }
    public interface OnClick{
        void click(int id);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    private void initView(ViewHolder holder,int type,FindNewsModel model){
        if (type == 0){
            holder.news_type1.setVisibility(View.GONE);
            holder.news_type2.setVisibility(View.GONE);
            holder.news_type3.setVisibility(View.VISIBLE);
            holder.news_type3_title.setText(model.getTitle());
            holder.news_type3_describe.setText(model.getIntro());
            holder.news_type3_route.setText(model.getUserName());
        }else if (type == 1){
            holder.news_type1.setVisibility(View.GONE);
            holder.news_type2.setVisibility(View.VISIBLE);
            holder.news_type3.setVisibility(View.GONE);
            GlideUtils.loadImageView(mContext,model.getImg(),holder.news_type2_image);
            holder.news_type2_title.setText(model.getTitle());
            holder.news_type2_describe.setText(model.getIntro());
            holder.news_type2_route.setText(model.getUserName());
        }else if (type > 1){
            //
            holder.news_type1.setVisibility(View.VISIBLE);
            holder.news_type2.setVisibility(View.GONE);
            holder.news_type3.setVisibility(View.GONE);
            String[] all=model.getImg().split(",");

            for (int i = 0; i < all.length; i++) {
                //LogUtil.e("TAG","加载图片:"+all[i]);
                if (i == 0){
                    GlideUtils.loadImageView(mContext,all[i],holder.news_type1_image1);
                }else if (i == 1){
                    GlideUtils.loadImageView(mContext,all[i],holder.news_type1_image2);
                }else if (i == 2){
                    GlideUtils.loadImageView(mContext,all[i],holder.news_type1_image3);
                }
            }
            holder.news_type1_title.setText(model.getTitle());
            holder.news_type1_route.setText(model.getUserName());
        }
    }
    class ViewHolder extends RecyclerView.ViewHolder {
        RelativeLayout news_type1,news_type2,news_type3;
        ImageView news_type1_image1,news_type1_image2,news_type1_image3;
        TextView news_type1_title,news_type1_route;
        //item 2
        ImageView news_type2_image;
        TextView news_type2_title;
        TextView news_type2_describe;
        TextView news_type2_route;
        //item3
        TextView news_type3_title;
        TextView news_type3_describe;
        TextView news_type3_route;
        //item点击
        LinearLayout item_click;
        ViewHolder(View itemView) {
            super(itemView);
            news_type1 = itemView.findViewById(R.id.news_type1);
            news_type2 = itemView.findViewById(R.id.news_type2);
            news_type3 = itemView.findViewById(R.id.news_type3);
            news_type1_image1 = itemView.findViewById(R.id.news_type1_image1);
            news_type1_image2 = itemView.findViewById(R.id.news_type1_image2);
            news_type1_image3 = itemView.findViewById(R.id.news_type1_image3);
            news_type1_title = itemView.findViewById(R.id.news_type1_title);
            news_type1_route = itemView.findViewById(R.id.news_type1_route);
            news_type2_image = itemView.findViewById(R.id.news_type2_image);
            news_type2_title = itemView.findViewById(R.id.news_type2_title);
            news_type2_describe = itemView.findViewById(R.id.news_type2_describe);
            news_type2_route = itemView.findViewById(R.id.news_type2_route);
            news_type3_title = itemView.findViewById(R.id.news_type3_title);
            news_type3_describe = itemView.findViewById(R.id.news_type3_describe);
            news_type3_route = itemView.findViewById(R.id.news_type3_route);
            item_click = itemView.findViewById(R.id.item_click);
        }
    }
}
