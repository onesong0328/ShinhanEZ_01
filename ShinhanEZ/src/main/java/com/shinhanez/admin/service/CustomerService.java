package com.shinhanez.admin.service;

<<<<<<< HEAD
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
=======
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
>>>>>>> 89630bd67649080f083e0a02b59ee5ec6702fbc4

import com.shinhanez.admin.domain.Customer;
import com.shinhanez.admin.mapper.CustomerMapper;

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

<<<<<<< HEAD
    // 고객 삭제 (실제 삭제 - 미사용)
    @Transactional
=======
    // 고객 삭제
>>>>>>> 89630bd67649080f083e0a02b59ee5ec6702fbc4
    public int delete(String customerId) {
        return customerMapper.delete(customerId);
    }

<<<<<<< HEAD
    // 고객 비활성화 (논리적 삭제)
    @Transactional
    public int deactivate(String customerId) {
        return customerMapper.deactivate(customerId);
    }

=======
>>>>>>> 89630bd67649080f083e0a02b59ee5ec6702fbc4
    // 고객 수
    public int count() {
        return customerMapper.count();
    }
<<<<<<< HEAD

    // 검색 조건에 따른 고객 수
    public int countBySearch(String searchType, String keyword) {
        Map<String, Object> params = new HashMap<>();
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        return customerMapper.countBySearch(params);
    }

    // 페이징 + 검색 + 정렬 고객 목록
    public List<Customer> findByPage(int page, int pageSize, String searchType, String keyword, String sortType) {
        Map<String, Object> params = new HashMap<>();
        params.put("startRow", (page - 1) * pageSize);
        params.put("endRow", page * pageSize);
        params.put("searchType", searchType);
        params.put("keyword", keyword);
        params.put("sortType", sortType);
        return customerMapper.findByPage(params);
    }

    // 고객ID 중복 체크
    public boolean existsById(String customerId) {
        return customerMapper.existsById(customerId) > 0;
    }
=======
>>>>>>> 89630bd67649080f083e0a02b59ee5ec6702fbc4
}
