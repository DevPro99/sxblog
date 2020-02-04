package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.po.Comment;

import java.util.List;

/**
 * @author Alex
 * @create 2020-01-26 15:16
 **/
public interface CommentService {

    List<Comment> listCommentByBlogId(Long blogId);

    Comment saveComment(Comment comment);

}
