package com.shinhanez.domain;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * 피보험자 Entity
 * - insured_person 테이블과 매핑
 */
public class InsuredPerson {
    private String insuredId;       // 피보험자 ID (PK)
    private String customerId;      // 가입 고객 ID (FK)
    private String name;            // 피보험자 이름
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;         // 생년월일
    private String gender;          // 성별 (M/F)
    private String phone;           // 연락처
    private String relation;        // 관계 (본인/배우자/자녀/부모)
    private Date regDate;           // 등록일
    
    // 조인용 필드 (customer 테이블)
    private String customerName;    // 가입 고객명

    // 기본 생성자
    public InsuredPerson() {}

    // Getter & Setter
    public String getInsuredId() { return insuredId; }
    public void setInsuredId(String insuredId) { this.insuredId = insuredId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Date getBirthDate() { return birthDate; }
    public void setBirthDate(Date birthDate) { this.birthDate = birthDate; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRelation() { return relation; }
    public void setRelation(String relation) { this.relation = relation; }

    public Date getRegDate() { return regDate; }
    public void setRegDate(Date regDate) { this.regDate = regDate; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    @Override
    public String toString() {
        return "InsuredPerson [insuredId=" + insuredId + ", name=" + name + "]";
    }
}
