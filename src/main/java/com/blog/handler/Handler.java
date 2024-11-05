package com.blog.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Handler {

    public static boolean deleteFile(String path){
        boolean flag = false;
        try{
            File file = new File(path);
            flag = file.delete();

        }catch (Exception e){
            e.printStackTrace();
        }
        return flag;
    }

    public static boolean saveFile(InputStream is, String path){
        boolean flag = false;
        try{
            byte[] bytes = new byte[is.available()];
            is.read(bytes);

            FileOutputStream fos = new FileOutputStream(path);
            fos.write(bytes);

            fos.flush();
            fos.close();
            flag = true;

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return flag;

    }

}
