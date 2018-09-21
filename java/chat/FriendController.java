package com.fbs.wowo.chat.web;

import com.fbs.wowo.base.BaseController;
import com.fbs.wowo.base.Response;
import com.fbs.wowo.chat.entity.Friend;
import com.fbs.wowo.chat.service.FriendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping("/friend")
public class FriendController extends BaseController {
    /**
     * 拒绝好友请求
     */
    @PostMapping("/reject")
    @ResponseBody
    public Response reject(@ModelAttribute Friend friend) {
        friendService.reject(friend);
        return success();
    }

    /**
     * 添加好友 通过好友验证
      */
    @PostMapping("/add")
    @ResponseBody
    public Response join(@Valid @ModelAttribute Friend friend, BindingResult bindingResult) {
        friendService.join(friend);
        return success();
    }

    /**
     * 发送好友验证
     * @param friend
     * @return
     */
    @PostMapping("/invite")
    @ResponseBody
    public Response invite(@Valid @ModelAttribute Friend friend, BindingResult bindingResult, @RequestParam(required = false) String content) {
        friendService.invite(friend, content);
        return success();
    }

    /**
     * 好友列表
     * @param uid 某人的userId，用于查找他的好友
     * @return
     */
    @GetMapping("/list")
    @ResponseBody
    public Response selectAll(@RequestParam String uid) {
        return success(friendService.selectAll(uid));
    }

    /**
     * 按双方id 获取好友关系
     * @param mid
     * @param fid
     * @return
     */
    @GetMapping("/f")
    @ResponseBody
    public Response selectByPrimaryKeyValid(@RequestParam String mid, @RequestParam String fid) {
        return success(friendService.selectByPrimaryKeyValid(mid, fid));
    }

    /**
     * 删除好友
     * @param mid
     * @param fid
     * @return
     */
    @PostMapping("/del")
    @ResponseBody
    public Response del(@RequestParam String mid, @RequestParam String fid) {
        friendService.deleteByPrimaryKey(mid, fid);
        return success();
    }

    /**
     * 修改好友备注
     * @param mid 我的id
     * @param fid 好友id
     * @param nickname 昵称
     * @return
     */
    @PostMapping("/nickname")
    @ResponseBody
    public Response nickname(@RequestParam String mid, @RequestParam String fid, @RequestParam String nickname) {
        // 需要判断记录是fNickname还是myNickname
        // 只能修改自己对对方的
        friendService.updateNickname(mid, fid, nickname);
        return success();
    }

    /**
     * 获取好友信息
     * @param mid 我的id
     * @param fid 好友id
     * @return
     */
    @GetMapping("/friendInfo")
    @ResponseBody
    public Response friendInfo(@RequestParam String mid, @RequestParam String fid) {
        return success(friendService.friendInfo(mid, fid));
    }

    @Autowired
    private FriendService friendService;
}
