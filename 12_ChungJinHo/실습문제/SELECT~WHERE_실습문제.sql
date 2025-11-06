-- ========================================
-- SELECT ~ WHERE 실습문제
-- ========================================

-- ========================================
-- 기본 SELECT 문제
-- ========================================

-- 1번. tbl_menu 테이블에서 메뉴명(menu_name)과 가격(menu_price)만 조회하세요.
select menu_name
      ,menu_price
  from tbl_menu;


-- 2번. 별칭(AS)을 사용하여 현재 날짜와 시간을 '조회시각'이라는 이름으로 출력하세요.
select now() `조회시각`
  from dual;


-- 3번. tbl_category 테이블의 모든 컬럼을 조회하세요.
select *
  from tbl_category;


-- ========================================
-- ORDER BY 문제
-- ========================================

-- 4번. tbl_menu 테이블에서 메뉴 가격이 높은 순서대로 메뉴명, 가격을 조회하세요.
select menu_name
      ,menu_price
  from tbl_menu
 order
    by menu_price desc;


-- 5번. tbl_menu 테이블에서 카테고리 코드 오름차순, 같은 카테고리 내에서는 가격 내림차순으로 정렬하여 모든 컬럼을 조회하세요.
select *
  from tbl_menu
 order
   by category_code, menu_price desc;


-- 6번. tbl_menu 테이블에서 주문가능상태(orderable_status) 기준으로 정렬하되, 'Y'가 먼저 나오도록 조회하세요.
select *
  from tbl_menu
 order
    by case when orderable_status = 'Y' then 1
            when orderable_status = 'N' then 2
            else 3 end;



-- ========================================
-- WHERE 절 - 비교 연산자
-- ========================================

-- 7번. tbl_menu 테이블에서 가격이 10,000원인 메뉴의 메뉴명과 가격을 조회하세요.
select menu_name
      ,menu_price
  from tbl_menu
 where menu_price = '10000';


-- 8번. tbl_menu 테이블에서 주문이 불가능한(orderable_status = 'N') 메뉴의 모든 정보를 조회하세요.
select *
  from tbl_menu
 where orderable_status = 'N'


-- 9번. tbl_menu 테이블에서 가격이 15,000원 이상인 메뉴의 메뉴코드, 메뉴명, 가격을 조회하세요.
select menu_code
      ,menu_name
      ,menu_price
  from tbl_menu
 where menu_price >= '15000';


-- 10번. tbl_menu 테이블에서 카테고리 코드가 8번이 아닌 메뉴들을 조회하세요.
select *
  from tbl_menu
 where category_code <> '8';


-- ========================================
-- WHERE 절 - 논리 연산자
-- ========================================

-- 11번. tbl_menu 테이블에서 가격이 5,000원 이상이면서 주문 가능한(orderable_status = 'Y') 메뉴를 조회하세요.
select *
  from tbl_menu
 where menu_price >= '5000'
   and orderable_status = 'Y';


-- 12번. tbl_menu 테이블에서 카테고리 코드가 4번이거나 가격이 9,000원인 메뉴를 조회하세요.
select *
  from tbl_menu
 where category_code = '4'
    or menu_price = '9000';


-- 13번. tbl_menu 테이블에서 (카테고리 코드가 6번 또는 10번) 그리고 주문 가능한 메뉴를 조회하세요. (괄호 사용)
select *
  from tbl_menu
 where (
       category_code = '6'
    or category_code = '10')
   and orderable_status = 'Y';


-- 14번. tbl_menu 테이블에서 가격이 8,000원 이상 20,000원 이하인 메뉴를 조회하세요. (AND 사용)
select *
  from tbl_menu
 where menu_price >= '8000'
   and menu_price <= '20000';


-- ========================================
-- WHERE 절 - BETWEEN
-- ========================================

-- 15번. tbl_menu 테이블에서 메뉴 코드가 5번부터 15번 사이인 메뉴를 조회하세요. (BETWEEN 사용)
select *
  from tbl_menu
 where menu_code between '5' and '15';


-- 16번. tbl_menu 테이블에서 가격이 10,000원 ~ 20,000원 범위가 아닌 메뉴를 가격순으로 조회하세요. (NOT BETWEEN 사용)
select *
  from tbl_menu
 where menu_price between '10000' and '20000';


