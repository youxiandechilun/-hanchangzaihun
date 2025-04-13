package org.example.hanchangzaihun.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Clothing {
    private Integer id;
    private String url;
    private String eraTag;
    private String styleTag;
    private Integer goal;
    private String name;
}
