
create table board(
	num int primary key,   --게시글번호, 기본키
	writer varchar2(30),   --작성자
	pass varchar2(20),	   --글 비밀번호
	subject varchar2(100), --제목
	content varchar2(4000),--내용
	file1 varchar2(100),   --첨부파일명
	boardid varchar2(1),   --게시판 종류 1: 공지사항, 2: 자유게시판, 3:Q&A 게시판
	regdate date,		   --등록일시
	ip varchar2(20),	   --작성자 IP값
	readcnt number(10),	   --조회수
	grp int,			   --답변글시 원글의 게시글 번호
	grplevel number(3),	   --답변글의 레벨
	grpstep number(5)	   --글 그룹의 순서
);

         
select * from board;
drop table board;


/* Drop Tables */

DROP TABLE BakeryMenu CASCADE CONSTRAINTS;
DROP TABLE BakeryReview CASCADE CONSTRAINTS;
DROP TABLE Wish CASCADE CONSTRAINTS;
DROP TABLE LikeBakery CASCADE CONSTRAINTS;
DROP TABLE Reservation CASCADE CONSTRAINTS;
DROP TABLE Bakery CASCADE CONSTRAINTS;
DROP TABLE BakeryReservation CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE UserAccount CASCADE CONSTRAINTS;

delete bakery where bakeryid='bakery20'
select * from useraccount

/* Create Tables */
DROP TABLE Bakery CASCADE CONSTRAINTS;

CREATE TABLE Bakery
(
	bakeryid  varchar2(20) NOT NULL,
	bname varchar2(50) NOT NULL,
	bakeryinfo varchar2(500),
	bakeryimg varchar2(200),
	fileurl varchar2(200),
	location varchar2(200) NOT NULL,
	opentime varchar2(20 char),
	closetime varchar2(20),
	dayoff varchar2(50),
	bakerytel varchar2(100), 
	likeno number NOT NULL,
	viewno number,
	regdate date NOT NULL,
	userid varchar2(15 char) NOT NULL,
	adminchk number NOT NULL,
	pageid varchar2(20) NOT NULL,
	PRIMARY KEY (bakeryid )
);


select* from bakery

alter table Bakery modify bname varchar2(50)

CREATE TABLE BakeryMenu
(
	bakeryid  varchar2(20) NOT NULL,
	no number NOT NULL,
	menuid number,
	menuname varchar2(50),
	menuimg varchar2(200),
	menufileurl varchar2(200),
	menuinfo varchar2(200),
	PRIMARY KEY (bakeryid , no)
);



CREATE TABLE BakeryReservation
(
	predate date NOT NULL,
	prenum number NOT NULL,
	PRIMARY KEY (predate, prenum)
);
select * from bakeryreservation;
select * from reservation;

CREATE TABLE BakeryReview
(
	no number NOT NULL,
	bakeryid  varchar2(20) NOT NULL,
	userid varchar2(15 char) NOT NULL,
	subject varchar2(30 char) NOT NULL,
	content varchar2(50 char) NOT NULL,
	regdate date NOT NULL,
	file1 varchar2(100 char),
	ip varchar2(20),       -- 작성자의 컴퓨터의 ip값 
        readcnt number(10),    -- 조회수 상세보기시 1씩 증가
        grp number,               -- 답변글 작성시, 본문의 게시글 번호
        grplevel number(3),    -- 답변글의 레벨
        grpstep number(5),   -- 글 그룹의 순서
	PRIMARY KEY (no)
);


CREATE TABLE board
(
	board_no number NOT NULL,
	id varchar2(20 char) NOT NULL,
	board_pw varchar2(20 char) NOT NULL,
	title varchar2(100 char) NOT NULL,
	content varchar2(4000 char) NOT NULL,
	file1 varchar2(100 char),
	fileurl varchar2(20 char),
	regdate date,
	readcnt number(10,0),
	PRIMARY KEY (board_no)
);


CREATE TABLE LikeBakery
(
	likestate number NOT NULL,
	bakeryid  varchar2(20) NOT NULL,
	userid varchar2(15 char) NOT NULL,
	PRIMARY KEY (bakeryid , userid)
);


CREATE TABLE Reservation
(
	no number NOT NULL,
	userid varchar2(15 char) NOT NULL,
	bakeryid  varchar2(20) NOT NULL,
	predate date NOT NULL,
	prenum number NOT NULL,
	PRIMARY KEY (no)
);

insert into reservation values  (1, 'cus1', 'bakery1', sysdate, 1);
insert into reservation values  (2, 'cus1', 'bakery3', sysdate, 3);
insert into reservation values  (3, 'cus2', 'bakery11', sysdate, 1);
insert into reservation values  (4, 'cus3', 'bakery14', sysdate, 1);
insert into reservation values  (5, 'cus1', 'bakery18', sysdate, 1);
insert into reservation values  (6, 'cus4', 'bakery3', sysdate, 2);
insert into reservation values  (7, 'cus4', 'bakery10', sysdate, 1);

