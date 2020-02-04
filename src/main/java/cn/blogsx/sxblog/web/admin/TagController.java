package cn.blogsx.sxblog.web.admin;

import cn.blogsx.sxblog.po.Tag;
import cn.blogsx.sxblog.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

/**
 * @Description 标签控制器
 * @author Alex
 * @create 2020-01-23 14:48
 **/
@Controller
@RequestMapping("/admin")
public class TagController {

    @Autowired
    private TagService tagService;

    @GetMapping("/tags")
    public String tags(@PageableDefault(size = 8, sort = {"id"}, direction = Sort.Direction.DESC)
                                Pageable pageable, Model model) {
        model.addAttribute("page", tagService.listTag(pageable));
        return "admin/tags";
    }
    @GetMapping("/tags/input")
    public String input(Model model) {
        model.addAttribute("tag", new Tag());
        return "/admin/tags-input";
    }
    @GetMapping("/tags/{id}/input")
    public String editInput(@PathVariable Long id, Model model) {
        model.addAttribute("tag",tagService.getTag(id));
        return "admin/tags-input";
    }
    @PostMapping("/tags")
    public String post(@Valid Tag tag, BindingResult result, RedirectAttributes attributes) {
        //分类名称重复校验
        Tag tg = tagService.getTagByName(tag.getName());
        if (tg != null) {
            result.rejectValue("name","nameError","标签名称不能重复添加");
        }

        if (result.hasErrors()) {
            return "/admin/tags-input";
        }
        Tag t = tagService.saveTag(tag);
        if (t == null) {
            //保存失败
            attributes.addFlashAttribute("message", "添加失败！");
        } else {
            //保存成功
            attributes.addFlashAttribute("message", "添加成功！");
        }
        return "redirect:/admin/tags";
    }

    @PostMapping("/tags/{id}")
    public String editpost(@Valid Tag tag, BindingResult result,@PathVariable Long id, RedirectAttributes attributes) {
        //分类名称重复校验
        Tag tag1 = tagService.getTagByName(tag.getName());
        if (tag1 != null) {
            result.rejectValue("name","nameError","标签名称不能重复添加");
        }

        if (result.hasErrors()) {
            return "/admin/tags-input";
        }
        Tag t = tagService.updateTag(id,tag);
        if (t == null) {
            //保存失败
            attributes.addFlashAttribute("message", "更新失败！");
        } else {
            //保存成功
            attributes.addFlashAttribute("message", "更新成功！");
        }
        return "redirect:/admin/tags";
    }

    @GetMapping("/tags/{id}/delete")
    public String delete(@PathVariable long id,RedirectAttributes attributes){
        tagService.deleteTag(id);
        attributes.addFlashAttribute("message", "删除成功！");
        return "redirect:/admin/tags";
    }


}
