package com.atguitu.crud.test;

import com.atguitu.crud.bean.Emp;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;

/**
 * @author JESSICA
 * @create 2021-12-07 21:26
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:springmvc.xml", "classpath:applicationContext.xml"})
@WebAppConfiguration
public class MvcTest {

    @Autowired
    WebApplicationContext applicationContext;

    MockMvc mockMvc;

    @Before
    public void test01() {
        mockMvc = MockMvcBuilders.webAppContextSetup(applicationContext).build();
    }

    @Test
    public void test02() throws Exception {
        MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/getEmps").param("pn", "1")).andReturn();
        PageInfo pageInfo = (PageInfo) mvcResult.getRequest().getAttribute("pageInfo");
        System.out.println("当前页面" + pageInfo.getPageNum());
        System.out.println("总页码:" + pageInfo.getPages());
        System.out.println("总数" + pageInfo.getTotal());
        List<Emp> list = pageInfo.getList();
        for (Emp emp : list) {
            System.out.println(emp);
        }
        System.out.println("页码范围:" + Arrays.toString(pageInfo.getNavigatepageNums()));
    }

}
