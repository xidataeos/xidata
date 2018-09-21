package com.fbs.wowo.chat.web;

import com.fbs.wowo.base.BaseController;
import com.fbs.wowo.base.Response;
import com.fbs.wowo.chat.entity.Crew;
import com.fbs.wowo.chat.service.CrewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/crew")
public class CrewController extends BaseController {
    /**
     * uid
     * name
     * photo 群头像
     * pub 是否需要验证入群
     * brief
     */
    @PostMapping("/create")
    @ResponseBody
    public Response create(@ModelAttribute Crew crew, @RequestParam(required = false) MultipartFile photoFile) {
        return success(crewService.create(crew, photoFile));
    }

    @PostMapping("/create/add")
    @ResponseBody
    public Response create(@ModelAttribute Crew crew, @RequestParam String[] uids, @RequestParam(required = false) MultipartFile photoFile) {
        return success(crewService.create(crew, uids, photoFile));
    }

    @PostMapping("/invite")
    @ResponseBody
    public Response invite(@RequestParam String crewId, @RequestParam String[] uids) {
        crewService.invite(crewId, uids);
        return success();
    }

    @PostMapping("/join")
    @ResponseBody
    public Response join(@RequestParam String crewId, @RequestParam String userId) {
        crewService.join(crewId, userId);
        return success();
    }

    @PostMapping("/reply")
    @ResponseBody
    public Response reply(@RequestParam String crewId, @RequestParam String userId, @RequestParam(required = false) String content) {
        return success(crewService.reply(crewId, userId, content));
    }

    @GetMapping("/crewList")
    @ResponseBody
    public Response crewList(@RequestParam String userId) {
        return success(crewService.crewList(userId));
    }

    @GetMapping("/memberList")
    @ResponseBody
    public Response crewMember(@RequestParam String crewId) {
        return success(crewService.crewMember(crewId));
    }

    @PostMapping("/remove")
    @ResponseBody
    public Response remove(@RequestParam String crewId, @RequestParam String userId) {
        // TODO session判断群主
        crewService.remove(crewId, userId);
        return success();
    }
    @PostMapping("/del")
    @ResponseBody
    public Response del(@RequestParam String crewId, @RequestParam String ownerId) {
        // TODO session判断群主
        crewService.del(crewId, ownerId);
        return success();
    }

    @GetMapping("/s")
    @ResponseBody
    public Response find(@RequestParam String crewId, @RequestParam String userId) {
        return success(crewService.find(crewId, userId));
    }

    @PostMapping("/modify")
    @ResponseBody
    public Response modifyCrew(@ModelAttribute Crew crew, @RequestParam String ownerId, @RequestParam(required = false) MultipartFile photoFile) {
        return success(crewService.modifyCrew(crew, ownerId, photoFile));
    }

    @PostMapping("/modify/nickname")
    @ResponseBody
    public Response modifyNickname(@RequestParam String crewId, @RequestParam String userId, @RequestParam String nickname) {
        return success(crewService.modifyCrewNickname(crewId, userId, nickname));
    }

    @GetMapping("/hotCrew")
    @ResponseBody
    public Response hotCrew() {
        return success(crewService.hotCrew());
    }

    @PostMapping("/shield")
    @ResponseBody
    public Response shield(@RequestParam String crewId, @RequestParam String userId, @RequestParam Byte shield) {
        return success(crewService.shield(crewId, userId, shield));
    }

    @GetMapping("/query")
    @ResponseBody
    public Response hotCrew(@RequestParam String query) {
        return success(crewService.findByQueryString(query));
    }

    @Autowired
    private CrewService crewService;
}
