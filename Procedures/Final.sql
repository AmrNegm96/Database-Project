
use ExaminationSystem


-- insert Student Procedure
create proc add_studuent @std_id int , 
@dept_id int , @Fname varchar(50) , @Lname varchar(50),
@Address varchar(50) , @Phone varchar(11) , @Email varchar(50) , @BirthDate date
as
	insert into Student.Student 
	values(@std_id,@dept_id,@Fname,@Lname,@Address,@Phone,@Email,@BirthDate)
	

-- example
dbo.add_studuent 2 , 2 , 'user2' , null , null , '0110086665','zm5360112', '10-15-2000'


-- update Student Procedure
-- '''' ==> create single quates [@col_val ==> '@col_val']
alter proc update_student  @col varchar(20) , @col_val varchar(20) , @std_id int 
as execute ('update Student.Student set ' + @col + ' = ' + '''' + @col_val + '''' +'where st_id = ' + @std_id )
			
-- example
dbo.update_student 'dept_id' , 2 ,1



-- Delete Student Procedure
create proc delete_student  @std_id int 
as 
	delete from Student.Student where st_id = @std_id 
			
-- example
dbo.delete_student 1


----------------------------------------------------------------------------------
-- Department

-- insert Department Procedure
create proc add_Department @dept_id int , @dept_name varchar(50)
as
	insert into Department 
	values(@dept_id,@dept_name)
	

-- update Department Procedure
create proc update_Department  @col varchar(20) , @col_val varchar(20) , @dept_id int 
as execute ('update Department set ' + @col + ' = ' + '''' + @col_val + '''' +'where dept_id = ' + @dept_id )
			
-- example
dbo.update_Department 'dept_name' ,'d1' , 1


-- delete Department Procedure
create proc delete_Department  @dept_id int 
as
	delete from Department where dept_id= @dept_id 

-- example
dbo.delete_Department  1

----------------------------------------------------------------------------------
-- course

-- insert Course Procedure
create proc add_course @crs_id int , @dept_id int , @crs_name varchar(50) , @crs_duration int
as
	insert into Course 
	values(@crs_id,@dept_id,@crs_name,@crs_duration)
	

-- example
dbo.add_course 1 ,null , 'c++' , 10


-- update Course Procedure
create proc update_course  @col varchar(20) , @col_val varchar(20) , @crs_id int 
as execute ('update Course set ' + @col + ' = ' + '''' + @col_val + '''' +'where crs_id = ' + @crs_id )
			
-- example
dbo.update_course 'dept_id' , 2 ,1


-- Delete Course Procedure
create proc delete_course  @crs_id int 
as 
	delete from Course where crs_id = @crs_id 


-----------------------------------------------------------------------------------

-- Student_Courses Procedure 

create proc assign_courses_to_students  @crs_id int , @st_id int  
as
	insert into Student.Student_Courses values(@crs_id , @st_id )

-- example
dbo.assign_courses_to_students 2 , 1


-- get student cources Procedure [by using st_id]
alter proc get_student_cources  @st_id int  
as
	select Fname  , crs_name 
	from  Student.Student_Courses sc , Student.Student s , Course c
	where sc.crs_id = c.crs_id and sc.st_id = s.st_id and s.st_id = @st_id
-- example
dbo.get_student_cources 1


-- get all student cources Procedure
alter proc get_all_students_courses    
as
	select Fname  , crs_name 
	from  Student.Student_Courses sc , Student.Student s , Course c
	where sc.crs_id = c.crs_id and sc.st_id = s.st_id
-- example
dbo.get_all_students_courses 



-- delete all cources that are assigned to student => Procedure
create proc delete_student_courses  @st_id int
as
	delete from  Student.Student_Courses  where st_id = @st_id
-- example
dbo.delete_student_courses 1




-- update student cources Procedure

-- update crsID for specific student
alter proc update_student_courses  @st_id int  , @old_crs_id int , @new_crs_id int
as
	update Student.Student_Courses set crs_id = @new_crs_id where   crs_id = @old_crs_id and st_id = @st_id

-- example
dbo.update_student_courses 1,1 ,3

-- update stdID for specific course
create proc update_course_students  @crs_id int  , @old_st_id int , @new_st_id int
as
	update Student.Student_Courses set st_id = @new_st_id where   st_id = @old_st_id and crs_id = @crs_id

-- example
dbo.update_course_students 2,2 ,3


-----------------------------------------------------------------------------------

-- dbo.Topic Procedure

--Insert
create proc add_topic @topic_name varchar(50), @crs_id int
as
	insert into	Topic (crs_id,topic_name) values(@crs_id,@topic_name);

add_topic 'responsive',3;
add_topic 'inheritance',1;

--Select
create proc select_topic @topic_id int
as
	select * from Topic where topic_id = @topic_id;

select_topic 1

create proc select_all_topics
as
	select * from Topic;

select_all_topics

--Update
create proc update_topic_name @topic_name varchar(50) , @topic_id int
as
	update topic set topic_name = @topic_name where topic_id = @topic_id

update_topic_name 'RWD' , 1

--Delete
create proc delete_topic @topic_id int
as
	delete from topic where topic_id = @topic_id

delete_topic 1


----------------------------------------------------------------------------------
-- Instructor
--select all Instructors

create proc Select_AllInst
as
	select * from Instructors.Instructors

dbo.select_AllInst

--select cetrain Instructors

create proc Select_Inst @ins_id int
as
	select * from Instructors.Instructors
	where ins_id = @ins_id

dbo.select_Inst 1

-- insert Instructor Procedure
create proc add_Instructor @Inst_id int , @Dept_id int , @Inst_name varchar(50) , 
@Inst_deg varchar(50) , @Inst_sal money
as
	insert into Instructors.Instructors 
	values(@Inst_id , @Dept_id , @Inst_name , @Inst_deg , @Inst_sal)

-- add 2 instructors

dbo.add_Instructor 1 , 2 , 'Amr sherif Negm' , 'Phd' , 80000
dbo.add_Instructor 2 , 2 , 'Youssef ehab' , 'Phd' , 90000
dbo.add_Instructor 3 , 2 , 'To be delete' , 'none' , 0000

-- update Instructor Procedure
create proc update_instructor  @col varchar(20) , @col_val varchar(20) , @ins_id int 
as execute ('update Instructors.Instructors set ' + @col + ' = ' + '''' + @col_val + '''' +' where ins_id = ' + @ins_id )


-- edit 2 instructors

dbo.update_instructor  'salary'   , '90000' , 1
dbo.update_instructor  'dept_id'   , '1' , 2


		
-- delete Instructor Procedure
create proc delete_Instructor  @Ins_id int 
as
	delete from Instructors.Instructors where ins_id = @Ins_id 

-- delete 1 instructor
dbo.delete_Instructor  3

----------------------------------------------------------------------------------
-- Ins_Courses

--Select
create proc select_instructor_courses @ins_id int
as
	select * from Instructors.Ins_Courses where ins_id = @ins_id

select_instructor_courses 1
--Insert
create proc add_instructor_course @ins_id int , @crs_id int
as
	insert into Instructors.Ins_Courses values(@ins_id,@crs_id)

add_instructor_course 2,1
add_instructor_course 1,1
add_instructor_course 1,2

--Update
   
   --change course's instructor
create proc update_course_instructor @ins_id int, @crs_id int
as
	update Instructors.Ins_Courses set ins_id = @ins_id where crs_id = @crs_id;


	--change instructor's course that he teaches
create proc update_instructor_course @ins_id int, @crs_id int
as
	update Instructors.Ins_Courses set crs_id = @crs_id where ins_id = @ins_id

update_course_instructor 2,4
update_course_instructor 1,4

--Delete
create proc delete_instructor_course @ins_id int, @crs_id int
as
	delete from Instructors.Ins_Courses where ins_id = @ins_id and crs_id = @crs_id;

delete_instructor_course 1,1
add_instructor_course 1,1

----------------------------------------------------------------------------------
-- Questions

--Select
 --get a spacific course's question 
create proc select_course_questions @crs_id int
as
	select * from Exam.Questions where crs_id = @crs_id;

	--get mcq or true and false course's question
create proc select_course_questions_type @crs_id int, @crs_type varchar(20)
as
	select * from Exam.Questions where crs_id = @crs_id and type like @crs_type;

select_course_questions 4
select_course_questions_type 4, 'mcq'

--Insert
create proc add_question @question varchar(200), @answer varchar(100) , @crs_id int , @type varchar(20)
as
	insert into Exam.Questions (qst_title,model_answer,crs_id,type) 
	values(@question,@answer,@crs_id,@type)

add_question 'test','1',1,'true/false'

--Update
create proc update_question @qst_id int, @question varchar(200), @answer varchar(100) , @crs_id int , @type varchar(20)
as
	update Exam.Questions set
		qst_title = @question, model_answer = @answer, crs_id = @crs_id , type = @type 
		where qst_id = @qst_id

update_question 38, 'test', 'abcbd',1,'mcq'

--Delete
create proc delete_question @qst_id int
as
	delete from Exam.Questions where qst_id = @qst_id

delete_question 40

----------------------------------------------------------------------------------
-- Questions_Choices

--Select 
create proc select_choices @qst_id int
as
	select * from Exam.Questions_Choices where qst_id = @qst_id;

select_choices 25

--Insert
create proc add_choices @qst_id int, @a varchar(200),@b varchar(200),@c varchar(200),@d varchar(200)
as
	insert into Exam.Questions_Choices values(@qst_id,@a,@b,@c,@d);

--Update
create proc update_choices @qst_id int, @a varchar(200),@b varchar(200),@c varchar(200),@d varchar(200)
as
	update Exam.Questions_Choices set
	a =@a, b=@b, c = @c , d=@d where qst_id = @qst_id

--Delete
create proc delete_choices @qst_id int
as
	delete from Exam.Questions_Choices where qst_id = @qst_id;
------------------------------------------------------------------------------------------------------
--Exam_Question

--Select
create proc select_exam_question @ex_id int
as 
	select * from Exam.Exam_Questions where ex_id = @ex_id;


--Insert
create proc add_question_to_exam @ex_id int, @qst_id int
as
	insert into Exam.Exam_Questions
	values (@ex_id, @qst_id)

--Update
create proc update_exam_question @ex_id int , @qst_id int
as
	update Exam.Exam_Questions
	set qst_id = @qst_id 
	where ex_id = @ex_id

--Delete
create proc delete_exam_questions @ex_id int
as 
	delete from Exam.Exam_Questions
	where ex_id = @ex_id

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
BULK INSERT Exam.Questions
FROM 'D:/oop.txt'
WITH 
(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n' 
)

BULK INSERT Exam.Questions_Choices
FROM 'D:/oopAns.txt'
WITH 
(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n' 
)

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------- Exam Generation ----------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

alter proc ExamGeneration @crs_id int, @exam_name varchar(100), @mcq int , @TF int
as
	declare @examID int
	declare @questions Table(qst_id int)

	--created new exam with course id and course name
	insert into Exam.Exams values (@crs_id,@exam_name)

	--insert into table @questions the generated mcq
	insert into @questions 
	select Top(@mcq) qst_id
	from Exam.Questions
	where type = 'mcq' and crs_id = 1
	order by NEWID()

	--insert into table @questions the generated true/false questions
	insert into @questions 
	select Top(@TF) qst_id
	from Exam.Questions
	where type = 't/f' and crs_id = 1
	order by NEWID()

	--Get the id of the newly created exams
	select top(1) @examID = ex_id from Exam.Exams
	order by ex_id desc

	--create new cursor to loop on the @questions table 
	--and insert the questions into Exam_Questions (@examID, qst_id)
	declare c1 cursor
	for 
	select qst_id from @questions

	declare @id int
	open c1
	fetch c1 into @id
	while @@FETCH_STATUS=0
		begin
		insert into Exam.Exam_Questions 
		values(@examID,@id)
		fetch c1 into @id
		end
	close c1 
	deallocate c1

	ExamGeneration 1, 'inhertance', 5 ,5

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
----------------------------------------- Exam Answers -----------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

create proc ExamAnswers @examID int ,  @stID int , @stA1 varchar(200),@stA2 varchar(200),
@stA3 varchar(200),@stA4 varchar(200),@stA5 varchar(200),@stA6 varchar(200),@stA7 varchar(200),
@stA8 varchar(200),@stA9 varchar(200),@stA10 varchar(200)
as 
	declare @stAnsTable Table(ans varchar(200))
	insert into @stAnsTable values(@stA1),(@stA2),(@stA3),(@stA4),(@stA5),(@stA6)
	,(@stA7),(@stA8),(@stA9),(@stA10)


	declare c1 cursor
	for 
	select qst_id from Exam.Exam_Questions
	where ex_id = @examID
	declare @q_id int
	open c1
	fetch c1 into @q_id
	
	declare c2 cursor
	for 
	select * from @stAnsTable
	declare @ans varchar(200)
	open c2
	fetch c2 into @ans
		
	while @@FETCH_STATUS=0
		begin
		insert into Student.Students_Answers values(@examID,@stID,@q_id,@ans)
		fetch c1 into @q_id
		fetch c2 into @ans
		end
	close c1 
	deallocate c1
	close c2 
	deallocate c2

ExamGeneration 4 , 'C++ one' , 10 , 0
ExamAnswers 3 , 1 , 'a','b','c','d','e','f','g','h','i','j'

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
---------------------------------------- Exam Correction ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------


--get course id by exam id from table exams
--join between student_answers and question on qst_id where ex_id is equal exam_id

--var for grade
--var for course id
create proc ExamCorrection @examID int , @stID int
as
	begin try
	declare @grade int
	declare @crsID int

	select @grade = COUNT(ex_id), @crsID=crs_id
	from Student.Students_Answers a, Exam.Questions q
	where a.qst_id = q.qst_id and a.ex_id = @examID and a.st_id = @stID
	and st_ans like model_answer
	group by crs_id

	set @grade = @grade*10
--	set @grade = Convert(varchar,@grade)+'%'

	update Student.Student_Courses
	set grade = @grade 
	where crs_id = @crsID and st_id = @stID
	end try
	begin catch
	select 'Error! please in check exam id and/or student id'
	end catch


	-------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------ Reports ---------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

--1 get all students in a department
create proc getStudentInDept @dept_id int
as 
	begin try
		select s.st_id , (s.Fname + ' ' + Lname) as [Full Name]
		from student.Student s , department d
		where s.dept_id = d.dept_id and s.dept_id = @dept_id
	end try
	begin catch
		SELECT 'Error! Please Make Sure that the Department ID Exists'
	end catch

--2 show student courses and grades
create proc getStudentCoursesGrades @stID int
as
	begin try
		select crs_id , grade 
		from Student.Student_Courses 
		where st_id = @stID
	end try
	begin catch
		select 'Error! Please Make sure that Student ID is Correct!'
	end catch

--3 Take instructor id and print a list of courses that he teaches and number of 
--student in each course

create proc getInstructorCoursesDetals @ins_id int
as
	begin try
		select ic.crs_id , c.crs_name , Count(sc.st_id) as [Number of Students]
		from Instructors.Ins_Courses ic, Course c , Student.Student_Courses sc
		where ic.ins_id = @ins_id and ic.crs_id = c.crs_id and ic.crs_id = sc.crs_id
		group by ic.crs_id , c.crs_name
	end try
	begin catch
		select 'Error! Please Make sure that Instructor ID is Correct!'
	end catch


--4 show all topic in a course
create proc getCourseTopics @crs_id int
as
	begin try
		select topic_name as Topic
		from Topic where crs_id = @crs_id
	end try
	begin catch
		select 'Error! Please make sure that Course ID is Correct!'
	end catch

getCourseTopics 1

	-- Report that takes exam number and returns the Questions in it and chocies
	--5 Qusestions(title) | Questions_choices(choices) | Exam_Questions(q-id)
	alter proc Questions_Choices_in_Exam_Report @ex_id int
	as
		declare @Ex_qst Table (qst_id int)
		
		declare @TF_questions Table ( qst_title varchar(200) , a varchar(100) ,b varchar(100) , c varchar(100) , d varchar(100) )
		declare @mcq_questions Table (qst_title varchar(200) , a varchar(100) ,b varchar(100) , c varchar(100) , d varchar(100) )


		insert into @Ex_qst 
		select  qst_id from Exam.Exam_Questions
		where ex_id = @ex_id

		
	declare c1 cursor
	for 
	select q.qst_id from @Ex_qst q
	open c1
	declare @q int

	fetch c1 into @q

		
	while @@FETCH_STATUS=0
		begin
		-- insert into TF_questions
		insert into @TF_questions (qst_title) 
		select qst_title from Exam.Questions 
		where qst_id = @q and type = 't/f'
		
		-- insert into mcq_questions
		insert into @mcq_questions (qst_title,a,b,c,d)
		select qst_title , a , b , c , d
		from Exam.Questions q , Exam.Questions_Choices c
		where type = 'mcq' and q.qst_id = @q and q.qst_id = c.qst_id
		
		fetch c1 into @q

		end
	close c1 
	deallocate c1

declare @TF_Exsist int , @mcq_Exsist int

select * from @TF_questions
union all
select * from @mcq_questions


Questions_Choices_in_Exam_Report 2


	--6 Report that takes studentId and ExamID & show exam questions and student answer



	create proc show_stdAns_ModelAns @std_id int, @ex_id int 
	as
		select q.qst_title  ,sa.st_ans
		from Student.Student s, Exam.Exams e, Exam.Questions q, Exam.Exam_Questions eq ,Exam.Questions_Choices qc ,Student.Students_Answers sa ,Course c ,Student.Students_Exams se
		where e.ex_id=@ex_id and s.st_id=@std_id and e.ex_id=eq.ex_id  and eq.qst_id =q.qst_id and q.qst_id =qc.qst_id and e.ex_id=sa.ex_id and s.st_id =sa.st_id and c.crs_id=e.crs_id and
		s.st_id=sa.st_id and s.st_id =se.st_id and se.ex_id=e.ex_id and sa.qst_id=q.qst_id
		

	
		