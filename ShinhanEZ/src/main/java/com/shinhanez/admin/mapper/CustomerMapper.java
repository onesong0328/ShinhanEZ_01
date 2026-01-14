package com.shinhanez.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.shinhanez.admin.domain.Customer;

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

    // 고객 비활성화 (논리적 삭제)
    int deactivate(String customerId);

    // 고객 수 카운트
    int count();

    // 검색 조건에 따른 고객 수 카운트
    int countBySearch(Map<String, Object> params);

    // 페이징 + 검색 + 정렬 고객 목록
    List<Customer> findByPage(Map<String, Object> params);

    // 고객ID 중복 체크
    int existsById(String customerId);
}
