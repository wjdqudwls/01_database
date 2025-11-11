-- q1
DROP TABLE students;
DROP TABLE grades;

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    class VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    grade CHAR(1)
    ,FOREIGN KEY (student_id) REFERENCES students (student_id)
);

INSERT INTO students VALUES  (1, '유관순', 'A');
INSERT INTO students VALUES  (2, '신사임당', 'B');
INSERT INTO students VALUES  (3, '홍길동', 'C');

SELECT * FROM students;

INSERT INTO grades  (student_id, subject, grade) VALUES
                                                     (1,'과학','A'),
                                                     (1,'과학','A'),
                                                     (2,'과학','C'),
                                                     (2,'수학','B'),
                                                     (3,'수학','B'),
                                                     (3,'수학','B');

CREATE VIEW IF NOT EXISTS studentView AS (
SELECT g.subject,
       s.name,
       s.class,
       g.grade
FROM students s
    JOIN grades g ON (s.student_id = g.student_id)
    ORDER BY g.subject ASC
                                         );

SELECT * FROM studentView;

-- q2. 인덱스 생성
CREATE INDEX test1 ON employee(dept_code);
-- q2. 인덱스 조회
SHOW INDEX FROM menudb.EMPLOYEE;
-- q2. 인덱스 삭제
DROP INDEX test1 ON menudb.EMPLOYEE;