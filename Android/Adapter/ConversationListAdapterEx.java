package com.wowo.wowo.Adapter;

import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;

import io.rong.imkit.model.UIConversation;
import io.rong.imkit.widget.adapter.ConversationListAdapter;
import io.rong.imlib.model.Conversation;


public class ConversationListAdapterEx extends ConversationListAdapter {
    private static final String TAG= ConversationListAdapterEx.class.getSimpleName();
    public ConversationListAdapterEx(Context context) {
        super(context);
    }

    @Override
    protected View newView(Context context, int position, ViewGroup group) {
        return super.newView(context, position, group);
    }

    @Override
    protected void bindView(View v, int position, UIConversation data) {
        Log.e(TAG, "bindView: " );
        if (data != null) {
            Log.e(TAG, "data != null: " );
            if (data.getConversationType().equals(Conversation.ConversationType.DISCUSSION))
                Log.e(TAG, "equals: " );
                data.setUnreadType(UIConversation.UnreadRemindType.REMIND_ONLY);

        }
        super.bindView(v, position, data);
    }
}
