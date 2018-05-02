package com.tz.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class DataDownUtil {

   public static String getHtmlResourceByUrl(String url, String encoding) {
      StringBuffer buffer = new StringBuffer();
      URL urlObj = null;
      URLConnection uc = null;
      InputStreamReader isr = null;
      BufferedReader reader = null;

      try {
         urlObj = new URL(url);
         uc = urlObj.openConnection();
         isr = new InputStreamReader(uc.getInputStream(), encoding);
         reader = new BufferedReader(isr);
         String e = null;

         while((e = reader.readLine()) != null) {
            buffer.append(e + "\n");
         }
      } catch (MalformedURLException var18) {
         var18.printStackTrace();
         System.out.println("网络不给力，请检查网络设置");
      } catch (IOException var19) {
         var19.printStackTrace();
         System.out.println("网络打开失败，情稍后重试");
      } finally {
         if(isr != null) {
            try {
               isr.close();
            } catch (IOException var17) {
               var17.printStackTrace();
            }
         }

      }

      return buffer.toString();
   }

   public static List findImages(String url, String encoding) {
      String html = getHtmlResourceByUrl(url, encoding);
      Document document = Jsoup.parse(html);
      Elements elements = document.getElementsByTag("img");
      ArrayList list = new ArrayList();
      HashMap map = null;
      Iterator var8 = elements.iterator();

      while(var8.hasNext()) {
         Element ele = (Element)var8.next();
         map = new HashMap();
         String src = ele.attr("src");
         String title = ele.attr("alt");
         if(src.startsWith("http") && (src.indexOf("jpg") != -1 || src.indexOf("jpeg") != -1)) {
            String name = src.substring(src.lastIndexOf("/") + 1);
            map.put("src", src);
            map.put("title", title);
            map.put("name", name);
            list.add(map);
         }
      }

      return list;
   }

   public static void main(String[] arsddsfsdfgs) {
      String url = "http://tech.qq.com/";
      String encoding = "gbk";
      String html = getHtmlResourceByUrl(url, encoding);
      Document document = Jsoup.parse(html);
      Elements elements = document.getElementsByTag("img");
      ArrayList list = new ArrayList();
      HashMap map = null;
      Iterator var9 = elements.iterator();

      while(var9.hasNext()) {
         Element ele = (Element)var9.next();
         map = new HashMap();
         String src = ele.attr("src");
         String title = ele.attr("alt");
         if(src.startsWith("http") && src.indexOf("jpg") != -1) {
            String name = src.substring(src.lastIndexOf("/") + 1);
            map.put("src", src);
            map.put("title", title);
            map.put("name", name);
            list.add(map);
         }
      }

      System.out.println(list);
   }
}