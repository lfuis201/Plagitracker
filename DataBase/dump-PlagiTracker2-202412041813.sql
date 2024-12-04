--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 15.7

-- Started on 2024-12-04 18:14:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 241 (class 1259 OID 58803)
-- Name: Assignments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Assignments" (
    "Id" uuid NOT NULL,
    "Description" character varying(250),
    "Title" character varying(50) NOT NULL,
    "SubmissionDate" timestamp with time zone NOT NULL,
    "AnalysisDate" timestamp with time zone NOT NULL,
    "IsAnalyzed" boolean NOT NULL,
    "CourseId" uuid NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "DolosURLId" character varying(20)
);


ALTER TABLE public."Assignments" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 58897)
-- Name: Classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Classes" (
    "Id" uuid NOT NULL,
    "Name" character varying(40) NOT NULL,
    "Description" text,
    "ExerciseId" uuid NOT NULL,
    "ParentClassId" uuid NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Classes" OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 58845)
-- Name: Codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Codes" (
    "Id" uuid NOT NULL,
    "SubmissionId" uuid NOT NULL,
    "FileName" character varying(50) NOT NULL,
    "Content" text NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Codes" OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 58793)
-- Name: Courses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Courses" (
    "Id" uuid NOT NULL,
    "Name" character varying(80) NOT NULL,
    "TeacherId" uuid NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsArchived" boolean DEFAULT false NOT NULL,
    "InvitationId" uuid DEFAULT '00000000-0000-0000-0000-000000000000'::uuid NOT NULL
);


ALTER TABLE public."Courses" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 58813)
-- Name: Enrollments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Enrollments" (
    "StudentId" uuid NOT NULL,
    "CourseId" uuid NOT NULL,
    "Grade" numeric(4,2) NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Enrollments" OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 58885)
-- Name: Exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Exercises" (
    "Id" uuid NOT NULL,
    "Name" character varying(50) NOT NULL,
    "Description" text NOT NULL,
    "AssignmentId" uuid NOT NULL,
    "HaveBody" boolean DEFAULT false NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Exercises" OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 58980)
-- Name: Methods; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Methods" (
    "Id" uuid NOT NULL,
    "Name" character varying(40) NOT NULL,
    "Type" text NOT NULL,
    "ParameterTypes" text NOT NULL,
    "Description" text,
    "ClassId" uuid NOT NULL,
    "IsEnabled" boolean NOT NULL,
    "CreatedAt" timestamp with time zone NOT NULL,
    "UpdatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Methods" OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 58962)
-- Name: Parameter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Parameter" (
    "Id" uuid NOT NULL,
    "Name" character varying(40) NOT NULL,
    "Type" text NOT NULL,
    "Description" text,
    "MethodId" uuid NOT NULL
);


ALTER TABLE public."Parameter" OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 58857)
-- Name: Plagiarisms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Plagiarisms" (
    "Id" uuid NOT NULL,
    "Similarity" numeric(5,2) NOT NULL,
    "Coincidences" integer NOT NULL,
    "CodeSnippet" text,
    "CodeId" uuid NOT NULL,
    "Algorithm" integer NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Plagiarisms" OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 58773)
-- Name: Students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Students" (
    "Id" uuid NOT NULL
);


ALTER TABLE public."Students" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 58828)
-- Name: Submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Submissions" (
    "Id" uuid NOT NULL,
    "Url" character varying(60) NOT NULL,
    "SubmissionDate" timestamp with time zone NOT NULL,
    "Grade" numeric(4,2) NOT NULL,
    "StudentId" uuid NOT NULL,
    "AssignmentId" uuid NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "UrlState" integer DEFAULT 0 NOT NULL,
    "Compiler" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."Submissions" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 58783)
-- Name: Teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Teachers" (
    "Id" uuid NOT NULL
);


ALTER TABLE public."Teachers" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 58766)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "Id" uuid NOT NULL,
    "FirstName" character varying(50) NOT NULL,
    "LastName" character varying(50) NOT NULL,
    "Email" character varying(50) NOT NULL,
    "PasswordHash" bytea NOT NULL,
    "LogInAttempts" integer NOT NULL,
    "IsLocked" boolean NOT NULL,
    "UnlockDate" timestamp with time zone NOT NULL,
    "IsVerified" boolean DEFAULT false NOT NULL,
    "VerificationCode" integer DEFAULT 0 NOT NULL,
    "VerificationCodeExpiration" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "ResetPasswordAttempts" integer DEFAULT 0 NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "IsEnabled" boolean DEFAULT false NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 58761)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 3513 (class 0 OID 58803)
