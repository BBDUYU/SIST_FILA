package com.util;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/displayImage.do")
public class DisplayImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 주소창의 path 파라미터를 읽어옴
        String filePath = request.getParameter("path"); 
        File file = new File(filePath);

        if (!file.exists()) {
            return; // 파일이 없으면 그냥 종료
        }

        // 파일 확장자에 따라 MIME 타입 설정
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) mimeType = "image/jpeg";
        response.setContentType(mimeType);

        // 파일을 읽어서 스트림으로 전송
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            byte[] buffer = new byte[1024];
            int len;
            while ((len = fis.read(buffer)) != -1) {
                os.write(buffer, 0, len);
            }
        }
    }
}