-- Execution Courses to delete
--select EXECUTION_COURSE.ID_INTERNAL
--from EXECUTION_PERIOD
--	inner join EXECUTION_COURSE on EXECUTION_PERIOD.ID_INTERNAL = EXECUTION_COURSE.KEY_EXECUTION_PERIOD
--	inner join EXECUTION_YEAR on EXECUTION_YEAR.ID_INTERNAL = EXECUTION_PERIOD.KEY_EXECUTION_YEAR
--	left join CURRICULAR_COURSE_EXECUTION_COURSE on CURRICULAR_COURSE_EXECUTION_COURSE.KEY_EXECUTION_COURSE = EXECUTION_COURSE.ID_INTERNAL
--where CURRICULAR_COURSE_EXECUTION_COURSE.INTERNAL_CODE is null;

select concat('delete from EXECUTION_COURSE where ID_INTERNAL = ', EXECUTION_COURSE.ID_INTERNAL, ';') as ""
from EXECUTION_PERIOD
	inner join EXECUTION_COURSE on EXECUTION_PERIOD.ID_INTERNAL = EXECUTION_COURSE.KEY_EXECUTION_PERIOD
	inner join EXECUTION_YEAR on EXECUTION_YEAR.ID_INTERNAL = EXECUTION_PERIOD.KEY_EXECUTION_YEAR
	left join CURRICULAR_COURSE_EXECUTION_COURSE on CURRICULAR_COURSE_EXECUTION_COURSE.KEY_EXECUTION_COURSE = EXECUTION_COURSE.ID_INTERNAL
where CURRICULAR_COURSE_EXECUTION_COURSE.INTERNAL_CODE is null;

-- Lessons to delete
--select LESSON.ID_INTERNAL
--from LESSON
--	left join SHIFT_LESSON on SHIFT_LESSON.KEY_LESSON = LESSON.ID_INTERNAL
--where SHIFT_LESSON.ID_INTERNAL is NULL;

select concat('delete from LESSON where ID_INTERNAL = ', LESSON.ID_INTERNAL, ';') as ""
from LESSON
	left join SHIFT_LESSON on SHIFT_LESSON.KEY_LESSON = LESSON.ID_INTERNAL
where SHIFT_LESSON.ID_INTERNAL is NULL;

-- Shifts to delete
--select SHIFT.ID_INTERNAL
--from SHIFT
--	inner join EXECUTION_COURSE on EXECUTION_COURSE.ID_INTERNAL = SHIFT.KEY_EXECUTION_COURSE
--	inner join EXECUTION_PERIOD on EXECUTION_PERIOD.ID_INTERNAL = EXECUTION_COURSE.KEY_EXECUTION_PERIOD
--	left join SHIFT_LESSON on SHIFT_LESSON.KEY_SHIFT = SHIFT.ID_INTERNAL
--	left join SHIFT_STUDENT on SHIFT_STUDENT.KEY_SHIFT = SHIFT.ID_INTERNAL
--where SHIFT_LESSON.ID_INTERNAL is null
--	and SHIFT_STUDENT.ID_INTERNAL is null
--	and EXECUTION_PERIOD.ID_INTERNAL = 1;

select concat('delete from SHIFT where ID_INTERNAL = ', SHIFT.ID_INTERNAL, ';') as ""
from SHIFT
	inner join EXECUTION_COURSE on EXECUTION_COURSE.ID_INTERNAL = SHIFT.KEY_EXECUTION_COURSE
	inner join EXECUTION_PERIOD on EXECUTION_PERIOD.ID_INTERNAL = EXECUTION_COURSE.KEY_EXECUTION_PERIOD
	left join SHIFT_LESSON on SHIFT_LESSON.KEY_SHIFT = SHIFT.ID_INTERNAL
	left join SHIFT_STUDENT on SHIFT_STUDENT.KEY_SHIFT = SHIFT.ID_INTERNAL
where SHIFT_LESSON.ID_INTERNAL is null
	and SHIFT_STUDENT.ID_INTERNAL is null
	and EXECUTION_PERIOD.ID_INTERNAL = 1;
	
