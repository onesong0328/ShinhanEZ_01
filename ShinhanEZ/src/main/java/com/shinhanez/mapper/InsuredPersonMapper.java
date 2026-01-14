package com.shinhanez.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.shinhanez.domain.InsuredPerson;

/**
 * 피보험자 Mapper
 */
@Mapper
public interface InsuredPersonMapper {
    
    // 전체 목록 (고객명 조인)
    List<InsuredPerson> findAll();
    
    // 상세 조회
    InsuredPerson findById(String insuredId);
    
    // 등록
    int insert(InsuredPerson insuredPerson);
    
    // 수정
    int update(InsuredPerson insuredPerson);
    
    // 삭제
    int delete(String insuredId);
    
    // 전체 수
    int count();
    
    // 페이징 목록 조회
    List<InsuredPerson> findByPage(@Param("offset") int offset, 
                                    @Param("size") int size, 
                                    @Param("sort") String sort);
    
    // 검색 + 페이징
    List<InsuredPerson> findBySearch(@Param("keyword") String keyword,
                                      @Param("offset") int offset,
                                      @Param("size") int size);
    
    // 검색 결과 수
    int countBySearch(@Param("keyword") String keyword);
    
    // 새 ID 생성
    String getNextId();
}