CREATE TABLE Wish
(
	userid varchar2(15 char) NOT NULL,
	bakeryid  varchar2(20) NOT NULL,
	wishdate date NOT NULL
);


insert into wish values ('cus1', 'bakery1', sysdate);
insert into wish values ('cus1', 'bakery2', sysdate);
insert into wish values ('cus1', 'bakery3', sysdate);
insert into wish values ('cus1', 'bakery4', sysdate);
insert into wish values ('cus1', 'bakery5', sysdate);
insert into wish values ('cus1', 'bakery6', sysdate);

insert into wish values ('cus2', 'bakery1', sysdate);
insert into wish values ('cus2', 'bakery2', sysdate);
insert into wish values ('cus2', 'bakery3', sysdate);
insert into wish values ('cus3', 'bakery4', sysdate);
insert into wish values ('cus3', 'bakery5', sysdate);
insert into wish values ('cus3', 'bakery6', sysdate);



CREATE TABLE UserAccount
(
	userid varchar2(15 char) NOT NULL,
	pass varchar2(15 char) NOT NULL,
	name varchar2(30 char) NOT NULL,
	tel number NOT NULL,
	email varchar2(30) NOT NULL,
	type number NOT NULL,
	CONSTRAINT SYS_C007414 PRIMARY KEY (userid)
);
select * from USERACCOUNT
insert into USERACCOUNT values ('userid', '1111', 'name', '101010')
insert into useraccount values ('admin', '1234', '관리자', '010-1234-5678', 'admin@naver.com', 0);

/* Create Foreign Keys */

ALTER TABLE BakeryMenu
	ADD FOREIGN KEY (bakeryid )
	REFERENCES Bakery (bakeryid )
;


ALTER TABLE BakeryReview
	ADD FOREIGN KEY (bakeryid )
	REFERENCES Bakery (bakeryid )
;


ALTER TABLE LikeBakery
	ADD FOREIGN KEY (bakeryid )
	REFERENCES Bakery (bakeryid )
;


ALTER TABLE Reservation
	ADD FOREIGN KEY (bakeryid )
	REFERENCES Bakery (bakeryid )
;


ALTER TABLE BakeryReservation
	ADD FOREIGN KEY (predate, prenum)
	REFERENCES BakeryReservation (predate, prenum)
;


ALTER TABLE WishList
	ADD FOREIGN KEY (bakeryid , userid)
	REFERENCES LikeBakery (bakeryid , userid)
;


ALTER TABLE Bakery
	ADD FOREIGN KEY (userid)
	REFERENCES useraccount (userid)
;


ALTER TABLE BakeryReview
	ADD FOREIGN KEY (userid)
	REFERENCES useraccount (userid)
;


ALTER TABLE LikeBakery
	ADD FOREIGN KEY (userid)
	REFERENCES useraccount (userid)
;


ALTER TABLE Reservation
	ADD FOREIGN KEY (userid)
	REFERENCES useraccount (userid)
;

select * from useraccount





CREATE TABLE UserAccount
(
	userid varchar2(15 char) NOT NULL,
	pass varchar2(15 char) NOT NULL,
	name varchar2(30 char) NOT NULL,
	tel varchar2 (100 char) NOT NULL,
	email varchar2(100) NOT NULL,
	type number NOT NULL,
	CONSTRAINT SYS_C007414 PRIMARY KEY (userid)
);
DROP TABLE UserAccount CASCADE CONSTRAINTS;
delete useraccount where userid='customwe1'
insert into useraccount values ('admin', '1234', '관리자', '010-1234-5678', 'admin@naver.com', 0);
insert into useraccount values ('cus1', '1234', '장우진', '010-1234-5678', 'woojin@naver.com', 1);
insert into useraccount values('cus1','1234','최서진','010-1234-5678','seojin@naver.com',0);
insert into useraccount values('cus2','1234','정은우','010-1234-5678','eunwoo@naver.com',0);
insert into useraccount values('cus3','1234','지승우','010-1234-5678','seungwoo@naver.com',0);
insert into useraccount values('cus4','1234','이하린','010-1234-5678','harin@naver.com',0);
insert into useraccount values('cus5','1234','강지원','010-1234-5678','jiwon@naver.com',0);
insert into useraccount values('cus6','1234','한소윤','010-1234-5678','soyoon@naver.com',0);
insert into useraccount values('cus7','1234','이서아','010-1234-5678','seoa@naver.com',0);
insert into useraccount values('cus8','1234','한가은','010-1234-5678','gaeun@naver.com',0);
insert into useraccount values('cus9','1234','박민지','010-1234-5678','minji@naver.com',0);
insert into useraccount values('cus10','1234','박시후','010-1234-5678','sihoo@naver.com',0);


