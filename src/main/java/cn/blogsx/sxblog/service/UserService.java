package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.po.User;

public interface UserService {
    User checkUser(String username,String password);
}
