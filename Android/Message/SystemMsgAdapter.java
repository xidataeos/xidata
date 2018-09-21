package com.wowo.wowo.Message;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.wowo.wowo.Base.BaseActivity;
import com.wowo.wowo.Model.UserModel;
import com.wowo.wowo.R;
import com.wowo.wowo.Utils.Encrypt;
import com.wowo.wowo.Utils.SharedPreferencesManager;
import com.wowo.wowo.rxjava.BaseResponse;
import com.wowo.wowo.rxjava.ProgressSubscriber;
import com.wowo.wowo.rxjava.RetrofitAPIManager;
import com.wowo.wowo.rxjava.SubscriberOnNextListener;

import java.util.List;

public class SystemMsgAdapter extends BaseAdapter{
    private List<SystemMsgModel> models;
    private Context mContext;
    private UserModel userModel;

    public SystemMsgAdapter(Context mContext,List<SystemMsgModel> models) {
        this.mContext = mContext;
        this.models = models;
        userModel = SharedPreferencesManager.getInstance().getUserData(mContext);
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
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder;
        final SystemMsgModel model = (SystemMsgModel) getItem(position);
        if (convertView==null){
            holder = new ViewHolder();
//            convertView = View.inflate(mContext, R.layout.item_sys_msg,null);
//            holder.mTvText = (TextView) convertView.findViewById(R.id.item_sys_msg_text);
//            holder.mIvDot = (ImageView) convertView.findViewById(R.id.item_sys_msg_dot);
            convertView.setTag(holder);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }
        switch (model.getIsRead()){
            case "0"://未读
                holder.mIvDot.setSelected(true);
                break;
            case "1"://已读
                holder.mIvDot.setSelected(false);
                break;
        }
        holder.mTvText.setText(model.getMsg());
        convertView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                SubscriberOnNextListener mListener = new SubscriberOnNextListener<BaseResponse<String>>() {
                    @Override
                    public void onNext(BaseResponse<String> baseResponse) {
                        model.setIsRead("1");
                        notifyDataSetChanged();
                    }
                };
//                RetrofitAPIManager.getInstance().updateMessage(new ProgressSubscriber<BaseResponse<String>>(mListener,(BaseActivity)mContext,0),model.getMessageId(), Encrypt.base64(userModel.getUserId()));
            }
        });
        return convertView;
    }
    class ViewHolder{
        TextView mTvText;
        ImageView mIvDot;
    }
}
