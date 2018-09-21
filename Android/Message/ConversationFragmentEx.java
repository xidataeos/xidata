package com.wowo.wowo.Message;

import android.content.Intent;

import io.rong.imkit.fragment.ConversationFragment;
import io.rong.imlib.model.Conversation;

/**

 */
public class ConversationFragmentEx extends ConversationFragment {
    @Override
    public void onReadReceiptStateClick(io.rong.imlib.model.Message message) {
        if (message.getConversationType() == Conversation.ConversationType.GROUP) { //目前只适配了群组会话
//            Intent intent = new Intent(getActivity(), ReadReceiptDetailActivity.class);
//            intent.putExtra("message", message);
//            getActivity().startActivity(intent);
        }
    }

    public void onWarningDialog(String msg) {
        String typeStr = getUri().getLastPathSegment();
        if (!typeStr.equals("chatroom")) {
            super.onWarningDialog(msg);
        }
    }
}
