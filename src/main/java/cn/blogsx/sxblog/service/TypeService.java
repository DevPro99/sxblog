package cn.blogsx.sxblog.service;

import cn.blogsx.sxblog.po.Type;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface TypeService {
    Type saveType(Type type);

    Type getType(Long id);
    Type getTypeByName(String name);

    Page<Type> listType(Pageable pageable);

    Type updateType(Long id,Type type);

    void deleteType(Long id);

    List<Type> listType();

    List<Type> listTypeTop(Integer size);

}
