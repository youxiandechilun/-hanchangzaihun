package org.example.hanchangzaihun.service;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.Users;
import org.example.hanchangzaihun.mapper.WebMapper;
import org.springframework.stereotype.Service;

@Service
public class WebService {
    @Resource
    private WebMapper loginMapper;

    public Users login(String username) {
        return loginMapper.login(username);
    }

    public int selectByUsername(String username) {
        return loginMapper.selectByUsername(username);
    }

    public int selectByName(String name) {
        return loginMapper.selectByName(name);
    }

    public void register(Users users) {
        loginMapper.register(users);
    }

    public Users selectByUsername2(String username) {
        return loginMapper.selectByUsername2(username);
    }

}
