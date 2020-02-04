package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.dao.UserRepository;
import cn.blogsx.sxblog.po.User;
import cn.blogsx.sxblog.utils.MD5Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Alex
 * @create 2020-01-22 20:48
 **/
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Override
    public User checkUser(String username, String password) {
        User user =userRepository.findByUsernameAndPassword(username, MD5Utils.code(password));
        System.out.println(user.toString());
        return user;
    }
}
