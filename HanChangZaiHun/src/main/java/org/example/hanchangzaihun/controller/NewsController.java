package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.service.NewsService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/news")
public class NewsController {
    @Resource
    private NewsService newsService;

    @RequestMapping("/selectAll")
    public Result selectAll() {
        return Result.success(newsService.selectAll());
    }
    @RequestMapping("/selectId/{id}")
    public Result selectAll(@PathVariable Integer id) {
        return Result.success(newsService.selectId(id));
    }
}
