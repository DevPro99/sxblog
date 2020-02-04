package cn.blogsx.sxblog.dao;

import cn.blogsx.sxblog.po.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Long> {
    User findByUsernameAndPassword(String username,String password);

}
