package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.hanchangzaihun.entity.News;

import java.util.List;

@Mapper
public interface NewsMapper {
    @Select("select * from han.news")
    List<News> selectAll();
    @Select("select * from han.news where id=#{id}")
    News selectId(Integer id);
}
