package org.example.hanchangzaihun.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Knowlegde {
    private Integer id;
    private String title;
    private String body;
    private String url;
}
