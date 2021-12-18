package com.atguitu.crud.service;

import com.atguitu.crud.bean.Emp;
import com.atguitu.crud.bean.EmpExample;
import com.atguitu.crud.dao.EmpMapper;
import org.mybatis.generator.codegen.ibatis2.model.ExampleGenerator;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author JESSICA
 * @create 2021-12-07 21:16
 */
@Service
public class EmployeeService {


    @Autowired
    EmpMapper empMapper;

    //指定批量操作的mapper
    @Autowired
    SqlSessionTemplate sqlSessionTemplate;


    public List<Emp> getEmps() {
        EmpExample empExample = new EmpExample();
        empExample.setOrderByClause("emp_id");
        return empMapper.selectByExampleWithDept(empExample);
    }

    public void saveEmp(Emp emp) {
        empMapper.insertSelective(emp);
    }

    /**
     * 当前用户名是够可用
     *
     * @param name
     * @return true:可用  false：不可用
     */
    public boolean checkName(String name) {
        EmpExample empExample = new EmpExample();
        EmpExample.Criteria criteria = empExample.createCriteria();
        criteria.andEmpNameEqualTo(name);
        int count = empMapper.countByExample(empExample);
        return count == 0;
    }

    public Emp getEmpById(Integer id) {
        return empMapper.selectByPrimaryKey(id);
    }

    /**
     * 更新雇员信息
     *
     * @param emp
     * @return true:成功
     */
    public void updateEmp(Emp emp) {
        empMapper.updateByPrimaryKeySelective(emp);
    }

    //删除指定id的雇员
    public void deleteEmpById(Integer id) {
        empMapper.deleteByPrimaryKey(id);
    }

    public void deleteEmps(List<Integer> ids) {
        //1.这是使用批量删除对象
//        EmpMapper empMapper = sqlSessionTemplate.getMapper(EmpMapper.class);
//        for (Integer id : ids) {
//            empMapper.deleteByPrimaryKey(id);
//        }
        //2.使用in(1,2,3)删除
        EmpExample empExample = new EmpExample();
        EmpExample.Criteria criteria = empExample.createCriteria();
        criteria.andEmpIdIn(ids);
        empMapper.deleteByExample(empExample);
    }
}
