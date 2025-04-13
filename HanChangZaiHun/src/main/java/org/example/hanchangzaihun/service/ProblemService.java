package org.example.hanchangzaihun.service;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.Problem;
import org.example.hanchangzaihun.entity.Users;
import org.example.hanchangzaihun.mapper.ProblemMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProblemService {
    @Resource
    private ProblemMapper problemMapper;

    public List<Problem> selectAll() {
        return problemMapper.selectAll();
    }

    public Users update(String username) {
        int goals = problemMapper.selectByGoal(username);
        problemMapper.update(username, goals + 1);
        return problemMapper.selectByUsername(username);
    }
}
