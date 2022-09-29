-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_USER 생성
CREATE TABLE T_USER
(
    USER_UID VARCHAR2(100) NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_PHONE VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20),
    USER_NICK VARCHAR2(20),
    USER_EMAIL VARCHAR2(50),
    ADMIN_STATUS CHAR(1),
    STATUS CHAR(1),
    REG_DATE DATE,
    BIZ_NUM VARCHAR2(20),
    BIZ_NAME VARCHAR2(20),
    BIZ_DATE DATE
);
--INDEX & PK 생성
CREATE UNIQUE INDEX UPK_USER ON T_USER(USER_UID ASC);
ALTER TABLE T_USER ADD CONSTRAINT UPK_USER PRIMARY KEY(USER_UID);
--T_USER COMMENT생성
COMMENT ON COLUMN T_USER.USER_UID IS '회원고유번호';
COMMENT ON COLUMN T_USER.USER_ID IS'이용자아이디';
COMMENT ON COLUMN T_USER.USER_PWD IS'이용자비밀번호';
COMMENT ON COLUMN T_USER.USER_PNUM IS'이용자전화번호'; 
COMMENT ON COLUMN T_USER.USER_NAME IS'이용자명';
COMMENT ON COLUMN T_USER.USER_NICK IS'이용자닉네임';
COMMENT ON COLUMN T_USER.USER_EMAIL IS'이용자이메일';
COMMENT ON COLUMN T_USER.MANAGE_WHETHER IS'관리자여부(Y:권한있음 N:권한없음)';
COMMENT ON COLUMN T_USER.STATUS IS'사용여부(Y:사용 N:정지)';
COMMENT ON COLUMN T_USER.REG_DATE IS'등록일';
COMMENT ON COLUMN T_USER.BUIS_NUM IS'사업자번호';
COMMENT ON COLUMN T_USER.BUIS_NAME IS'대표명';
COMMENT ON COLUMN T_USER.BUIS_DATE IS'사업자등록일';
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_USER_FILE 생성
CREATE TABLE T_USER_FILE
(
    USER_UID VARCHAR2(100) NOT NULL,
    FILE_NAME VARCHAR2(50),
    FILE_EXT VARCHAR2(20),
    FILE_SIZE NUMBER(12),
    REG_DATE DATE
);
--T_USER_FILE FK 생성
ALTER TABLE T_USER_FILE ADD CONSTRAINT UFK_UFILE FOREIGN KEY(USER_UID) REFERENCES T_USER(USER_UID);
--T_USER_FILE COMMENT 생성
COMMENT ON COLUMN T_USER_FILE.USER_UID IS '회원고유번호';
COMMENT ON COLUMN T_USER_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN T_USER_FILE.FILE_EXT IS '파일확장자';
COMMENT ON COLUMN T_USER_FILE.FILE_SIZE IS '파일크기';
COMMENT ON COLUMN T_USER_FILE.REG_DATE IS '등록일';





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_BOARD 생성
CREATE TABLE T_BOARD
(
    BBS_SEQ NUMBER(12) NOT NULL,
    USER_UID VARCHAR2(100) NOT NULL,
    BBS_NO NUMBER(12) NOT NULL,
    BBS_TITLE VARCHAR2(150),
    BBS_CONTENT CLOB NOT NULL,
    BBS_LIKE_CNT NUMBER(12),
    BBS_READ_CNT NUMBER(12),
    REG_DATE DATE,
    BBS_COMMENT CHAR(1),
    COMMENT_PARENT NUMBER(12),
    COMMENT_GROUP NUMBER(12),
    COMMENT_ORDER NUMBER(12),
    COMMENT_INDENT NUMBER(12)
);
--T_BOARD INDEX & PK, FK 생성
CREATE UNIQUE INDEX BPK_BOARD ON T_BOARD(BBS_SEQ ASC);
ALTER TABLE T_BOARD ADD CONSTRAINT BPK_BOARD PRIMARY KEY(BBS_SEQ);
ALTER TABLE T_BOARD ADD CONSTRAINT UFK_BOARD FOREIGN KEY(USER_UID) REFERENCES T_USER(USER_UID);
--T_BOARD COMMENT 생성
COMMENT ON COLUMN T_BOARD.BBS_SEQ IS '게시물고유번호(시퀀스:BBS_SEQ)';
COMMENT ON COLUMN T_BOARD.USER_UID IS '회원고유번호';
COMMENT ON COLUMN T_BOARD.BBS_NO IS '게시판 번호';
COMMENT ON COLUMN T_BOARD.BBS_TITLE IS '게시물 제목';
COMMENT ON COLUMN T_BOARD.BBS_CONTENT IS '내용';
COMMENT ON COLUMN T_BOARD.BBS_LIKE_CNT IS '게시물 좋아요수';
COMMENT ON COLUMN T_BOARD.BBS_READ_CNT IS '게시물 조회수';
COMMENT ON COLUMN T_BOARD.REG_DATE IS '게시물 등록일';
COMMENT ON COLUMN T_BOARD.BBS_COMMENT IS '댓글허용';
COMMENT ON COLUMN T_BOARD.COMMENT_PARENT IS '댓글 부모번호';
COMMENT ON COLUMN T_BOARD.COMMENT_GROUP IS '댓글 그룹번호';
COMMENT ON COLUMN T_BOARD.COMMENT_ORDER IS '댓글 그룹내순서';
COMMENT ON COLUMN T_BOARD.COMMENT_INDENT IS '댓글 들여쓰기';
--SEQUENCE(BBS_SEQ) 생성
CREATE SEQUENCE BBS_SEQ
INCREMENT BY 1
MAXVALUE 999999999999
MINVALUE 1
NOCACHE
NOCYCLE;
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_BOARD_FILE 생성
CREATE TABLE T_BOARD_FILE
(
    BBS_SEQ NUMBER(12) NOT NULL,
    FILE_SEQ NUMBER(12) NOT NULL,
    FILE_ORG_NAME VARCHAR2(50),
    FILE_NAME VARCHAR2(50),
    FILE_EXT VARCHAR2(20),
    FILE_SIZE NUMBER(12),
    REG_DATE DATE
);
--T_BOARD_FILE FK 생성
ALTER TABLE T_BOARD_FILE ADD CONSTRAINT BFK_BFILE FOREIGN KEY(BBS_SEQ) REFERENCES T_BOARD(BBS_SEQ);
--T_BOARD_FILE COMMENT 생성
COMMENT ON COLUMN T_BOARD_FILE.BBS_SEQ IS '게시물고유번호(T_BOARD:BBS_SEQ)';
COMMENT ON COLUMN T_BOARD_FILE.FILE_SEQ IS '파일번호';
COMMENT ON COLUMN T_BOARD_FILE.FILE_ORG_NAME IS '원본파일명';
COMMENT ON COLUMN T_BOARD_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN T_BOARD_FILE.FILE_EXT IS '파일 확장자';
COMMENT ON COLUMN T_BOARD_FILE.FILE_SIZE IS '파일 크기';
COMMENT ON COLUMN T_BOARD_FILE.REG_DATE IS '등록일';
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_BOARD_REPORT 생성
CREATE TABLE T_BOARD_REPORT
(
    BBS_SEQ NUMBER(12) NOT NULL, 
    USER_UID VARCHAR2(100) NOT NULL,
    REPORT1 CHAR(1),
    REPORT2 CHAR(1),
    REPORT3 CHAR(1),
    REPORT4 CHAR(1),
    ETC_REPORT VARCHAR2(100),
    REG_DATE DATE
);
--T_BOARD_REPORT FK 생성
ALTER TABLE T_BOARD_REPORT ADD CONSTRAINT BFK_BREPORT FOREIGN KEY(BBS_SEQ) REFERENCES T_BOARD(BBS_SEQ);
ALTER TABLE T_BOARD_REPORT ADD CONSTRAINT UFK_BREPORT FOREIGN KEY(USER_UID) REFERENCES T_USER(USER_UID);
--T_BOARD_REPORT COMMEENT생성
COMMENT ON COLUMN T_BOARD_REPORT.BBS_SEQ IS '게시물고유번호(T_BOARD:BBS_SEQ)';
COMMENT ON COLUMN T_BOARD_REPORT.USER_UID IS '회원고유번호';
COMMENT ON COLUMN T_BOARD_REPORT.REPORT1 IS '신고사유1';
COMMENT ON COLUMN T_BOARD_REPORT.REPORT2 IS '신고사유2';
COMMENT ON COLUMN T_BOARD_REPORT.REPORT3 IS '신고사유3';
COMMENT ON COLUMN T_BOARD_REPORT.REPORT4 IS '신고사유4';
COMMENT ON COLUMN T_BOARD_REPORT.ETC_REPORT IS '기타신고사유';
COMMENT ON COLUMN T_BOARD_REPORT.REG_DATE IS '등록일';





