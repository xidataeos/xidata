package com.fbs.wowo.blockchain.web;

import com.fbs.wowo.base.BaseController;
import com.fbs.wowo.base.Response;
import com.fbs.wowo.blockchain.entity.Transfer;
import com.fbs.wowo.blockchain.service.TransferService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/transfer")
public class TransferController extends BaseController {
    // 转账操作（插入）
    @PostMapping("/t")
    @ResponseBody
    public Response transfer(@ModelAttribute Transfer transfer) {
        transferService.transfer(transfer);
        return success();
    }
    // 查询转账

    @Autowired
    private TransferService transferService;
}
