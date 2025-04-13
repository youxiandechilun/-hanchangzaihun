package org.example.hanchangzaihun.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.hanchangzaihun.entity.Clothing;

import java.util.List;

@Mapper
public interface ClothingMapper {
    @Select("select * from han.female_clothing where era_tag like concat ('%',#{eraTag},'%') and style_tag like concat('%',#{styleTag},'%')")
    List<Clothing> selectAll1(Clothing clothing);
    @Select("select * from han.male_clothing where era_tag like concat ('%',#{eraTag},'%') and style_tag like concat('%',#{styleTag},'%')")
    List<Clothing> selectAll2(Clothing clothing);
}
