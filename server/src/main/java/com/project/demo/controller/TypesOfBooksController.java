package com.project.demo.controller;

import com.project.demo.entity.TypesOfBooks;
import com.project.demo.service.TypesOfBooksService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 书籍种类：(TypesOfBooks)表控制层
 *
 */
@RestController
@RequestMapping("/types_of_books")
public class TypesOfBooksController extends BaseController<TypesOfBooks, TypesOfBooksService> {

    /**
     * 书籍种类对象
     */
    @Autowired
    public TypesOfBooksController(TypesOfBooksService service) {
        setService(service);
    }


    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        return success(1);
    }

}
