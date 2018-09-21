package com.wowo.wowo.Adapter;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wowo.wowo.Activity.ConferenceDetailsActivity;
import com.wowo.wowo.Activity.EducationDetailsActivity;
import com.wowo.wowo.Activity.GroupDetailsActivity;
import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.EducationListModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.GlideUtils;
import com.wowo.wowo.Views.CircleImageView.CircleImageView;

import java.util.List;

public class EducationRcAdapter extends RecyclerView.Adapter<EducationRcAdapter.ViewHolder>{
    private Bundle bundle;
    private Context mContext;
    private List<EducationListModel> list;
    private int finish;
    public EducationRcAdapter(Context mContext, List<EducationListModel> list) {
        this.list = list;
        this.mContext= mContext;
    }
    public EducationRcAdapter(Context mContext, List<EducationListModel> list ,int finish) {
        this.list = list;
        this.mContext= mContext;
        this.finish= finish;
    }

    @Override
    public ViewHolder onCreateViewHolder( ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_gv_educationlist, parent, false);
        EducationRcAdapter.ViewHolder viewHolder = new EducationRcAdapter.ViewHolder(view);
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
            final EducationListModel model  = list.get(position);
            holder.mTvTitle.setText(model.getETitle());
            holder.mTvSynop.setText(model.getESyIntro());
            if (model.getEFlame()){
                holder.mIvFire.setVisibility(View.VISIBLE);
            }else{
                holder.mIvFire.setVisibility(View.GONE);
            }
        GlideUtils.loadImageView(mContext,model.getEImg(),holder.mIvPic);
             holder. mLyItem.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle = new Bundle();
                bundle.putInt("EId", model.getEId());
                ((BaseActivity) mContext).openActivity(EducationDetailsActivity.class, bundle);
                if (finish==1){
                    ((BaseActivity) mContext).finish();
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
        TextView mTvTitle,mTvSynop;
        ImageView mIvPic,mIvFire;
        LinearLayout mLyItem;
        ViewHolder(View itemView) {
            super(itemView);
            mLyItem =  itemView.findViewById(R.id.item_gv_education);
            mIvPic=  itemView.findViewById(R.id.item_iv_pic);
            mIvFire=  itemView.findViewById(R.id.item_iv_fire);
            mTvTitle = itemView.findViewById(R.id.item_tv_title);
            mTvSynop = itemView.findViewById(R.id.item_tv_synop);
        }
    }
    }
