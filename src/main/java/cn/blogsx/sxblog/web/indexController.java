package cn.blogsx.sxblog.web;

import cn.blogsx.sxblog.NotFoundException;
import cn.blogsx.sxblog.po.Blog;
import cn.blogsx.sxblog.service.BlogService;
import cn.blogsx.sxblog.service.TagService;
import cn.blogsx.sxblog.service.TagService;
import cn.blogsx.sxblog.vo.BlogQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class indexController {
    @Autowired
    private BlogService blogService;

    @Autowired
    private TagService TagService;

    @Autowired
    private TagService tagService;

    @GetMapping("/")
    public String index(@PageableDefault(size = 8,sort ={"updateTime"},direction = Sort.Direction.DESC )
                          Pageable pageable, Model model){
        /**
         * 博客列表数据
         */
        model.addAttribute("page",blogService.listBlog(pageable));
        /**
         * 分类列表数据
         */
        model.addAttribute("Tags",TagService.listTagTop(6));
        /**
         * 标签列表数据
         */
        model.addAttribute("tags",tagService.listTagTop(10));
        /**
         * 推荐博客列表
         */
        model.addAttribute("recommendBlogs",blogService.listRecommendBlogTop(8));
        return "index";
    }

    /**
     * 首页查询方法
     * @param pageable
     * @param model
     * @return
     */
    @PostMapping("/search")
    public String search(@PageableDefault(size = 8,sort ={"updateTime"},direction = Sort.Direction.DESC )
                         @RequestParam String query, Pageable pageable, Model model) {
        model.addAttribute("page",blogService.listBlog("%"+query+"%",pageable));
        model.addAttribute("query",query);
        return "search";

    }

    /**
     * 博客详情页面
     * @return
     */

    @GetMapping("/blog/{id}")
    public String blog(@PathVariable Long id,Model model){
        model.addAttribute("blog",blogService.getAndConvert(id));
        return "blog";
    }


}
