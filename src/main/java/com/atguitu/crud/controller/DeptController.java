package com.atguitu.crud.controller;

import com.atguitu.crud.bean.Dept;
import com.atguitu.crud.bean.Emp;
import com.atguitu.crud.bean.Msg;
import com.atguitu.crud.service.DeptService;
import com.atguitu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author JESSICA
 * @create 2021-12-07 21:14
 */
@Controller
public class DeptController {

    @Autowired
    DeptService deptService;


    /*需要考虑直接返回json数据，不进行跳转*/
    @ResponseBody
    @RequestMapping("/getDepts")
    public Msg getDepts() {
        List<Dept> emps = deptService.getDepts();
        return Msg.success().add("depts", emps);
    }
}