-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_SHOP 생성
CREATE TABLE T_SHOP (
    SHOP_UID VARCHAR2(100),
    USER_UID VARCHAR2(100),
    SHOP_NAME VARCHAR2(100),
    SHOP_TYPE CHAR(1),
    SHOP_HOLIDAY VARCHAR2(100),
    SHOP_HASHTAG VARCHAR2(100),
    SHOP_LOCATION1 VARCHAR2(50),
    SHOP_LOCATION2 VARCHAR2(50),
    SHOP_LOCATION3 VARCHAR2(50),
    SHOP_ADRESS VARCHAR2(200),
    SHOP_TELEPHONE VARCHAR2(15),
    SHOP_INTRO  VARCHAR2(200),
    SHOP_CLOB CLOB,
    REG_DATE DATE
);
--T_SHOP INDEX & PK,FK 생성
CREATE UNIQUE INDEX SPK_SHOP ON T_SHOP(SHOP_UID);
ALTER TABLE T_SHOP ADD CONSTRAINT SPK_SHOP PRIMARY KEY(SHOP_UID);
ALTER TABLE T_SHOP ADD CONSTRAINT UFK_SHOP FOREIGN KEY(USER_UID) REFERENCES T_USER(USER_UID);
--T_SHOP COMMENT생성
COMMENT ON TABLE T_SHOP IS '매장정보 테이블';
COMMENT ON COLUMN T_SHOP.SHOP_UID IS '매장 고유번호';
COMMENT ON COLUMN T_SHOP.USER_UID IS '관리자 고유번호';
COMMENT ON COLUMN T_SHOP.SHOP_NAME IS '매장 이름';
COMMENT ON COLUMN T_SHOP.SHOP_TYPE IS '매장 타입 1:파인다이닝 2:오마카세';
COMMENT ON COLUMN T_SHOP.SHOP_HOLIDAY IS '매장 휴일';
COMMENT ON COLUMN T_SHOP.SHOP_HASHTAG IS '매장 해쉬태그';
COMMENT ON COLUMN T_SHOP.SHOP_LOCATION1 IS '매장 지역1(시 도)';
COMMENT ON COLUMN T_SHOP.SHOP_LOCATION2 IS '매장 지역2(군 구)';
COMMENT ON COLUMN T_SHOP.SHOP_LOCATION3 IS '매장 지역3(동)';
COMMENT ON COLUMN T_SHOP.SHOP_ADRESS IS '매장 주소';
COMMENT ON COLUMN T_SHOP.SHOP_TELEPHONE IS '매장 전화번호';
COMMENT ON COLUMN T_SHOP.SHOP_INTRO IS '매장 한줄소개';
COMMENT ON COLUMN T_SHOP.SHOP_CLOB IS '매장 내용';
COMMENT ON COLUMN T_SHOP.REG_DATE IS '매장 등록일';
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_SHOP_FILE생성
CREATE TABLE T_SHOP_FILE (
    SHOP_UID VARCHAR2(100),
    FILE_SEQ NUMBER(12),
    FILE_ORG_NAME VARCHAR2(50),
    FILE_NAME VARCHAR2(50),
    FILE_EXT VARCHAR2(20),
    FILE_SIZE NUMBER(12),
    REG_DATE DATE
);
--T_SHOP_FILE FK 생성
ALTER TABLE T_SHOP_FILE ADD CONSTRAINT SFK_SFILE FOREIGN KEY(SHOP_UID) REFERENCES T_SHOP(SHOP_UID);
--T_SHOP_FILE COMMENT 생성
COMMENT ON TABLE T_SHOP_FILE IS '매장정보_첨부파일';
COMMENT ON COLUMN T_SHOP_FILE.SHOP_UID IS '매장 고유번호';
COMMENT ON COLUMN T_SHOP_FILE.FILE_SEQ IS '파일번호';
COMMENT ON COLUMN T_SHOP_FILE.FILE_ORG_NAME IS '원본파일명';
COMMENT ON COLUMN T_SHOP_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN T_SHOP_FILE.FILE_EXT IS '파일확장자';
COMMENT ON COLUMN T_SHOP_FILE.FILE_SIZE IS '파일사이즈';
COMMENT ON COLUMN T_SHOP_FILE.REG_DATE IS '등록일';
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_SHOP_TIME생성
CREATE TABLE T_SHOP_TIME (
    SHOP_UID VARCHAR2(100),
    ORDER_TIME CHAR(4) NOT NULL
);
--T_SHOP_TIME FK 생성
ALTER TABLE T_SHOP_TIME ADD CONSTRAINT SFK_STIME FOREIGN KEY(SHOP_UID) REFERENCES T_SHOP(SHOP_UID);
--T_SHOP_TIME COMMENT 생성
COMMENT ON TABLE T_SHOP_TIME IS '매장 영업시간 테이블';
COMMENT ON COLUMN T_SHOP_TIME.SHOP_UID IS '매장 고유번호';
COMMENT ON COLUMN T_SHOP_TIME.SHOP_TIME IS '매장 영업시간';
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--T_SHOP_MENU생성
CREATE TABLE T_SHOP_MENU(
    SHOP_UID VARCHAR2(100),
    MENU_CODE CHAR(4) NOT NULL,
    MENU_NAME VARCHAR2(100) NOT NULL,
    MENU_PRICE NUMBER(12) NOT NULL
);
--T_SHOP_MENU FK 생성
ALTER TABLE T_SHOP_MENU ADD CONSTRAINT SFK_SMENU FOREIGN KEY(SHOP_UID) REFERENCES T_SHOP(SHOP_UID);
--T_SHOP_MENU COMMENT 생성
COMMENT ON TABLE T_SHOP_MENU IS '매장 메뉴정보 테이블';
COMMENT ON COLUMN T_SHOP_MENU.SHOP_UID IS '매장 고유번호';
COMMENT ON COLUMN T_SHOP_MENU.MENU_CODE IS '매장 메뉴코드';
COMMENT ON COLUMN T_SHOP_MENU.MENU_NAME IS '매장 메뉴이름';
COMMENT ON COLUMN T_SHOP_MENU.MENU_PRICE IS '매장 메뉴가격';
