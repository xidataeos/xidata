package com.fbs.wowo.util.eos;

import com.alibaba.fastjson.JSONObject;
import com.fbs.wowo.util.HttpUtils;
import org.apache.http.entity.StringEntity;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class EOSUtils {

    /**
     * 生成公钥 生成私钥
     * @return
     */
    public static Map<String, String> EOSKey() {
        Map<String, String> keySet = new HashMap<>();
        try {
            keySet = HttpUtils.KeySet("/createkey");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return keySet;
    }

    /**
     * 发送数据到链上 转账 TODO WOT
     */
    public static String transfer(String fromId, String fromPubKey, String toId, String toPubKey, String asset, String tip) {
        JSONObject jo = new JSONObject();
        jo.put("from", fromId);
        jo.put("fromPK", fromPubKey);
        jo.put("to", toId);
        jo.put("toPK", toPubKey);
        jo.put("asset", asset + " SH");
        jo.put("memo", tip);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/fbstransfer", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }
    /**
     * 发红包
     */
    public static String sendRed(String fromId, String fromPubKey, String asset, int count, String tip) {
        JSONObject jo = new JSONObject();
        jo.put("user", fromId);
        jo.put("userPK", fromPubKey);
        jo.put("asset", asset + " SH");
        jo.put("num", count);
        jo.put("memo", tip);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/redenvelope/send", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }

    /**
     * 收红包
     */
    public static String recvRed(String toId, String toPubKey, String asset, String tip) {
        JSONObject jo = new JSONObject();
        jo.put("user", toId);
        jo.put("userPK", toPubKey);
        jo.put("asset", asset + " SH");
        jo.put("memo", tip);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/redenvelope/recv", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }

    /**
     *  创建游戏
     *  @Param gameId:游戏的唯一标识
     *  @Param creator:创建游戏者
     *  @Param category:分类
     *  @Param memo:备注  谁创建了游戏
     */
    public static String eggCreate(String gameid, String creator, String category, String memo) {
        JSONObject jo = new JSONObject();
        jo.put("gameid", gameid);
        jo.put("creator", creator);
        jo.put("category", category);
        jo.put("memo", memo);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/egggame/create", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }

    /**
     *  用户下注
     *  @Param gameid:游戏标识
     *  @Param gamename:游戏名称
     *  @Param user:下注者名称
     *  @Param userPK:下注者公钥
     *  @Param quantity:下注金额   100.0000 WOT
     *  @Param memo:描述   用户谁下注多少彩蛋
     *
     *
     */
    public static String eggBet(String gameid, String gamename, String user, String userPK, String quantity, String memo) {
        JSONObject jo = new JSONObject();
        jo.put("gameid", gameid);
        jo.put("gamename", gamename);
        jo.put("user", user);
        jo.put("userPK", userPK);
        jo.put("quantity", quantity);
        jo.put("memo", memo);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/egggame/bet", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }

    /**
     *游戏结算
     * @Param gameId:游戏ID
     * @Param gamename:游戏名称
     * @Param user:下注者名称
     * @Param userPK:用户公钥
     * @Param quantity:结算金额
     * @Param memo:描述
     *
     */
    public static String eggSettlement(String gameid, String gamename, String user, String userPK, String quantity, String memo) {
        JSONObject jo = new JSONObject();
        jo.put("gameid", gameid);
        jo.put("gamename", gamename);
        jo.put("user", user);
        jo.put("userPK", userPK);
        jo.put("quantity", quantity);
        jo.put("memo", memo);

        String transaction_id = null;
        try {
            transaction_id = HttpUtils.post("/egggame/settlement", jo.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return transaction_id;
    }
}
