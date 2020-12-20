package org.codeGenerator.utils;

import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class Reflector {
    public static void main(String[] args) throws Exception {
        Set s = new HashSet();
        s.add("foo");
        Iterator i = s.iterator();
        i.hasNext();
        Method m = i.getClass().getDeclaredMethod("hasNext", new Class[0]);
//        Method m = i.getClass().getMethod("hasNext", new Class[0]);
        System.out.println(m.invoke(i, new Object[0]));
    }
}