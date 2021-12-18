package com.atguitu.crud.test;

import com.atguitu.crud.bean.Dept;
import com.atguitu.crud.bean.Emp;
import com.atguitu.crud.dao.DeptMapper;
import com.atguitu.crud.dao.EmpMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.swing.plaf.synth.SynthTextAreaUI;
import java.util.List;
import java.util.UUID;

/**
 * 使用spring-test来测试持久层功能
 *
 * @author JESSICA
 * @create 2021-12-07 20:49
 */

@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MybatisTest {

    @Autowired
    EmpMapper empMapper;
    @Autowired
    DeptMapper deptMapper;

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    @Test
    public void test01() {

//        /*新增部门*/
//        int rs = deptMapper.insert(new Dept(2, "市场部"));
//        System.out.println(rs);
        List<Emp> depts = empMapper.selectByExampleWithDept(null);
        System.out.println(depts);
        /*批量新增雇员*/
        long start = System.currentTimeMillis();
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5);
            empMapper = sqlSessionTemplate.getMapper(EmpMapper.class);
//            empMapper.insertSelective(new Emp(null, uid + "号雇员", "1", uid + i + "@qq.com", 1, null));
        }
        long end = System.currentTimeMillis();
        System.out.println((end - start) + "毫秒");
    }

}
