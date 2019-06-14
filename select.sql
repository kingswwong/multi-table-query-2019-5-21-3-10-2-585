# 1.查询同时存在1课程和2课程的情况
	SELECT
  *
FROM student
WHERE student.id in
      (SELECT
         sc1.studentId
       FROM student_course sc1,student_course sc2
       WHERE sc1.studentId = sc2.studentId and sc1.courseId = 1 and sc2.courseId = 2)

# 2.查询同时存在1课程和2课程的情况

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
	SELECT * FROM 
	(select
  		c.studentId as stu_id,
  		s.name as name,
  		sum(c.score) /  count(c.courseId) as avg
		FROM student_course c, student s WHERE c.studentId = s.id GROUP BY stu_id) temp 
	WHERE temp.avg >= 60

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
	SELECT
  		s.id
	FROM student s WHERE id NOT IN 
	(SELECT
  		sc.studentId AS stu_id
	FROM student_course sc GROUP BY stu_id )

	SELECT
  		s.id
	FROM student s LEFT JOIN student_course sc ON s.id = sc.studentId WHERE isnull(sc.score)

# 5.查询所有有成绩的SQL
	#查询所有成绩且分数不为null
	select s.score as score FROM student_course s  where score is not null
	#查询所有有成绩的学生的信息
	SELECT s.*
	FROM student s,student_course sc WHERE s.id = sc.studentId GROUP BY sc.studentId

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
	SELECT
  *
FROM student
WHERE student.id in
      (SELECT
         sc1.studentId
       FROM student_course sc1,student_course sc2
       WHERE sc1.studentId = sc2.studentId and sc1.courseId = 1 and sc2.courseId = 2)

# 7.检索1课程分数小于60，按分数降序排列的学生信息
	select s.* FROM student s,student_course sc WHERE s.id = sc.studentId and sc.courseId = 1 AND sc.score < 60 ORDER BY sc.score DESC
# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
SELECT
  sc.courseId as courseId,
  avg(sc.score) AS avg
FROM student_course sc GROUP BY sc.courseId ORDER BY avg DESC , sc.courseId ASC ;
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
SELECT
  s.*
FROM student_course sc,student s WHERE s.id = sc.studentId and sc.courseId = (SELECT c.id FROM course c WHERE c.name = '数学') and sc.score < 60
