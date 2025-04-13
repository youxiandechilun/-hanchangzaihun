package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.entity.Users;
import org.example.hanchangzaihun.service.WebService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping
public class WebController {
    @Resource
    private WebService loginService;

    @PostMapping("/login")
    public Result login(@RequestBody Users users) {
        Users users1 = loginService.login(users.getUsername());
        if (users1 != null) {
            if (users1.getPassword().equals(users.getPassword())) {
                return Result.success(users1);
            } else {
                return Result.error("密码错误");
            }
        } else {
            return Result.error("用户不存在,请您先注册账号");
        }
    }

    @PostMapping("/register")
    public Result register(@RequestBody Users users) {
        if (loginService.selectByUsername(users.getUsername()) == 0) {
            if (loginService.selectByName(users.getName()) == 0) {
                loginService.register(users);
                return Result.success(loginService.selectByUsername2(users.getUsername()));
            } else {
                return Result.error("昵称已存在");
            }
        } else {
            return Result.error("账号已存在");
        }
    }

    @GetMapping("/selectByUsername/{username}")
    public Result selectByUsername(@PathVariable("username") String username) {
        return Result.success(loginService.selectByUsername2(username));
    }
}
