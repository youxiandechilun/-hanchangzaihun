package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.entity.Message;
import org.example.hanchangzaihun.service.MessageService;
import org.example.hanchangzaihun.service.WebService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/message")
public class MessageController {
    @Resource
    private MessageService messageService;
    @Resource
    private WebService webService;

    @PostMapping("/add")
    public Result add(@RequestBody Message message) {
        if (webService.selectByUsername(message.getUsername()) == 0) {
            return Result.error("当前账号不存在，遇到错误");
        } else {
            messageService.add(message);
            return Result.success(messageService.selectByUsername(message.getUsername(), message.getContent()));
        }
    }

    @GetMapping("/selectAll")
    public Result selectAll() {
        return Result.success(messageService.selectAll());
    }
}
