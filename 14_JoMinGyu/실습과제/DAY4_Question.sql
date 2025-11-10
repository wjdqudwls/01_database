
# 1.
drop table if exists team_info;
drop table if exists member_info;

create table if not exists team_info(
    team_code   int                   auto_increment comment '소속코드',
    team_name   varchar(100) not null                comment '소속명',
    team_detail varchar(100)                         comment '소속상세정보',
    use_yn      char(2)                              comment '사용여부',
    primary key (team_code),
    check ( use_yn in ('Y', 'N') )
) engine = innodb comment '소속정보';

create table if not exists member_info(
    member_code     int         auto_increment          comment '회원코드',
    member_name     varchar(70) not null                comment '회원이름',
    birth_date      date                                comment '생년월일',
    division_code   char(2)                             comment '회원이름',
    detail_info     varchar(500)                        comment '상세정보',
    contact         varchar(50) not null                comment '연락처',
    team_code       int         not null                comment '소속코드',
    active_status   char(2)     not null default 'Y'    comment '활동상태',
    primary key (member_code),
    check (active_status in ('Y', 'N', 'H')),
    FOREIGN KEY (team_code)
        REFERENCES team_info (team_code)
) engine = innodb comment '회원정보';


#2.
select * from team_info;
select * from member_info;

insert into team_info (team_code, team_name, team_detail, use_yn)
values (1, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y'),
       (2, '맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N'),
       (3, '행복찾기부', null, 'Y');

select * from team_info;

insert into member_info (member_code, member_name, birth_date, division_code, detail_info, contact, team_code, active_status)
values (1, '송가인', '1990-01-30', 1, '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H'),
       (2, '임영웅', '1992-05-03', null, '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y'),
       (3, '태진아', null, null, null, '(1급 기밀)', 3, 'Y');

select * from member_info;


#3.
select count(*) as member_count
from (select *
      from employee e
               join department d on e.DEPT_CODE = d.DEPT_ID
      where d.DEPT_TITLE = '기술지원부'
        and e.JOB_CODE = 'J6'
      union
      select *
      from employee e
               join department d on e.DEPT_CODE = d.DEPT_ID
      where d.DEPT_TITLE = '인사관리부'
        and e.JOB_CODE = 'J7'
      union
      select *
      from employee e
               join department d on e.DEPT_CODE = d.DEPT_ID
      where d.DEPT_TITLE like '%영업%'
        and e.JOB_CODE = 'J3') as team;

select * from employee;