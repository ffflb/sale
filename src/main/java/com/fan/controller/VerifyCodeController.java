package com.fan.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * @ClassName:com.qst.controller
 * @Description:
 * @Author:范
 **/
@Controller
public class VerifyCodeController {

//    获取验证码
    @RequestMapping("/getVerifyCode")
    public void getVerifyCode(HttpSession session, HttpServletResponse servletResponse ) throws IOException {
        //图片对象
        BufferedImage bi = new BufferedImage(80, 35, BufferedImage.TYPE_INT_RGB);
        //画笔
        Graphics2D g = (Graphics2D) bi.getGraphics();
        g.setColor(Color.darkGray);
        //填充背景
        g.fillRect(0, 0, 80, 35);
        g.setColor(Color.ORANGE);
        //产生验证码
        String str = "23456789qwertyuiopasdfghjkzxcvbnmQWERTYUIOPASDFGHJKZXCVBNM";
        StringBuilder s = new StringBuilder();
        for (int i = 0; i < 4; i++) {

            //产生随机下标
            int index = new Random().nextInt(str.length());

            String randomChar = str.charAt(index)+"";
            s.append(randomChar);
        }
        g.drawString(s.toString(), 25, 20);
        session.setAttribute("VerifyCode", s.toString());
        ImageIO.write(bi, "JPEG", servletResponse.getOutputStream());
    }
}
