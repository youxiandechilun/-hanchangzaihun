package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.hanchangzaihun.entity.Message;

import java.util.List;

@Mapper
public interface MessageMapper {
    @Insert("insert into han.message(username, category, content, create_time) VALUES (#{username},#{category},#{content},#{createTime})")
    void add(Message message);
    @Select("select * from han.message where username=#{username} and content=#{content}")
    List<Message> selectByUsername(String username, String content);
    @Select("select * from han.message")
    List<Message> selectAll();
}
