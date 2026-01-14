package com.shinhanez.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.shinhanez.domain.Customer;

/**
 * 고객(보험자) Mapper
 * - 관리자 페이지에서 CRUD
 */
@Mapper
public interface CustomerMapper {
    
    // 전체 고객 목록
    List<Customer> findAll();
    
    // 고객 상세 조회
    Customer findById(String customerId);
    
    // 고객 등록
    int insert(Customer customer);
    
    // 고객 수정
    int update(Customer customer);
    
    // 고객 삭제
    int delete(String customerId);
    
    // 고객 수 카운트
    int count();
    
    // 페이징 목록 조회
    List<Customer> findByPage(@Param("offset") int offset, 
                               @Param("size") int size, 
                               @Param("sort") String sort);
    
    // 검색 + 페이징
    List<Customer> findBySearch(@Param("keyword") String keyword,
                                 @Param("offset") int offset,
                                 @Param("size") int size);
    
    // 검색 결과 수
    int countBySearch(@Param("keyword") String keyword);
}
