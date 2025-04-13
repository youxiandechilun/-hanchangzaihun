package org.example.hanchangzaihun.service;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.Clothing;
import org.example.hanchangzaihun.mapper.ClothingMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClothingServer {
    @Resource
    private ClothingMapper clothingMapper;

    public List<Clothing> selectAll1(Clothing clothing) {
        return clothingMapper.selectAll1(clothing);
    }

    public List<Clothing> selectAll2(Clothing clothing) {
        return clothingMapper.selectAll2(clothing);
    }
}
