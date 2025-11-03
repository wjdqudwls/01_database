/*
 result set을 정렬하는 구문
 result set이란 ?
 select 문의 결과 집합 (select 실행해서 조회되는 데이터의 집합)

보통 select문 제일 마지막에 작성

정렬 방식
 1) ASC : 오름차순(ASCENDING)
 2) DESC : 내림차순(DESCENDING)
 */

select a.* from tbl_menu a order by a.menu_code; -- ASC는 생략 가능
select a.* from tbl_menu a order by a.menu_code DESC;

-- 문자열 정렬 유니코드 순 abcㄱㄴㄷ
select a.* from tbl_menu a order by a.menu_name;
select a.* from tbl_menu a order by a.menu_name DESC;

-- 여러 절로 정렬
select a.menu_code, a.menu_name, a.menu_price
    from tbl_menu a
order by a.menu_price, a.menu_name;

/*
order by 절에는 컬럼명 외에
연산 결과, 별칭, 컬럼 순서 등을 사용할 수 있다
*/

-- 컬럼 순서 이용
select a.menu_code, a.menu_name, a.menu_price
    from tbl_menu a
order by 2;

-- 연산 결과 이용
select a.menu_code, a.menu_name, a.menu_price, a.menu_code * a.menu_price
    from tbl_menu a
order by menu_code * menu_price desc;

-- 별칭 이용
select a.menu_code cd, a.menu_name nm, a.menu_price pc, a.menu_code * a.menu_price cdxpc
    from tbl_menu a
order by cdxpc desc;

SELECT
    a.menu_code AS cd,
    a.menu_name AS nm,
    a.menu_price AS pc,
    a.menu_code * a.menu_price AS `연산 결과`
FROM tbl_menu a
ORDER BY `연산 결과` DESC;

-- db에서 null은 공백
select a.*
  from tbl_category a;

-- null 값의 정렬 방식 null 이 작은값 취급
select count(ifnull(a.ref_category_code,'0')) cnt
  from tbl_category a
order by cnt;

/*
    asc 정렬 시 null은 무조건 윗쪽
    desc 정렬 시 null은 무조건 아랫쪽
    order by 대상 컬럼 앞에 -추가 시 정렬 방향이 반대로
*/

SELECT FIELD('A', 'A', 'B', 'C');

-- field 함수 이용해서 정렬하기
SELECT
       menu_name
     , orderable_status
  FROM tbl_menu
 ORDER BY FIELD(orderable_status, 'Y', 'N');

-- in으로 비슷하게
SELECT
       menu_name,
       orderable_status
  FROM tbl_menu
 ORDER BY
       CASE
         WHEN orderable_status IN ('Y') THEN 1
         WHEN orderable_status IN ('N') THEN 2
         ELSE 3
       END;