insert into useraccount values('boss1','1234','김도윤','010-1234-5678','doyun@naver.com',1);
insert into useraccount values('boss2','1234','박서준','010-1234-5678','sujun@naver.com',1);
insert into useraccount values('boss3','1234','이하준','010-1234-5678','hajun@naver.com',1);
insert into useraccount values('boss4','1234','김은우','010-1234-5678','woo@naver.com',1);
insert into useraccount values('boss5','1234','최시우','010-1234-5678','siwoo@naver.com',1);
insert into useraccount values('boss6','1234','한이준','010-1234-5678','jun@naver.com',1);
insert into useraccount values('boss7','1234','유지호','010-1234-5678','jiho@naver.com',1);
insert into useraccount values('boss8','1234','김유준','010-1234-5678','ujun@naver.com',1);
insert into useraccount values('boss9','1234','정건우','010-1234-5678','gunwoo@naver.com',1);
insert into useraccount values('boss10','1234','김예준','010-1234-5678','yejun@naver.com',1);


insert into useraccount values('boss11','1234','유지안','010-1234-5678','jian@naver.com',1);
insert into useraccount values('boss12','1234','김하윤','010-1234-5678','hayun@naver.com',1);
insert into useraccount values('boss13','1234','한지유','010-1234-5678','jijun@naver.com',1);
insert into useraccount values('boss14','1234','김서아','010-1234-5678','sea@naver.com',1);
insert into useraccount values('boss15','1234','이지연','010-1234-5678','jiyeon@naver.com',1);
insert into useraccount values('boss16','1234','김지우','010-1234-5678','jiwoo@naver.com',1);
insert into useraccount values('boss17','1234','김유나','010-1234-5678','yuna@naver.com',1);
insert into useraccount values('boss18','1234','최하연','010-1234-5678','hayeon@naver.com',1);
insert into useraccount values('boss19','1234','박수연','010-1234-5678','suyeon@naver.com',1);
insert into useraccount values('boss20','1234','김다은','010-1234-5678','da@naver.com',1);


insert into useraccount values('boss21','1234','김현우','010-1234-5678','hunwoo@naver.com',1);
insert into useraccount values('boss22','1234','김우주','010-1234-5678','wooju@naver.com',1);
insert into useraccount values('boss23','1234','박준서','010-1234-5678','junseo@naver.com',1);
insert into useraccount values('boss24','1234','박지한','010-1234-5678','jihan@naver.com',1);
insert into useraccount values('boss25','1234','최정우','010-1234-5678','jungwoo@naver.com',1);
insert into useraccount values('boss26','1234','김진혁','010-1234-5678','jinhyeok@naver.com',1);
insert into useraccount values('boss27','1234','김주혁','010-1234-5678','juhyeok@naver.com',1);
insert into useraccount values('boss28','1234','정찬','010-1234-5678','jungchan@naver.com',1);
insert into useraccount values('boss29','1234','박재하','010-1234-5678','jaha@naver.com',1);
insert into useraccount values('boss30','1234','유석훈','010-1234-5678','seokhun@naver.com',1);



insert into useraccount values('boss31','1234','김나연','010-1234-5678','nayeon@naver.com',1);
insert into useraccount values('boss32','1234','정지아','010-1234-5678','jia@naver.com',1);
insert into useraccount values('boss33','1234','김지수','010-1234-5678','jisu@naver.com',1);
insert into useraccount values('boss34','1234','박정아','010-1234-5678','junga@naver.com',1);
insert into useraccount values('boss35','1234','김채연','010-1234-5678','chayeon@naver.com',1);
insert into useraccount values('boss36','1234','김나경','010-1234-5678','nakung@naver.com',1);
insert into useraccount values('boss37','1234','박지원','010-1234-5678','jiwon@naver.com',1);
insert into useraccount values('boss38','1234','이채원','010-1234-5678','chawon@naver.com',1);
insert into useraccount values('boss39','1234','김지선','010-1234-5678','jisun@naver.com',1);
insert into useraccount values('boss40','1234','유다현','010-1234-5678','dahyeon@naver.com',1);

insert into useraccount values('boss41','1234','서현아','010-1234-5678','huna@naver.com',1);
insert into useraccount values('boss42','1234','김준혁','010-1234-5678','junheok@naver.com',1);
insert into useraccount values('boss43','1234','정혜정','010-1234-5678','hyejung@naver.com',1);
insert into useraccount values('boss44','1234','최성아','010-1234-5678','sunga@naver.com',1);

