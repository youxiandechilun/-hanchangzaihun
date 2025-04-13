package org.example.hanchangzaihun.service;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.News;
import org.example.hanchangzaihun.mapper.NewsMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NewsService {
    @Resource
    private NewsMapper newsMapper;

    public List<News> selectAll() {
        return newsMapper.selectAll();
    }

    public News selectId(Integer id) {
        return newsMapper.selectId(id);
    }
}
