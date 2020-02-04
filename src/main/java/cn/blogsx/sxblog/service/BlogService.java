package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.po.Blog;
import cn.blogsx.sxblog.vo.BlogQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

/**
 * @Dscription 博客service
 * @Author Alex
 * @Time 2020-01-23 15:33:18
 */

public interface BlogService {
    Blog getBlog(Long  id);

    Page<Blog> listBlog(Pageable pageable, BlogQuery blog);

    Page<Blog> listBlog(Pageable pageable);

    Map<String,List<Blog>> archiveBlog();

    Long countBlog();

    Page<Blog> listBlog(Long tagId,Pageable pageable);

    Page<Blog> listBlog(String query,Pageable pageable);

    /**
     * 博客推荐列表
     * @param size
     * @return
     */
    List<Blog> listRecommendBlogTop(Integer size);

    Blog saveBlog(Blog blog);

    Blog updateBlog(Long id,Blog blog);

    void deleteBlog(Long id);

    Blog getAndConvert(Long id);



}
