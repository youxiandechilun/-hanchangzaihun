package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.hanchangzaihun.entity.Knowlegde;

import java.util.List;

@Mapper
public interface KnowledgeMapper {
    @Select("select * from han.knowledge")
    List<Knowlegde> selectAll();
}
