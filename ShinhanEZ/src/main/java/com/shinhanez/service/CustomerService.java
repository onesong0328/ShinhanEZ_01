package com.shinhanez.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhanez.domain.Customer;
import com.shinhanez.mapper.CustomerMapper;

/**
 * 고객(보험자) 서비스
 * - 관리자 페이지용 CRUD
 */
@Service
public class CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    // 전체 고객 목록
    public List<Customer> findAll() {
        return customerMapper.findAll();
    }

    // 고객 상세 조회
    public Customer findById(String customerId) {
        return customerMapper.findById(customerId);
    }

    // 고객 등록
    public int insert(Customer customer) {
        return customerMapper.insert(customer);
    }

    // 고객 수정
    public int update(Customer customer) {
        return customerMapper.update(customer);
    }

    // 고객 삭제
    public int delete(String customerId) {
        return customerMapper.delete(customerId);
    }

    // 고객 수
    public int count() {
        return customerMapper.count();
    }
    
    // 페이징 목록 조회
    public List<Customer> findByPage(int page, int size, String sort) {
        int offset = (page - 1) * size;
        return customerMapper.findByPage(offset, size, sort);
    }
    
    // 검색 + 페이징
    public List<Customer> findBySearch(String keyword, int page, int size) {
        int offset = (page - 1) * size;
        return customerMapper.findBySearch(keyword, offset, size);
    }
    
    // 검색 결과 수
    public int countBySearch(String keyword) {
        return customerMapper.countBySearch(keyword);
    }
}
