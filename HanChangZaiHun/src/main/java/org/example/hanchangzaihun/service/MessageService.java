package org.example.hanchangzaihun.service;

import cn.hutool.core.date.DateTime;
import jakarta.annotation.Resource;
import org.example.hanchangzaihun.entity.Message;
import org.example.hanchangzaihun.mapper.MessageMapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class MessageService {
    @Resource
    private MessageMapper messageMapper;

    public void add(Message message) {
        LocalDateTime localDateTime = new DateTime().toLocalDateTime();
        message.setCreateTime(String.valueOf(localDateTime));
        messageMapper.add(message);
    }

    public List<Message> selectByUsername(String username, String content) {
        return messageMapper.selectByUsername(username, content);
    }

    public List<Message> selectAll() {
        return messageMapper.selectAll();
    }
}
