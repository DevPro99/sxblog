package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.NotFoundException;
import cn.blogsx.sxblog.dao.BlogRepository;
import cn.blogsx.sxblog.po.Blog;
import cn.blogsx.sxblog.po.Type;
import cn.blogsx.sxblog.utils.MarkdownUtils;
import cn.blogsx.sxblog.utils.MyBeanUtils;
import cn.blogsx.sxblog.vo.BlogQuery;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.*;
import java.util.*;

/**
 * @author Alex
 * @create 2020-01-23 15:36
 **/
@Service
public class BlogServiceImpl implements BlogService {
    @Autowired
    private BlogRepository blogRepository;

    @Override
    public Blog getBlog(Long id) {
        return blogRepository.findOne(id);
    }

    @Override
    public Page<Blog> listBlog(Pageable pageable, BlogQuery blog) {
        return blogRepository.findAll(new Specification<Blog>() {
            @Override
            public Predicate toPredicate(Root<Blog> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
                List<Predicate> predicates = new ArrayList<>();
                //动态查询
                if (!"".equals(blog.getTitle()) && blog.getTitle() != null) {
                    predicates.add(cb.like(root.<String>get("title"), "%"+blog.getTitle()+"%"));
                }
                if (blog.getTypeId() != null) {
                    predicates.add(cb.equal(root.<Type>get("type").get("id"), blog.getTypeId()));
                }
                if (blog.isRecommend()) {
                    predicates.add(cb.equal(root.<Boolean>get("recommend"), blog.isRecommend()));
                }
                cq.where(predicates.toArray(new Predicate[predicates.size()]));
                return null;
            }
        },pageable);
    }

    @Override
    public Page<Blog> listBlog(Pageable pageable) {
        return blogRepository.findAll(pageable);
    }

    @Override
    public Map<String, List<Blog>> archiveBlog() {
        List<String> years = blogRepository.findGroupYear();
        Map<String, List<Blog>> map = new HashMap<>();
        for (String year : years) {
            map.put(year, blogRepository.findByYear(year));
        }
        return map;
    }

    @Override
    public Long countBlog() {
        return blogRepository.count();
    }

    @Override
    public Page<Blog> listBlog(Long tagId, Pageable pageable) {
        return blogRepository.findAll(new Specification<Blog>() {
            @Override
            public Predicate toPredicate(Root<Blog> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
                Join join = root.join("tags");
                return cb.equal(join.get("id"),tagId);
            }
        },pageable);
    }

    @Override
    public Page<Blog> listBlog(String query, Pageable pageable) {
        return blogRepository.findByQuery(query,pageable);
    }

    @Override
    public List<Blog> listRecommendBlogTop(Integer size) {
        Sort sort = new Sort(Sort.Direction.DESC,"updateTime");
        Pageable pageable =  new PageRequest(0,size,sort);
        return blogRepository.findTop(pageable);
    }

    @Transactional
    @Override
    public Blog saveBlog(Blog blog) {
        if(blog.getId()==null){
            //当前博客为新增博客
            blog.setCreateTime(new Date());
            blog.setUpdateTime(new Date());
            blog.setViews(0);//初始化浏览次数
        }else {
            blog.setUpdateTime(new Date());
        }
        return blogRepository.save(blog) ;
    }

    @Transactional
    @Override
    public Blog updateBlog(Long id, Blog blog) {
        Blog b=blogRepository.findOne(id);
        if(b==null){
            throw new NotFoundException("该博客不存在");
        }
        BeanUtils.copyProperties(blog,b, MyBeanUtils.getNullPropertyNames(blog));
        b.setUpdateTime(new Date());
        return blogRepository.save(b);
    }

    @Transactional
    @Override
    public void deleteBlog(Long id) {
        blogRepository.delete(id);
    }

    @Override
    public Blog getAndConvert(Long id) {
        Blog blog = blogRepository.findOne(id);
        if(blog == null) {
            throw new NotFoundException("博客不存在");
        }
        Blog b = new Blog();
        BeanUtils.copyProperties(blog,b);
        String content = b.getContent();
        //处理markdown
        b.setContent(MarkdownUtils.markdownToHtmlExtensions(content));
        return b;
    }
}