-- ========================================
-- WHERE 절 - LIKE
-- ========================================

-- 17번. tbl_menu 테이블에서 메뉴명에 '마늘'이 포함된 메뉴를 조회하세요.
select *
  from tbl_menu
 where menu_name like '%마늘%';


-- 18번. tbl_menu 테이블에서 메뉴명이 '스'로 끝나는 메뉴를 조회하세요.
select *
  from tbl_menu
 where menu_name like '%스';


-- 19번. tbl_menu 테이블에서 메뉴명이 '생'으로 시작하는 메뉴를 조회하세요.
select *
  from tbl_menu
 where menu_name like '생%';


-- 20번. tbl_menu 테이블에서 메뉴명의 두 번째 글자가 '마'인 메뉴를 조회하세요. (_ 사용)
select *
  from tbl_menu
 where menu_name like '_마%';


-- 21번. tbl_menu 테이블에서 메뉴명에 '김치'가 포함되지 않은 메뉴를 조회하세요. (NOT LIKE 사용)
select *
  from tbl_menu
 where menu_name not like '%김치%';


-- ========================================
-- WHERE 절 - IN
-- ========================================

-- 22번. tbl_menu 테이블에서 카테고리 코드가 4, 8, 12번에 해당하는 메뉴를 카테고리 코드순으로 조회하세요. (IN 사용)
select *
  from tbl_menu
 where category_code in ('4','8','12')
 order
    by category_code;


-- 23번. tbl_category 테이블에서 카테고리 코드가 1, 2, 3번이 아닌 카테고리를 조회하세요. (NOT IN 사용)
select *
  from tbl_category
 where category_code not in ('1','2','3')
 order
    by category_code;


-- ========================================
-- WHERE 절 - IS NULL
-- ========================================

-- 24번. tbl_category 테이블에서 상위 카테고리가 없는(ref_category_code가 NULL) 카테고리를 조회하세요.
select *
  from tbl_category
 where ref_category_code is null;


-- 25번. tbl_category 테이블에서 상위 카테고리가 있는(ref_category_code가 NULL이 아닌) 카테고리를 조회하세요.
select *
  from tbl_category
 where ref_category_code is not null;


-- ========================================
-- 종합 문제
-- ========================================

-- 26번. tbl_menu 테이블에서 가격이 7,000원 이상이고, 카테고리 코드가 4, 6, 10번 중 하나이며, 주문 가능한 메뉴를 가격 오름차순으로 조회하세요.
select *
  from tbl_menu
 where menu_price >= '7000'
   and category_code in ('4','6','10')
   and orderable_status = 'Y'
 order
    by menu_price;


-- 27번. tbl_menu 테이블에서 메뉴명에 '아'가 포함되거나 가격이 5,000원 이하인 메뉴를 메뉴명 오름차순으로 조회하세요.
select *
  from tbl_menu
 where menu_name like '%아%'
    or menu_price <= '5000'
 order
    by menu_name;


-- 28번. tbl_menu 테이블에서 카테고리 코드가 8~12번 사이이고, 메뉴명에 '빵'이 포함된 메뉴의 메뉴명과 가격을 조회하세요.
select menu_name
      ,menu_price
  from tbl_menu
 where category_code between '8' and '12'
   and menu_name like '%빵%';


-- 29번. tbl_category 테이블에서 상위 카테고리 코드가 1번 또는 2번인 카테고리의 카테고리명과 상위 카테고리 코드를 조회하세요.
select category_name
      ,ref_category_code
  from tbl_category
 where ref_category_code in ('1','2');


-- 30번. tbl_menu 테이블에서 주문 불가능하거나(orderable_status = 'N'), 가격이 10,000원 미만인 메뉴 중 메뉴명이 '빵', '떡', '찜' 중 하나로 끝나는 메뉴를 조회하세요. (여러 조건 조합)
select *
  from tbl_menu
 where orderable_status = 'N'
    or (
       menu_price < '10000'
       and (
           menu_name like '%빵'
           or menu_name like '%떡'
           or menu_name like '%찜'
           )
       );
