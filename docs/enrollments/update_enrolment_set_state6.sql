SELECT CONCAT('UPDATE ENROLMENT SET STATE = 6 WHERE ID_INTERNAL = ', E.ID_INTERNAL, ';') AS ""
FROM ENROLMENT E
INNER JOIN ENROLMENT_EVALUATION EE1 ON EE1.KEY_ENROLMENT = E.ID_INTERNAL
INNER JOIN ENROLMENT_EVALUATION EE2 ON EE2.KEY_ENROLMENT = E.ID_INTERNAL
INNER JOIN STUDENT_CURRICULAR_PLAN SCP ON E.KEY_STUDENT_CURRICULAR_PLAN = SCP.ID_INTERNAL
INNER JOIN STUDENT S ON SCP.KEY_STUDENT = S.ID_INTERNAL
WHERE
EE1.GRADE = 'NA' AND
EE2.GRADE IS NULL AND
S.DEGREE_TYPE = 1 AND
E.KEY_EXECUTION_PERIOD <> 80 AND
E.STATE = 3;
