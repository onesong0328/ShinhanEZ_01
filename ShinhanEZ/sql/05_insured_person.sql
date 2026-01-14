/*
    =============================================
    ShinhanEZ - 05. 피보험자(insured_person) 테이블
    =============================================
    - 보험 계약의 피보험자 정보를 저장
    - 고객(customer)과 1:N 관계
    =============================================
*/

-- 테이블 삭제 (초기화 시)
DROP TABLE insured_person CASCADE CONSTRAINTS;

-- 피보험자 테이블 생성
CREATE TABLE insured_person (
    insured_id      VARCHAR2(50)    PRIMARY KEY,            -- 피보험자 ID
    customer_id     VARCHAR2(50)    NOT NULL,               -- 가입 고객 ID (FK)
    name            VARCHAR2(100)   NOT NULL,               -- 피보험자 이름
    birth_date      DATE            NOT NULL,               -- 생년월일
    gender          CHAR(1)         NOT NULL 
                        CHECK (gender IN ('M', 'F')),       -- 성별 (M:남, F:여)
    phone           VARCHAR2(20),                           -- 연락처
    relation        VARCHAR2(20)    NOT NULL,               -- 관계 (본인/배우자/자녀/부모)
    reg_date        DATE            DEFAULT SYSDATE,        -- 등록일
    CONSTRAINT fk_insured_customer FOREIGN KEY (customer_id) 
        REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- 테이블 코멘트
COMMENT ON TABLE insured_person IS '피보험자 테이블';
COMMENT ON COLUMN insured_person.insured_id IS '피보험자 ID (PK)';
COMMENT ON COLUMN insured_person.customer_id IS '가입 고객 ID (FK)';
COMMENT ON COLUMN insured_person.name IS '피보험자 이름';
COMMENT ON COLUMN insured_person.birth_date IS '생년월일';
COMMENT ON COLUMN insured_person.gender IS '성별 (M:남, F:여)';
COMMENT ON COLUMN insured_person.phone IS '연락처';
COMMENT ON COLUMN insured_person.relation IS '관계 (본인/배우자/자녀/부모)';
COMMENT ON COLUMN insured_person.reg_date IS '등록일';

-- 시퀀스 생성 (더미 15개 이후부터 시작)
DROP SEQUENCE insured_seq;
CREATE SEQUENCE insured_seq START WITH 16 INCREMENT BY 1;

-- 더미 데이터 (피보험자 15명)
INSERT INTO insured_person VALUES ('I001', 'C001', '김철수', TO_DATE('19850315','YYYYMMDD'), 'M', '010-1234-5678', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I002', 'C001', '김미영', TO_DATE('19870520','YYYYMMDD'), 'F', '010-1111-2222', '배우자', SYSDATE);
INSERT INTO insured_person VALUES ('I003', 'C001', '김지훈', TO_DATE('20150810','YYYYMMDD'), 'M', NULL, '자녀', SYSDATE);
INSERT INTO insured_person VALUES ('I004', 'C002', '이영희', TO_DATE('19900722','YYYYMMDD'), 'F', '010-2345-6789', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I005', 'C002', '박준혁', TO_DATE('19880305','YYYYMMDD'), 'M', '010-3333-4444', '배우자', SYSDATE);
INSERT INTO insured_person VALUES ('I006', 'C003', '박민수', TO_DATE('19781105','YYYYMMDD'), 'M', '010-3456-7890', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I007', 'C003', '박순자', TO_DATE('19520620','YYYYMMDD'), 'F', '010-5555-6666', '부모', SYSDATE);
INSERT INTO insured_person VALUES ('I008', 'C004', '최수진', TO_DATE('19950830','YYYYMMDD'), 'F', '010-4567-8901', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I009', 'C005', '정대호', TO_DATE('19820214','YYYYMMDD'), 'M', '010-5678-9012', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I010', 'C005', '정미선', TO_DATE('19850910','YYYYMMDD'), 'F', '010-7777-8888', '배우자', SYSDATE);
INSERT INTO insured_person VALUES ('I011', 'C005', '정하은', TO_DATE('20180325','YYYYMMDD'), 'F', NULL, '자녀', SYSDATE);
INSERT INTO insured_person VALUES ('I012', 'C006', '한미영', TO_DATE('19880919','YYYYMMDD'), 'F', '010-6789-0123', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I013', 'C007', '강동원', TO_DATE('19751201','YYYYMMDD'), 'M', '010-7890-1234', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I014', 'C008', '윤서연', TO_DATE('19920605','YYYYMMDD'), 'F', '010-8901-2345', '본인', SYSDATE);
INSERT INTO insured_person VALUES ('I015', 'C009', '임재현', TO_DATE('19800428','YYYYMMDD'), 'M', '010-9012-3456', '본인', SYSDATE);

COMMIT;

-- 확인 (가입고객명 조인)
SELECT i.insured_id, c.name AS customer_name, i.name AS insured_name, 
       i.relation, i.birth_date, i.gender, i.phone, i.reg_date
FROM insured_person i
JOIN customer c ON i.customer_id = c.customer_id
ORDER BY i.reg_date DESC;

-- 피보험자 수 확인
SELECT COUNT(*) AS total_insured FROM insured_person;
