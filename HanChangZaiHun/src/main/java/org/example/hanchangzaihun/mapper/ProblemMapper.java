package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.hanchangzaihun.entity.Problem;
import org.example.hanchangzaihun.entity.Users;

import java.util.List;

@Mapper
public interface ProblemMapper {
    @Select("select * from han.problem")
    List<Problem> selectAll();
    @Select("select goal from han.users where username=#{username}")
    int selectByGoal(String username);
    @Update("update han.users set han.users.goal=#{i} where han.users.username=#{username}")
    void update(String username, int i);
    @Select("select * from han.users where username=#{username}")
    Users selectByUsername(String username);
}
