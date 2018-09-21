package com.fbs.wowo.blockchain.web;

import com.fbs.wowo.base.BaseController;
import com.fbs.wowo.base.Response;
import com.fbs.wowo.blockchain.entity.RedMulti;
import com.fbs.wowo.blockchain.entity.RedSingle;
import com.fbs.wowo.blockchain.service.RedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/red")
public class RedController extends BaseController {

    // 发单人红包
    @PostMapping("/sendSingle")
    @ResponseBody
    public Response sendSingle(@ModelAttribute RedSingle redSingle) {
        redService.sendRedSingle(redSingle);
        return success();
    }

    // 领单人红包
    @PostMapping("/recvSingle")
    @ResponseBody
    public Response recvSingle(@RequestParam String redSingleId) {
        return success(redService.recvRedSingle(redSingleId));
    }

    // 发群红包
    @PostMapping("/sendMulti")
    @ResponseBody
    public Response sendMulti(@ModelAttribute RedMulti redMulti) {
        redService.sendRedMulti(redMulti);
        return success();
    }
    // 领群红包
    @PostMapping("/recvMulti")
    @ResponseBody
    public Response recvMulti(@RequestParam String redMultiId, @RequestParam String recvId) {
        return success(redService.recvRedMulti(redMultiId, recvId));
    }

    @GetMapping("/single")
    @ResponseBody
    public Response single(@RequestParam String redSingleId) {
        return success(redService.findRedSingleByRedId(redSingleId));
    }

    @GetMapping("/multi")
    @ResponseBody
    public Response multi(@RequestParam String redMultiId, @RequestParam String recvId) {
        return success(redService.findRedMultiByRedId(redMultiId, recvId));
    }

    @Autowired
    private RedService redService;
}
