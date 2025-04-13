package org.example.hanchangzaihun.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
    private Integer id;
    private String username;
    private Integer category;
    private String content;
    private String createTime;
}
