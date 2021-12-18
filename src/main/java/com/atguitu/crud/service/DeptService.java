package com.atguitu.crud.service;

import com.atguitu.crud.bean.Dept;
import com.atguitu.crud.dao.DeptMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author JESSICA
 * @create 2021-12-12 22:18
 */
@Service
public class DeptService {

    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getDepts() {
        return deptMapper.selectByExample(null);
    }
}
