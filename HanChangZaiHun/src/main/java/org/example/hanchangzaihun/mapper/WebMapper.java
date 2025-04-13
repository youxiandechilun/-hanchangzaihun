package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.hanchangzaihun.entity.Users;

@Mapper
public interface WebMapper {
    @Select("SELECT * FROM han.users WHERE username=#{username}")
    Users login(String username);

    @Select("select count(*) from han.users where username=#{username}")
    int selectByUsername(String username);

    @Select("select count(*) from han.users where name=#{name}")
    int selectByName(String name);

    @Insert("insert into han.users(username, password, name, goal) VALUES (#{username},#{password},#{name},#{goal})")
    void register(Users users);

    @Select("select * from han.users where username=#{username}")
    Users selectByUsername2(String username);
}
