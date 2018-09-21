package com.fbs.wowo.util;

import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Property {
    private static final Properties Properties = new Properties();
    static {
        try {
            ClassPathResource resource = new ClassPathResource("property.properties");
            InputStream in = resource.getInputStream();
            Properties.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static String getProperty(String key) {
        return Properties.getProperty(key);
    }
}
