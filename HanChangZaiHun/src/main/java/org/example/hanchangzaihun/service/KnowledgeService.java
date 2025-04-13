package org.example.hanchangzaihun.service;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.Knowlegde;
import org.example.hanchangzaihun.mapper.KnowledgeMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class KnowledgeService {
    @Resource
    private KnowledgeMapper knowledgeMapper;

    public List<Knowlegde> selectAll() {
        return knowledgeMapper.selectAll();
    }
}
