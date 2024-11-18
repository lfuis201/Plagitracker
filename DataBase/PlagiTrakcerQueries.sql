CREATE ROLE "IIS APPPOOL\PlagiTracker.WebAPI" WITH LOGIN PASSWORD 'admin';
ALTER ROLE "IIS APPPOOL\PlagiTracker.WebAPI" CREATEDB;
GRANT ALL PRIVILEGES ON DATABASE "PlagiTracker" TO "IIS APPPOOL\PlagiTracker.WebAPI" ;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

select u.* from "Teachers" t inner join "Users" u on u."Id" = t."Id" ;

select u.* from "Students" s inner join "Users" u ON u."Id" = s."Id" ;

select u."Id", u."Email", c."Name", c."Id"  from "Students" s 
	inner join "Users" u ON u."Id" = s."Id" inner join "Enrollments" e on e."StudentId" = s."Id" 
	inner join "Courses" c ON c."Id" = e."CourseId" where u."Email"  = 'elmerson30@plagitracker.com';

select * from "Students" s ;

select * from "Teachers" t ;

select * from "Users" u ;

select * from "Courses" c ;

select e.* from "Enrollments" e ;

select u."Email", c."Name" as "CourseName",  e.* from "Enrollments" e inner join "Users" u on u."Id" = e."StudentId" inner join "Courses" c ON c."Id" = e."CourseId" order by e."CourseId" ;

select * from "Assignments" a ;
select c."Name" as "CourseName" ,a.* from "Assignments" a inner join "Courses" c ON c."Id" = a."CourseId";

select * from "Submissions" s ;
select u."Email" , s.* from "Submissions" s inner join "Users" u on u."Id" = s."StudentId" order by s."AssignmentId"  ;
 
select * from "Codes" c ;

select * from "Plagiarisms" p ;

select * from "__EFMigrationsHistory" eh ;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