-- Dependencies: 241
-- Data for Name: Assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3519 (class 0 OID 58897)
-- Dependencies: 247
-- Data for Name: Classes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3516 (class 0 OID 58845)
-- Dependencies: 244
-- Data for Name: Codes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3512 (class 0 OID 58793)
-- Dependencies: 240
-- Data for Name: Courses; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3514 (class 0 OID 58813)
-- Dependencies: 242
-- Data for Name: Enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3518 (class 0 OID 58885)
-- Dependencies: 246
-- Data for Name: Exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3521 (class 0 OID 58980)
-- Dependencies: 249
-- Data for Name: Methods; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3520 (class 0 OID 58962)
-- Dependencies: 248
-- Data for Name: Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3517 (class 0 OID 58857)
-- Dependencies: 245
-- Data for Name: Plagiarisms; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3510 (class 0 OID 58773)
-- Dependencies: 238
-- Data for Name: Students; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3515 (class 0 OID 58828)
-- Dependencies: 243
-- Data for Name: Submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3511 (class 0 OID 58783)
-- Dependencies: 239
-- Data for Name: Teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3509 (class 0 OID 58766)
-- Dependencies: 237
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3508 (class 0 OID 58761)
-- Dependencies: 236
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."__EFMigrationsHistory" VALUES ('20241009172748_UpgradeDataBasev3', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241009233022_UndateConstraintPlagiarism', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241014075442_VerificationCodeUserAdded', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241024113958_AssigmentCodeEstructureAdded', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241028010654_ExerciseUpdated', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241028114151_BaseEntityAdded', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241030172445_ParameterAdded', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241030174125_FunctionUpdated', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241106031133_IsArchivedAddedInCourse', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241113111027_ChangeNameFunctionToMethod', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117095603_UrlStateAddedToSubmission', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117115420_AddInvitatiovIdToCourse', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117115641_AddInvitatiovIdToCourse2', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117120015_RemoveInvitatiovIdToCourse', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117120112_AddInvitatiovIdToCourse3', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117120226_AddInvitatiovIdToCourse4', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117120456_AddInvitatiovIdToCourse5', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117120619_AddInvitatiovIdToCourse6', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117121942_AddInvitatiovIdToCourse7', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241117182955_AddUrlCompilerTypeToSubmission', '8.0.8');
INSERT INTO public."__EFMigrationsHistory" VALUES ('20241118000907_UpdateAssignmentAndSubmission', '8.0.8');


--
-- TOC entry 3323 (class 2606 OID 58807)
-- Name: Assignments PK_Assignments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "PK_Assignments" PRIMARY KEY ("Id");


--
-- TOC entry 3344 (class 2606 OID 58903)
-- Name: Classes PK_Classes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "PK_Classes" PRIMARY KEY ("Id");


--
-- TOC entry 3333 (class 2606 OID 58851)
-- Name: Codes PK_Codes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "PK_Codes" PRIMARY KEY ("Id");


--
-- TOC entry 3319 (class 2606 OID 58797)
-- Name: Courses PK_Courses; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "PK_Courses" PRIMARY KEY ("Id");


--
-- TOC entry 3326 (class 2606 OID 58817)
-- Name: Enrollments PK_Enrollments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "PK_Enrollments" PRIMARY KEY ("StudentId", "CourseId");


--
-- TOC entry 3340 (class 2606 OID 58891)
-- Name: Exercises PK_Exercises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "PK_Exercises" PRIMARY KEY ("Id");


--
-- TOC entry 3350 (class 2606 OID 58986)
-- Name: Methods PK_Methods; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "PK_Methods" PRIMARY KEY ("Id");


--
-- TOC entry 3347 (class 2606 OID 58968)
-- Name: Parameter PK_Parameter; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "PK_Parameter" PRIMARY KEY ("Id");


--
-- TOC entry 3337 (class 2606 OID 58863)
-- Name: Plagiarisms PK_Plagiarisms; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "PK_Plagiarisms" PRIMARY KEY ("Id");


--
-- TOC entry 3312 (class 2606 OID 58777)
-- Name: Students PK_Students; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "PK_Students" PRIMARY KEY ("Id");


--
-- TOC entry 3330 (class 2606 OID 58834)
-- Name: Submissions PK_Submissions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "PK_Submissions" PRIMARY KEY ("Id");


--
-- TOC entry 3314 (class 2606 OID 58787)
-- Name: Teachers PK_Teachers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "PK_Teachers" PRIMARY KEY ("Id");


--
-- TOC entry 3310 (class 2606 OID 58772)
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- TOC entry 3307 (class 2606 OID 58765)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 3320 (class 1259 OID 58869)
-- Name: IX_Assignments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Assignments_CourseId" ON public."Assignments" USING btree ("CourseId");


--
-- TOC entry 3321 (class 1259 OID 58870)
-- Name: IX_Assignments_Title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Assignments_Title" ON public."Assignments" USING btree ("Title");


--
-- TOC entry 3341 (class 1259 OID 58926)
-- Name: IX_Classes_ExerciseId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Classes_ExerciseId_Name" ON public."Classes" USING btree ("ExerciseId", "Name");


--
-- TOC entry 3342 (class 1259 OID 58927)
-- Name: IX_Classes_ParentClassId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Classes_ParentClassId" ON public."Classes" USING btree ("ParentClassId");


--
-- TOC entry 3331 (class 1259 OID 58871)
-- Name: IX_Codes_SubmissionId_FileName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Codes_SubmissionId_FileName" ON public."Codes" USING btree ("SubmissionId", "FileName");


--
-- TOC entry 3315 (class 1259 OID 59024)
-- Name: IX_Courses_InvitationId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_InvitationId" ON public."Courses" USING btree ("InvitationId");


--
-- TOC entry 3316 (class 1259 OID 58979)
-- Name: IX_Courses_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_Name" ON public."Courses" USING btree ("Name");


--
-- TOC entry 3317 (class 1259 OID 58872)
-- Name: IX_Courses_TeacherId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Courses_TeacherId" ON public."Courses" USING btree ("TeacherId");


--
-- TOC entry 3324 (class 1259 OID 58873)
-- Name: IX_Enrollments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Enrollments_CourseId" ON public."Enrollments" USING btree ("CourseId");


--
-- TOC entry 3338 (class 1259 OID 58928)
-- Name: IX_Exercises_AssignmentId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Exercises_AssignmentId_Name" ON public."Exercises" USING btree ("AssignmentId", "Name");


--
-- TOC entry 3348 (class 1259 OID 58993)
-- Name: IX_Methods_ClassId_Type_Name_ParameterTypes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Methods_ClassId_Type_Name_ParameterTypes" ON public."Methods" USING btree ("ClassId", "Type", "Name", "ParameterTypes");


--
-- TOC entry 3345 (class 1259 OID 58992)
-- Name: IX_Parameter_MethodId_Type_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Parameter_MethodId_Type_Name" ON public."Parameter" USING btree ("MethodId", "Type", "Name");


--
-- TOC entry 3334 (class 1259 OID 58879)
-- Name: IX_Plagiarisms_CodeId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Plagiarisms_CodeId" ON public."Plagiarisms" USING btree ("CodeId");


--
-- TOC entry 3335 (class 1259 OID 58880)
-- Name: IX_Plagiarisms_Id_CodeId_Algorithm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Plagiarisms_Id_CodeId_Algorithm" ON public."Plagiarisms" USING btree ("Id", "CodeId", "Algorithm");


--
-- TOC entry 3327 (class 1259 OID 58875)
-- Name: IX_Submissions_AssignmentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Submissions_AssignmentId" ON public."Submissions" USING btree ("AssignmentId");


--
-- TOC entry 3328 (class 1259 OID 59026)
-- Name: IX_Submissions_StudentId_AssignmentId_Url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Submissions_StudentId_AssignmentId_Url" ON public."Submissions" USING btree ("StudentId", "AssignmentId", "Url");


--
-- TOC entry 3308 (class 1259 OID 58930)
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- TOC entry 3354 (class 2606 OID 58808)
-- Name: Assignments FK_Assignments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "FK_Assignments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3362 (class 2606 OID 58904)
-- Name: Classes FK_Classes_Classes_ParentClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Classes_ParentClassId" FOREIGN KEY ("ParentClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3363 (class 2606 OID 58909)
-- Name: Classes FK_Classes_Exercises_ExerciseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Exercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES public."Exercises"("Id") ON DELETE CASCADE;


--
-- TOC entry 3359 (class 2606 OID 58852)
-- Name: Codes FK_Codes_Submissions_SubmissionId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "FK_Codes_Submissions_SubmissionId" FOREIGN KEY ("SubmissionId") REFERENCES public."Submissions"("Id") ON DELETE CASCADE;


--
-- TOC entry 3353 (class 2606 OID 58798)
-- Name: Courses FK_Courses_Teachers_TeacherId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "FK_Courses_Teachers_TeacherId" FOREIGN KEY ("TeacherId") REFERENCES public."Teachers"("Id") ON DELETE CASCADE;


--
-- TOC entry 3355 (class 2606 OID 58818)
-- Name: Enrollments FK_Enrollments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3356 (class 2606 OID 58823)
-- Name: Enrollments FK_Enrollments_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3361 (class 2606 OID 58892)
-- Name: Exercises FK_Exercises_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "FK_Exercises_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3365 (class 2606 OID 58987)
-- Name: Methods FK_Methods_Classes_ClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "FK_Methods_Classes_ClassId" FOREIGN KEY ("ClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3364 (class 2606 OID 58994)
-- Name: Parameter FK_Parameter_Methods_MethodId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "FK_Parameter_Methods_MethodId" FOREIGN KEY ("MethodId") REFERENCES public."Methods"("Id") ON DELETE CASCADE;


--
-- TOC entry 3360 (class 2606 OID 58864)
-- Name: Plagiarisms FK_Plagiarisms_Codes_CodeId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "FK_Plagiarisms_Codes_CodeId" FOREIGN KEY ("CodeId") REFERENCES public."Codes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3351 (class 2606 OID 58778)
-- Name: Students FK_Students_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "FK_Students_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- TOC entry 3357 (class 2606 OID 58835)
-- Name: Submissions FK_Submissions_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3358 (class 2606 OID 58840)
-- Name: Submissions FK_Submissions_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3352 (class 2606 OID 58788)
-- Name: Teachers FK_Teachers_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "FK_Teachers_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


-- Completed on 2024-12-04 18:15:00

--
-- PostgreSQL database dump complete
--

