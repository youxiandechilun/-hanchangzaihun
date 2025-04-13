package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.service.KnowledgeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/knowledge")
public class KnowledgeController {
    @Resource
    private KnowledgeService knowledgeService;
    @GetMapping("/selectAll")
    public Result selectAll(){
        return Result.success(knowledgeService.selectAll());
    }
}
