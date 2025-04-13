package org.example.hanchangzaihun.controller;

import jakarta.annotation.Resource;
import org.example.hanchangzaihun.common.Result;
import org.example.hanchangzaihun.entity.Clothing;
import org.example.hanchangzaihun.service.ClothingServer;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/clothing")
public class ClothingController {
    @Resource
    private ClothingServer clothingServer;
    @PostMapping("/selectAll1")
    public Result selectAll1(@RequestBody Clothing clothing){
        if(clothing.getEraTag()==null){
            clothing.setEraTag("");
        }
        if(clothing.getStyleTag()==null){
            clothing.setStyleTag("");
        }
        return Result.success(clothingServer.selectAll1(clothing));
    }
    @PostMapping("/selectAll2")
    public Result selectAll2(@RequestBody Clothing clothing){
        if(clothing.getEraTag()==null){
            clothing.setEraTag("");
        }
        if(clothing.getStyleTag()==null){
            clothing.setStyleTag("");
        }
        return Result.success(clothingServer.selectAll2(clothing));
    }
}
