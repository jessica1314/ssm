package com.atguitu.crud.controller;

import com.atguitu.crud.bean.Emp;
import com.atguitu.crud.bean.Msg;
import com.atguitu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.testng.AbstractTestNGSpringContextTests;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.lang.annotation.ElementType;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author JESSICA
 * @create 2021-12-07 21:14
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    /**
     * 单个和批量二合一
     *
     * @param ids
     * @return
     */
    @ResponseBody
    @DeleteMapping("/emp/{ids}")
    public Msg deleteEmps(@PathVariable("ids") String ids) {
        //ids 形式是  1,2,3,4,5,6,7
        if (ids.contains(",")) {
            String[] split = ids.split(",");
            List<Integer> ints = Stream.of(split).map(Integer::parseInt).collect(Collectors.toList());
            employeeService.deleteEmps(ints);
            return Msg.success();
        } else {
            employeeService.deleteEmpById(Integer.parseInt(ids));
            return Msg.success();
        }

    }


    //保存员工，接收put请求
    @ResponseBody
    @PutMapping("/emp/{empId}")
    public Msg updateEmp(Emp emp) {
        employeeService.updateEmp(emp);
        return Msg.success();
    }


    //查询制定员工号的员工
    @ResponseBody
    @GetMapping("/emp/{id}")
    public Msg getEmpById(@PathVariable("id") Integer id) {
        Emp emp = employeeService.getEmpById(id);
        if (emp != null) {
            return Msg.success().add("emp", emp);
        } else {
            return Msg.fail();
        }
    }


    /*需要考虑直接返回json数据，不进行跳转*/
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        /*考虑分页，使用插件 pagehelper*/
        //获取第1页，10条内容，默认查询总数count
        PageHelper.startPage(pn, 5);
        List<Emp> emps = employeeService.getEmps();
        //用PageInfo对结果进行包装,navigatePages:代表连续显示的页数！
        PageInfo<Emp> pageInfo = new PageInfo<>(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    /**
     * 新增雇员信息
     * 进行第二次校验，防止前台修改请求参数钻漏洞
     *
     * @param emp
     * @return
     */
    @ResponseBody
    @RequestMapping("/saveEmp")
    public Msg saveEmp(@Valid Emp emp, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误的信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(emp);
            return Msg.success();
        }
    }


    /**
     * 接收前台的ajax请求，检验雇员名称是否使用
     *
     * @param name
     * @return
     */
    @ResponseBody
    @PostMapping("/checkName")
    public Msg checkName(@RequestParam("empName") String name) {
        //1.先判断用户名是否合法
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        boolean isMatch = name.matches(regName);
        if (!isMatch) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合/2-5位的纯汉字");
        }
        //2.然后校验是否重复
        boolean isUse = employeeService.checkName(name);
        if (isUse) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户不可用");
        }
    }

    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        /*考虑分页，使用插件 pagehelper*/
        //获取第1页，10条内容，默认查询总数count
        PageHelper.startPage(pn, 5);
        List<Emp> emps = employeeService.getEmps();
        //用PageInfo对结果进行包装,navigatePages:代表连续显示的页数！
        PageInfo<Emp> pageInfo = new PageInfo<>(emps, 5);
        model.addAttribute("pageInfo", pageInfo);
        return "list";
    }

}
