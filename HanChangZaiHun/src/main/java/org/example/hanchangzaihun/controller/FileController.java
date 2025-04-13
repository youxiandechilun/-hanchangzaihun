package org.example.hanchangzaihun.controller;

import cn.hutool.core.io.FileUtil;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.example.hanchangzaihun.common.Result;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;

@RestController
@RequestMapping("/files")
public class FileController {
//    @Value("${ip}")
//    private String ip;
    @Value("${server.port}")
    private String port;

    private static final String ROOT_PATH = System.getProperty("user.dir") + "/files";

    //文件上传
    @PostMapping("/upload")
    public Result upload(MultipartFile file) throws IOException {
        String originalFilename = file.getOriginalFilename();
        long flag = System.currentTimeMillis();
        String fileName = flag + "_" + originalFilename;
        File finalFile = new File(ROOT_PATH + "/" + fileName);
        if (!finalFile.getParentFile().exists()) {
            finalFile.getParentFile().mkdirs();
        }
        file.transferTo(finalFile);
        String url = "http://" + "8.140.229.104" + ":" + port + "/files/download?filename=" + fileName;
        //返回文件的URL路径
        return Result.success(url);
    }

    //    @GetMapping("/download")
//    public void download(String fileName, HttpServletResponse response) throws IOException {
//        File file = new File(ROOT_PATH + "/" + fileName);
//        ServletOutputStream os = response.getOutputStream();
//        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
//        response.setContentType("application/octet-stream");
//        FileUtil.writeToStream(file, os);
//        os.flush();
//        os.close();
//    }
//    @GetMapping("/download")
//    public void download(String fileName, HttpServletResponse response) throws IOException {
//        File file = new File(ROOT_PATH + "/" + fileName);  // 文件在存盘存储的对象
//        ServletOutputStream os = response.getOutputStream();
//        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
//        response.setContentType("application/octet-stream");
////        os.write(FileUtil.readBytes(file));
//        FileUtil.writeToStream(file, os);
//        os.flush();
//        os.close();
//    }
    @GetMapping("/download")
    public void download(@RequestParam String filename, HttpServletResponse response) throws IOException {
        if (filename == null || filename.isEmpty()) {
            throw new IllegalArgumentException("File name cannot be null or empty.");
        }

        String filePath = ROOT_PATH + "/" + filename;
        File file = new File(filePath);

        if (!file.exists() || !file.isFile()) {
            throw new FileNotFoundException("File not found: " + filePath);
        }

        ServletOutputStream os = response.getOutputStream();
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, StandardCharsets.UTF_8.name()));
        response.setContentType("application/octet-stream");

        FileUtil.writeToStream(file, os);
        os.flush();
        os.close();
    }
    @GetMapping("/stream")
    public void stream(@RequestParam String filename, HttpServletResponse response) throws IOException {
        if (filename == null || filename.isEmpty()) {
            throw new IllegalArgumentException("File name cannot be null or empty.");
        }

        String filePath = ROOT_PATH + "/" + filename;
        File file = new File(filePath);

        if (!file.exists() || !file.isFile()) {
            throw new FileNotFoundException("File not found: " + filePath);
        }

        // 设置内容类型，根据文件的实际格式来设置
        String mimeType = getMimeType(file); // 您需要实现这个方法来确定文件的MIME类型
        response.setContentType(mimeType);

        // 不设置Content-Disposition头，或者设置为inline（但通常省略也可以）
        // response.setHeader("Content-Disposition", "inline;filename=" + URLEncoder.encode(filename, StandardCharsets.UTF_8.name()));

        // 设置内容长度（可选，但有助于浏览器正确处理下载进度等）
        response.setContentLengthLong(file.length());

        // 获取输出流并写入文件内容
        try (ServletOutputStream os = response.getOutputStream()) {
            // 注意：这个示例没有处理范围请求，这在实际应用中通常是必需的
            Files.copy(file.toPath(), os);
            os.flush();
        }

        // 注意：在try-with-resources语句中关闭输出流后，不需要再次调用close()或flush()
        // 因为try-with-resources会自动处理资源的关闭
    }

    // 辅助方法，用于根据文件扩展名确定MIME类型
    private String getMimeType(File file) {
        String mimeType = null;
        String fileName = file.getName();
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex != -1) {
            String extension = fileName.substring(dotIndex + 1).toLowerCase();
            switch (extension) {
                case "mp4":
                    mimeType = "video/mp4";
                    break;
                // 添加其他视频格式和MIME类型的映射
                // ...
                default:
                    mimeType = "application/octet-stream"; // 未知类型，默认作为二进制流处理
            }
        }
        return mimeType;
    }
}
