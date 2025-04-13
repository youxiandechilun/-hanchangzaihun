package org.example.hanchangzaihun.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Users {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private Integer goal;
}
