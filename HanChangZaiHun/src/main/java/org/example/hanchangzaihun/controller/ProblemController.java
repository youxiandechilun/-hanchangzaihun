package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.service.ProblemService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/problem")
public class ProblemController {
    @Resource
    private ProblemService problemService;
    @GetMapping("/selectAll")
    public Result selectAll(){
        return Result.success(problemService.selectAll());
    }
    @GetMapping("/update/{username}")
    public Result update(@PathVariable("username") String username){
        return Result.success(problemService.update(username));
    }
}
