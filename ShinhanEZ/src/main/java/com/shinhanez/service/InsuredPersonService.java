package com.shinhanez.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shinhanez.domain.InsuredPerson;
import com.shinhanez.mapper.InsuredPersonMapper;

/**
 * 피보험자 서비스
 */
@Service
public class InsuredPersonService {

    @Autowired
    private InsuredPersonMapper insuredPersonMapper;

    // 전체 목록
    public List<InsuredPerson> findAll() {
        return insuredPersonMapper.findAll();
    }

    // 상세 조회
    public InsuredPerson findById(String insuredId) {
        return insuredPersonMapper.findById(insuredId);
    }

    // 등록
    public int insert(InsuredPerson insuredPerson) {
        // 새 ID 생성
        String newId = insuredPersonMapper.getNextId();
        insuredPerson.setInsuredId(newId);
        return insuredPersonMapper.insert(insuredPerson);
    }

    // 수정
    public int update(InsuredPerson insuredPerson) {
        return insuredPersonMapper.update(insuredPerson);
    }

    // 삭제
    public int delete(String insuredId) {
        return insuredPersonMapper.delete(insuredId);
    }

    // 전체 수
    public int count() {
        return insuredPersonMapper.count();
    }

    // 페이징 목록 조회
    public List<InsuredPerson> findByPage(int page, int size, String sort) {
        int offset = (page - 1) * size;
        return insuredPersonMapper.findByPage(offset, size, sort);
    }

    // 검색 + 페이징
    public List<InsuredPerson> findBySearch(String keyword, int page, int size) {
        int offset = (page - 1) * size;
        return insuredPersonMapper.findBySearch(keyword, offset, size);
    }

    // 검색 결과 수
    public int countBySearch(String keyword) {
        return insuredPersonMapper.countBySearch(keyword);
    }
}
