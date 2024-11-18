--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 15.7

-- Started on 2024-11-17 17:47:05

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
-- TOC entry 6 (class 2615 OID 49466)
-- Name: hangfire; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hangfire;


ALTER SCHEMA hangfire OWNER TO postgres;

--
-- TOC entry 5 (class 2615 OID 49346)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 49758)
-- Name: aggregatedcounter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.aggregatedcounter (
    id bigint NOT NULL,
    key text NOT NULL,
    value bigint NOT NULL,
    expireat timestamp with time zone
);


ALTER TABLE hangfire.aggregatedcounter OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 49757)
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.aggregatedcounter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.aggregatedcounter_id_seq OWNER TO postgres;

--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 234
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.aggregatedcounter_id_seq OWNED BY hangfire.aggregatedcounter.id;


--
-- TOC entry 217 (class 1259 OID 49473)
-- Name: counter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.counter (
    id bigint NOT NULL,
    key text NOT NULL,
    value bigint NOT NULL,
    expireat timestamp with time zone
);


ALTER TABLE hangfire.counter OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 49472)
-- Name: counter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.counter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.counter_id_seq OWNER TO postgres;

--
-- TOC entry 3625 (class 0 OID 0)
-- Dependencies: 216
-- Name: counter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.counter_id_seq OWNED BY hangfire.counter.id;


--
-- TOC entry 219 (class 1259 OID 49481)
-- Name: hash; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.hash (
    id bigint NOT NULL,
    key text NOT NULL,
    field text NOT NULL,
    value text,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.hash OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 49480)
-- Name: hash_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.hash_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.hash_id_seq OWNER TO postgres;

--
-- TOC entry 3626 (class 0 OID 0)
-- Dependencies: 218
-- Name: hash_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.hash_id_seq OWNED BY hangfire.hash.id;


--
-- TOC entry 221 (class 1259 OID 49492)
-- Name: job; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.job (
    id bigint NOT NULL,
    stateid bigint,
    statename text,
    invocationdata jsonb NOT NULL,
    arguments jsonb NOT NULL,
    createdat timestamp with time zone NOT NULL,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.job OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 49491)
-- Name: job_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.job_id_seq OWNER TO postgres;

--
-- TOC entry 3627 (class 0 OID 0)
-- Dependencies: 220
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.job_id_seq OWNED BY hangfire.job.id;


--
-- TOC entry 232 (class 1259 OID 49552)
-- Name: jobparameter; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.jobparameter (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    name text NOT NULL,
    value text,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.jobparameter OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 49551)
-- Name: jobparameter_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.jobparameter_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.jobparameter_id_seq OWNER TO postgres;

--
-- TOC entry 3628 (class 0 OID 0)
-- Dependencies: 231
-- Name: jobparameter_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.jobparameter_id_seq OWNED BY hangfire.jobparameter.id;


--
-- TOC entry 225 (class 1259 OID 49517)
-- Name: jobqueue; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.jobqueue (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    queue text NOT NULL,
    fetchedat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.jobqueue OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 49516)
-- Name: jobqueue_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.jobqueue_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.jobqueue_id_seq OWNER TO postgres;

--
-- TOC entry 3629 (class 0 OID 0)
-- Dependencies: 224
-- Name: jobqueue_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.jobqueue_id_seq OWNED BY hangfire.jobqueue.id;


--
-- TOC entry 227 (class 1259 OID 49525)
-- Name: list; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.list (
    id bigint NOT NULL,
    key text NOT NULL,
    value text,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.list OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 49524)
-- Name: list_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.list_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.list_id_seq OWNER TO postgres;

--
-- TOC entry 3630 (class 0 OID 0)
-- Dependencies: 226
-- Name: list_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.list_id_seq OWNED BY hangfire.list.id;


--
-- TOC entry 233 (class 1259 OID 49566)
-- Name: lock; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.lock (
    resource text NOT NULL,
    updatecount integer DEFAULT 0 NOT NULL,
    acquired timestamp with time zone
);


ALTER TABLE hangfire.lock OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 49467)
-- Name: schema; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.schema (
    version integer NOT NULL
);


ALTER TABLE hangfire.schema OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 49533)
-- Name: server; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.server (
    id text NOT NULL,
    data jsonb,
    lastheartbeat timestamp with time zone NOT NULL,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.server OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 49541)
-- Name: set; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.set (
    id bigint NOT NULL,
    key text NOT NULL,
    score double precision NOT NULL,
    value text NOT NULL,
    expireat timestamp with time zone,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.set OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 49540)
-- Name: set_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.set_id_seq OWNER TO postgres;

--
-- TOC entry 3631 (class 0 OID 0)
-- Dependencies: 229
-- Name: set_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.set_id_seq OWNED BY hangfire.set.id;


--
-- TOC entry 223 (class 1259 OID 49502)
-- Name: state; Type: TABLE; Schema: hangfire; Owner: postgres
--

CREATE TABLE hangfire.state (
    id bigint NOT NULL,
    jobid bigint NOT NULL,
    name text NOT NULL,
    reason text,
    createdat timestamp with time zone NOT NULL,
    data jsonb,
    updatecount integer DEFAULT 0 NOT NULL
);


ALTER TABLE hangfire.state OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 49501)
-- Name: state_id_seq; Type: SEQUENCE; Schema: hangfire; Owner: postgres
--

CREATE SEQUENCE hangfire.state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hangfire.state_id_seq OWNER TO postgres;

--
-- TOC entry 3632 (class 0 OID 0)
-- Dependencies: 222
-- Name: state_id_seq; Type: SEQUENCE OWNED BY; Schema: hangfire; Owner: postgres
--

ALTER SEQUENCE hangfire.state_id_seq OWNED BY hangfire.state.id;


--
-- TOC entry 241 (class 1259 OID 49935)
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
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL
);


ALTER TABLE public."Assignments" OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 50036)
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
-- TOC entry 244 (class 1259 OID 49977)
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
-- TOC entry 240 (class 1259 OID 49925)
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
-- TOC entry 242 (class 1259 OID 49945)
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
-- TOC entry 246 (class 1259 OID 50024)
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
-- TOC entry 249 (class 1259 OID 50120)
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
-- TOC entry 248 (class 1259 OID 50102)
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
-- TOC entry 245 (class 1259 OID 49989)
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
-- TOC entry 238 (class 1259 OID 49905)
-- Name: Students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Students" (
    "Id" uuid NOT NULL
);


ALTER TABLE public."Students" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 49960)
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
-- TOC entry 239 (class 1259 OID 49915)
-- Name: Teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Teachers" (
    "Id" uuid NOT NULL
);


ALTER TABLE public."Teachers" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49898)
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
-- TOC entry 236 (class 1259 OID 49893)
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- TOC entry 3299 (class 2604 OID 49761)
-- Name: aggregatedcounter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter ALTER COLUMN id SET DEFAULT nextval('hangfire.aggregatedcounter_id_seq'::regclass);


--
-- TOC entry 3282 (class 2604 OID 49599)
-- Name: counter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.counter ALTER COLUMN id SET DEFAULT nextval('hangfire.counter_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 49608)
-- Name: hash id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash ALTER COLUMN id SET DEFAULT nextval('hangfire.hash_id_seq'::regclass);


--
-- TOC entry 3285 (class 2604 OID 49618)
-- Name: job id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.job ALTER COLUMN id SET DEFAULT nextval('hangfire.job_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 49668)
-- Name: jobparameter id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter ALTER COLUMN id SET DEFAULT nextval('hangfire.jobparameter_id_seq'::regclass);


--
-- TOC entry 3289 (class 2604 OID 49691)
-- Name: jobqueue id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobqueue ALTER COLUMN id SET DEFAULT nextval('hangfire.jobqueue_id_seq'::regclass);


--
-- TOC entry 3291 (class 2604 OID 49711)
-- Name: list id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.list ALTER COLUMN id SET DEFAULT nextval('hangfire.list_id_seq'::regclass);


--
-- TOC entry 3294 (class 2604 OID 49720)
-- Name: set id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set ALTER COLUMN id SET DEFAULT nextval('hangfire.set_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 49645)
-- Name: state id; Type: DEFAULT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state ALTER COLUMN id SET DEFAULT nextval('hangfire.state_id_seq'::regclass);


--
-- TOC entry 3603 (class 0 OID 49758)
-- Dependencies: 235
-- Data for Name: aggregatedcounter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.aggregatedcounter VALUES (18, 'stats:succeeded:2024-10-27', 1, '2024-11-27 05:48:33.194588-05');
INSERT INTO hangfire.aggregatedcounter VALUES (24, 'stats:succeeded:2024-11-06', 3, '2024-12-06 00:00:02.211214-05');
INSERT INTO hangfire.aggregatedcounter VALUES (25, 'stats:succeeded:2024-11-17-10', 43, '2024-11-18 05:59:39.040884-05');
INSERT INTO hangfire.aggregatedcounter VALUES (42, 'stats:succeeded:2024-11-17-11', 5, '2024-11-18 06:05:38.682731-05');
INSERT INTO hangfire.aggregatedcounter VALUES (3, 'stats:succeeded', 59, NULL);
INSERT INTO hangfire.aggregatedcounter VALUES (27, 'stats:succeeded:2024-11-17', 49, '2024-12-17 07:43:32.089398-05');
INSERT INTO hangfire.aggregatedcounter VALUES (49, 'stats:succeeded:2024-11-17-12', 1, '2024-11-18 07:43:33.089398-05');


--
-- TOC entry 3585 (class 0 OID 49473)
-- Dependencies: 217
-- Data for Name: counter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3587 (class 0 OID 49481)
-- Dependencies: 219
-- Data for Name: hash; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3589 (class 0 OID 49492)
-- Dependencies: 221
-- Data for Name: job; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.job VALUES (23, 193, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"gbesth@plagitracker.com\\\"\",\"\\\"George Best Harrison\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"gbesth@plagitracker.com\"", "\"George Best Harrison\""]', '2024-11-17 05:43:09.789316-05', '2024-11-18 05:43:21.596247-05', 0);
INSERT INTO hangfire.job VALUES (59, 336, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"rgrau@plagitracker.com\\\"\",\"\\\"Rafael Grau\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"rgrau@plagitracker.com\"", "\"Rafael Grau\""]', '2024-11-17 06:05:31.235056-05', '2024-11-18 06:05:38.682731-05', 0);
INSERT INTO hangfire.job VALUES (12, 148, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"lmessic@plagitracker.com\\\"\",\"\\\"Lionel Andrés Messi Cuccitini\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"lmessic@plagitracker.com\"", "\"Lionel Andrés Messi Cuccitini\""]', '2024-11-17 05:24:57.420028-05', '2024-11-18 05:25:05.361167-05', 0);
INSERT INTO hangfire.job VALUES (21, 184, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"thenrya@plagitracker.com\\\"\",\"\\\"Thierry Henry Alexandre\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"thenrya@plagitracker.com\"", "\"Thierry Henry Alexandre\""]', '2024-11-17 05:42:45.456088-05', '2024-11-18 05:42:51.875137-05', 0);
INSERT INTO hangfire.job VALUES (51, 304, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"lluquen@ulasalle.edu.pe\\\"\",\"\\\"Luis Fernando Luque Nieto\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"lluquen@ulasalle.edu.pe\"", "\"Luis Fernando Luque Nieto\""]', '2024-11-17 05:53:19.093265-05', '2024-11-18 05:53:23.183343-05', 0);
INSERT INTO hangfire.job VALUES (29, 216, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"jcruyffh@plagitracker.com\\\"\",\"\\\"Johan Cruyff Hendrik\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"jcruyffh@plagitracker.com\"", "\"Johan Cruyff Hendrik\""]', '2024-11-17 05:44:16.775866-05', '2024-11-18 05:44:21.9769-05', 0);
INSERT INTO hangfire.job VALUES (60, 341, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"mbastidas@plagitracker.com\\\"\",\"\\\"Micaela Bastidas\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"mbastidas@plagitracker.com\"", "\"Micaela Bastidas\""]', '2024-11-17 06:06:29.85791-05', '2024-11-18 07:43:33.089398-05', 0);
INSERT INTO hangfire.job VALUES (48, 297, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"vvaldesa@plagitracker.com\\\"\",\"\\\"Victor Valdés Aguilar\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"vvaldesa@plagitracker.com\"", "\"Victor Valdés Aguilar\""]', '2024-11-17 05:49:07.820124-05', '2024-11-18 05:49:23.78385-05', 0);
INSERT INTO hangfire.job VALUES (40, 260, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ctevezm@plagitracker.com\\\"\",\"\\\"Carlos Tevez Martínez\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ctevezm@plagitracker.com\"", "\"Carlos Tevez Martínez\""]', '2024-11-17 05:47:32.469111-05', '2024-11-18 05:47:37.894276-05', 0);
INSERT INTO hangfire.job VALUES (43, 271, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"hkaneet@plagitracker.com\\\"\",\"\\\"Harry Kane Thompson\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"hkaneet@plagitracker.com\"", "\"Harry Kane Thompson\""]', '2024-11-17 05:48:31.913717-05', '2024-11-18 05:48:37.29552-05', 0);
INSERT INTO hangfire.job VALUES (42, 272, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"jrodriguezr@plagitracker.com\\\"\",\"\\\"James Rodríguez Rubio\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"jrodriguezr@plagitracker.com\"", "\"James Rodríguez Rubio\""]', '2024-11-17 05:48:24.860223-05', '2024-11-18 05:48:38.450694-05', 0);
INSERT INTO hangfire.job VALUES (1, 120, 'Failed', '{"Type": "PlagiTracker.WebAPI.HangFire.HangFireServices, PlagiTracker.WebAPI", "Method": "SavePlagiarismReport", "Arguments": "[\"\\\"ac85b4e5-33ea-4d2c-a281-f7ec41da15f7\\\"\",\"\\\"{\\\\\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"Pedro\\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"Picapiedra\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"bd755547-68fc-4094-8f87-8b65797d668e\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.covid.io/p/0dc699a0-6033-4bb6-b46c-15d238277749\\\\\\\",\\\\\\\"Codes\\\\\\\":{},\\\\\\\"State\\\\\\\":2,\\\\\\\"PlagiResults\\\\\\\":[]},\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"Ben\\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"Tennyson\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"6e701991-2a14-4493-a170-f4fe910e9c4a\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700\\\\\\\",\\\\\\\"Codes\\\\\\\":{\\\\\\\"Calculadora.java\\\\\\\":\\\\\\\"package com.example;\\\\\\\\n\\\\\\\\npublic class Calculadora {\\\\\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\\\\\nif (denominador == 0) {\\\\\\\\nthrow new DivisionPorCeroException(\\\\\\\\\\\\\\\"Error: División por cero no permitida.\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\nreturn (double) numerador / denominador;\\\\\\\\n}\\\\\\\\n\\\\\\\\npublic static void main(String[] args) {\\\\\\\\ntry {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Resultado: \\\\\\\\\\\\\\\" + dividir(10, 0));\\\\\\\\n} catch (DivisionPorCeroException e) {\\\\\\\\nSystem.err.println(e.getMessage());\\\\\\\\n}\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"DivisionPorCeroException.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\npackage com.example;\\\\\\\\n\\\\\\\\npublic class DivisionPorCeroException extends Exception {\\\\\\\\npublic DivisionPorCeroException(String mensaje) {\\\\\\\\nsuper(mensaje);\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\",\\\\\\\"Main.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\npackage com.example;\\\\\\\\n\\\\\\\\nclass Main {\\\\\\\\n\\\\\\\\npublic static void main(String[] args) {\\\\\\\\n\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Hello World!\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\n}\\\\\\\"},\\\\\\\"State\\\\\\\":3,\\\\\\\"PlagiResults\\\\\\\":[{\\\\\\\"Coincidencias\\\\\\\":82,\\\\\\\"Coincidences\\\\\\\":82,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.3942307692307692,\\\\\\\"JaccardSimilitude\\\\\\\":39.42,\\\\\\\"Similitud_Levenshtein\\\\\\\":26.08695652173913,\\\\\\\"LevenshteinSimilitude\\\\\\\":26.09,\\\\\\\"Similitud_Semantica\\\\\\\":0.3142857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":31.43},{\\\\\\\"Coincidencias\\\\\\\":91,\\\\\\\"Coincidences\\\\\\\":91,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.2676470588235294,\\\\\\\"JaccardSimilitude\\\\\\\":26.76,\\\\\\\"Similitud_Levenshtein\\\\\\\":51.61290322580645,\\\\\\\"LevenshteinSimilitude\\\\\\\":51.61,\\\\\\\"Similitud_Semantica\\\\\\\":0.7714285714285715,\\\\\\\"SemanticSimilitude\\\\\\\":77.14},{\\\\\\\"Coincidencias\\\\\\\":91,\\\\\\\"Coincidences\\\\\\\":91,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.5384615384615384,\\\\\\\"JaccardSimilitude\\\\\\\":53.85,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.434782608695656,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.43,\\\\\\\"Similitud_Semantica\\\\\\\":0.3142857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":31.43},{\\\\\\\"Coincidencias\\\\\\\":95,\\\\\\\"Coincidences\\\\\\\":95,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.3275862068965517,\\\\\\\"JaccardSimilitude\\\\\\\":32.76,\\\\\\\"Similitud_Levenshtein\\\\\\\":56.25,\\\\\\\"LevenshteinSimilitude\\\\\\\":56.25,\\\\\\\"Similitud_Semantica\\\\\\\":0.8285714285714285,\\\\\\\"SemanticSimilitude\\\\\\\":82.86},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1393258426966292,\\\\\\\"JaccardSimilitude\\\\\\\":13.93,\\\\\\\"Similitud_Levenshtein\\\\\\\":19.047619047619047,\\\\\\\"LevenshteinSimilitude\\\\\\\":19.05,\\\\\\\"Similitud_Semantica\\\\\\\":0.8,\\\\\\\"SemanticSimilitude\\\\\\\":80.0},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09494640122511486,\\\\\\\"JaccardSimilitude\\\\\\\":9.49,\\\\\\\"Similitud_Levenshtein\\\\\\\":68.88888888888889,\\\\\\\"LevenshteinSimilitude\\\\\\\":68.89,\\\\\\\"Similitud_Semantica\\\\\\\":0.6363636363636364,\\\\\\\"SemanticSimilitude\\\\\\\":63.64},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10961214165261383,\\\\\\\"JaccardSimilitude\\\\\\\":10.96,\\\\\\\"Similitud_Levenshtein\\\\\\\":54.700854700854705,\\\\\\\"LevenshteinSimilitude\\\\\\\":54.7,\\\\\\\"Similitud_Semantica\\\\\\\":0.426829268292683,\\\\\\\"SemanticSimilitude\\\\\\\":42.68},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.20253164556962025,\\\\\\\"JaccardSimilitude\\\\\\\":20.25,\\\\\\\"Similitud_Levenshtein\\\\\\\":42.465753424657535,\\\\\\\"LevenshteinSimilitude\\\\\\\":42.47,\\\\\\\"Similitud_Semantica\\\\\\\":0.3153153153153153,\\\\\\\"SemanticSimilitude\\\\\\\":31.53},{\\\\\\\"Coincidencias\\\\\\\":80,\\\\\\\"Coincidences\\\\\\\":80,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.17582417582417584,\\\\\\\"JaccardSimilitude\\\\\\\":17.58,\\\\\\\"Similitud_Levenshtein\\\\\\\":33.33333333333333,\\\\\\\"LevenshteinSimilitude\\\\\\\":33.33,\\\\\\\"Similitud_Semantica\\\\\\\":0.5789473684210527,\\\\\\\"SemanticSimilitude\\\\\\\":57.89},{\\\\\\\"Coincidencias\\\\\\\":88,\\\\\\\"Coincidences\\\\\\\":88,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.14965986394557823,\\\\\\\"JaccardSimilitude\\\\\\\":14.97,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.73913043478261,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.74,\\\\\\\"Similitud_Semantica\\\\\\\":0.7037037037037037,\\\\\\\"SemanticSimilitude\\\\\\\":70.37},{\\\\\\\"Coincidencias\\\\\\\":76,\\\\\\\"Coincidences\\\\\\\":76,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.17715617715617715,\\\\\\\"JaccardSimilitude\\\\\\\":17.72,\\\\\\\"Similitud_Levenshtein\\\\\\\":40.0,\\\\\\\"LevenshteinSimilitude\\\\\\\":40.0,\\\\\\\"Similitud_Semantica\\\\\\\":0.5789473684210527,\\\\\\\"SemanticSimilitude\\\\\\\":57.89},{\\\\\\\"Coincidencias\\\\\\\":78,\\\\\\\"Coincidences\\\\\\\":78,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.14130434782608695,\\\\\\\"JaccardSimilitude\\\\\\\":14.13,\\\\\\\"Similitud_Levenshtein\\\\\\\":20.833333333333336,\\\\\\\"LevenshteinSimilitude\\\\\\\":20.83,\\\\\\\"Similitud_Semantica\\\\\\\":0.6551724137931034,\\\\\\\"SemanticSimilitude\\\\\\\":65.52},{\\\\\\\"Coincidencias\\\\\\\":343,\\\\\\\"Coincidences\\\\\\\":343,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.8386308068459658,\\\\\\\"JaccardSimilitude\\\\\\\":83.86,\\\\\\\"Similitud_Levenshtein\\\\\\\":76.59574468085107,\\\\\\\"LevenshteinSimilitude\\\\\\\":76.6,\\\\\\\"Similitud_Semantica\\\\\\\":0.6785714285714286,\\\\\\\"SemanticSimilitude\\\\\\\":67.86},{\\\\\\\"Coincidencias\\\\\\\":85,\\\\\\\"Coincidences\\\\\\\":85,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09714285714285714,\\\\\\\"JaccardSimilitude\\\\\\\":9.71,\\\\\\\"Similitud_Levenshtein\\\\\\\":18.91891891891892,\\\\\\\"LevenshteinSimilitude\\\\\\\":18.92,\\\\\\\"Similitud_Semantica\\\\\\\":0.34545454545454546,\\\\\\\"SemanticSimilitude\\\\\\\":34.55},{\\\\\\\"Coincidencias\\\\\\\":130,\\\\\\\"Coincidences\\\\\\\":130,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.16817593790426907,\\\\\\\"JaccardSimilitude\\\\\\\":16.82,\\\\\\\"Similitud_Levenshtein\\\\\\\":13.861386138613863,\\\\\\\"LevenshteinSimilitude\\\\\\\":13.86,\\\\\\\"Similitud_Semantica\\\\\\\":0.23170731707317072,\\\\\\\"SemanticSimilitude\\\\\\\":23.17},{\\\\\\\"Coincidencias\\\\\\\":75,\\\\\\\"Coincidences\\\\\\\":75,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13636363636363635,\\\\\\\"JaccardSimilitude\\\\\\\":13.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":7.6923076923076925,\\\\\\\"LevenshteinSimilitude\\\\\\\":7.69,\\\\\\\"Similitud_Semantica\\\\\\\":0.1711711711711712,\\\\\\\"SemanticSimilitude\\\\\\\":17.12},{\\\\\\\"Coincidencias\\\\\\\":34,\\\\\\\"Coincidences\\\\\\\":34,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13385826771653545,\\\\\\\"JaccardSimilitude\\\\\\\":13.39,\\\\\\\"Similitud_Levenshtein\\\\\\\":27.77777777777778,\\\\\\\"LevenshteinSimilitude\\\\\\\":27.78,\\\\\\\"Similitud_Semantica\\\\\\\":0.43999999999999995,\\\\\\\"SemanticSimilitude\\\\\\\":44.0},{\\\\\\\"Coincidencias\\\\\\\":47,\\\\\\\"Coincidences\\\\\\\":47,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12303664921465969,\\\\\\\"JaccardSimilitude\\\\\\\":12.3,\\\\\\\"Similitud_Levenshtein\\\\\\\":57.692307692307686,\\\\\\\"LevenshteinSimilitude\\\\\\\":57.69,\\\\\\\"Similitud_Semantica\\\\\\\":0.9259259259259259,\\\\\\\"SemanticSimilitude\\\\\\\":92.59},{\\\\\\\"Coincidencias\\\\\\\":31,\\\\\\\"Coincidences\\\\\\\":31,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13656387665198239,\\\\\\\"JaccardSimilitude\\\\\\\":13.66,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.22222222222222,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.22,\\\\\\\"Similitud_Semantica\\\\\\\":0.43999999999999995,\\\\\\\"SemanticSimilitude\\\\\\\":44.0},{\\\\\\\"Coincidencias\\\\\\\":40,\\\\\\\"Coincidences\\\\\\\":40,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.11661807580174927,\\\\\\\"JaccardSimilitude\\\\\\\":11.66,\\\\\\\"Similitud_Levenshtein\\\\\\\":55.55555555555556,\\\\\\\"LevenshteinSimilitude\\\\\\\":55.56,\\\\\\\"Similitud_Semantica\\\\\\\":0.8620689655172413,\\\\\\\"SemanticSimilitude\\\\\\\":86.21},{\\\\\\\"Coincidencias\\\\\\\":92,\\\\\\\"Coincidences\\\\\\\":92,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.22276029055690072,\\\\\\\"JaccardSimilitude\\\\\\\":22.28,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.641509433962266,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.64,\\\\\\\"Similitud_Semantica\\\\\\\":0.8928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":89.29},{\\\\\\\"Coincidencias\\\\\\\":25,\\\\\\\"Coincidences\\\\\\\":25,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.036337209302325583,\\\\\\\"JaccardSimilitude\\\\\\\":3.63,\\\\\\\"Similitud_Levenshtein\\\\\\\":52.5,\\\\\\\"LevenshteinSimilitude\\\\\\\":52.5,\\\\\\\"Similitud_Semantica\\\\\\\":0.4545454545454546,\\\\\\\"SemanticSimilitude\\\\\\\":45.45},{\\\\\\\"Coincidencias\\\\\\\":35,\\\\\\\"Coincidences\\\\\\\":35,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.05636070853462158,\\\\\\\"JaccardSimilitude\\\\\\\":5.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":39.25233644859813,\\\\\\\"LevenshteinSimilitude\\\\\\\":39.25,\\\\\\\"Similitud_Semantica\\\\\\\":0.30487804878048785,\\\\\\\"SemanticSimilitude\\\\\\\":30.49},{\\\\\\\"Coincidencias\\\\\\\":26,\\\\\\\"Coincidences\\\\\\\":26,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.07386363636363637,\\\\\\\"JaccardSimilitude\\\\\\\":7.39,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.88235294117647,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.88,\\\\\\\"Similitud_Semantica\\\\\\\":0.22522522522522526,\\\\\\\"SemanticSimilitude\\\\\\\":22.52}]},\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"Khvicha\\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"Kvaratskhelia\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"31edb16a-feb4-4cab-812c-e8a4bdb6ad45\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee\\\\\\\",\\\\\\\"Codes\\\\\\\":{\\\\\\\"HelloCodiva.java\\\\\\\":\\\\\\\"\\\\\\\\npackage com.example;\\\\\\\\n\\\\\\\\nclass HelloCodiva {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\nint a = 15;\\\\\\\\nint b = 20; // will generate an error\\\\\\\\nint c = 654;\\\\\\\\nSystem.out.println(a+b+c);\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\",\\\\\\\"Main.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\npackage com.example;\\\\\\\\n\\\\\\\\npublic class Main {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\nint myNum = 5;               // integer (whole number)\\\\\\\\nfloat myFloatNum = 5.99f;    // floating point number\\\\\\\\nchar myLetter = ''D'';         // character\\\\\\\\nboolean myBool = true;       // boolean\\\\\\\\nString myText = \\\\\\\\\\\\\\\"Hello\\\\\\\\\\\\\\\";     // String\\\\\\\\nSystem.out.println(myNum);\\\\\\\\nSystem.out.println(myFloatNum);\\\\\\\\nSystem.out.println(myLetter);\\\\\\\\nSystem.out.println(myBool);\\\\\\\\nSystem.out.println(myText);\\\\\\\\n}\\\\\\\\n}\\\\\\\"},\\\\\\\"State\\\\\\\":3,\\\\\\\"PlagiResults\\\\\\\":[{\\\\\\\"Coincidencias\\\\\\\":88,\\\\\\\"Coincidences\\\\\\\":88,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.14965986394557823,\\\\\\\"JaccardSimilitude\\\\\\\":14.97,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.73913043478261,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.74,\\\\\\\"Similitud_Semantica\\\\\\\":0.7037037037037037,\\\\\\\"SemanticSimilitude\\\\\\\":70.37},{\\\\\\\"Coincidencias\\\\\\\":47,\\\\\\\"Coincidences\\\\\\\":47,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12303664921465969,\\\\\\\"JaccardSimilitude\\\\\\\":12.3,\\\\\\\"Similitud_Levenshtein\\\\\\\":57.692307692307686,\\\\\\\"LevenshteinSimilitude\\\\\\\":57.69,\\\\\\\"Similitud_Semantica\\\\\\\":0.9259259259259259,\\\\\\\"SemanticSimilitude\\\\\\\":92.59},{\\\\\\\"Coincidencias\\\\\\\":91,\\\\\\\"Coincidences\\\\\\\":91,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.2676470588235294,\\\\\\\"JaccardSimilitude\\\\\\\":26.76,\\\\\\\"Similitud_Levenshtein\\\\\\\":51.61290322580645,\\\\\\\"LevenshteinSimilitude\\\\\\\":51.61,\\\\\\\"Similitud_Semantica\\\\\\\":0.7714285714285715,\\\\\\\"SemanticSimilitude\\\\\\\":77.14},{\\\\\\\"Coincidencias\\\\\\\":84,\\\\\\\"Coincidences\\\\\\\":84,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.22641509433962265,\\\\\\\"JaccardSimilitude\\\\\\\":22.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":26.31578947368421,\\\\\\\"LevenshteinSimilitude\\\\\\\":26.32,\\\\\\\"Similitud_Semantica\\\\\\\":0.40740740740740744,\\\\\\\"SemanticSimilitude\\\\\\\":40.74},{\\\\\\\"Coincidencias\\\\\\\":247,\\\\\\\"Coincidences\\\\\\\":247,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.7417417417417418,\\\\\\\"JaccardSimilitude\\\\\\\":74.17,\\\\\\\"Similitud_Levenshtein\\\\\\\":85.71428571428571,\\\\\\\"LevenshteinSimilitude\\\\\\\":85.71,\\\\\\\"Similitud_Semantica\\\\\\\":0.9310344827586207,\\\\\\\"SemanticSimilitude\\\\\\\":93.1},{\\\\\\\"Coincidencias\\\\\\\":72,\\\\\\\"Coincidences\\\\\\\":72,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.11428571428571428,\\\\\\\"JaccardSimilitude\\\\\\\":11.43,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.818181818181817,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.82,\\\\\\\"Similitud_Semantica\\\\\\\":0.9642857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":96.43},{\\\\\\\"Coincidencias\\\\\\\":72,\\\\\\\"Coincidences\\\\\\\":72,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08591885441527446,\\\\\\\"JaccardSimilitude\\\\\\\":8.59,\\\\\\\"Similitud_Levenshtein\\\\\\\":36.58536585365854,\\\\\\\"LevenshteinSimilitude\\\\\\\":36.59,\\\\\\\"Similitud_Semantica\\\\\\\":0.49090909090909096,\\\\\\\"SemanticSimilitude\\\\\\\":49.09},{\\\\\\\"Coincidencias\\\\\\\":76,\\\\\\\"Coincidences\\\\\\\":76,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.0978120978120978,\\\\\\\"JaccardSimilitude\\\\\\\":9.78,\\\\\\\"Similitud_Levenshtein\\\\\\\":27.522935779816514,\\\\\\\"LevenshteinSimilitude\\\\\\\":27.52,\\\\\\\"Similitud_Semantica\\\\\\\":0.3292682926829268,\\\\\\\"SemanticSimilitude\\\\\\\":32.93},{\\\\\\\"Coincidencias\\\\\\\":66,\\\\\\\"Coincidences\\\\\\\":66,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12966601178781925,\\\\\\\"JaccardSimilitude\\\\\\\":12.97,\\\\\\\"Similitud_Levenshtein\\\\\\\":20.28985507246377,\\\\\\\"LevenshteinSimilitude\\\\\\\":20.29,\\\\\\\"Similitud_Semantica\\\\\\\":0.2432432432432432,\\\\\\\"SemanticSimilitude\\\\\\\":24.32},{\\\\\\\"Coincidencias\\\\\\\":80,\\\\\\\"Coincidences\\\\\\\":80,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.17582417582417584,\\\\\\\"JaccardSimilitude\\\\\\\":17.58,\\\\\\\"Similitud_Levenshtein\\\\\\\":33.33333333333333,\\\\\\\"LevenshteinSimilitude\\\\\\\":33.33,\\\\\\\"Similitud_Semantica\\\\\\\":0.5789473684210527,\\\\\\\"SemanticSimilitude\\\\\\\":57.89},{\\\\\\\"Coincidencias\\\\\\\":34,\\\\\\\"Coincidences\\\\\\\":34,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13385826771653545,\\\\\\\"JaccardSimilitude\\\\\\\":13.39,\\\\\\\"Similitud_Levenshtein\\\\\\\":27.77777777777778,\\\\\\\"LevenshteinSimilitude\\\\\\\":27.78,\\\\\\\"Similitud_Semantica\\\\\\\":0.43999999999999995,\\\\\\\"SemanticSimilitude\\\\\\\":44.0},{\\\\\\\"Coincidencias\\\\\\\":82,\\\\\\\"Coincidences\\\\\\\":82,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.3942307692307692,\\\\\\\"JaccardSimilitude\\\\\\\":39.42,\\\\\\\"Similitud_Levenshtein\\\\\\\":26.08695652173913,\\\\\\\"LevenshteinSimilitude\\\\\\\":26.09,\\\\\\\"Similitud_Semantica\\\\\\\":0.3142857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":31.43},{\\\\\\\"Coincidencias\\\\\\\":94,\\\\\\\"Coincidences\\\\\\\":94,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.42727272727272725,\\\\\\\"JaccardSimilitude\\\\\\\":42.73,\\\\\\\"Similitud_Levenshtein\\\\\\\":54.54545454545454,\\\\\\\"LevenshteinSimilitude\\\\\\\":54.55,\\\\\\\"Similitud_Semantica\\\\\\\":1.0,\\\\\\\"SemanticSimilitude\\\\\\\":100.0},{\\\\\\\"Coincidencias\\\\\\\":86,\\\\\\\"Coincidences\\\\\\\":86,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.24362606232294617,\\\\\\\"JaccardSimilitude\\\\\\\":24.36,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.0,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.0,\\\\\\\"Similitud_Semantica\\\\\\\":0.3793103448275862,\\\\\\\"SemanticSimilitude\\\\\\\":37.93},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12424849699398798,\\\\\\\"JaccardSimilitude\\\\\\\":12.42,\\\\\\\"Similitud_Levenshtein\\\\\\\":10.256410256410255,\\\\\\\"LevenshteinSimilitude\\\\\\\":10.26,\\\\\\\"Similitud_Semantica\\\\\\\":0.3928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":39.29},{\\\\\\\"Coincidencias\\\\\\\":61,\\\\\\\"Coincidences\\\\\\\":61,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08615819209039548,\\\\\\\"JaccardSimilitude\\\\\\\":8.62,\\\\\\\"Similitud_Levenshtein\\\\\\\":15.151515151515152,\\\\\\\"LevenshteinSimilitude\\\\\\\":15.15,\\\\\\\"Similitud_Semantica\\\\\\\":0.19999999999999996,\\\\\\\"SemanticSimilitude\\\\\\\":20.0},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10046367851622875,\\\\\\\"JaccardSimilitude\\\\\\\":10.05,\\\\\\\"Similitud_Levenshtein\\\\\\\":10.75268817204301,\\\\\\\"LevenshteinSimilitude\\\\\\\":10.75,\\\\\\\"Similitud_Semantica\\\\\\\":0.13414634146341464,\\\\\\\"SemanticSimilitude\\\\\\\":13.41},{\\\\\\\"Coincidencias\\\\\\\":63,\\\\\\\"Coincidences\\\\\\\":63,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.16981132075471697,\\\\\\\"JaccardSimilitude\\\\\\\":16.98,\\\\\\\"Similitud_Levenshtein\\\\\\\":6.557377049180328,\\\\\\\"LevenshteinSimilitude\\\\\\\":6.56,\\\\\\\"Similitud_Semantica\\\\\\\":0.09909909909909909,\\\\\\\"SemanticSimilitude\\\\\\\":9.91}]},\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"Khabib \\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"Nurmagomedov\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"e0d30fd2-1027-4af3-be3b-238a579dacb8\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8\\\\\\\",\\\\\\\"Codes\\\\\\\":{\\\\\\\"HelloCodiva.java\\\\\\\":\\\\\\\"package com.example;\\\\\\\\n\\\\\\\\nclass HelloCodiva {\\\\\\\\n\\\\\\\\npublic static void main(String[] args) {\\\\\\\\n\\\\\\\\nString greeting = \\\\\\\\\\\\\\\"Hello World\\\\\\\\\\\\\\\";\\\\\\\\nSystem.out.println(greeting);\\\\\\\\n\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\",\\\\\\\"Main.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\npackage com.example;\\\\\\\\n\\\\\\\\nclass Main {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\nchar myLetter = ''D'';         // character\\\\\\\\nboolean myBool = true;       // boolean\\\\\\\\nString myText = \\\\\\\\\\\\\\\"Hello\\\\\\\\\\\\\\\";     // String\\\\\\\\n\\\\\\\\nint myNum = 5;\\\\\\\\nfloat myFloatNum = 5.99f;\\\\\\\\n\\\\\\\\nSystem.out.println(myNum);\\\\\\\\nSystem.out.println(myFloatNum);\\\\\\\\nSystem.out.println(myLetter);\\\\\\\\nSystem.out.println(myBool);\\\\\\\\nSystem.out.println(myText);\\\\\\\\n}\\\\\\\\n}\\\\\\\"},\\\\\\\"State\\\\\\\":3,\\\\\\\"PlagiResults\\\\\\\":[{\\\\\\\"Coincidencias\\\\\\\":76,\\\\\\\"Coincidences\\\\\\\":76,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.17715617715617715,\\\\\\\"JaccardSimilitude\\\\\\\":17.72,\\\\\\\"Similitud_Levenshtein\\\\\\\":40.0,\\\\\\\"LevenshteinSimilitude\\\\\\\":40.0,\\\\\\\"Similitud_Semantica\\\\\\\":0.5789473684210527,\\\\\\\"SemanticSimilitude\\\\\\\":57.89},{\\\\\\\"Coincidencias\\\\\\\":31,\\\\\\\"Coincidences\\\\\\\":31,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13656387665198239,\\\\\\\"JaccardSimilitude\\\\\\\":13.66,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.22222222222222,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.22,\\\\\\\"Similitud_Semantica\\\\\\\":0.43999999999999995,\\\\\\\"SemanticSimilitude\\\\\\\":44.0},{\\\\\\\"Coincidencias\\\\\\\":91,\\\\\\\"Coincidences\\\\\\\":91,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.5384615384615384,\\\\\\\"JaccardSimilitude\\\\\\\":53.85,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.434782608695656,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.43,\\\\\\\"Similitud_Semantica\\\\\\\":0.3142857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":31.43},{\\\\\\\"Coincidencias\\\\\\\":94,\\\\\\\"Coincidences\\\\\\\":94,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.42727272727272725,\\\\\\\"JaccardSimilitude\\\\\\\":42.73,\\\\\\\"Similitud_Levenshtein\\\\\\\":54.54545454545454,\\\\\\\"LevenshteinSimilitude\\\\\\\":54.55,\\\\\\\"Similitud_Semantica\\\\\\\":1.0,\\\\\\\"SemanticSimilitude\\\\\\\":100.0},{\\\\\\\"Coincidencias\\\\\\\":84,\\\\\\\"Coincidences\\\\\\\":84,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.22641509433962265,\\\\\\\"JaccardSimilitude\\\\\\\":22.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":26.31578947368421,\\\\\\\"LevenshteinSimilitude\\\\\\\":26.32,\\\\\\\"Similitud_Semantica\\\\\\\":0.40740740740740744,\\\\\\\"SemanticSimilitude\\\\\\\":40.74},{\\\\\\\"Coincidencias\\\\\\\":59,\\\\\\\"Coincidences\\\\\\\":59,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.125,\\\\\\\"JaccardSimilitude\\\\\\\":12.5,\\\\\\\"Similitud_Levenshtein\\\\\\\":25.64102564102564,\\\\\\\"LevenshteinSimilitude\\\\\\\":25.64,\\\\\\\"Similitud_Semantica\\\\\\\":0.3928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":39.29},{\\\\\\\"Coincidencias\\\\\\\":60,\\\\\\\"Coincidences\\\\\\\":60,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08836524300441827,\\\\\\\"JaccardSimilitude\\\\\\\":8.84,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.21212121212121,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.21,\\\\\\\"Similitud_Semantica\\\\\\\":0.19999999999999996,\\\\\\\"SemanticSimilitude\\\\\\\":20.0},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10355987055016182,\\\\\\\"JaccardSimilitude\\\\\\\":10.36,\\\\\\\"Similitud_Levenshtein\\\\\\\":15.053763440860216,\\\\\\\"LevenshteinSimilitude\\\\\\\":15.05,\\\\\\\"Similitud_Semantica\\\\\\\":0.13414634146341464,\\\\\\\"SemanticSimilitude\\\\\\\":13.41},{\\\\\\\"Coincidencias\\\\\\\":60,\\\\\\\"Coincidences\\\\\\\":60,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1744186046511628,\\\\\\\"JaccardSimilitude\\\\\\\":17.44,\\\\\\\"Similitud_Levenshtein\\\\\\\":9.836065573770492,\\\\\\\"LevenshteinSimilitude\\\\\\\":9.84,\\\\\\\"Similitud_Semantica\\\\\\\":0.09909909909909909,\\\\\\\"SemanticSimilitude\\\\\\\":9.91},{\\\\\\\"Coincidencias\\\\\\\":78,\\\\\\\"Coincidences\\\\\\\":78,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.14130434782608695,\\\\\\\"JaccardSimilitude\\\\\\\":14.13,\\\\\\\"Similitud_Levenshtein\\\\\\\":20.833333333333336,\\\\\\\"LevenshteinSimilitude\\\\\\\":20.83,\\\\\\\"Similitud_Semantica\\\\\\\":0.6551724137931034,\\\\\\\"SemanticSimilitude\\\\\\\":65.52},{\\\\\\\"Coincidencias\\\\\\\":40,\\\\\\\"Coincidences\\\\\\\":40,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.11661807580174927,\\\\\\\"JaccardSimilitude\\\\\\\":11.66,\\\\\\\"Similitud_Levenshtein\\\\\\\":55.55555555555556,\\\\\\\"LevenshteinSimilitude\\\\\\\":55.56,\\\\\\\"Similitud_Semantica\\\\\\\":0.8620689655172413,\\\\\\\"SemanticSimilitude\\\\\\\":86.21},{\\\\\\\"Coincidencias\\\\\\\":95,\\\\\\\"Coincidences\\\\\\\":95,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.3275862068965517,\\\\\\\"JaccardSimilitude\\\\\\\":32.76,\\\\\\\"Similitud_Levenshtein\\\\\\\":56.25,\\\\\\\"LevenshteinSimilitude\\\\\\\":56.25,\\\\\\\"Similitud_Semantica\\\\\\\":0.8285714285714285,\\\\\\\"SemanticSimilitude\\\\\\\":82.86},{\\\\\\\"Coincidencias\\\\\\\":86,\\\\\\\"Coincidences\\\\\\\":86,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.24362606232294617,\\\\\\\"JaccardSimilitude\\\\\\\":24.36,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.0,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.0,\\\\\\\"Similitud_Semantica\\\\\\\":0.3793103448275862,\\\\\\\"SemanticSimilitude\\\\\\\":37.93},{\\\\\\\"Coincidencias\\\\\\\":247,\\\\\\\"Coincidences\\\\\\\":247,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.7417417417417418,\\\\\\\"JaccardSimilitude\\\\\\\":74.17,\\\\\\\"Similitud_Levenshtein\\\\\\\":85.71428571428571,\\\\\\\"LevenshteinSimilitude\\\\\\\":85.71,\\\\\\\"Similitud_Semantica\\\\\\\":0.9310344827586207,\\\\\\\"SemanticSimilitude\\\\\\\":93.1},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10810810810810811,\\\\\\\"JaccardSimilitude\\\\\\\":10.81,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.052631578947366,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.05,\\\\\\\"Similitud_Semantica\\\\\\\":0.9655172413793104,\\\\\\\"SemanticSimilitude\\\\\\\":96.55},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08135168961201501,\\\\\\\"JaccardSimilitude\\\\\\\":8.14,\\\\\\\"Similitud_Levenshtein\\\\\\\":40.476190476190474,\\\\\\\"LevenshteinSimilitude\\\\\\\":40.48,\\\\\\\"Similitud_Semantica\\\\\\\":0.5272727272727273,\\\\\\\"SemanticSimilitude\\\\\\\":52.73},{\\\\\\\"Coincidencias\\\\\\\":70,\\\\\\\"Coincidences\\\\\\\":70,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09497964721845319,\\\\\\\"JaccardSimilitude\\\\\\\":9.5,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.630630630630627,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.63,\\\\\\\"Similitud_Semantica\\\\\\\":0.35365853658536583,\\\\\\\"SemanticSimilitude\\\\\\\":35.37},{\\\\\\\"Coincidencias\\\\\\\":63,\\\\\\\"Coincidences\\\\\\\":63,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1351931330472103,\\\\\\\"JaccardSimilitude\\\\\\\":13.52,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.857142857142858,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.86,\\\\\\\"Similitud_Semantica\\\\\\\":0.26126126126126126,\\\\\\\"SemanticSimilitude\\\\\\\":26.13}]},\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"Ramzan\\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"Kadyrov\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"b6c2d5e1-33c4-4048-820b-03d25fe674b9\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3\\\\\\\",\\\\\\\"Codes\\\\\\\":{\\\\\\\"Calculadora.java\\\\\\\":\\\\\\\"class DivisionPorCeroException extends Exception {\\\\\\\\npublic DivisionPorCeroException(String mensaje) {\\\\\\\\nsuper(mensaje);\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\npublic class Calculadora {\\\\\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\\\\\nif (denominador == 0) {\\\\\\\\nthrow new DivisionPorCeroException(\\\\\\\\\\\\\\\"Error: División por cero no permitida.\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\nreturn (double) numerador / denominador;\\\\\\\\n}\\\\\\\\n\\\\\\\\npublic static void main(String[] args) {\\\\\\\\ntry {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Resultado: \\\\\\\\\\\\\\\" + dividir(10, 0));\\\\\\\\n} catch (DivisionPorCeroException e) {\\\\\\\\nSystem.err.println(e.getMessage());\\\\\\\\n}\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"Diccionario.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\nimport java.util.HashMap;\\\\\\\\n\\\\\\\\npublic class Diccionario {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\n// Crear un HashMap para almacenar palabras y sus definiciones\\\\\\\\nHashMap<String, String> diccionario = new HashMap<>();\\\\\\\\n\\\\\\\\n// Añadir elementos al diccionario\\\\\\\\ndiccionario.put(\\\\\\\\\\\\\\\"Java\\\\\\\\\\\\\\\", \\\\\\\\\\\\\\\"Lenguaje de programación orientado a objetos.\\\\\\\\\\\\\\\");\\\\\\\\ndiccionario.put(\\\\\\\\\\\\\\\"Python\\\\\\\\\\\\\\\", \\\\\\\\\\\\\\\"Lenguaje de programación de alto nivel.\\\\\\\\\\\\\\\");\\\\\\\\ndiccionario.put(\\\\\\\\\\\\\\\"HTML\\\\\\\\\\\\\\\", \\\\\\\\\\\\\\\"Lenguaje de marcado para crear páginas web.\\\\\\\\\\\\\\\");\\\\\\\\n\\\\\\\\n// Buscar y mostrar una definición\\\\\\\\nString palabra = \\\\\\\\\\\\\\\"Java\\\\\\\\\\\\\\\";\\\\\\\\nif (diccionario.containsKey(palabra)) {\\\\\\\\nSystem.out.println(palabra + \\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\" + diccionario.get(palabra));\\\\\\\\n} else {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Palabra no encontrada en el diccionario.\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\n\\\\\\\\n// Mostrar todas las palabras en el diccionario\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\\nPalabras en el diccionario:\\\\\\\\\\\\\\\");\\\\\\\\nfor (String key : diccionario.keySet()) {\\\\\\\\nSystem.out.println(key + \\\\\\\\\\\\\\\": \\\\\\\\\\\\\\\" + diccionario.get(key));\\\\\\\\n}\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"FileHandler.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\nimport java.io.*;\\\\\\\\n\\\\\\\\npublic class FileHandler {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\nString fileName = \\\\\\\\\\\\\\\"example.txt\\\\\\\\\\\\\\\";\\\\\\\\n\\\\\\\\n// Escribir en un archivo\\\\\\\\ntry (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {\\\\\\\\nwriter.write(\\\\\\\\\\\\\\\"Este es un ejemplo de escritura en archivo.\\\\\\\\\\\\\\\");\\\\\\\\nwriter.newLine();\\\\\\\\nwriter.write(\\\\\\\\\\\\\\\"Java es genial para manejar archivos.\\\\\\\\\\\\\\\");\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Escritura en archivo completada.\\\\\\\\\\\\\\\");\\\\\\\\n} catch (IOException e) {\\\\\\\\nSystem.err.println(\\\\\\\\\\\\\\\"Error al escribir en el archivo: \\\\\\\\\\\\\\\" + e.getMessage());\\\\\\\\n}\\\\\\\\n\\\\\\\\n// Leer desde un archivo\\\\\\\\ntry (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {\\\\\\\\nString line;\\\\\\\\nwhile ((line = reader.readLine()) != null) {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Contenido del archivo: \\\\\\\\\\\\\\\" + line);\\\\\\\\n}\\\\\\\\n} catch (IOException e) {\\\\\\\\nSystem.err.println(\\\\\\\\\\\\\\\"Error al leer el archivo: \\\\\\\\\\\\\\\" + e.getMessage());\\\\\\\\n}\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"TestAnimales.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\nclass Animal {\\\\\\\\npublic void sonido() {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"El animal hace un sonido\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\nclass Perro extends Animal {\\\\\\\\n@Override\\\\\\\\npublic void sonido() {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"El perro ladra\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\nclass Gato extends Animal {\\\\\\\\n@Override\\\\\\\\npublic void sonido() {\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"El gato maúlla\\\\\\\\\\\\\\\");\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\npublic class TestAnimales {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\nAnimal miPerro = new Perro();\\\\\\\\nAnimal miGato = new Gato();\\\\\\\\n\\\\\\\\nmiPerro.sonido();\\\\\\\\nmiGato.sonido();\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"asf.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\nclass asf {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\n\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Hello Codiva\\\\\\\\\\\\\\\");\\\\\\\\n\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\\n\\\\\\\",\\\\\\\"asfsadasd.java\\\\\\\":\\\\\\\"\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\n\\\\\\\\nclass asfsadasd {\\\\\\\\npublic static void main(String[] args) {\\\\\\\\n\\\\\\\\nSystem.out.println(\\\\\\\\\\\\\\\"Hello Codiva\\\\\\\\\\\\\\\");\\\\\\\\n\\\\\\\\n}\\\\\\\\n}\\\\\\\\n\\\\\\\"},\\\\\\\"State\\\\\\\":3,\\\\\\\"PlagiResults\\\\\\\":[{\\\\\\\"Coincidencias\\\\\\\":343,\\\\\\\"Coincidences\\\\\\\":343,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.8386308068459658,\\\\\\\"JaccardSimilitude\\\\\\\":83.86,\\\\\\\"Similitud_Levenshtein\\\\\\\":76.59574468085107,\\\\\\\"LevenshteinSimilitude\\\\\\\":76.6,\\\\\\\"Similitud_Semantica\\\\\\\":0.6785714285714286,\\\\\\\"SemanticSimilitude\\\\\\\":67.86},{\\\\\\\"Coincidencias\\\\\\\":92,\\\\\\\"Coincidences\\\\\\\":92,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.22276029055690072,\\\\\\\"JaccardSimilitude\\\\\\\":22.28,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.641509433962266,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.64,\\\\\\\"Similitud_Semantica\\\\\\\":0.8928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":89.29},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1393258426966292,\\\\\\\"JaccardSimilitude\\\\\\\":13.93,\\\\\\\"Similitud_Levenshtein\\\\\\\":19.047619047619047,\\\\\\\"LevenshteinSimilitude\\\\\\\":19.05,\\\\\\\"Similitud_Semantica\\\\\\\":0.8,\\\\\\\"SemanticSimilitude\\\\\\\":80.0},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12424849699398798,\\\\\\\"JaccardSimilitude\\\\\\\":12.42,\\\\\\\"Similitud_Levenshtein\\\\\\\":10.256410256410255,\\\\\\\"LevenshteinSimilitude\\\\\\\":10.26,\\\\\\\"Similitud_Semantica\\\\\\\":0.3928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":39.29},{\\\\\\\"Coincidencias\\\\\\\":72,\\\\\\\"Coincidences\\\\\\\":72,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.11428571428571428,\\\\\\\"JaccardSimilitude\\\\\\\":11.43,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.818181818181817,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.82,\\\\\\\"Similitud_Semantica\\\\\\\":0.9642857142857143,\\\\\\\"SemanticSimilitude\\\\\\\":96.43},{\\\\\\\"Coincidencias\\\\\\\":59,\\\\\\\"Coincidences\\\\\\\":59,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.125,\\\\\\\"JaccardSimilitude\\\\\\\":12.5,\\\\\\\"Similitud_Levenshtein\\\\\\\":10.256410256410255,\\\\\\\"LevenshteinSimilitude\\\\\\\":10.26,\\\\\\\"Similitud_Semantica\\\\\\\":0.3928571428571429,\\\\\\\"SemanticSimilitude\\\\\\\":39.29},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10810810810810811,\\\\\\\"JaccardSimilitude\\\\\\\":10.81,\\\\\\\"Similitud_Levenshtein\\\\\\\":21.052631578947366,\\\\\\\"LevenshteinSimilitude\\\\\\\":21.05,\\\\\\\"Similitud_Semantica\\\\\\\":0.9655172413793104,\\\\\\\"SemanticSimilitude\\\\\\\":96.55},{\\\\\\\"Coincidencias\\\\\\\":85,\\\\\\\"Coincidences\\\\\\\":85,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09714285714285714,\\\\\\\"JaccardSimilitude\\\\\\\":9.71,\\\\\\\"Similitud_Levenshtein\\\\\\\":18.91891891891892,\\\\\\\"LevenshteinSimilitude\\\\\\\":18.92,\\\\\\\"Similitud_Semantica\\\\\\\":0.34545454545454546,\\\\\\\"SemanticSimilitude\\\\\\\":34.55},{\\\\\\\"Coincidencias\\\\\\\":25,\\\\\\\"Coincidences\\\\\\\":25,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.036337209302325583,\\\\\\\"JaccardSimilitude\\\\\\\":3.63,\\\\\\\"Similitud_Levenshtein\\\\\\\":52.5,\\\\\\\"LevenshteinSimilitude\\\\\\\":52.5,\\\\\\\"Similitud_Semantica\\\\\\\":0.4545454545454546,\\\\\\\"SemanticSimilitude\\\\\\\":45.45},{\\\\\\\"Coincidencias\\\\\\\":62,\\\\\\\"Coincidences\\\\\\\":62,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09494640122511486,\\\\\\\"JaccardSimilitude\\\\\\\":9.49,\\\\\\\"Similitud_Levenshtein\\\\\\\":66.66666666666666,\\\\\\\"LevenshteinSimilitude\\\\\\\":66.67,\\\\\\\"Similitud_Semantica\\\\\\\":0.6363636363636364,\\\\\\\"SemanticSimilitude\\\\\\\":63.64},{\\\\\\\"Coincidencias\\\\\\\":61,\\\\\\\"Coincidences\\\\\\\":61,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08615819209039548,\\\\\\\"JaccardSimilitude\\\\\\\":8.62,\\\\\\\"Similitud_Levenshtein\\\\\\\":15.151515151515152,\\\\\\\"LevenshteinSimilitude\\\\\\\":15.15,\\\\\\\"Similitud_Semantica\\\\\\\":0.19999999999999996,\\\\\\\"SemanticSimilitude\\\\\\\":20.0},{\\\\\\\"Coincidencias\\\\\\\":72,\\\\\\\"Coincidences\\\\\\\":72,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08591885441527446,\\\\\\\"JaccardSimilitude\\\\\\\":8.59,\\\\\\\"Similitud_Levenshtein\\\\\\\":36.58536585365854,\\\\\\\"LevenshteinSimilitude\\\\\\\":36.59,\\\\\\\"Similitud_Semantica\\\\\\\":0.49090909090909096,\\\\\\\"SemanticSimilitude\\\\\\\":49.09},{\\\\\\\"Coincidencias\\\\\\\":60,\\\\\\\"Coincidences\\\\\\\":60,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08836524300441827,\\\\\\\"JaccardSimilitude\\\\\\\":8.84,\\\\\\\"Similitud_Levenshtein\\\\\\\":18.181818181818183,\\\\\\\"LevenshteinSimilitude\\\\\\\":18.18,\\\\\\\"Similitud_Semantica\\\\\\\":0.19999999999999996,\\\\\\\"SemanticSimilitude\\\\\\\":20.0},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"Diccionario.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.08135168961201501,\\\\\\\"JaccardSimilitude\\\\\\\":8.14,\\\\\\\"Similitud_Levenshtein\\\\\\\":38.095238095238095,\\\\\\\"LevenshteinSimilitude\\\\\\\":38.1,\\\\\\\"Similitud_Semantica\\\\\\\":0.5272727272727273,\\\\\\\"SemanticSimilitude\\\\\\\":52.73},{\\\\\\\"Coincidencias\\\\\\\":130,\\\\\\\"Coincidences\\\\\\\":130,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.16817593790426907,\\\\\\\"JaccardSimilitude\\\\\\\":16.82,\\\\\\\"Similitud_Levenshtein\\\\\\\":13.861386138613863,\\\\\\\"LevenshteinSimilitude\\\\\\\":13.86,\\\\\\\"Similitud_Semantica\\\\\\\":0.23170731707317072,\\\\\\\"SemanticSimilitude\\\\\\\":23.17},{\\\\\\\"Coincidencias\\\\\\\":35,\\\\\\\"Coincidences\\\\\\\":35,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.05636070853462158,\\\\\\\"JaccardSimilitude\\\\\\\":5.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":39.25233644859813,\\\\\\\"LevenshteinSimilitude\\\\\\\":39.25,\\\\\\\"Similitud_Semantica\\\\\\\":0.30487804878048785,\\\\\\\"SemanticSimilitude\\\\\\\":30.49},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10961214165261383,\\\\\\\"JaccardSimilitude\\\\\\\":10.96,\\\\\\\"Similitud_Levenshtein\\\\\\\":52.991452991452995,\\\\\\\"LevenshteinSimilitude\\\\\\\":52.99,\\\\\\\"Similitud_Semantica\\\\\\\":0.426829268292683,\\\\\\\"SemanticSimilitude\\\\\\\":42.68},{\\\\\\\"Coincidencias\\\\\\\":65,\\\\\\\"Coincidences\\\\\\\":65,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10046367851622875,\\\\\\\"JaccardSimilitude\\\\\\\":10.05,\\\\\\\"Similitud_Levenshtein\\\\\\\":10.75268817204301,\\\\\\\"LevenshteinSimilitude\\\\\\\":10.75,\\\\\\\"Similitud_Semantica\\\\\\\":0.13414634146341464,\\\\\\\"SemanticSimilitude\\\\\\\":13.41},{\\\\\\\"Coincidencias\\\\\\\":76,\\\\\\\"Coincidences\\\\\\\":76,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.0978120978120978,\\\\\\\"JaccardSimilitude\\\\\\\":9.78,\\\\\\\"Similitud_Levenshtein\\\\\\\":27.522935779816514,\\\\\\\"LevenshteinSimilitude\\\\\\\":27.52,\\\\\\\"Similitud_Semantica\\\\\\\":0.3292682926829268,\\\\\\\"SemanticSimilitude\\\\\\\":32.93},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.10355987055016182,\\\\\\\"JaccardSimilitude\\\\\\\":10.36,\\\\\\\"Similitud_Levenshtein\\\\\\\":12.903225806451612,\\\\\\\"LevenshteinSimilitude\\\\\\\":12.9,\\\\\\\"Similitud_Semantica\\\\\\\":0.13414634146341464,\\\\\\\"SemanticSimilitude\\\\\\\":13.41},{\\\\\\\"Coincidencias\\\\\\\":70,\\\\\\\"Coincidences\\\\\\\":70,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"FileHandler.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.09497964721845319,\\\\\\\"JaccardSimilitude\\\\\\\":9.5,\\\\\\\"Similitud_Levenshtein\\\\\\\":28.82882882882883,\\\\\\\"LevenshteinSimilitude\\\\\\\":28.83,\\\\\\\"Similitud_Semantica\\\\\\\":0.35365853658536583,\\\\\\\"SemanticSimilitude\\\\\\\":35.37},{\\\\\\\"Coincidencias\\\\\\\":75,\\\\\\\"Coincidences\\\\\\\":75,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Calculadora.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.13636363636363635,\\\\\\\"JaccardSimilitude\\\\\\\":13.64,\\\\\\\"Similitud_Levenshtein\\\\\\\":7.6923076923076925,\\\\\\\"LevenshteinSimilitude\\\\\\\":7.69,\\\\\\\"Similitud_Semantica\\\\\\\":0.1711711711711712,\\\\\\\"SemanticSimilitude\\\\\\\":17.12},{\\\\\\\"Coincidencias\\\\\\\":26,\\\\\\\"Coincidences\\\\\\\":26,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"DivisionPorCeroException.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.07386363636363637,\\\\\\\"JaccardSimilitude\\\\\\\":7.39,\\\\\\\"Similitud_Levenshtein\\\\\\\":30.88235294117647,\\\\\\\"LevenshteinSimilitude\\\\\\\":30.88,\\\\\\\"Similitud_Semantica\\\\\\\":0.22522522522522526,\\\\\\\"SemanticSimilitude\\\\\\\":22.52},{\\\\\\\"Coincidencias\\\\\\\":64,\\\\\\\"Coincidences\\\\\\\":64,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.20253164556962025,\\\\\\\"JaccardSimilitude\\\\\\\":20.25,\\\\\\\"Similitud_Levenshtein\\\\\\\":42.465753424657535,\\\\\\\"LevenshteinSimilitude\\\\\\\":42.47,\\\\\\\"Similitud_Semantica\\\\\\\":0.3153153153153153,\\\\\\\"SemanticSimilitude\\\\\\\":31.53},{\\\\\\\"Coincidencias\\\\\\\":63,\\\\\\\"Coincidences\\\\\\\":63,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.16981132075471697,\\\\\\\"JaccardSimilitude\\\\\\\":16.98,\\\\\\\"Similitud_Levenshtein\\\\\\\":6.557377049180328,\\\\\\\"LevenshteinSimilitude\\\\\\\":6.56,\\\\\\\"Similitud_Semantica\\\\\\\":0.09909909909909909,\\\\\\\"SemanticSimilitude\\\\\\\":9.91},{\\\\\\\"Coincidencias\\\\\\\":66,\\\\\\\"Coincidences\\\\\\\":66,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.12966601178781925,\\\\\\\"JaccardSimilitude\\\\\\\":12.97,\\\\\\\"Similitud_Levenshtein\\\\\\\":20.28985507246377,\\\\\\\"LevenshteinSimilitude\\\\\\\":20.29,\\\\\\\"Similitud_Semantica\\\\\\\":0.2432432432432432,\\\\\\\"SemanticSimilitude\\\\\\\":24.32},{\\\\\\\"Coincidencias\\\\\\\":60,\\\\\\\"Coincidences\\\\\\\":60,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"HelloCodiva.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1744186046511628,\\\\\\\"JaccardSimilitude\\\\\\\":17.44,\\\\\\\"Similitud_Levenshtein\\\\\\\":9.836065573770492,\\\\\\\"LevenshteinSimilitude\\\\\\\":9.84,\\\\\\\"Similitud_Semantica\\\\\\\":0.09909909909909909,\\\\\\\"SemanticSimilitude\\\\\\\":9.91},{\\\\\\\"Coincidencias\\\\\\\":63,\\\\\\\"Coincidences\\\\\\\":63,\\\\\\\"Nombre1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"FileName1\\\\\\\":\\\\\\\"TestAnimales.java\\\\\\\",\\\\\\\"Nombre2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"FileName2\\\\\\\":\\\\\\\"Main.java\\\\\\\",\\\\\\\"Usuario_Id1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"UserId1\\\\\\\":\\\\\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\\\\\",\\\\\\\"Usuario_Id2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"UserId2\\\\\\\":\\\\\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\\\\\",\\\\\\\"Similitud_Jaccard\\\\\\\":0.1351931330472103,\\\\\\\"JaccardSimilitude\\\\\\\":13.52,\\\\\\\"Similitud_Levenshtein\\\\\\\":22.857142857142858,\\\\\\\"LevenshteinSimilitude\\\\\\\":22.86,\\\\\\\"Similitud_Semantica\\\\\\\":0.26126126126126126,\\\\\\\"SemanticSimilitude\\\\\\\":26.13}]},\\\\\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\\\\\":{\\\\\\\"Id\\\\\\\":\\\\\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\\\\\",\\\\\\\"FirstName\\\\\\\":\\\\\\\"August\\\\\\\",\\\\\\\"LastName\\\\\\\":\\\\\\\"von Kageneck\\\\\\\",\\\\\\\"SubmissionId\\\\\\\":\\\\\\\"6252ac2f-e197-4ec3-821f-56ef3dffc72c\\\\\\\",\\\\\\\"Url\\\\\\\":\\\\\\\"https://www.codiva.io/p/0dc6fsdf99a0-6033-4bb6-b46c-15d238277749\\\\\\\",\\\\\\\"Codes\\\\\\\":{},\\\\\\\"State\\\\\\\":1,\\\\\\\"PlagiResults\\\\\\\":[]}}\\\"\",\"{\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\":{\\\"Id\\\":\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\",\\\"FirstName\\\":\\\"Pedro\\\",\\\"LastName\\\":\\\"Picapiedra\\\",\\\"SubmissionId\\\":\\\"bd755547-68fc-4094-8f87-8b65797d668e\\\",\\\"Url\\\":\\\"https://www.covid.io/p/0dc699a0-6033-4bb6-b46c-15d238277749\\\",\\\"Codes\\\":{},\\\"State\\\":2,\\\"PlagiResults\\\":[]},\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\":{\\\"Id\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"FirstName\\\":\\\"Ben\\\",\\\"LastName\\\":\\\"Tennyson\\\",\\\"SubmissionId\\\":\\\"6e701991-2a14-4493-a170-f4fe910e9c4a\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700\\\",\\\"Codes\\\":{\\\"Calculadora.java\\\":\\\"package com.example;\\\\n\\\\npublic class Calculadora {\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\nif (denominador == 0) {\\\\nthrow new DivisionPorCeroException(\\\\\\\"Error: División por cero no permitida.\\\\\\\");\\\\n}\\\\nreturn (double) numerador / denominador;\\\\n}\\\\n\\\\npublic static void main(String[] args) {\\\\ntry {\\\\nSystem.out.println(\\\\\\\"Resultado: \\\\\\\" + dividir(10, 0));\\\\n} catch (DivisionPorCeroException e) {\\\\nSystem.err.println(e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\",\\\"DivisionPorCeroException.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\npublic class DivisionPorCeroException extends Exception {\\\\npublic DivisionPorCeroException(String mensaje) {\\\\nsuper(mensaje);\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\nclass Main {\\\\n\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello World!\\\\\\\");\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":82,\\\"Coincidences\\\":82,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.3942307692307692,\\\"JaccardSimilitude\\\":39.42,\\\"Similitud_Levenshtein\\\":26.08695652173913,\\\"LevenshteinSimilitude\\\":26.09,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.2676470588235294,\\\"JaccardSimilitude\\\":26.76,\\\"Similitud_Levenshtein\\\":51.61290322580645,\\\"LevenshteinSimilitude\\\":51.61,\\\"Similitud_Semantica\\\":0.7714285714285715,\\\"SemanticSimilitude\\\":77.14},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.5384615384615384,\\\"JaccardSimilitude\\\":53.85,\\\"Similitud_Levenshtein\\\":30.434782608695656,\\\"LevenshteinSimilitude\\\":30.43,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":95,\\\"Coincidences\\\":95,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.3275862068965517,\\\"JaccardSimilitude\\\":32.76,\\\"Similitud_Levenshtein\\\":56.25,\\\"LevenshteinSimilitude\\\":56.25,\\\"Similitud_Semantica\\\":0.8285714285714285,\\\"SemanticSimilitude\\\":82.86},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1393258426966292,\\\"JaccardSimilitude\\\":13.93,\\\"Similitud_Levenshtein\\\":19.047619047619047,\\\"LevenshteinSimilitude\\\":19.05,\\\"Similitud_Semantica\\\":0.8,\\\"SemanticSimilitude\\\":80.0},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09494640122511486,\\\"JaccardSimilitude\\\":9.49,\\\"Similitud_Levenshtein\\\":68.88888888888889,\\\"LevenshteinSimilitude\\\":68.89,\\\"Similitud_Semantica\\\":0.6363636363636364,\\\"SemanticSimilitude\\\":63.64},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10961214165261383,\\\"JaccardSimilitude\\\":10.96,\\\"Similitud_Levenshtein\\\":54.700854700854705,\\\"LevenshteinSimilitude\\\":54.7,\\\"Similitud_Semantica\\\":0.426829268292683,\\\"SemanticSimilitude\\\":42.68},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.20253164556962025,\\\"JaccardSimilitude\\\":20.25,\\\"Similitud_Levenshtein\\\":42.465753424657535,\\\"LevenshteinSimilitude\\\":42.47,\\\"Similitud_Semantica\\\":0.3153153153153153,\\\"SemanticSimilitude\\\":31.53},{\\\"Coincidencias\\\":80,\\\"Coincidences\\\":80,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.17582417582417584,\\\"JaccardSimilitude\\\":17.58,\\\"Similitud_Levenshtein\\\":33.33333333333333,\\\"LevenshteinSimilitude\\\":33.33,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":88,\\\"Coincidences\\\":88,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.14965986394557823,\\\"JaccardSimilitude\\\":14.97,\\\"Similitud_Levenshtein\\\":21.73913043478261,\\\"LevenshteinSimilitude\\\":21.74,\\\"Similitud_Semantica\\\":0.7037037037037037,\\\"SemanticSimilitude\\\":70.37},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.17715617715617715,\\\"JaccardSimilitude\\\":17.72,\\\"Similitud_Levenshtein\\\":40.0,\\\"LevenshteinSimilitude\\\":40.0,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":78,\\\"Coincidences\\\":78,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.14130434782608695,\\\"JaccardSimilitude\\\":14.13,\\\"Similitud_Levenshtein\\\":20.833333333333336,\\\"LevenshteinSimilitude\\\":20.83,\\\"Similitud_Semantica\\\":0.6551724137931034,\\\"SemanticSimilitude\\\":65.52},{\\\"Coincidencias\\\":343,\\\"Coincidences\\\":343,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.8386308068459658,\\\"JaccardSimilitude\\\":83.86,\\\"Similitud_Levenshtein\\\":76.59574468085107,\\\"LevenshteinSimilitude\\\":76.6,\\\"Similitud_Semantica\\\":0.6785714285714286,\\\"SemanticSimilitude\\\":67.86},{\\\"Coincidencias\\\":85,\\\"Coincidences\\\":85,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09714285714285714,\\\"JaccardSimilitude\\\":9.71,\\\"Similitud_Levenshtein\\\":18.91891891891892,\\\"LevenshteinSimilitude\\\":18.92,\\\"Similitud_Semantica\\\":0.34545454545454546,\\\"SemanticSimilitude\\\":34.55},{\\\"Coincidencias\\\":130,\\\"Coincidences\\\":130,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.16817593790426907,\\\"JaccardSimilitude\\\":16.82,\\\"Similitud_Levenshtein\\\":13.861386138613863,\\\"LevenshteinSimilitude\\\":13.86,\\\"Similitud_Semantica\\\":0.23170731707317072,\\\"SemanticSimilitude\\\":23.17},{\\\"Coincidencias\\\":75,\\\"Coincidences\\\":75,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.13636363636363635,\\\"JaccardSimilitude\\\":13.64,\\\"Similitud_Levenshtein\\\":7.6923076923076925,\\\"LevenshteinSimilitude\\\":7.69,\\\"Similitud_Semantica\\\":0.1711711711711712,\\\"SemanticSimilitude\\\":17.12},{\\\"Coincidencias\\\":34,\\\"Coincidences\\\":34,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.13385826771653545,\\\"JaccardSimilitude\\\":13.39,\\\"Similitud_Levenshtein\\\":27.77777777777778,\\\"LevenshteinSimilitude\\\":27.78,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":47,\\\"Coincidences\\\":47,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12303664921465969,\\\"JaccardSimilitude\\\":12.3,\\\"Similitud_Levenshtein\\\":57.692307692307686,\\\"LevenshteinSimilitude\\\":57.69,\\\"Similitud_Semantica\\\":0.9259259259259259,\\\"SemanticSimilitude\\\":92.59},{\\\"Coincidencias\\\":31,\\\"Coincidences\\\":31,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.13656387665198239,\\\"JaccardSimilitude\\\":13.66,\\\"Similitud_Levenshtein\\\":22.22222222222222,\\\"LevenshteinSimilitude\\\":22.22,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":40,\\\"Coincidences\\\":40,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.11661807580174927,\\\"JaccardSimilitude\\\":11.66,\\\"Similitud_Levenshtein\\\":55.55555555555556,\\\"LevenshteinSimilitude\\\":55.56,\\\"Similitud_Semantica\\\":0.8620689655172413,\\\"SemanticSimilitude\\\":86.21},{\\\"Coincidencias\\\":92,\\\"Coincidences\\\":92,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.22276029055690072,\\\"JaccardSimilitude\\\":22.28,\\\"Similitud_Levenshtein\\\":22.641509433962266,\\\"LevenshteinSimilitude\\\":22.64,\\\"Similitud_Semantica\\\":0.8928571428571429,\\\"SemanticSimilitude\\\":89.29},{\\\"Coincidencias\\\":25,\\\"Coincidences\\\":25,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.036337209302325583,\\\"JaccardSimilitude\\\":3.63,\\\"Similitud_Levenshtein\\\":52.5,\\\"LevenshteinSimilitude\\\":52.5,\\\"Similitud_Semantica\\\":0.4545454545454546,\\\"SemanticSimilitude\\\":45.45},{\\\"Coincidencias\\\":35,\\\"Coincidences\\\":35,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.05636070853462158,\\\"JaccardSimilitude\\\":5.64,\\\"Similitud_Levenshtein\\\":39.25233644859813,\\\"LevenshteinSimilitude\\\":39.25,\\\"Similitud_Semantica\\\":0.30487804878048785,\\\"SemanticSimilitude\\\":30.49},{\\\"Coincidencias\\\":26,\\\"Coincidences\\\":26,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.07386363636363637,\\\"JaccardSimilitude\\\":7.39,\\\"Similitud_Levenshtein\\\":30.88235294117647,\\\"LevenshteinSimilitude\\\":30.88,\\\"Similitud_Semantica\\\":0.22522522522522526,\\\"SemanticSimilitude\\\":22.52}]},\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\":{\\\"Id\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"FirstName\\\":\\\"Khvicha\\\",\\\"LastName\\\":\\\"Kvaratskhelia\\\",\\\"SubmissionId\\\":\\\"31edb16a-feb4-4cab-812c-e8a4bdb6ad45\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee\\\",\\\"Codes\\\":{\\\"HelloCodiva.java\\\":\\\"\\\\npackage com.example;\\\\n\\\\nclass HelloCodiva {\\\\npublic static void main(String[] args) {\\\\nint a = 15;\\\\nint b = 20; // will generate an error\\\\nint c = 654;\\\\nSystem.out.println(a+b+c);\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\npublic class Main {\\\\npublic static void main(String[] args) {\\\\nint myNum = 5;               // integer (whole number)\\\\nfloat myFloatNum = 5.99f;    // floating point number\\\\nchar myLetter = ''D'';         // character\\\\nboolean myBool = true;       // boolean\\\\nString myText = \\\\\\\"Hello\\\\\\\";     // String\\\\nSystem.out.println(myNum);\\\\nSystem.out.println(myFloatNum);\\\\nSystem.out.println(myLetter);\\\\nSystem.out.println(myBool);\\\\nSystem.out.println(myText);\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":88,\\\"Coincidences\\\":88,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.14965986394557823,\\\"JaccardSimilitude\\\":14.97,\\\"Similitud_Levenshtein\\\":21.73913043478261,\\\"LevenshteinSimilitude\\\":21.74,\\\"Similitud_Semantica\\\":0.7037037037037037,\\\"SemanticSimilitude\\\":70.37},{\\\"Coincidencias\\\":47,\\\"Coincidences\\\":47,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.12303664921465969,\\\"JaccardSimilitude\\\":12.3,\\\"Similitud_Levenshtein\\\":57.692307692307686,\\\"LevenshteinSimilitude\\\":57.69,\\\"Similitud_Semantica\\\":0.9259259259259259,\\\"SemanticSimilitude\\\":92.59},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.2676470588235294,\\\"JaccardSimilitude\\\":26.76,\\\"Similitud_Levenshtein\\\":51.61290322580645,\\\"LevenshteinSimilitude\\\":51.61,\\\"Similitud_Semantica\\\":0.7714285714285715,\\\"SemanticSimilitude\\\":77.14},{\\\"Coincidencias\\\":84,\\\"Coincidences\\\":84,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.22641509433962265,\\\"JaccardSimilitude\\\":22.64,\\\"Similitud_Levenshtein\\\":26.31578947368421,\\\"LevenshteinSimilitude\\\":26.32,\\\"Similitud_Semantica\\\":0.40740740740740744,\\\"SemanticSimilitude\\\":40.74},{\\\"Coincidencias\\\":247,\\\"Coincidences\\\":247,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.7417417417417418,\\\"JaccardSimilitude\\\":74.17,\\\"Similitud_Levenshtein\\\":85.71428571428571,\\\"LevenshteinSimilitude\\\":85.71,\\\"Similitud_Semantica\\\":0.9310344827586207,\\\"SemanticSimilitude\\\":93.1},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.11428571428571428,\\\"JaccardSimilitude\\\":11.43,\\\"Similitud_Levenshtein\\\":21.818181818181817,\\\"LevenshteinSimilitude\\\":21.82,\\\"Similitud_Semantica\\\":0.9642857142857143,\\\"SemanticSimilitude\\\":96.43},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08591885441527446,\\\"JaccardSimilitude\\\":8.59,\\\"Similitud_Levenshtein\\\":36.58536585365854,\\\"LevenshteinSimilitude\\\":36.59,\\\"Similitud_Semantica\\\":0.49090909090909096,\\\"SemanticSimilitude\\\":49.09},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.0978120978120978,\\\"JaccardSimilitude\\\":9.78,\\\"Similitud_Levenshtein\\\":27.522935779816514,\\\"LevenshteinSimilitude\\\":27.52,\\\"Similitud_Semantica\\\":0.3292682926829268,\\\"SemanticSimilitude\\\":32.93},{\\\"Coincidencias\\\":66,\\\"Coincidences\\\":66,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.12966601178781925,\\\"JaccardSimilitude\\\":12.97,\\\"Similitud_Levenshtein\\\":20.28985507246377,\\\"LevenshteinSimilitude\\\":20.29,\\\"Similitud_Semantica\\\":0.2432432432432432,\\\"SemanticSimilitude\\\":24.32},{\\\"Coincidencias\\\":80,\\\"Coincidences\\\":80,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.17582417582417584,\\\"JaccardSimilitude\\\":17.58,\\\"Similitud_Levenshtein\\\":33.33333333333333,\\\"LevenshteinSimilitude\\\":33.33,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":34,\\\"Coincidences\\\":34,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13385826771653545,\\\"JaccardSimilitude\\\":13.39,\\\"Similitud_Levenshtein\\\":27.77777777777778,\\\"LevenshteinSimilitude\\\":27.78,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":82,\\\"Coincidences\\\":82,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.3942307692307692,\\\"JaccardSimilitude\\\":39.42,\\\"Similitud_Levenshtein\\\":26.08695652173913,\\\"LevenshteinSimilitude\\\":26.09,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":94,\\\"Coincidences\\\":94,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.42727272727272725,\\\"JaccardSimilitude\\\":42.73,\\\"Similitud_Levenshtein\\\":54.54545454545454,\\\"LevenshteinSimilitude\\\":54.55,\\\"Similitud_Semantica\\\":1.0,\\\"SemanticSimilitude\\\":100.0},{\\\"Coincidencias\\\":86,\\\"Coincidences\\\":86,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.24362606232294617,\\\"JaccardSimilitude\\\":24.36,\\\"Similitud_Levenshtein\\\":30.0,\\\"LevenshteinSimilitude\\\":30.0,\\\"Similitud_Semantica\\\":0.3793103448275862,\\\"SemanticSimilitude\\\":37.93},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.12424849699398798,\\\"JaccardSimilitude\\\":12.42,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":61,\\\"Coincidences\\\":61,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08615819209039548,\\\"JaccardSimilitude\\\":8.62,\\\"Similitud_Levenshtein\\\":15.151515151515152,\\\"LevenshteinSimilitude\\\":15.15,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10046367851622875,\\\"JaccardSimilitude\\\":10.05,\\\"Similitud_Levenshtein\\\":10.75268817204301,\\\"LevenshteinSimilitude\\\":10.75,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.16981132075471697,\\\"JaccardSimilitude\\\":16.98,\\\"Similitud_Levenshtein\\\":6.557377049180328,\\\"LevenshteinSimilitude\\\":6.56,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91}]},\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\":{\\\"Id\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"FirstName\\\":\\\"Khabib \\\",\\\"LastName\\\":\\\"Nurmagomedov\\\",\\\"SubmissionId\\\":\\\"e0d30fd2-1027-4af3-be3b-238a579dacb8\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8\\\",\\\"Codes\\\":{\\\"HelloCodiva.java\\\":\\\"package com.example;\\\\n\\\\nclass HelloCodiva {\\\\n\\\\npublic static void main(String[] args) {\\\\n\\\\nString greeting = \\\\\\\"Hello World\\\\\\\";\\\\nSystem.out.println(greeting);\\\\n\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\nclass Main {\\\\npublic static void main(String[] args) {\\\\nchar myLetter = ''D'';         // character\\\\nboolean myBool = true;       // boolean\\\\nString myText = \\\\\\\"Hello\\\\\\\";     // String\\\\n\\\\nint myNum = 5;\\\\nfloat myFloatNum = 5.99f;\\\\n\\\\nSystem.out.println(myNum);\\\\nSystem.out.println(myFloatNum);\\\\nSystem.out.println(myLetter);\\\\nSystem.out.println(myBool);\\\\nSystem.out.println(myText);\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.17715617715617715,\\\"JaccardSimilitude\\\":17.72,\\\"Similitud_Levenshtein\\\":40.0,\\\"LevenshteinSimilitude\\\":40.0,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":31,\\\"Coincidences\\\":31,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13656387665198239,\\\"JaccardSimilitude\\\":13.66,\\\"Similitud_Levenshtein\\\":22.22222222222222,\\\"LevenshteinSimilitude\\\":22.22,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.5384615384615384,\\\"JaccardSimilitude\\\":53.85,\\\"Similitud_Levenshtein\\\":30.434782608695656,\\\"LevenshteinSimilitude\\\":30.43,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":94,\\\"Coincidences\\\":94,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.42727272727272725,\\\"JaccardSimilitude\\\":42.73,\\\"Similitud_Levenshtein\\\":54.54545454545454,\\\"LevenshteinSimilitude\\\":54.55,\\\"Similitud_Semantica\\\":1.0,\\\"SemanticSimilitude\\\":100.0},{\\\"Coincidencias\\\":84,\\\"Coincidences\\\":84,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.22641509433962265,\\\"JaccardSimilitude\\\":22.64,\\\"Similitud_Levenshtein\\\":26.31578947368421,\\\"LevenshteinSimilitude\\\":26.32,\\\"Similitud_Semantica\\\":0.40740740740740744,\\\"SemanticSimilitude\\\":40.74},{\\\"Coincidencias\\\":59,\\\"Coincidences\\\":59,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.125,\\\"JaccardSimilitude\\\":12.5,\\\"Similitud_Levenshtein\\\":25.64102564102564,\\\"LevenshteinSimilitude\\\":25.64,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08836524300441827,\\\"JaccardSimilitude\\\":8.84,\\\"Similitud_Levenshtein\\\":21.21212121212121,\\\"LevenshteinSimilitude\\\":21.21,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10355987055016182,\\\"JaccardSimilitude\\\":10.36,\\\"Similitud_Levenshtein\\\":15.053763440860216,\\\"LevenshteinSimilitude\\\":15.05,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1744186046511628,\\\"JaccardSimilitude\\\":17.44,\\\"Similitud_Levenshtein\\\":9.836065573770492,\\\"LevenshteinSimilitude\\\":9.84,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":78,\\\"Coincidences\\\":78,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.14130434782608695,\\\"JaccardSimilitude\\\":14.13,\\\"Similitud_Levenshtein\\\":20.833333333333336,\\\"LevenshteinSimilitude\\\":20.83,\\\"Similitud_Semantica\\\":0.6551724137931034,\\\"SemanticSimilitude\\\":65.52},{\\\"Coincidencias\\\":40,\\\"Coincidences\\\":40,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.11661807580174927,\\\"JaccardSimilitude\\\":11.66,\\\"Similitud_Levenshtein\\\":55.55555555555556,\\\"LevenshteinSimilitude\\\":55.56,\\\"Similitud_Semantica\\\":0.8620689655172413,\\\"SemanticSimilitude\\\":86.21},{\\\"Coincidencias\\\":95,\\\"Coincidences\\\":95,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.3275862068965517,\\\"JaccardSimilitude\\\":32.76,\\\"Similitud_Levenshtein\\\":56.25,\\\"LevenshteinSimilitude\\\":56.25,\\\"Similitud_Semantica\\\":0.8285714285714285,\\\"SemanticSimilitude\\\":82.86},{\\\"Coincidencias\\\":86,\\\"Coincidences\\\":86,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.24362606232294617,\\\"JaccardSimilitude\\\":24.36,\\\"Similitud_Levenshtein\\\":30.0,\\\"LevenshteinSimilitude\\\":30.0,\\\"Similitud_Semantica\\\":0.3793103448275862,\\\"SemanticSimilitude\\\":37.93},{\\\"Coincidencias\\\":247,\\\"Coincidences\\\":247,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.7417417417417418,\\\"JaccardSimilitude\\\":74.17,\\\"Similitud_Levenshtein\\\":85.71428571428571,\\\"LevenshteinSimilitude\\\":85.71,\\\"Similitud_Semantica\\\":0.9310344827586207,\\\"SemanticSimilitude\\\":93.1},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10810810810810811,\\\"JaccardSimilitude\\\":10.81,\\\"Similitud_Levenshtein\\\":21.052631578947366,\\\"LevenshteinSimilitude\\\":21.05,\\\"Similitud_Semantica\\\":0.9655172413793104,\\\"SemanticSimilitude\\\":96.55},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08135168961201501,\\\"JaccardSimilitude\\\":8.14,\\\"Similitud_Levenshtein\\\":40.476190476190474,\\\"LevenshteinSimilitude\\\":40.48,\\\"Similitud_Semantica\\\":0.5272727272727273,\\\"SemanticSimilitude\\\":52.73},{\\\"Coincidencias\\\":70,\\\"Coincidences\\\":70,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09497964721845319,\\\"JaccardSimilitude\\\":9.5,\\\"Similitud_Levenshtein\\\":30.630630630630627,\\\"LevenshteinSimilitude\\\":30.63,\\\"Similitud_Semantica\\\":0.35365853658536583,\\\"SemanticSimilitude\\\":35.37},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1351931330472103,\\\"JaccardSimilitude\\\":13.52,\\\"Similitud_Levenshtein\\\":22.857142857142858,\\\"LevenshteinSimilitude\\\":22.86,\\\"Similitud_Semantica\\\":0.26126126126126126,\\\"SemanticSimilitude\\\":26.13}]},\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\":{\\\"Id\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"FirstName\\\":\\\"Ramzan\\\",\\\"LastName\\\":\\\"Kadyrov\\\",\\\"SubmissionId\\\":\\\"b6c2d5e1-33c4-4048-820b-03d25fe674b9\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3\\\",\\\"Codes\\\":{\\\"Calculadora.java\\\":\\\"class DivisionPorCeroException extends Exception {\\\\npublic DivisionPorCeroException(String mensaje) {\\\\nsuper(mensaje);\\\\n}\\\\n}\\\\n\\\\npublic class Calculadora {\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\nif (denominador == 0) {\\\\nthrow new DivisionPorCeroException(\\\\\\\"Error: División por cero no permitida.\\\\\\\");\\\\n}\\\\nreturn (double) numerador / denominador;\\\\n}\\\\n\\\\npublic static void main(String[] args) {\\\\ntry {\\\\nSystem.out.println(\\\\\\\"Resultado: \\\\\\\" + dividir(10, 0));\\\\n} catch (DivisionPorCeroException e) {\\\\nSystem.err.println(e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\",\\\"Diccionario.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nimport java.util.HashMap;\\\\n\\\\npublic class Diccionario {\\\\npublic static void main(String[] args) {\\\\n// Crear un HashMap para almacenar palabras y sus definiciones\\\\nHashMap<String, String> diccionario = new HashMap<>();\\\\n\\\\n// Añadir elementos al diccionario\\\\ndiccionario.put(\\\\\\\"Java\\\\\\\", \\\\\\\"Lenguaje de programación orientado a objetos.\\\\\\\");\\\\ndiccionario.put(\\\\\\\"Python\\\\\\\", \\\\\\\"Lenguaje de programación de alto nivel.\\\\\\\");\\\\ndiccionario.put(\\\\\\\"HTML\\\\\\\", \\\\\\\"Lenguaje de marcado para crear páginas web.\\\\\\\");\\\\n\\\\n// Buscar y mostrar una definición\\\\nString palabra = \\\\\\\"Java\\\\\\\";\\\\nif (diccionario.containsKey(palabra)) {\\\\nSystem.out.println(palabra + \\\\\\\": \\\\\\\" + diccionario.get(palabra));\\\\n} else {\\\\nSystem.out.println(\\\\\\\"Palabra no encontrada en el diccionario.\\\\\\\");\\\\n}\\\\n\\\\n// Mostrar todas las palabras en el diccionario\\\\nSystem.out.println(\\\\\\\"\\\\\\\\nPalabras en el diccionario:\\\\\\\");\\\\nfor (String key : diccionario.keySet()) {\\\\nSystem.out.println(key + \\\\\\\": \\\\\\\" + diccionario.get(key));\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\",\\\"FileHandler.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nimport java.io.*;\\\\n\\\\npublic class FileHandler {\\\\npublic static void main(String[] args) {\\\\nString fileName = \\\\\\\"example.txt\\\\\\\";\\\\n\\\\n// Escribir en un archivo\\\\ntry (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {\\\\nwriter.write(\\\\\\\"Este es un ejemplo de escritura en archivo.\\\\\\\");\\\\nwriter.newLine();\\\\nwriter.write(\\\\\\\"Java es genial para manejar archivos.\\\\\\\");\\\\nSystem.out.println(\\\\\\\"Escritura en archivo completada.\\\\\\\");\\\\n} catch (IOException e) {\\\\nSystem.err.println(\\\\\\\"Error al escribir en el archivo: \\\\\\\" + e.getMessage());\\\\n}\\\\n\\\\n// Leer desde un archivo\\\\ntry (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {\\\\nString line;\\\\nwhile ((line = reader.readLine()) != null) {\\\\nSystem.out.println(\\\\\\\"Contenido del archivo: \\\\\\\" + line);\\\\n}\\\\n} catch (IOException e) {\\\\nSystem.err.println(\\\\\\\"Error al leer el archivo: \\\\\\\" + e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\",\\\"TestAnimales.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass Animal {\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El animal hace un sonido\\\\\\\");\\\\n}\\\\n}\\\\n\\\\nclass Perro extends Animal {\\\\n@Override\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El perro ladra\\\\\\\");\\\\n}\\\\n}\\\\n\\\\nclass Gato extends Animal {\\\\n@Override\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El gato maúlla\\\\\\\");\\\\n}\\\\n}\\\\n\\\\npublic class TestAnimales {\\\\npublic static void main(String[] args) {\\\\nAnimal miPerro = new Perro();\\\\nAnimal miGato = new Gato();\\\\n\\\\nmiPerro.sonido();\\\\nmiGato.sonido();\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\",\\\"asf.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass asf {\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello Codiva\\\\\\\");\\\\n\\\\n}\\\\n}\\\\n\\\\n\\\",\\\"asfsadasd.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass asfsadasd {\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello Codiva\\\\\\\");\\\\n\\\\n}\\\\n}\\\\n\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":343,\\\"Coincidences\\\":343,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.8386308068459658,\\\"JaccardSimilitude\\\":83.86,\\\"Similitud_Levenshtein\\\":76.59574468085107,\\\"LevenshteinSimilitude\\\":76.6,\\\"Similitud_Semantica\\\":0.6785714285714286,\\\"SemanticSimilitude\\\":67.86},{\\\"Coincidencias\\\":92,\\\"Coincidences\\\":92,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.22276029055690072,\\\"JaccardSimilitude\\\":22.28,\\\"Similitud_Levenshtein\\\":22.641509433962266,\\\"LevenshteinSimilitude\\\":22.64,\\\"Similitud_Semantica\\\":0.8928571428571429,\\\"SemanticSimilitude\\\":89.29},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.1393258426966292,\\\"JaccardSimilitude\\\":13.93,\\\"Similitud_Levenshtein\\\":19.047619047619047,\\\"LevenshteinSimilitude\\\":19.05,\\\"Similitud_Semantica\\\":0.8,\\\"SemanticSimilitude\\\":80.0},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12424849699398798,\\\"JaccardSimilitude\\\":12.42,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.11428571428571428,\\\"JaccardSimilitude\\\":11.43,\\\"Similitud_Levenshtein\\\":21.818181818181817,\\\"LevenshteinSimilitude\\\":21.82,\\\"Similitud_Semantica\\\":0.9642857142857143,\\\"SemanticSimilitude\\\":96.43},{\\\"Coincidencias\\\":59,\\\"Coincidences\\\":59,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.125,\\\"JaccardSimilitude\\\":12.5,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.10810810810810811,\\\"JaccardSimilitude\\\":10.81,\\\"Similitud_Levenshtein\\\":21.052631578947366,\\\"LevenshteinSimilitude\\\":21.05,\\\"Similitud_Semantica\\\":0.9655172413793104,\\\"SemanticSimilitude\\\":96.55},{\\\"Coincidencias\\\":85,\\\"Coincidences\\\":85,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.09714285714285714,\\\"JaccardSimilitude\\\":9.71,\\\"Similitud_Levenshtein\\\":18.91891891891892,\\\"LevenshteinSimilitude\\\":18.92,\\\"Similitud_Semantica\\\":0.34545454545454546,\\\"SemanticSimilitude\\\":34.55},{\\\"Coincidencias\\\":25,\\\"Coincidences\\\":25,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.036337209302325583,\\\"JaccardSimilitude\\\":3.63,\\\"Similitud_Levenshtein\\\":52.5,\\\"LevenshteinSimilitude\\\":52.5,\\\"Similitud_Semantica\\\":0.4545454545454546,\\\"SemanticSimilitude\\\":45.45},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.09494640122511486,\\\"JaccardSimilitude\\\":9.49,\\\"Similitud_Levenshtein\\\":66.66666666666666,\\\"LevenshteinSimilitude\\\":66.67,\\\"Similitud_Semantica\\\":0.6363636363636364,\\\"SemanticSimilitude\\\":63.64},{\\\"Coincidencias\\\":61,\\\"Coincidences\\\":61,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.08615819209039548,\\\"JaccardSimilitude\\\":8.62,\\\"Similitud_Levenshtein\\\":15.151515151515152,\\\"LevenshteinSimilitude\\\":15.15,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.08591885441527446,\\\"JaccardSimilitude\\\":8.59,\\\"Similitud_Levenshtein\\\":36.58536585365854,\\\"LevenshteinSimilitude\\\":36.59,\\\"Similitud_Semantica\\\":0.49090909090909096,\\\"SemanticSimilitude\\\":49.09},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.08836524300441827,\\\"JaccardSimilitude\\\":8.84,\\\"Similitud_Levenshtein\\\":18.181818181818183,\\\"LevenshteinSimilitude\\\":18.18,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.08135168961201501,\\\"JaccardSimilitude\\\":8.14,\\\"Similitud_Levenshtein\\\":38.095238095238095,\\\"LevenshteinSimilitude\\\":38.1,\\\"Similitud_Semantica\\\":0.5272727272727273,\\\"SemanticSimilitude\\\":52.73},{\\\"Coincidencias\\\":130,\\\"Coincidences\\\":130,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.16817593790426907,\\\"JaccardSimilitude\\\":16.82,\\\"Similitud_Levenshtein\\\":13.861386138613863,\\\"LevenshteinSimilitude\\\":13.86,\\\"Similitud_Semantica\\\":0.23170731707317072,\\\"SemanticSimilitude\\\":23.17},{\\\"Coincidencias\\\":35,\\\"Coincidences\\\":35,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.05636070853462158,\\\"JaccardSimilitude\\\":5.64,\\\"Similitud_Levenshtein\\\":39.25233644859813,\\\"LevenshteinSimilitude\\\":39.25,\\\"Similitud_Semantica\\\":0.30487804878048785,\\\"SemanticSimilitude\\\":30.49},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.10961214165261383,\\\"JaccardSimilitude\\\":10.96,\\\"Similitud_Levenshtein\\\":52.991452991452995,\\\"LevenshteinSimilitude\\\":52.99,\\\"Similitud_Semantica\\\":0.426829268292683,\\\"SemanticSimilitude\\\":42.68},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.10046367851622875,\\\"JaccardSimilitude\\\":10.05,\\\"Similitud_Levenshtein\\\":10.75268817204301,\\\"LevenshteinSimilitude\\\":10.75,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.0978120978120978,\\\"JaccardSimilitude\\\":9.78,\\\"Similitud_Levenshtein\\\":27.522935779816514,\\\"LevenshteinSimilitude\\\":27.52,\\\"Similitud_Semantica\\\":0.3292682926829268,\\\"SemanticSimilitude\\\":32.93},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.10355987055016182,\\\"JaccardSimilitude\\\":10.36,\\\"Similitud_Levenshtein\\\":12.903225806451612,\\\"LevenshteinSimilitude\\\":12.9,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":70,\\\"Coincidences\\\":70,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.09497964721845319,\\\"JaccardSimilitude\\\":9.5,\\\"Similitud_Levenshtein\\\":28.82882882882883,\\\"LevenshteinSimilitude\\\":28.83,\\\"Similitud_Semantica\\\":0.35365853658536583,\\\"SemanticSimilitude\\\":35.37},{\\\"Coincidencias\\\":75,\\\"Coincidences\\\":75,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13636363636363635,\\\"JaccardSimilitude\\\":13.64,\\\"Similitud_Levenshtein\\\":7.6923076923076925,\\\"LevenshteinSimilitude\\\":7.69,\\\"Similitud_Semantica\\\":0.1711711711711712,\\\"SemanticSimilitude\\\":17.12},{\\\"Coincidencias\\\":26,\\\"Coincidences\\\":26,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.07386363636363637,\\\"JaccardSimilitude\\\":7.39,\\\"Similitud_Levenshtein\\\":30.88235294117647,\\\"LevenshteinSimilitude\\\":30.88,\\\"Similitud_Semantica\\\":0.22522522522522526,\\\"SemanticSimilitude\\\":22.52},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.20253164556962025,\\\"JaccardSimilitude\\\":20.25,\\\"Similitud_Levenshtein\\\":42.465753424657535,\\\"LevenshteinSimilitude\\\":42.47,\\\"Similitud_Semantica\\\":0.3153153153153153,\\\"SemanticSimilitude\\\":31.53},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.16981132075471697,\\\"JaccardSimilitude\\\":16.98,\\\"Similitud_Levenshtein\\\":6.557377049180328,\\\"LevenshteinSimilitude\\\":6.56,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":66,\\\"Coincidences\\\":66,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12966601178781925,\\\"JaccardSimilitude\\\":12.97,\\\"Similitud_Levenshtein\\\":20.28985507246377,\\\"LevenshteinSimilitude\\\":20.29,\\\"Similitud_Semantica\\\":0.2432432432432432,\\\"SemanticSimilitude\\\":24.32},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.1744186046511628,\\\"JaccardSimilitude\\\":17.44,\\\"Similitud_Levenshtein\\\":9.836065573770492,\\\"LevenshteinSimilitude\\\":9.84,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.1351931330472103,\\\"JaccardSimilitude\\\":13.52,\\\"Similitud_Levenshtein\\\":22.857142857142858,\\\"LevenshteinSimilitude\\\":22.86,\\\"Similitud_Semantica\\\":0.26126126126126126,\\\"SemanticSimilitude\\\":26.13}]},\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\":{\\\"Id\\\":\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\",\\\"FirstName\\\":\\\"August\\\",\\\"LastName\\\":\\\"von Kageneck\\\",\\\"SubmissionId\\\":\\\"6252ac2f-e197-4ec3-821f-56ef3dffc72c\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/0dc6fsdf99a0-6033-4bb6-b46c-15d238277749\\\",\\\"Codes\\\":{},\\\"State\\\":1,\\\"PlagiResults\\\":[]}}\"]", "ParameterTypes": "[\"System.Guid, mscorlib\",\"System.String\",\"System.Collections.Generic.Dictionary`2[[System.Guid, mscorlib],[PlagiTracker.Services.SeleniumServices.StudentSubmission, PlagiTracker.Services]], mscorlib\"]"}', '["\"ac85b4e5-33ea-4d2c-a281-f7ec41da15f7\"", "\"{\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\":{\\\"Id\\\":\\\"1979d2a7-de35-4d83-9aa9-857171cba7fa\\\",\\\"FirstName\\\":\\\"Pedro\\\",\\\"LastName\\\":\\\"Picapiedra\\\",\\\"SubmissionId\\\":\\\"bd755547-68fc-4094-8f87-8b65797d668e\\\",\\\"Url\\\":\\\"https://www.covid.io/p/0dc699a0-6033-4bb6-b46c-15d238277749\\\",\\\"Codes\\\":{},\\\"State\\\":2,\\\"PlagiResults\\\":[]},\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\":{\\\"Id\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"FirstName\\\":\\\"Ben\\\",\\\"LastName\\\":\\\"Tennyson\\\",\\\"SubmissionId\\\":\\\"6e701991-2a14-4493-a170-f4fe910e9c4a\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700\\\",\\\"Codes\\\":{\\\"Calculadora.java\\\":\\\"package com.example;\\\\n\\\\npublic class Calculadora {\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\nif (denominador == 0) {\\\\nthrow new DivisionPorCeroException(\\\\\\\"Error: División por cero no permitida.\\\\\\\");\\\\n}\\\\nreturn (double) numerador / denominador;\\\\n}\\\\n\\\\npublic static void main(String[] args) {\\\\ntry {\\\\nSystem.out.println(\\\\\\\"Resultado: \\\\\\\" + dividir(10, 0));\\\\n} catch (DivisionPorCeroException e) {\\\\nSystem.err.println(e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\",\\\"DivisionPorCeroException.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\npublic class DivisionPorCeroException extends Exception {\\\\npublic DivisionPorCeroException(String mensaje) {\\\\nsuper(mensaje);\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\nclass Main {\\\\n\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello World!\\\\\\\");\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":82,\\\"Coincidences\\\":82,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.3942307692307692,\\\"JaccardSimilitude\\\":39.42,\\\"Similitud_Levenshtein\\\":26.08695652173913,\\\"LevenshteinSimilitude\\\":26.09,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.2676470588235294,\\\"JaccardSimilitude\\\":26.76,\\\"Similitud_Levenshtein\\\":51.61290322580645,\\\"LevenshteinSimilitude\\\":51.61,\\\"Similitud_Semantica\\\":0.7714285714285715,\\\"SemanticSimilitude\\\":77.14},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.5384615384615384,\\\"JaccardSimilitude\\\":53.85,\\\"Similitud_Levenshtein\\\":30.434782608695656,\\\"LevenshteinSimilitude\\\":30.43,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":95,\\\"Coincidences\\\":95,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.3275862068965517,\\\"JaccardSimilitude\\\":32.76,\\\"Similitud_Levenshtein\\\":56.25,\\\"LevenshteinSimilitude\\\":56.25,\\\"Similitud_Semantica\\\":0.8285714285714285,\\\"SemanticSimilitude\\\":82.86},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1393258426966292,\\\"JaccardSimilitude\\\":13.93,\\\"Similitud_Levenshtein\\\":19.047619047619047,\\\"LevenshteinSimilitude\\\":19.05,\\\"Similitud_Semantica\\\":0.8,\\\"SemanticSimilitude\\\":80.0},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09494640122511486,\\\"JaccardSimilitude\\\":9.49,\\\"Similitud_Levenshtein\\\":68.88888888888889,\\\"LevenshteinSimilitude\\\":68.89,\\\"Similitud_Semantica\\\":0.6363636363636364,\\\"SemanticSimilitude\\\":63.64},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10961214165261383,\\\"JaccardSimilitude\\\":10.96,\\\"Similitud_Levenshtein\\\":54.700854700854705,\\\"LevenshteinSimilitude\\\":54.7,\\\"Similitud_Semantica\\\":0.426829268292683,\\\"SemanticSimilitude\\\":42.68},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.20253164556962025,\\\"JaccardSimilitude\\\":20.25,\\\"Similitud_Levenshtein\\\":42.465753424657535,\\\"LevenshteinSimilitude\\\":42.47,\\\"Similitud_Semantica\\\":0.3153153153153153,\\\"SemanticSimilitude\\\":31.53},{\\\"Coincidencias\\\":80,\\\"Coincidences\\\":80,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.17582417582417584,\\\"JaccardSimilitude\\\":17.58,\\\"Similitud_Levenshtein\\\":33.33333333333333,\\\"LevenshteinSimilitude\\\":33.33,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":88,\\\"Coincidences\\\":88,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.14965986394557823,\\\"JaccardSimilitude\\\":14.97,\\\"Similitud_Levenshtein\\\":21.73913043478261,\\\"LevenshteinSimilitude\\\":21.74,\\\"Similitud_Semantica\\\":0.7037037037037037,\\\"SemanticSimilitude\\\":70.37},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.17715617715617715,\\\"JaccardSimilitude\\\":17.72,\\\"Similitud_Levenshtein\\\":40.0,\\\"LevenshteinSimilitude\\\":40.0,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":78,\\\"Coincidences\\\":78,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.14130434782608695,\\\"JaccardSimilitude\\\":14.13,\\\"Similitud_Levenshtein\\\":20.833333333333336,\\\"LevenshteinSimilitude\\\":20.83,\\\"Similitud_Semantica\\\":0.6551724137931034,\\\"SemanticSimilitude\\\":65.52},{\\\"Coincidencias\\\":343,\\\"Coincidences\\\":343,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.8386308068459658,\\\"JaccardSimilitude\\\":83.86,\\\"Similitud_Levenshtein\\\":76.59574468085107,\\\"LevenshteinSimilitude\\\":76.6,\\\"Similitud_Semantica\\\":0.6785714285714286,\\\"SemanticSimilitude\\\":67.86},{\\\"Coincidencias\\\":85,\\\"Coincidences\\\":85,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09714285714285714,\\\"JaccardSimilitude\\\":9.71,\\\"Similitud_Levenshtein\\\":18.91891891891892,\\\"LevenshteinSimilitude\\\":18.92,\\\"Similitud_Semantica\\\":0.34545454545454546,\\\"SemanticSimilitude\\\":34.55},{\\\"Coincidencias\\\":130,\\\"Coincidences\\\":130,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.16817593790426907,\\\"JaccardSimilitude\\\":16.82,\\\"Similitud_Levenshtein\\\":13.861386138613863,\\\"LevenshteinSimilitude\\\":13.86,\\\"Similitud_Semantica\\\":0.23170731707317072,\\\"SemanticSimilitude\\\":23.17},{\\\"Coincidencias\\\":75,\\\"Coincidences\\\":75,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.13636363636363635,\\\"JaccardSimilitude\\\":13.64,\\\"Similitud_Levenshtein\\\":7.6923076923076925,\\\"LevenshteinSimilitude\\\":7.69,\\\"Similitud_Semantica\\\":0.1711711711711712,\\\"SemanticSimilitude\\\":17.12},{\\\"Coincidencias\\\":34,\\\"Coincidences\\\":34,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.13385826771653545,\\\"JaccardSimilitude\\\":13.39,\\\"Similitud_Levenshtein\\\":27.77777777777778,\\\"LevenshteinSimilitude\\\":27.78,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":47,\\\"Coincidences\\\":47,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12303664921465969,\\\"JaccardSimilitude\\\":12.3,\\\"Similitud_Levenshtein\\\":57.692307692307686,\\\"LevenshteinSimilitude\\\":57.69,\\\"Similitud_Semantica\\\":0.9259259259259259,\\\"SemanticSimilitude\\\":92.59},{\\\"Coincidencias\\\":31,\\\"Coincidences\\\":31,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.13656387665198239,\\\"JaccardSimilitude\\\":13.66,\\\"Similitud_Levenshtein\\\":22.22222222222222,\\\"LevenshteinSimilitude\\\":22.22,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":40,\\\"Coincidences\\\":40,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.11661807580174927,\\\"JaccardSimilitude\\\":11.66,\\\"Similitud_Levenshtein\\\":55.55555555555556,\\\"LevenshteinSimilitude\\\":55.56,\\\"Similitud_Semantica\\\":0.8620689655172413,\\\"SemanticSimilitude\\\":86.21},{\\\"Coincidencias\\\":92,\\\"Coincidences\\\":92,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.22276029055690072,\\\"JaccardSimilitude\\\":22.28,\\\"Similitud_Levenshtein\\\":22.641509433962266,\\\"LevenshteinSimilitude\\\":22.64,\\\"Similitud_Semantica\\\":0.8928571428571429,\\\"SemanticSimilitude\\\":89.29},{\\\"Coincidencias\\\":25,\\\"Coincidences\\\":25,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.036337209302325583,\\\"JaccardSimilitude\\\":3.63,\\\"Similitud_Levenshtein\\\":52.5,\\\"LevenshteinSimilitude\\\":52.5,\\\"Similitud_Semantica\\\":0.4545454545454546,\\\"SemanticSimilitude\\\":45.45},{\\\"Coincidencias\\\":35,\\\"Coincidences\\\":35,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.05636070853462158,\\\"JaccardSimilitude\\\":5.64,\\\"Similitud_Levenshtein\\\":39.25233644859813,\\\"LevenshteinSimilitude\\\":39.25,\\\"Similitud_Semantica\\\":0.30487804878048785,\\\"SemanticSimilitude\\\":30.49},{\\\"Coincidencias\\\":26,\\\"Coincidences\\\":26,\\\"Nombre1\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName1\\\":\\\"DivisionPorCeroException.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId1\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.07386363636363637,\\\"JaccardSimilitude\\\":7.39,\\\"Similitud_Levenshtein\\\":30.88235294117647,\\\"LevenshteinSimilitude\\\":30.88,\\\"Similitud_Semantica\\\":0.22522522522522526,\\\"SemanticSimilitude\\\":22.52}]},\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\":{\\\"Id\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"FirstName\\\":\\\"Khvicha\\\",\\\"LastName\\\":\\\"Kvaratskhelia\\\",\\\"SubmissionId\\\":\\\"31edb16a-feb4-4cab-812c-e8a4bdb6ad45\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee\\\",\\\"Codes\\\":{\\\"HelloCodiva.java\\\":\\\"\\\\npackage com.example;\\\\n\\\\nclass HelloCodiva {\\\\npublic static void main(String[] args) {\\\\nint a = 15;\\\\nint b = 20; // will generate an error\\\\nint c = 654;\\\\nSystem.out.println(a+b+c);\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\npublic class Main {\\\\npublic static void main(String[] args) {\\\\nint myNum = 5;               // integer (whole number)\\\\nfloat myFloatNum = 5.99f;    // floating point number\\\\nchar myLetter = ''D'';         // character\\\\nboolean myBool = true;       // boolean\\\\nString myText = \\\\\\\"Hello\\\\\\\";     // String\\\\nSystem.out.println(myNum);\\\\nSystem.out.println(myFloatNum);\\\\nSystem.out.println(myLetter);\\\\nSystem.out.println(myBool);\\\\nSystem.out.println(myText);\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":88,\\\"Coincidences\\\":88,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.14965986394557823,\\\"JaccardSimilitude\\\":14.97,\\\"Similitud_Levenshtein\\\":21.73913043478261,\\\"LevenshteinSimilitude\\\":21.74,\\\"Similitud_Semantica\\\":0.7037037037037037,\\\"SemanticSimilitude\\\":70.37},{\\\"Coincidencias\\\":47,\\\"Coincidences\\\":47,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.12303664921465969,\\\"JaccardSimilitude\\\":12.3,\\\"Similitud_Levenshtein\\\":57.692307692307686,\\\"LevenshteinSimilitude\\\":57.69,\\\"Similitud_Semantica\\\":0.9259259259259259,\\\"SemanticSimilitude\\\":92.59},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.2676470588235294,\\\"JaccardSimilitude\\\":26.76,\\\"Similitud_Levenshtein\\\":51.61290322580645,\\\"LevenshteinSimilitude\\\":51.61,\\\"Similitud_Semantica\\\":0.7714285714285715,\\\"SemanticSimilitude\\\":77.14},{\\\"Coincidencias\\\":84,\\\"Coincidences\\\":84,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.22641509433962265,\\\"JaccardSimilitude\\\":22.64,\\\"Similitud_Levenshtein\\\":26.31578947368421,\\\"LevenshteinSimilitude\\\":26.32,\\\"Similitud_Semantica\\\":0.40740740740740744,\\\"SemanticSimilitude\\\":40.74},{\\\"Coincidencias\\\":247,\\\"Coincidences\\\":247,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.7417417417417418,\\\"JaccardSimilitude\\\":74.17,\\\"Similitud_Levenshtein\\\":85.71428571428571,\\\"LevenshteinSimilitude\\\":85.71,\\\"Similitud_Semantica\\\":0.9310344827586207,\\\"SemanticSimilitude\\\":93.1},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.11428571428571428,\\\"JaccardSimilitude\\\":11.43,\\\"Similitud_Levenshtein\\\":21.818181818181817,\\\"LevenshteinSimilitude\\\":21.82,\\\"Similitud_Semantica\\\":0.9642857142857143,\\\"SemanticSimilitude\\\":96.43},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08591885441527446,\\\"JaccardSimilitude\\\":8.59,\\\"Similitud_Levenshtein\\\":36.58536585365854,\\\"LevenshteinSimilitude\\\":36.59,\\\"Similitud_Semantica\\\":0.49090909090909096,\\\"SemanticSimilitude\\\":49.09},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.0978120978120978,\\\"JaccardSimilitude\\\":9.78,\\\"Similitud_Levenshtein\\\":27.522935779816514,\\\"LevenshteinSimilitude\\\":27.52,\\\"Similitud_Semantica\\\":0.3292682926829268,\\\"SemanticSimilitude\\\":32.93},{\\\"Coincidencias\\\":66,\\\"Coincidences\\\":66,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.12966601178781925,\\\"JaccardSimilitude\\\":12.97,\\\"Similitud_Levenshtein\\\":20.28985507246377,\\\"LevenshteinSimilitude\\\":20.29,\\\"Similitud_Semantica\\\":0.2432432432432432,\\\"SemanticSimilitude\\\":24.32},{\\\"Coincidencias\\\":80,\\\"Coincidences\\\":80,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.17582417582417584,\\\"JaccardSimilitude\\\":17.58,\\\"Similitud_Levenshtein\\\":33.33333333333333,\\\"LevenshteinSimilitude\\\":33.33,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":34,\\\"Coincidences\\\":34,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13385826771653545,\\\"JaccardSimilitude\\\":13.39,\\\"Similitud_Levenshtein\\\":27.77777777777778,\\\"LevenshteinSimilitude\\\":27.78,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":82,\\\"Coincidences\\\":82,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.3942307692307692,\\\"JaccardSimilitude\\\":39.42,\\\"Similitud_Levenshtein\\\":26.08695652173913,\\\"LevenshteinSimilitude\\\":26.09,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":94,\\\"Coincidences\\\":94,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.42727272727272725,\\\"JaccardSimilitude\\\":42.73,\\\"Similitud_Levenshtein\\\":54.54545454545454,\\\"LevenshteinSimilitude\\\":54.55,\\\"Similitud_Semantica\\\":1.0,\\\"SemanticSimilitude\\\":100.0},{\\\"Coincidencias\\\":86,\\\"Coincidences\\\":86,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.24362606232294617,\\\"JaccardSimilitude\\\":24.36,\\\"Similitud_Levenshtein\\\":30.0,\\\"LevenshteinSimilitude\\\":30.0,\\\"Similitud_Semantica\\\":0.3793103448275862,\\\"SemanticSimilitude\\\":37.93},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.12424849699398798,\\\"JaccardSimilitude\\\":12.42,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":61,\\\"Coincidences\\\":61,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08615819209039548,\\\"JaccardSimilitude\\\":8.62,\\\"Similitud_Levenshtein\\\":15.151515151515152,\\\"LevenshteinSimilitude\\\":15.15,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10046367851622875,\\\"JaccardSimilitude\\\":10.05,\\\"Similitud_Levenshtein\\\":10.75268817204301,\\\"LevenshteinSimilitude\\\":10.75,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId1\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.16981132075471697,\\\"JaccardSimilitude\\\":16.98,\\\"Similitud_Levenshtein\\\":6.557377049180328,\\\"LevenshteinSimilitude\\\":6.56,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91}]},\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\":{\\\"Id\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"FirstName\\\":\\\"Khabib \\\",\\\"LastName\\\":\\\"Nurmagomedov\\\",\\\"SubmissionId\\\":\\\"e0d30fd2-1027-4af3-be3b-238a579dacb8\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8\\\",\\\"Codes\\\":{\\\"HelloCodiva.java\\\":\\\"package com.example;\\\\n\\\\nclass HelloCodiva {\\\\n\\\\npublic static void main(String[] args) {\\\\n\\\\nString greeting = \\\\\\\"Hello World\\\\\\\";\\\\nSystem.out.println(greeting);\\\\n\\\\n}\\\\n}\\\\n\\\",\\\"Main.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\npackage com.example;\\\\n\\\\nclass Main {\\\\npublic static void main(String[] args) {\\\\nchar myLetter = ''D'';         // character\\\\nboolean myBool = true;       // boolean\\\\nString myText = \\\\\\\"Hello\\\\\\\";     // String\\\\n\\\\nint myNum = 5;\\\\nfloat myFloatNum = 5.99f;\\\\n\\\\nSystem.out.println(myNum);\\\\nSystem.out.println(myFloatNum);\\\\nSystem.out.println(myLetter);\\\\nSystem.out.println(myBool);\\\\nSystem.out.println(myText);\\\\n}\\\\n}\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.17715617715617715,\\\"JaccardSimilitude\\\":17.72,\\\"Similitud_Levenshtein\\\":40.0,\\\"LevenshteinSimilitude\\\":40.0,\\\"Similitud_Semantica\\\":0.5789473684210527,\\\"SemanticSimilitude\\\":57.89},{\\\"Coincidencias\\\":31,\\\"Coincidences\\\":31,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13656387665198239,\\\"JaccardSimilitude\\\":13.66,\\\"Similitud_Levenshtein\\\":22.22222222222222,\\\"LevenshteinSimilitude\\\":22.22,\\\"Similitud_Semantica\\\":0.43999999999999995,\\\"SemanticSimilitude\\\":44.0},{\\\"Coincidencias\\\":91,\\\"Coincidences\\\":91,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.5384615384615384,\\\"JaccardSimilitude\\\":53.85,\\\"Similitud_Levenshtein\\\":30.434782608695656,\\\"LevenshteinSimilitude\\\":30.43,\\\"Similitud_Semantica\\\":0.3142857142857143,\\\"SemanticSimilitude\\\":31.43},{\\\"Coincidencias\\\":94,\\\"Coincidences\\\":94,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.42727272727272725,\\\"JaccardSimilitude\\\":42.73,\\\"Similitud_Levenshtein\\\":54.54545454545454,\\\"LevenshteinSimilitude\\\":54.55,\\\"Similitud_Semantica\\\":1.0,\\\"SemanticSimilitude\\\":100.0},{\\\"Coincidencias\\\":84,\\\"Coincidences\\\":84,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.22641509433962265,\\\"JaccardSimilitude\\\":22.64,\\\"Similitud_Levenshtein\\\":26.31578947368421,\\\"LevenshteinSimilitude\\\":26.32,\\\"Similitud_Semantica\\\":0.40740740740740744,\\\"SemanticSimilitude\\\":40.74},{\\\"Coincidencias\\\":59,\\\"Coincidences\\\":59,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.125,\\\"JaccardSimilitude\\\":12.5,\\\"Similitud_Levenshtein\\\":25.64102564102564,\\\"LevenshteinSimilitude\\\":25.64,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08836524300441827,\\\"JaccardSimilitude\\\":8.84,\\\"Similitud_Levenshtein\\\":21.21212121212121,\\\"LevenshteinSimilitude\\\":21.21,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10355987055016182,\\\"JaccardSimilitude\\\":10.36,\\\"Similitud_Levenshtein\\\":15.053763440860216,\\\"LevenshteinSimilitude\\\":15.05,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"HelloCodiva.java\\\",\\\"FileName1\\\":\\\"HelloCodiva.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1744186046511628,\\\"JaccardSimilitude\\\":17.44,\\\"Similitud_Levenshtein\\\":9.836065573770492,\\\"LevenshteinSimilitude\\\":9.84,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":78,\\\"Coincidences\\\":78,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.14130434782608695,\\\"JaccardSimilitude\\\":14.13,\\\"Similitud_Levenshtein\\\":20.833333333333336,\\\"LevenshteinSimilitude\\\":20.83,\\\"Similitud_Semantica\\\":0.6551724137931034,\\\"SemanticSimilitude\\\":65.52},{\\\"Coincidencias\\\":40,\\\"Coincidences\\\":40,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.11661807580174927,\\\"JaccardSimilitude\\\":11.66,\\\"Similitud_Levenshtein\\\":55.55555555555556,\\\"LevenshteinSimilitude\\\":55.56,\\\"Similitud_Semantica\\\":0.8620689655172413,\\\"SemanticSimilitude\\\":86.21},{\\\"Coincidencias\\\":95,\\\"Coincidences\\\":95,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.3275862068965517,\\\"JaccardSimilitude\\\":32.76,\\\"Similitud_Levenshtein\\\":56.25,\\\"LevenshteinSimilitude\\\":56.25,\\\"Similitud_Semantica\\\":0.8285714285714285,\\\"SemanticSimilitude\\\":82.86},{\\\"Coincidencias\\\":86,\\\"Coincidences\\\":86,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.24362606232294617,\\\"JaccardSimilitude\\\":24.36,\\\"Similitud_Levenshtein\\\":30.0,\\\"LevenshteinSimilitude\\\":30.0,\\\"Similitud_Semantica\\\":0.3793103448275862,\\\"SemanticSimilitude\\\":37.93},{\\\"Coincidencias\\\":247,\\\"Coincidences\\\":247,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.7417417417417418,\\\"JaccardSimilitude\\\":74.17,\\\"Similitud_Levenshtein\\\":85.71428571428571,\\\"LevenshteinSimilitude\\\":85.71,\\\"Similitud_Semantica\\\":0.9310344827586207,\\\"SemanticSimilitude\\\":93.1},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.10810810810810811,\\\"JaccardSimilitude\\\":10.81,\\\"Similitud_Levenshtein\\\":21.052631578947366,\\\"LevenshteinSimilitude\\\":21.05,\\\"Similitud_Semantica\\\":0.9655172413793104,\\\"SemanticSimilitude\\\":96.55},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"Diccionario.java\\\",\\\"FileName2\\\":\\\"Diccionario.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.08135168961201501,\\\"JaccardSimilitude\\\":8.14,\\\"Similitud_Levenshtein\\\":40.476190476190474,\\\"LevenshteinSimilitude\\\":40.48,\\\"Similitud_Semantica\\\":0.5272727272727273,\\\"SemanticSimilitude\\\":52.73},{\\\"Coincidencias\\\":70,\\\"Coincidences\\\":70,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"FileHandler.java\\\",\\\"FileName2\\\":\\\"FileHandler.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.09497964721845319,\\\"JaccardSimilitude\\\":9.5,\\\"Similitud_Levenshtein\\\":30.630630630630627,\\\"LevenshteinSimilitude\\\":30.63,\\\"Similitud_Semantica\\\":0.35365853658536583,\\\"SemanticSimilitude\\\":35.37},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"Main.java\\\",\\\"FileName1\\\":\\\"Main.java\\\",\\\"Nombre2\\\":\\\"TestAnimales.java\\\",\\\"FileName2\\\":\\\"TestAnimales.java\\\",\\\"Usuario_Id1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId1\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Usuario_Id2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId2\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Similitud_Jaccard\\\":0.1351931330472103,\\\"JaccardSimilitude\\\":13.52,\\\"Similitud_Levenshtein\\\":22.857142857142858,\\\"LevenshteinSimilitude\\\":22.86,\\\"Similitud_Semantica\\\":0.26126126126126126,\\\"SemanticSimilitude\\\":26.13}]},\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\":{\\\"Id\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"FirstName\\\":\\\"Ramzan\\\",\\\"LastName\\\":\\\"Kadyrov\\\",\\\"SubmissionId\\\":\\\"b6c2d5e1-33c4-4048-820b-03d25fe674b9\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3\\\",\\\"Codes\\\":{\\\"Calculadora.java\\\":\\\"class DivisionPorCeroException extends Exception {\\\\npublic DivisionPorCeroException(String mensaje) {\\\\nsuper(mensaje);\\\\n}\\\\n}\\\\n\\\\npublic class Calculadora {\\\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\\\nif (denominador == 0) {\\\\nthrow new DivisionPorCeroException(\\\\\\\"Error: División por cero no permitida.\\\\\\\");\\\\n}\\\\nreturn (double) numerador / denominador;\\\\n}\\\\n\\\\npublic static void main(String[] args) {\\\\ntry {\\\\nSystem.out.println(\\\\\\\"Resultado: \\\\\\\" + dividir(10, 0));\\\\n} catch (DivisionPorCeroException e) {\\\\nSystem.err.println(e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\",\\\"Diccionario.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nimport java.util.HashMap;\\\\n\\\\npublic class Diccionario {\\\\npublic static void main(String[] args) {\\\\n// Crear un HashMap para almacenar palabras y sus definiciones\\\\nHashMap<String, String> diccionario = new HashMap<>();\\\\n\\\\n// Añadir elementos al diccionario\\\\ndiccionario.put(\\\\\\\"Java\\\\\\\", \\\\\\\"Lenguaje de programación orientado a objetos.\\\\\\\");\\\\ndiccionario.put(\\\\\\\"Python\\\\\\\", \\\\\\\"Lenguaje de programación de alto nivel.\\\\\\\");\\\\ndiccionario.put(\\\\\\\"HTML\\\\\\\", \\\\\\\"Lenguaje de marcado para crear páginas web.\\\\\\\");\\\\n\\\\n// Buscar y mostrar una definición\\\\nString palabra = \\\\\\\"Java\\\\\\\";\\\\nif (diccionario.containsKey(palabra)) {\\\\nSystem.out.println(palabra + \\\\\\\": \\\\\\\" + diccionario.get(palabra));\\\\n} else {\\\\nSystem.out.println(\\\\\\\"Palabra no encontrada en el diccionario.\\\\\\\");\\\\n}\\\\n\\\\n// Mostrar todas las palabras en el diccionario\\\\nSystem.out.println(\\\\\\\"\\\\\\\\nPalabras en el diccionario:\\\\\\\");\\\\nfor (String key : diccionario.keySet()) {\\\\nSystem.out.println(key + \\\\\\\": \\\\\\\" + diccionario.get(key));\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\",\\\"FileHandler.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nimport java.io.*;\\\\n\\\\npublic class FileHandler {\\\\npublic static void main(String[] args) {\\\\nString fileName = \\\\\\\"example.txt\\\\\\\";\\\\n\\\\n// Escribir en un archivo\\\\ntry (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {\\\\nwriter.write(\\\\\\\"Este es un ejemplo de escritura en archivo.\\\\\\\");\\\\nwriter.newLine();\\\\nwriter.write(\\\\\\\"Java es genial para manejar archivos.\\\\\\\");\\\\nSystem.out.println(\\\\\\\"Escritura en archivo completada.\\\\\\\");\\\\n} catch (IOException e) {\\\\nSystem.err.println(\\\\\\\"Error al escribir en el archivo: \\\\\\\" + e.getMessage());\\\\n}\\\\n\\\\n// Leer desde un archivo\\\\ntry (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {\\\\nString line;\\\\nwhile ((line = reader.readLine()) != null) {\\\\nSystem.out.println(\\\\\\\"Contenido del archivo: \\\\\\\" + line);\\\\n}\\\\n} catch (IOException e) {\\\\nSystem.err.println(\\\\\\\"Error al leer el archivo: \\\\\\\" + e.getMessage());\\\\n}\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\\n\\\",\\\"TestAnimales.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass Animal {\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El animal hace un sonido\\\\\\\");\\\\n}\\\\n}\\\\n\\\\nclass Perro extends Animal {\\\\n@Override\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El perro ladra\\\\\\\");\\\\n}\\\\n}\\\\n\\\\nclass Gato extends Animal {\\\\n@Override\\\\npublic void sonido() {\\\\nSystem.out.println(\\\\\\\"El gato maúlla\\\\\\\");\\\\n}\\\\n}\\\\n\\\\npublic class TestAnimales {\\\\npublic static void main(String[] args) {\\\\nAnimal miPerro = new Perro();\\\\nAnimal miGato = new Gato();\\\\n\\\\nmiPerro.sonido();\\\\nmiGato.sonido();\\\\n}\\\\n}\\\\n\\\\n\\\\n\\\",\\\"asf.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass asf {\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello Codiva\\\\\\\");\\\\n\\\\n}\\\\n}\\\\n\\\\n\\\",\\\"asfsadasd.java\\\":\\\"\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\n\\\\nclass asfsadasd {\\\\npublic static void main(String[] args) {\\\\n\\\\nSystem.out.println(\\\\\\\"Hello Codiva\\\\\\\");\\\\n\\\\n}\\\\n}\\\\n\\\"},\\\"State\\\":3,\\\"PlagiResults\\\":[{\\\"Coincidencias\\\":343,\\\"Coincidences\\\":343,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.8386308068459658,\\\"JaccardSimilitude\\\":83.86,\\\"Similitud_Levenshtein\\\":76.59574468085107,\\\"LevenshteinSimilitude\\\":76.6,\\\"Similitud_Semantica\\\":0.6785714285714286,\\\"SemanticSimilitude\\\":67.86},{\\\"Coincidencias\\\":92,\\\"Coincidences\\\":92,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.22276029055690072,\\\"JaccardSimilitude\\\":22.28,\\\"Similitud_Levenshtein\\\":22.641509433962266,\\\"LevenshteinSimilitude\\\":22.64,\\\"Similitud_Semantica\\\":0.8928571428571429,\\\"SemanticSimilitude\\\":89.29},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.1393258426966292,\\\"JaccardSimilitude\\\":13.93,\\\"Similitud_Levenshtein\\\":19.047619047619047,\\\"LevenshteinSimilitude\\\":19.05,\\\"Similitud_Semantica\\\":0.8,\\\"SemanticSimilitude\\\":80.0},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12424849699398798,\\\"JaccardSimilitude\\\":12.42,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.11428571428571428,\\\"JaccardSimilitude\\\":11.43,\\\"Similitud_Levenshtein\\\":21.818181818181817,\\\"LevenshteinSimilitude\\\":21.82,\\\"Similitud_Semantica\\\":0.9642857142857143,\\\"SemanticSimilitude\\\":96.43},{\\\"Coincidencias\\\":59,\\\"Coincidences\\\":59,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.125,\\\"JaccardSimilitude\\\":12.5,\\\"Similitud_Levenshtein\\\":10.256410256410255,\\\"LevenshteinSimilitude\\\":10.26,\\\"Similitud_Semantica\\\":0.3928571428571429,\\\"SemanticSimilitude\\\":39.29},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"Calculadora.java\\\",\\\"FileName1\\\":\\\"Calculadora.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.10810810810810811,\\\"JaccardSimilitude\\\":10.81,\\\"Similitud_Levenshtein\\\":21.052631578947366,\\\"LevenshteinSimilitude\\\":21.05,\\\"Similitud_Semantica\\\":0.9655172413793104,\\\"SemanticSimilitude\\\":96.55},{\\\"Coincidencias\\\":85,\\\"Coincidences\\\":85,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.09714285714285714,\\\"JaccardSimilitude\\\":9.71,\\\"Similitud_Levenshtein\\\":18.91891891891892,\\\"LevenshteinSimilitude\\\":18.92,\\\"Similitud_Semantica\\\":0.34545454545454546,\\\"SemanticSimilitude\\\":34.55},{\\\"Coincidencias\\\":25,\\\"Coincidences\\\":25,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.036337209302325583,\\\"JaccardSimilitude\\\":3.63,\\\"Similitud_Levenshtein\\\":52.5,\\\"LevenshteinSimilitude\\\":52.5,\\\"Similitud_Semantica\\\":0.4545454545454546,\\\"SemanticSimilitude\\\":45.45},{\\\"Coincidencias\\\":62,\\\"Coincidences\\\":62,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.09494640122511486,\\\"JaccardSimilitude\\\":9.49,\\\"Similitud_Levenshtein\\\":66.66666666666666,\\\"LevenshteinSimilitude\\\":66.67,\\\"Similitud_Semantica\\\":0.6363636363636364,\\\"SemanticSimilitude\\\":63.64},{\\\"Coincidencias\\\":61,\\\"Coincidences\\\":61,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.08615819209039548,\\\"JaccardSimilitude\\\":8.62,\\\"Similitud_Levenshtein\\\":15.151515151515152,\\\"LevenshteinSimilitude\\\":15.15,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":72,\\\"Coincidences\\\":72,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.08591885441527446,\\\"JaccardSimilitude\\\":8.59,\\\"Similitud_Levenshtein\\\":36.58536585365854,\\\"LevenshteinSimilitude\\\":36.59,\\\"Similitud_Semantica\\\":0.49090909090909096,\\\"SemanticSimilitude\\\":49.09},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.08836524300441827,\\\"JaccardSimilitude\\\":8.84,\\\"Similitud_Levenshtein\\\":18.181818181818183,\\\"LevenshteinSimilitude\\\":18.18,\\\"Similitud_Semantica\\\":0.19999999999999996,\\\"SemanticSimilitude\\\":20.0},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"Diccionario.java\\\",\\\"FileName1\\\":\\\"Diccionario.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.08135168961201501,\\\"JaccardSimilitude\\\":8.14,\\\"Similitud_Levenshtein\\\":38.095238095238095,\\\"LevenshteinSimilitude\\\":38.1,\\\"Similitud_Semantica\\\":0.5272727272727273,\\\"SemanticSimilitude\\\":52.73},{\\\"Coincidencias\\\":130,\\\"Coincidences\\\":130,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.16817593790426907,\\\"JaccardSimilitude\\\":16.82,\\\"Similitud_Levenshtein\\\":13.861386138613863,\\\"LevenshteinSimilitude\\\":13.86,\\\"Similitud_Semantica\\\":0.23170731707317072,\\\"SemanticSimilitude\\\":23.17},{\\\"Coincidencias\\\":35,\\\"Coincidences\\\":35,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.05636070853462158,\\\"JaccardSimilitude\\\":5.64,\\\"Similitud_Levenshtein\\\":39.25233644859813,\\\"LevenshteinSimilitude\\\":39.25,\\\"Similitud_Semantica\\\":0.30487804878048785,\\\"SemanticSimilitude\\\":30.49},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.10961214165261383,\\\"JaccardSimilitude\\\":10.96,\\\"Similitud_Levenshtein\\\":52.991452991452995,\\\"LevenshteinSimilitude\\\":52.99,\\\"Similitud_Semantica\\\":0.426829268292683,\\\"SemanticSimilitude\\\":42.68},{\\\"Coincidencias\\\":65,\\\"Coincidences\\\":65,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.10046367851622875,\\\"JaccardSimilitude\\\":10.05,\\\"Similitud_Levenshtein\\\":10.75268817204301,\\\"LevenshteinSimilitude\\\":10.75,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":76,\\\"Coincidences\\\":76,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.0978120978120978,\\\"JaccardSimilitude\\\":9.78,\\\"Similitud_Levenshtein\\\":27.522935779816514,\\\"LevenshteinSimilitude\\\":27.52,\\\"Similitud_Semantica\\\":0.3292682926829268,\\\"SemanticSimilitude\\\":32.93},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.10355987055016182,\\\"JaccardSimilitude\\\":10.36,\\\"Similitud_Levenshtein\\\":12.903225806451612,\\\"LevenshteinSimilitude\\\":12.9,\\\"Similitud_Semantica\\\":0.13414634146341464,\\\"SemanticSimilitude\\\":13.41},{\\\"Coincidencias\\\":70,\\\"Coincidences\\\":70,\\\"Nombre1\\\":\\\"FileHandler.java\\\",\\\"FileName1\\\":\\\"FileHandler.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.09497964721845319,\\\"JaccardSimilitude\\\":9.5,\\\"Similitud_Levenshtein\\\":28.82882882882883,\\\"LevenshteinSimilitude\\\":28.83,\\\"Similitud_Semantica\\\":0.35365853658536583,\\\"SemanticSimilitude\\\":35.37},{\\\"Coincidencias\\\":75,\\\"Coincidences\\\":75,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Calculadora.java\\\",\\\"FileName2\\\":\\\"Calculadora.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.13636363636363635,\\\"JaccardSimilitude\\\":13.64,\\\"Similitud_Levenshtein\\\":7.6923076923076925,\\\"LevenshteinSimilitude\\\":7.69,\\\"Similitud_Semantica\\\":0.1711711711711712,\\\"SemanticSimilitude\\\":17.12},{\\\"Coincidencias\\\":26,\\\"Coincidences\\\":26,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"DivisionPorCeroException.java\\\",\\\"FileName2\\\":\\\"DivisionPorCeroException.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.07386363636363637,\\\"JaccardSimilitude\\\":7.39,\\\"Similitud_Levenshtein\\\":30.88235294117647,\\\"LevenshteinSimilitude\\\":30.88,\\\"Similitud_Semantica\\\":0.22522522522522526,\\\"SemanticSimilitude\\\":22.52},{\\\"Coincidencias\\\":64,\\\"Coincidences\\\":64,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"UserId2\\\":\\\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\\\",\\\"Similitud_Jaccard\\\":0.20253164556962025,\\\"JaccardSimilitude\\\":20.25,\\\"Similitud_Levenshtein\\\":42.465753424657535,\\\"LevenshteinSimilitude\\\":42.47,\\\"Similitud_Semantica\\\":0.3153153153153153,\\\"SemanticSimilitude\\\":31.53},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.16981132075471697,\\\"JaccardSimilitude\\\":16.98,\\\"Similitud_Levenshtein\\\":6.557377049180328,\\\"LevenshteinSimilitude\\\":6.56,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":66,\\\"Coincidences\\\":66,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"UserId2\\\":\\\"239e66d0-16c3-4ce4-b321-058b64269f5e\\\",\\\"Similitud_Jaccard\\\":0.12966601178781925,\\\"JaccardSimilitude\\\":12.97,\\\"Similitud_Levenshtein\\\":20.28985507246377,\\\"LevenshteinSimilitude\\\":20.29,\\\"Similitud_Semantica\\\":0.2432432432432432,\\\"SemanticSimilitude\\\":24.32},{\\\"Coincidencias\\\":60,\\\"Coincidences\\\":60,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"HelloCodiva.java\\\",\\\"FileName2\\\":\\\"HelloCodiva.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.1744186046511628,\\\"JaccardSimilitude\\\":17.44,\\\"Similitud_Levenshtein\\\":9.836065573770492,\\\"LevenshteinSimilitude\\\":9.84,\\\"Similitud_Semantica\\\":0.09909909909909909,\\\"SemanticSimilitude\\\":9.91},{\\\"Coincidencias\\\":63,\\\"Coincidences\\\":63,\\\"Nombre1\\\":\\\"TestAnimales.java\\\",\\\"FileName1\\\":\\\"TestAnimales.java\\\",\\\"Nombre2\\\":\\\"Main.java\\\",\\\"FileName2\\\":\\\"Main.java\\\",\\\"Usuario_Id1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"UserId1\\\":\\\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\\\",\\\"Usuario_Id2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"UserId2\\\":\\\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\\\",\\\"Similitud_Jaccard\\\":0.1351931330472103,\\\"JaccardSimilitude\\\":13.52,\\\"Similitud_Levenshtein\\\":22.857142857142858,\\\"LevenshteinSimilitude\\\":22.86,\\\"Similitud_Semantica\\\":0.26126126126126126,\\\"SemanticSimilitude\\\":26.13}]},\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\":{\\\"Id\\\":\\\"e7c43279-2bcc-4c09-9165-b824041166fc\\\",\\\"FirstName\\\":\\\"August\\\",\\\"LastName\\\":\\\"von Kageneck\\\",\\\"SubmissionId\\\":\\\"6252ac2f-e197-4ec3-821f-56ef3dffc72c\\\",\\\"Url\\\":\\\"https://www.codiva.io/p/0dc6fsdf99a0-6033-4bb6-b46c-15d238277749\\\",\\\"Codes\\\":{},\\\"State\\\":1,\\\"PlagiResults\\\":[]}}\"", "{\"1979d2a7-de35-4d83-9aa9-857171cba7fa\":{\"Id\":\"1979d2a7-de35-4d83-9aa9-857171cba7fa\",\"FirstName\":\"Pedro\",\"LastName\":\"Picapiedra\",\"SubmissionId\":\"bd755547-68fc-4094-8f87-8b65797d668e\",\"Url\":\"https://www.covid.io/p/0dc699a0-6033-4bb6-b46c-15d238277749\",\"Codes\":{},\"State\":2,\"PlagiResults\":[]},\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\":{\"Id\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"FirstName\":\"Ben\",\"LastName\":\"Tennyson\",\"SubmissionId\":\"6e701991-2a14-4493-a170-f4fe910e9c4a\",\"Url\":\"https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700\",\"Codes\":{\"Calculadora.java\":\"package com.example;\\n\\npublic class Calculadora {\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\nif (denominador == 0) {\\nthrow new DivisionPorCeroException(\\\"Error: División por cero no permitida.\\\");\\n}\\nreturn (double) numerador / denominador;\\n}\\n\\npublic static void main(String[] args) {\\ntry {\\nSystem.out.println(\\\"Resultado: \\\" + dividir(10, 0));\\n} catch (DivisionPorCeroException e) {\\nSystem.err.println(e.getMessage());\\n}\\n}\\n}\\n\\n\",\"DivisionPorCeroException.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\npublic class DivisionPorCeroException extends Exception {\\npublic DivisionPorCeroException(String mensaje) {\\nsuper(mensaje);\\n}\\n}\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\nclass Main {\\n\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello World!\\\");\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":82,\"Coincidences\":82,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.3942307692307692,\"JaccardSimilitude\":39.42,\"Similitud_Levenshtein\":26.08695652173913,\"LevenshteinSimilitude\":26.09,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.2676470588235294,\"JaccardSimilitude\":26.76,\"Similitud_Levenshtein\":51.61290322580645,\"LevenshteinSimilitude\":51.61,\"Similitud_Semantica\":0.7714285714285715,\"SemanticSimilitude\":77.14},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.5384615384615384,\"JaccardSimilitude\":53.85,\"Similitud_Levenshtein\":30.434782608695656,\"LevenshteinSimilitude\":30.43,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.3275862068965517,\"JaccardSimilitude\":32.76,\"Similitud_Levenshtein\":56.25,\"LevenshteinSimilitude\":56.25,\"Similitud_Semantica\":0.8285714285714285,\"SemanticSimilitude\":82.86},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1393258426966292,\"JaccardSimilitude\":13.93,\"Similitud_Levenshtein\":19.047619047619047,\"LevenshteinSimilitude\":19.05,\"Similitud_Semantica\":0.8,\"SemanticSimilitude\":80.0},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.09494640122511486,\"JaccardSimilitude\":9.49,\"Similitud_Levenshtein\":68.88888888888889,\"LevenshteinSimilitude\":68.89,\"Similitud_Semantica\":0.6363636363636364,\"SemanticSimilitude\":63.64},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10961214165261383,\"JaccardSimilitude\":10.96,\"Similitud_Levenshtein\":54.700854700854705,\"LevenshteinSimilitude\":54.7,\"Similitud_Semantica\":0.426829268292683,\"SemanticSimilitude\":42.68},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.20253164556962025,\"JaccardSimilitude\":20.25,\"Similitud_Levenshtein\":42.465753424657535,\"LevenshteinSimilitude\":42.47,\"Similitud_Semantica\":0.3153153153153153,\"SemanticSimilitude\":31.53},{\"Coincidencias\":80,\"Coincidences\":80,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.17582417582417584,\"JaccardSimilitude\":17.58,\"Similitud_Levenshtein\":33.33333333333333,\"LevenshteinSimilitude\":33.33,\"Similitud_Semantica\":0.5789473684210527,\"SemanticSimilitude\":57.89},{\"Coincidencias\":88,\"Coincidences\":88,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.14965986394557823,\"JaccardSimilitude\":14.97,\"Similitud_Levenshtein\":21.73913043478261,\"LevenshteinSimilitude\":21.74,\"Similitud_Semantica\":0.7037037037037037,\"SemanticSimilitude\":70.37},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.17715617715617715,\"JaccardSimilitude\":17.72,\"Similitud_Levenshtein\":40.0,\"LevenshteinSimilitude\":40.0,\"Similitud_Semantica\":0.5789473684210527,\"SemanticSimilitude\":57.89},{\"Coincidencias\":78,\"Coincidences\":78,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.14130434782608695,\"JaccardSimilitude\":14.13,\"Similitud_Levenshtein\":20.833333333333336,\"LevenshteinSimilitude\":20.83,\"Similitud_Semantica\":0.6551724137931034,\"SemanticSimilitude\":65.52},{\"Coincidencias\":343,\"Coincidences\":343,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.8386308068459658,\"JaccardSimilitude\":83.86,\"Similitud_Levenshtein\":76.59574468085107,\"LevenshteinSimilitude\":76.6,\"Similitud_Semantica\":0.6785714285714286,\"SemanticSimilitude\":67.86},{\"Coincidencias\":85,\"Coincidences\":85,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.09714285714285714,\"JaccardSimilitude\":9.71,\"Similitud_Levenshtein\":18.91891891891892,\"LevenshteinSimilitude\":18.92,\"Similitud_Semantica\":0.34545454545454546,\"SemanticSimilitude\":34.55},{\"Coincidencias\":130,\"Coincidences\":130,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.16817593790426907,\"JaccardSimilitude\":16.82,\"Similitud_Levenshtein\":13.861386138613863,\"LevenshteinSimilitude\":13.86,\"Similitud_Semantica\":0.23170731707317072,\"SemanticSimilitude\":23.17},{\"Coincidencias\":75,\"Coincidences\":75,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.13636363636363635,\"JaccardSimilitude\":13.64,\"Similitud_Levenshtein\":7.6923076923076925,\"LevenshteinSimilitude\":7.69,\"Similitud_Semantica\":0.1711711711711712,\"SemanticSimilitude\":17.12},{\"Coincidencias\":34,\"Coincidences\":34,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.13385826771653545,\"JaccardSimilitude\":13.39,\"Similitud_Levenshtein\":27.77777777777778,\"LevenshteinSimilitude\":27.78,\"Similitud_Semantica\":0.43999999999999995,\"SemanticSimilitude\":44.0},{\"Coincidencias\":47,\"Coincidences\":47,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12303664921465969,\"JaccardSimilitude\":12.3,\"Similitud_Levenshtein\":57.692307692307686,\"LevenshteinSimilitude\":57.69,\"Similitud_Semantica\":0.9259259259259259,\"SemanticSimilitude\":92.59},{\"Coincidencias\":31,\"Coincidences\":31,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.13656387665198239,\"JaccardSimilitude\":13.66,\"Similitud_Levenshtein\":22.22222222222222,\"LevenshteinSimilitude\":22.22,\"Similitud_Semantica\":0.43999999999999995,\"SemanticSimilitude\":44.0},{\"Coincidencias\":40,\"Coincidences\":40,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.11661807580174927,\"JaccardSimilitude\":11.66,\"Similitud_Levenshtein\":55.55555555555556,\"LevenshteinSimilitude\":55.56,\"Similitud_Semantica\":0.8620689655172413,\"SemanticSimilitude\":86.21},{\"Coincidencias\":92,\"Coincidences\":92,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.22276029055690072,\"JaccardSimilitude\":22.28,\"Similitud_Levenshtein\":22.641509433962266,\"LevenshteinSimilitude\":22.64,\"Similitud_Semantica\":0.8928571428571429,\"SemanticSimilitude\":89.29},{\"Coincidencias\":25,\"Coincidences\":25,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.036337209302325583,\"JaccardSimilitude\":3.63,\"Similitud_Levenshtein\":52.5,\"LevenshteinSimilitude\":52.5,\"Similitud_Semantica\":0.4545454545454546,\"SemanticSimilitude\":45.45},{\"Coincidencias\":35,\"Coincidences\":35,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.05636070853462158,\"JaccardSimilitude\":5.64,\"Similitud_Levenshtein\":39.25233644859813,\"LevenshteinSimilitude\":39.25,\"Similitud_Semantica\":0.30487804878048785,\"SemanticSimilitude\":30.49},{\"Coincidencias\":26,\"Coincidences\":26,\"Nombre1\":\"DivisionPorCeroException.java\",\"FileName1\":\"DivisionPorCeroException.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId1\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.07386363636363637,\"JaccardSimilitude\":7.39,\"Similitud_Levenshtein\":30.88235294117647,\"LevenshteinSimilitude\":30.88,\"Similitud_Semantica\":0.22522522522522526,\"SemanticSimilitude\":22.52}]},\"239e66d0-16c3-4ce4-b321-058b64269f5e\":{\"Id\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"FirstName\":\"Khvicha\",\"LastName\":\"Kvaratskhelia\",\"SubmissionId\":\"31edb16a-feb4-4cab-812c-e8a4bdb6ad45\",\"Url\":\"https://www.codiva.io/p/2e48c734-df91-4d02-b9d5-470c9302b6ee\",\"Codes\":{\"HelloCodiva.java\":\"\\npackage com.example;\\n\\nclass HelloCodiva {\\npublic static void main(String[] args) {\\nint a = 15;\\nint b = 20; // will generate an error\\nint c = 654;\\nSystem.out.println(a+b+c);\\n}\\n}\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\npublic class Main {\\npublic static void main(String[] args) {\\nint myNum = 5;               // integer (whole number)\\nfloat myFloatNum = 5.99f;    // floating point number\\nchar myLetter = ''D'';         // character\\nboolean myBool = true;       // boolean\\nString myText = \\\"Hello\\\";     // String\\nSystem.out.println(myNum);\\nSystem.out.println(myFloatNum);\\nSystem.out.println(myLetter);\\nSystem.out.println(myBool);\\nSystem.out.println(myText);\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":88,\"Coincidences\":88,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.14965986394557823,\"JaccardSimilitude\":14.97,\"Similitud_Levenshtein\":21.73913043478261,\"LevenshteinSimilitude\":21.74,\"Similitud_Semantica\":0.7037037037037037,\"SemanticSimilitude\":70.37},{\"Coincidencias\":47,\"Coincidences\":47,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.12303664921465969,\"JaccardSimilitude\":12.3,\"Similitud_Levenshtein\":57.692307692307686,\"LevenshteinSimilitude\":57.69,\"Similitud_Semantica\":0.9259259259259259,\"SemanticSimilitude\":92.59},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.2676470588235294,\"JaccardSimilitude\":26.76,\"Similitud_Levenshtein\":51.61290322580645,\"LevenshteinSimilitude\":51.61,\"Similitud_Semantica\":0.7714285714285715,\"SemanticSimilitude\":77.14},{\"Coincidencias\":84,\"Coincidences\":84,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.22641509433962265,\"JaccardSimilitude\":22.64,\"Similitud_Levenshtein\":26.31578947368421,\"LevenshteinSimilitude\":26.32,\"Similitud_Semantica\":0.40740740740740744,\"SemanticSimilitude\":40.74},{\"Coincidencias\":247,\"Coincidences\":247,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.7417417417417418,\"JaccardSimilitude\":74.17,\"Similitud_Levenshtein\":85.71428571428571,\"LevenshteinSimilitude\":85.71,\"Similitud_Semantica\":0.9310344827586207,\"SemanticSimilitude\":93.1},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.11428571428571428,\"JaccardSimilitude\":11.43,\"Similitud_Levenshtein\":21.818181818181817,\"LevenshteinSimilitude\":21.82,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08591885441527446,\"JaccardSimilitude\":8.59,\"Similitud_Levenshtein\":36.58536585365854,\"LevenshteinSimilitude\":36.59,\"Similitud_Semantica\":0.49090909090909096,\"SemanticSimilitude\":49.09},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.0978120978120978,\"JaccardSimilitude\":9.78,\"Similitud_Levenshtein\":27.522935779816514,\"LevenshteinSimilitude\":27.52,\"Similitud_Semantica\":0.3292682926829268,\"SemanticSimilitude\":32.93},{\"Coincidencias\":66,\"Coincidences\":66,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.12966601178781925,\"JaccardSimilitude\":12.97,\"Similitud_Levenshtein\":20.28985507246377,\"LevenshteinSimilitude\":20.29,\"Similitud_Semantica\":0.2432432432432432,\"SemanticSimilitude\":24.32},{\"Coincidencias\":80,\"Coincidences\":80,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.17582417582417584,\"JaccardSimilitude\":17.58,\"Similitud_Levenshtein\":33.33333333333333,\"LevenshteinSimilitude\":33.33,\"Similitud_Semantica\":0.5789473684210527,\"SemanticSimilitude\":57.89},{\"Coincidencias\":34,\"Coincidences\":34,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.13385826771653545,\"JaccardSimilitude\":13.39,\"Similitud_Levenshtein\":27.77777777777778,\"LevenshteinSimilitude\":27.78,\"Similitud_Semantica\":0.43999999999999995,\"SemanticSimilitude\":44.0},{\"Coincidencias\":82,\"Coincidences\":82,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.3942307692307692,\"JaccardSimilitude\":39.42,\"Similitud_Levenshtein\":26.08695652173913,\"LevenshteinSimilitude\":26.09,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":94,\"Coincidences\":94,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.42727272727272725,\"JaccardSimilitude\":42.73,\"Similitud_Levenshtein\":54.54545454545454,\"LevenshteinSimilitude\":54.55,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":86,\"Coincidences\":86,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.24362606232294617,\"JaccardSimilitude\":24.36,\"Similitud_Levenshtein\":30.0,\"LevenshteinSimilitude\":30.0,\"Similitud_Semantica\":0.3793103448275862,\"SemanticSimilitude\":37.93},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.12424849699398798,\"JaccardSimilitude\":12.42,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":61,\"Coincidences\":61,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08615819209039548,\"JaccardSimilitude\":8.62,\"Similitud_Levenshtein\":15.151515151515152,\"LevenshteinSimilitude\":15.15,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10046367851622875,\"JaccardSimilitude\":10.05,\"Similitud_Levenshtein\":10.75268817204301,\"LevenshteinSimilitude\":10.75,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId1\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.16981132075471697,\"JaccardSimilitude\":16.98,\"Similitud_Levenshtein\":6.557377049180328,\"LevenshteinSimilitude\":6.56,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91}]},\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\":{\"Id\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"FirstName\":\"Khabib \",\"LastName\":\"Nurmagomedov\",\"SubmissionId\":\"e0d30fd2-1027-4af3-be3b-238a579dacb8\",\"Url\":\"https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8\",\"Codes\":{\"HelloCodiva.java\":\"package com.example;\\n\\nclass HelloCodiva {\\n\\npublic static void main(String[] args) {\\n\\nString greeting = \\\"Hello World\\\";\\nSystem.out.println(greeting);\\n\\n}\\n}\\n\",\"Main.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\npackage com.example;\\n\\nclass Main {\\npublic static void main(String[] args) {\\nchar myLetter = ''D'';         // character\\nboolean myBool = true;       // boolean\\nString myText = \\\"Hello\\\";     // String\\n\\nint myNum = 5;\\nfloat myFloatNum = 5.99f;\\n\\nSystem.out.println(myNum);\\nSystem.out.println(myFloatNum);\\nSystem.out.println(myLetter);\\nSystem.out.println(myBool);\\nSystem.out.println(myText);\\n}\\n}\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.17715617715617715,\"JaccardSimilitude\":17.72,\"Similitud_Levenshtein\":40.0,\"LevenshteinSimilitude\":40.0,\"Similitud_Semantica\":0.5789473684210527,\"SemanticSimilitude\":57.89},{\"Coincidencias\":31,\"Coincidences\":31,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.13656387665198239,\"JaccardSimilitude\":13.66,\"Similitud_Levenshtein\":22.22222222222222,\"LevenshteinSimilitude\":22.22,\"Similitud_Semantica\":0.43999999999999995,\"SemanticSimilitude\":44.0},{\"Coincidencias\":91,\"Coincidences\":91,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.5384615384615384,\"JaccardSimilitude\":53.85,\"Similitud_Levenshtein\":30.434782608695656,\"LevenshteinSimilitude\":30.43,\"Similitud_Semantica\":0.3142857142857143,\"SemanticSimilitude\":31.43},{\"Coincidencias\":94,\"Coincidences\":94,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.42727272727272725,\"JaccardSimilitude\":42.73,\"Similitud_Levenshtein\":54.54545454545454,\"LevenshteinSimilitude\":54.55,\"Similitud_Semantica\":1.0,\"SemanticSimilitude\":100.0},{\"Coincidencias\":84,\"Coincidences\":84,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.22641509433962265,\"JaccardSimilitude\":22.64,\"Similitud_Levenshtein\":26.31578947368421,\"LevenshteinSimilitude\":26.32,\"Similitud_Semantica\":0.40740740740740744,\"SemanticSimilitude\":40.74},{\"Coincidencias\":59,\"Coincidences\":59,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.125,\"JaccardSimilitude\":12.5,\"Similitud_Levenshtein\":25.64102564102564,\"LevenshteinSimilitude\":25.64,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08836524300441827,\"JaccardSimilitude\":8.84,\"Similitud_Levenshtein\":21.21212121212121,\"LevenshteinSimilitude\":21.21,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10355987055016182,\"JaccardSimilitude\":10.36,\"Similitud_Levenshtein\":15.053763440860216,\"LevenshteinSimilitude\":15.05,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"HelloCodiva.java\",\"FileName1\":\"HelloCodiva.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1744186046511628,\"JaccardSimilitude\":17.44,\"Similitud_Levenshtein\":9.836065573770492,\"LevenshteinSimilitude\":9.84,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":78,\"Coincidences\":78,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.14130434782608695,\"JaccardSimilitude\":14.13,\"Similitud_Levenshtein\":20.833333333333336,\"LevenshteinSimilitude\":20.83,\"Similitud_Semantica\":0.6551724137931034,\"SemanticSimilitude\":65.52},{\"Coincidencias\":40,\"Coincidences\":40,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.11661807580174927,\"JaccardSimilitude\":11.66,\"Similitud_Levenshtein\":55.55555555555556,\"LevenshteinSimilitude\":55.56,\"Similitud_Semantica\":0.8620689655172413,\"SemanticSimilitude\":86.21},{\"Coincidencias\":95,\"Coincidences\":95,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.3275862068965517,\"JaccardSimilitude\":32.76,\"Similitud_Levenshtein\":56.25,\"LevenshteinSimilitude\":56.25,\"Similitud_Semantica\":0.8285714285714285,\"SemanticSimilitude\":82.86},{\"Coincidencias\":86,\"Coincidences\":86,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.24362606232294617,\"JaccardSimilitude\":24.36,\"Similitud_Levenshtein\":30.0,\"LevenshteinSimilitude\":30.0,\"Similitud_Semantica\":0.3793103448275862,\"SemanticSimilitude\":37.93},{\"Coincidencias\":247,\"Coincidences\":247,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.7417417417417418,\"JaccardSimilitude\":74.17,\"Similitud_Levenshtein\":85.71428571428571,\"LevenshteinSimilitude\":85.71,\"Similitud_Semantica\":0.9310344827586207,\"SemanticSimilitude\":93.1},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.10810810810810811,\"JaccardSimilitude\":10.81,\"Similitud_Levenshtein\":21.052631578947366,\"LevenshteinSimilitude\":21.05,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"Diccionario.java\",\"FileName2\":\"Diccionario.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.08135168961201501,\"JaccardSimilitude\":8.14,\"Similitud_Levenshtein\":40.476190476190474,\"LevenshteinSimilitude\":40.48,\"Similitud_Semantica\":0.5272727272727273,\"SemanticSimilitude\":52.73},{\"Coincidencias\":70,\"Coincidences\":70,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"FileHandler.java\",\"FileName2\":\"FileHandler.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.09497964721845319,\"JaccardSimilitude\":9.5,\"Similitud_Levenshtein\":30.630630630630627,\"LevenshteinSimilitude\":30.63,\"Similitud_Semantica\":0.35365853658536583,\"SemanticSimilitude\":35.37},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"Main.java\",\"FileName1\":\"Main.java\",\"Nombre2\":\"TestAnimales.java\",\"FileName2\":\"TestAnimales.java\",\"Usuario_Id1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId1\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Usuario_Id2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId2\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Similitud_Jaccard\":0.1351931330472103,\"JaccardSimilitude\":13.52,\"Similitud_Levenshtein\":22.857142857142858,\"LevenshteinSimilitude\":22.86,\"Similitud_Semantica\":0.26126126126126126,\"SemanticSimilitude\":26.13}]},\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\":{\"Id\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"FirstName\":\"Ramzan\",\"LastName\":\"Kadyrov\",\"SubmissionId\":\"b6c2d5e1-33c4-4048-820b-03d25fe674b9\",\"Url\":\"https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3\",\"Codes\":{\"Calculadora.java\":\"class DivisionPorCeroException extends Exception {\\npublic DivisionPorCeroException(String mensaje) {\\nsuper(mensaje);\\n}\\n}\\n\\npublic class Calculadora {\\npublic static double dividir(int numerador, int denominador) throws DivisionPorCeroException {\\nif (denominador == 0) {\\nthrow new DivisionPorCeroException(\\\"Error: División por cero no permitida.\\\");\\n}\\nreturn (double) numerador / denominador;\\n}\\n\\npublic static void main(String[] args) {\\ntry {\\nSystem.out.println(\\\"Resultado: \\\" + dividir(10, 0));\\n} catch (DivisionPorCeroException e) {\\nSystem.err.println(e.getMessage());\\n}\\n}\\n}\\n\\n\\n\\n\\n\\n\\n\",\"Diccionario.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nimport java.util.HashMap;\\n\\npublic class Diccionario {\\npublic static void main(String[] args) {\\n// Crear un HashMap para almacenar palabras y sus definiciones\\nHashMap<String, String> diccionario = new HashMap<>();\\n\\n// Añadir elementos al diccionario\\ndiccionario.put(\\\"Java\\\", \\\"Lenguaje de programación orientado a objetos.\\\");\\ndiccionario.put(\\\"Python\\\", \\\"Lenguaje de programación de alto nivel.\\\");\\ndiccionario.put(\\\"HTML\\\", \\\"Lenguaje de marcado para crear páginas web.\\\");\\n\\n// Buscar y mostrar una definición\\nString palabra = \\\"Java\\\";\\nif (diccionario.containsKey(palabra)) {\\nSystem.out.println(palabra + \\\": \\\" + diccionario.get(palabra));\\n} else {\\nSystem.out.println(\\\"Palabra no encontrada en el diccionario.\\\");\\n}\\n\\n// Mostrar todas las palabras en el diccionario\\nSystem.out.println(\\\"\\\\nPalabras en el diccionario:\\\");\\nfor (String key : diccionario.keySet()) {\\nSystem.out.println(key + \\\": \\\" + diccionario.get(key));\\n}\\n}\\n}\\n\\n\\n\\n\",\"FileHandler.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nimport java.io.*;\\n\\npublic class FileHandler {\\npublic static void main(String[] args) {\\nString fileName = \\\"example.txt\\\";\\n\\n// Escribir en un archivo\\ntry (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {\\nwriter.write(\\\"Este es un ejemplo de escritura en archivo.\\\");\\nwriter.newLine();\\nwriter.write(\\\"Java es genial para manejar archivos.\\\");\\nSystem.out.println(\\\"Escritura en archivo completada.\\\");\\n} catch (IOException e) {\\nSystem.err.println(\\\"Error al escribir en el archivo: \\\" + e.getMessage());\\n}\\n\\n// Leer desde un archivo\\ntry (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {\\nString line;\\nwhile ((line = reader.readLine()) != null) {\\nSystem.out.println(\\\"Contenido del archivo: \\\" + line);\\n}\\n} catch (IOException e) {\\nSystem.err.println(\\\"Error al leer el archivo: \\\" + e.getMessage());\\n}\\n}\\n}\\n\\n\\n\\n\",\"TestAnimales.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass Animal {\\npublic void sonido() {\\nSystem.out.println(\\\"El animal hace un sonido\\\");\\n}\\n}\\n\\nclass Perro extends Animal {\\n@Override\\npublic void sonido() {\\nSystem.out.println(\\\"El perro ladra\\\");\\n}\\n}\\n\\nclass Gato extends Animal {\\n@Override\\npublic void sonido() {\\nSystem.out.println(\\\"El gato maúlla\\\");\\n}\\n}\\n\\npublic class TestAnimales {\\npublic static void main(String[] args) {\\nAnimal miPerro = new Perro();\\nAnimal miGato = new Gato();\\n\\nmiPerro.sonido();\\nmiGato.sonido();\\n}\\n}\\n\\n\\n\",\"asf.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass asf {\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello Codiva\\\");\\n\\n}\\n}\\n\\n\",\"asfsadasd.java\":\"\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\nclass asfsadasd {\\npublic static void main(String[] args) {\\n\\nSystem.out.println(\\\"Hello Codiva\\\");\\n\\n}\\n}\\n\"},\"State\":3,\"PlagiResults\":[{\"Coincidencias\":343,\"Coincidences\":343,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.8386308068459658,\"JaccardSimilitude\":83.86,\"Similitud_Levenshtein\":76.59574468085107,\"LevenshteinSimilitude\":76.6,\"Similitud_Semantica\":0.6785714285714286,\"SemanticSimilitude\":67.86},{\"Coincidencias\":92,\"Coincidences\":92,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.22276029055690072,\"JaccardSimilitude\":22.28,\"Similitud_Levenshtein\":22.641509433962266,\"LevenshteinSimilitude\":22.64,\"Similitud_Semantica\":0.8928571428571429,\"SemanticSimilitude\":89.29},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.1393258426966292,\"JaccardSimilitude\":13.93,\"Similitud_Levenshtein\":19.047619047619047,\"LevenshteinSimilitude\":19.05,\"Similitud_Semantica\":0.8,\"SemanticSimilitude\":80.0},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12424849699398798,\"JaccardSimilitude\":12.42,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.11428571428571428,\"JaccardSimilitude\":11.43,\"Similitud_Levenshtein\":21.818181818181817,\"LevenshteinSimilitude\":21.82,\"Similitud_Semantica\":0.9642857142857143,\"SemanticSimilitude\":96.43},{\"Coincidencias\":59,\"Coincidences\":59,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.125,\"JaccardSimilitude\":12.5,\"Similitud_Levenshtein\":10.256410256410255,\"LevenshteinSimilitude\":10.26,\"Similitud_Semantica\":0.3928571428571429,\"SemanticSimilitude\":39.29},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"Calculadora.java\",\"FileName1\":\"Calculadora.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.10810810810810811,\"JaccardSimilitude\":10.81,\"Similitud_Levenshtein\":21.052631578947366,\"LevenshteinSimilitude\":21.05,\"Similitud_Semantica\":0.9655172413793104,\"SemanticSimilitude\":96.55},{\"Coincidencias\":85,\"Coincidences\":85,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.09714285714285714,\"JaccardSimilitude\":9.71,\"Similitud_Levenshtein\":18.91891891891892,\"LevenshteinSimilitude\":18.92,\"Similitud_Semantica\":0.34545454545454546,\"SemanticSimilitude\":34.55},{\"Coincidencias\":25,\"Coincidences\":25,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.036337209302325583,\"JaccardSimilitude\":3.63,\"Similitud_Levenshtein\":52.5,\"LevenshteinSimilitude\":52.5,\"Similitud_Semantica\":0.4545454545454546,\"SemanticSimilitude\":45.45},{\"Coincidencias\":62,\"Coincidences\":62,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.09494640122511486,\"JaccardSimilitude\":9.49,\"Similitud_Levenshtein\":66.66666666666666,\"LevenshteinSimilitude\":66.67,\"Similitud_Semantica\":0.6363636363636364,\"SemanticSimilitude\":63.64},{\"Coincidencias\":61,\"Coincidences\":61,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.08615819209039548,\"JaccardSimilitude\":8.62,\"Similitud_Levenshtein\":15.151515151515152,\"LevenshteinSimilitude\":15.15,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":72,\"Coincidences\":72,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.08591885441527446,\"JaccardSimilitude\":8.59,\"Similitud_Levenshtein\":36.58536585365854,\"LevenshteinSimilitude\":36.59,\"Similitud_Semantica\":0.49090909090909096,\"SemanticSimilitude\":49.09},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.08836524300441827,\"JaccardSimilitude\":8.84,\"Similitud_Levenshtein\":18.181818181818183,\"LevenshteinSimilitude\":18.18,\"Similitud_Semantica\":0.19999999999999996,\"SemanticSimilitude\":20.0},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"Diccionario.java\",\"FileName1\":\"Diccionario.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.08135168961201501,\"JaccardSimilitude\":8.14,\"Similitud_Levenshtein\":38.095238095238095,\"LevenshteinSimilitude\":38.1,\"Similitud_Semantica\":0.5272727272727273,\"SemanticSimilitude\":52.73},{\"Coincidencias\":130,\"Coincidences\":130,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.16817593790426907,\"JaccardSimilitude\":16.82,\"Similitud_Levenshtein\":13.861386138613863,\"LevenshteinSimilitude\":13.86,\"Similitud_Semantica\":0.23170731707317072,\"SemanticSimilitude\":23.17},{\"Coincidencias\":35,\"Coincidences\":35,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.05636070853462158,\"JaccardSimilitude\":5.64,\"Similitud_Levenshtein\":39.25233644859813,\"LevenshteinSimilitude\":39.25,\"Similitud_Semantica\":0.30487804878048785,\"SemanticSimilitude\":30.49},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.10961214165261383,\"JaccardSimilitude\":10.96,\"Similitud_Levenshtein\":52.991452991452995,\"LevenshteinSimilitude\":52.99,\"Similitud_Semantica\":0.426829268292683,\"SemanticSimilitude\":42.68},{\"Coincidencias\":65,\"Coincidences\":65,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.10046367851622875,\"JaccardSimilitude\":10.05,\"Similitud_Levenshtein\":10.75268817204301,\"LevenshteinSimilitude\":10.75,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":76,\"Coincidences\":76,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.0978120978120978,\"JaccardSimilitude\":9.78,\"Similitud_Levenshtein\":27.522935779816514,\"LevenshteinSimilitude\":27.52,\"Similitud_Semantica\":0.3292682926829268,\"SemanticSimilitude\":32.93},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.10355987055016182,\"JaccardSimilitude\":10.36,\"Similitud_Levenshtein\":12.903225806451612,\"LevenshteinSimilitude\":12.9,\"Similitud_Semantica\":0.13414634146341464,\"SemanticSimilitude\":13.41},{\"Coincidencias\":70,\"Coincidences\":70,\"Nombre1\":\"FileHandler.java\",\"FileName1\":\"FileHandler.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.09497964721845319,\"JaccardSimilitude\":9.5,\"Similitud_Levenshtein\":28.82882882882883,\"LevenshteinSimilitude\":28.83,\"Similitud_Semantica\":0.35365853658536583,\"SemanticSimilitude\":35.37},{\"Coincidencias\":75,\"Coincidences\":75,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Calculadora.java\",\"FileName2\":\"Calculadora.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.13636363636363635,\"JaccardSimilitude\":13.64,\"Similitud_Levenshtein\":7.6923076923076925,\"LevenshteinSimilitude\":7.69,\"Similitud_Semantica\":0.1711711711711712,\"SemanticSimilitude\":17.12},{\"Coincidencias\":26,\"Coincidences\":26,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"DivisionPorCeroException.java\",\"FileName2\":\"DivisionPorCeroException.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.07386363636363637,\"JaccardSimilitude\":7.39,\"Similitud_Levenshtein\":30.88235294117647,\"LevenshteinSimilitude\":30.88,\"Similitud_Semantica\":0.22522522522522526,\"SemanticSimilitude\":22.52},{\"Coincidencias\":64,\"Coincidences\":64,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"UserId2\":\"12bedd1a-d7c6-4b54-aeb5-507ef12d4f83\",\"Similitud_Jaccard\":0.20253164556962025,\"JaccardSimilitude\":20.25,\"Similitud_Levenshtein\":42.465753424657535,\"LevenshteinSimilitude\":42.47,\"Similitud_Semantica\":0.3153153153153153,\"SemanticSimilitude\":31.53},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.16981132075471697,\"JaccardSimilitude\":16.98,\"Similitud_Levenshtein\":6.557377049180328,\"LevenshteinSimilitude\":6.56,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":66,\"Coincidences\":66,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"UserId2\":\"239e66d0-16c3-4ce4-b321-058b64269f5e\",\"Similitud_Jaccard\":0.12966601178781925,\"JaccardSimilitude\":12.97,\"Similitud_Levenshtein\":20.28985507246377,\"LevenshteinSimilitude\":20.29,\"Similitud_Semantica\":0.2432432432432432,\"SemanticSimilitude\":24.32},{\"Coincidencias\":60,\"Coincidences\":60,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"HelloCodiva.java\",\"FileName2\":\"HelloCodiva.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.1744186046511628,\"JaccardSimilitude\":17.44,\"Similitud_Levenshtein\":9.836065573770492,\"LevenshteinSimilitude\":9.84,\"Similitud_Semantica\":0.09909909909909909,\"SemanticSimilitude\":9.91},{\"Coincidencias\":63,\"Coincidences\":63,\"Nombre1\":\"TestAnimales.java\",\"FileName1\":\"TestAnimales.java\",\"Nombre2\":\"Main.java\",\"FileName2\":\"Main.java\",\"Usuario_Id1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"UserId1\":\"af2eff91-54b0-43b4-91c4-57b7e2d62f15\",\"Usuario_Id2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"UserId2\":\"9b934e06-3abd-4b8d-b45f-7e2106b4bc74\",\"Similitud_Jaccard\":0.1351931330472103,\"JaccardSimilitude\":13.52,\"Similitud_Levenshtein\":22.857142857142858,\"LevenshteinSimilitude\":22.86,\"Similitud_Semantica\":0.26126126126126126,\"SemanticSimilitude\":26.13}]},\"e7c43279-2bcc-4c09-9165-b824041166fc\":{\"Id\":\"e7c43279-2bcc-4c09-9165-b824041166fc\",\"FirstName\":\"August\",\"LastName\":\"von Kageneck\",\"SubmissionId\":\"6252ac2f-e197-4ec3-821f-56ef3dffc72c\",\"Url\":\"https://www.codiva.io/p/0dc6fsdf99a0-6033-4bb6-b46c-15d238277749\",\"Codes\":{},\"State\":1,\"PlagiResults\":[]}}"]', '2024-10-09 11:52:11.042921-05', NULL, 0);
INSERT INTO hangfire.job VALUES (26, 210, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"icasillasf@plagitracker.com\\\"\",\"\\\"Iker Casillas Fernández\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"icasillasf@plagitracker.com\"", "\"Iker Casillas Fernández\""]', '2024-11-17 05:43:35.834852-05', '2024-11-18 05:43:51.894101-05', 0);
INSERT INTO hangfire.job VALUES (47, 289, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"zibrahimovich@plagitracker.com\\\"\",\"\\\"Zlatan Ibrahimović Hansson\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"zibrahimovich@plagitracker.com\"", "\"Zlatan Ibrahimović Hansson\""]', '2024-11-17 05:49:01.712069-05', '2024-11-18 05:49:08.391624-05', 0);
INSERT INTO hangfire.job VALUES (50, 300, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ftorress@plagitracker.com\\\"\",\"\\\"Fernando Torres Sanz\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ftorress@plagitracker.com\"", "\"Fernando Torres Sanz\""]', '2024-11-17 05:49:20.993366-05', '2024-11-18 05:49:37.704336-05', 0);
INSERT INTO hangfire.job VALUES (31, 224, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"gbuffoni@plagitracker.com\\\"\",\"\\\"Gianluigi Buffon Italiano\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"gbuffoni@plagitracker.com\"", "\"Gianluigi Buffon Italiano\""]', '2024-11-17 05:46:04.160268-05', '2024-11-18 05:46:22.182919-05', 0);
INSERT INTO hangfire.job VALUES (13, 152, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"dmaradonaf@plagitracker.com\\\"\",\"\\\"Diego Armando Maradona Franco\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"dmaradonaf@plagitracker.com\"", "\"Diego Armando Maradona Franco\""]', '2024-11-17 05:39:28.673011-05', '2024-11-18 05:39:36.962615-05', 0);
INSERT INTO hangfire.job VALUES (22, 188, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"setoof@plagitracker.com\\\"\",\"\\\"Samuel Eto''o Fils\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"setoof@plagitracker.com\"", "\"Samuel Eto''o Fils\""]', '2024-11-17 05:43:01.352145-05', '2024-11-18 05:43:06.886315-05', 0);
INSERT INTO hangfire.job VALUES (30, 220, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"flampardh@plagitracker.com\\\"\",\"\\\"Frank Lampard Henry\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"flampardh@plagitracker.com\"", "\"Frank Lampard Henry\""]', '2024-11-17 05:44:38.516088-05', '2024-11-18 05:44:52.597132-05', 0);
INSERT INTO hangfire.job VALUES (44, 279, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"msalahg@plagitracker.com\\\"\",\"\\\"Mohamed Salah Ghaly\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"msalahg@plagitracker.com\"", "\"Mohamed Salah Ghaly\""]', '2024-11-17 05:48:40.700794-05', '2024-11-18 05:48:54.341727-05', 0);
INSERT INTO hangfire.job VALUES (52, 308, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"eportugalc@ulasalle.edu.pe\\\"\",\"\\\"Elmerson Ramith Portugal Carpio\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"eportugalc@ulasalle.edu.pe\"", "\"Elmerson Ramith Portugal Carpio\""]', '2024-11-17 05:54:22.49406-05', '2024-11-18 05:54:38.947862-05', 0);
INSERT INTO hangfire.job VALUES (46, 288, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"lsuarezd@plagitracker.com\\\"\",\"\\\"Luis Suárez Díaz\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"lsuarezd@plagitracker.com\"", "\"Luis Suárez Díaz\""]', '2024-11-17 05:48:55.343636-05', '2024-11-18 05:49:07.888661-05', 0);
INSERT INTO hangfire.job VALUES (24, 200, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"rgonzalezb@plagitracker.com\\\"\",\"\\\"Raúl González Blanco\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"rgonzalezb@plagitracker.com\"", "\"Raúl González Blanco\""]', '2024-11-17 05:43:20.178633-05', '2024-11-18 05:43:37.049694-05', 0);
INSERT INTO hangfire.job VALUES (14, 156, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"cdossantosa@plagitracker.com\\\"\",\"\\\"Cristiano Ronaldo Dos Santos Aveiro\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"cdossantosa@plagitracker.com\"", "\"Cristiano Ronaldo Dos Santos Aveiro\""]', '2024-11-17 05:40:48.865842-05', '2024-11-18 05:41:06.812688-05', 0);
INSERT INTO hangfire.job VALUES (32, 228, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ainiestal@plagitracker.com\\\"\",\"\\\"Andrés Iniesta Luján\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ainiestal@plagitracker.com\"", "\"Andrés Iniesta Luján\""]', '2024-11-17 05:46:28.4551-05', '2024-11-18 05:46:37.562075-05', 0);
INSERT INTO hangfire.job VALUES (45, 281, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"kbenzema@plagitracker.com\\\"\",\"\\\"Karim Benzema Hafid\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"kbenzema@plagitracker.com\"", "\"Karim Benzema Hafid\""]', '2024-11-17 05:48:47.879993-05', '2024-11-18 05:48:56.292672-05', 0);
INSERT INTO hangfire.job VALUES (53, 312, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"oquispev@ulasalle.edu.pe\\\"\",\"\\\"Olger Antonio Jose Quispe Vilca\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"oquispev@ulasalle.edu.pe\"", "\"Olger Antonio Jose Quispe Vilca\""]', '2024-11-17 05:56:51.233583-05', '2024-11-18 05:57:08.325712-05', 0);
INSERT INTO hangfire.job VALUES (20, 180, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"apirlob@plagitracker.com\\\"\",\"\\\"Andrea Pirlo Baldini\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"apirlob@plagitracker.com\"", "\"Andrea Pirlo Baldini\""]', '2024-11-17 05:41:54.856431-05', '2024-11-18 05:42:07.977761-05', 0);
INSERT INTO hangfire.job VALUES (15, 160, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"kmbappel@plagitracker.com\\\"\",\"\\\"Kylian Mbappé Lottin\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"kmbappel@plagitracker.com\"", "\"Kylian Mbappé Lottin\""]', '2024-11-17 05:41:14.412469-05', '2024-11-18 05:41:21.712536-05', 0);
INSERT INTO hangfire.job VALUES (49, 296, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ecavanig@plagitracker.com\\\"\",\"\\\"Edinson Cavani Gómez\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ecavanig@plagitracker.com\"", "\"Edinson Cavani Gómez\""]', '2024-11-17 05:49:14.224746-05', '2024-11-18 05:49:22.603326-05', 0);
INSERT INTO hangfire.job VALUES (54, 316, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"lmamania@ulasalle.edu.pe\\\"\",\"\\\"Luisfelipe Rodrigo Mamani Arosquipa\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"lmamania@ulasalle.edu.pe\"", "\"Luisfelipe Rodrigo Mamani Arosquipa\""]', '2024-11-17 05:59:24.4223-05', '2024-11-18 05:59:39.040884-05', 0);
INSERT INTO hangfire.job VALUES (34, 235, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"sramosg@plagitracker.com\\\"\",\"\\\"Sergio Ramos García\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"sramosg@plagitracker.com\"", "\"Sergio Ramos García\""]', '2024-11-17 05:46:48.54389-05', '2024-11-18 05:46:52.512126-05', 0);
INSERT INTO hangfire.job VALUES (35, 245, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ppogban@plagitracker.com\\\"\",\"\\\"Paul Pogba Ndombele\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ppogban@plagitracker.com\"", "\"Paul Pogba Ndombele\""]', '2024-11-17 05:46:54.339574-05', '2024-11-18 05:47:08.094547-05', 0);
INSERT INTO hangfire.job VALUES (25, 201, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"dbeckhamg@plagitracker.com\\\"\",\"\\\"David Beckham Golden\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"dbeckhamg@plagitracker.com\"", "\"David Beckham Golden\""]', '2024-11-17 05:43:28.648551-05', '2024-11-18 05:43:37.52092-05', 0);
INSERT INTO hangfire.job VALUES (18, 173, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"lmodricv@plagitracker.com\\\"\",\"\\\"Luka Modric Valcic\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"lmodricv@plagitracker.com\"", "\"Luka Modric Valcic\""]', '2024-11-17 05:41:41.275582-05', '2024-11-18 05:41:51.715538-05', 0);
INSERT INTO hangfire.job VALUES (33, 236, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"gpiqueb@plagitracker.com\\\"\",\"\\\"Gerard Piqué Bernabeu\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"gpiqueb@plagitracker.com\"", "\"Gerard Piqué Bernabeu\""]', '2024-11-17 05:46:37.857036-05', '2024-11-18 05:46:53.019095-05', 0);
INSERT INTO hangfire.job VALUES (27, 211, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"pnascimentoa@plagitracker.com\\\"\",\"\\\"Pele Nascimento Arantes\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"pnascimentoa@plagitracker.com\"", "\"Pele Nascimento Arantes\""]', '2024-11-17 05:43:41.885243-05', '2024-11-18 05:43:52.735384-05', 0);
INSERT INTO hangfire.job VALUES (37, 251, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"wrooneym@plagitracker.com\\\"\",\"\\\"Wayne Rooney Marcus\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"wrooneym@plagitracker.com\"", "\"Wayne Rooney Marcus\""]', '2024-11-17 05:47:06.471576-05', '2024-11-18 05:47:22.426183-05', 0);
INSERT INTO hangfire.job VALUES (28, 212, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"rdeassism@plagitracker.com\\\"\",\"\\\"Ronaldinho De Assis Moreira\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"rdeassism@plagitracker.com\"", "\"Ronaldinho De Assis Moreira\""]', '2024-11-17 05:43:48.416147-05', '2024-11-18 05:43:53.222382-05', 0);
INSERT INTO hangfire.job VALUES (55, 320, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"ittitoc@ulasalle.edu.pe\\\"\",\"\\\"Isabel Karina Ttito Campos\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ittitoc@ulasalle.edu.pe\"", "\"Isabel Karina Ttito Campos\""]', '2024-11-17 06:00:23.585319-05', '2024-11-18 06:00:38.397717-05', 0);
INSERT INTO hangfire.job VALUES (17, 167, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"nsantosj@plagitracker.com\\\"\",\"\\\"Neymar da Silva Santos Júnior\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"nsantosj@plagitracker.com\"", "\"Neymar da Silva Santos Júnior\""]', '2024-11-17 05:41:32.97264-05', '2024-11-18 05:41:36.712431-05', 0);
INSERT INTO hangfire.job VALUES (36, 244, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"gbalet@plagitracker.com\\\"\",\"\\\"Gareth Bale Thomas\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"gbalet@plagitracker.com\"", "\"Gareth Bale Thomas\""]', '2024-11-17 05:46:59.946371-05', '2024-11-18 05:47:07.529904-05', 0);
INSERT INTO hangfire.job VALUES (16, 168, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"ehaalandb@plagitracker.com\\\"\",\"\\\"Erling Haaland Braut\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"ehaalandb@plagitracker.com\"", "\"Erling Haaland Braut\""]', '2024-11-17 05:41:23.584334-05', '2024-11-18 05:41:37.275031-05', 0);
INSERT INTO hangfire.job VALUES (56, 324, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"mgrau@plagitracker.com\\\"\",\"\\\"Miguel Grau\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"mgrau@plagitracker.com\"", "\"Miguel Grau\""]', '2024-11-17 06:03:16.538685-05', '2024-11-18 06:03:23.576757-05', 0);
INSERT INTO hangfire.job VALUES (41, 264, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"pcoutinhoc@plagitracker.com\\\"\",\"\\\"Philippe Coutinho Correia\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"pcoutinhoc@plagitracker.com\"", "\"Philippe Coutinho Correia\""]', '2024-11-17 05:47:40.140527-05', '2024-11-18 05:47:53.129361-05', 0);
INSERT INTO hangfire.job VALUES (58, 332, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"aavelino @plagitracker.com\\\"\",\"\\\"Andrés Avelino Cáceres\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"aavelino @plagitracker.com\"", "\"Andrés Avelino Cáceres\""]', '2024-11-17 06:04:29.642982-05', '2024-11-18 06:04:38.696728-05', 0);
INSERT INTO hangfire.job VALUES (19, 179, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"zzidaney@plagitracker.com\\\"\",\"\\\"Zinedine Zidane Yazid\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"zzidaney@plagitracker.com\"", "\"Zinedine Zidane Yazid\""]', '2024-11-17 05:41:48.453573-05', '2024-11-18 05:42:06.79031-05', 0);
INSERT INTO hangfire.job VALUES (57, 328, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeTeacherEmail", "Arguments": "[\"\\\"fbolognesi@plagitracker.com\\\"\",\"\\\"Francisco Bolognesi\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"fbolognesi@plagitracker.com\"", "\"Francisco Bolognesi\""]', '2024-11-17 06:03:54.046848-05', '2024-11-18 06:04:08.784973-05', 0);
INSERT INTO hangfire.job VALUES (38, 253, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"xhernandezc@plagitracker.com\\\"\",\"\\\"Xavi Hernández Creus\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"xhernandezc@plagitracker.com\"", "\"Xavi Hernández Creus\""]', '2024-11-17 05:47:14.601185-05', '2024-11-18 05:47:22.948377-05', 0);
INSERT INTO hangfire.job VALUES (39, 259, 'Succeeded', '{"Type": "PlagiTracker.Services.EmailServices.EmailAuthenticator, PlagiTracker.Services", "Method": "WelcomeStudentEmail", "Arguments": "[\"\\\"rcarlosd@plagitracker.com\\\"\",\"\\\"Roberto Carlos Da Silva\\\"\"]", "ParameterTypes": "[\"System.String\",\"System.String\"]"}', '["\"rcarlosd@plagitracker.com\"", "\"Roberto Carlos Da Silva\""]', '2024-11-17 05:47:22.754196-05', '2024-11-18 05:47:37.466632-05', 0);


--
-- TOC entry 3600 (class 0 OID 49552)
-- Dependencies: 232
-- Data for Name: jobparameter; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.jobparameter VALUES (1, 1, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (2, 1, 'RetryCount', '10', 0);
INSERT INTO hangfire.jobparameter VALUES (15, 12, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (16, 13, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (17, 14, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (18, 15, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (19, 16, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (20, 17, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (21, 18, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (22, 19, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (23, 20, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (24, 21, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (25, 22, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (26, 23, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (27, 24, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (28, 25, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (29, 26, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (30, 27, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (31, 28, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (32, 29, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (33, 30, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (34, 31, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (35, 32, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (36, 33, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (37, 34, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (38, 35, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (39, 36, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (40, 37, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (41, 38, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (42, 39, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (43, 40, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (44, 41, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (45, 42, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (46, 43, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (47, 44, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (48, 45, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (49, 46, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (50, 47, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (51, 48, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (52, 49, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (53, 50, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (54, 51, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (55, 52, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (56, 53, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (57, 54, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (58, 55, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (59, 56, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (60, 57, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (61, 58, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (62, 59, 'CurrentCulture', '"en-US"', 0);
INSERT INTO hangfire.jobparameter VALUES (63, 60, 'CurrentCulture', '"en-US"', 0);


--
-- TOC entry 3593 (class 0 OID 49517)
-- Dependencies: 225
-- Data for Name: jobqueue; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3595 (class 0 OID 49525)
-- Dependencies: 227
-- Data for Name: list; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3601 (class 0 OID 49566)
-- Dependencies: 233
-- Data for Name: lock; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3583 (class 0 OID 49467)
-- Dependencies: 215
-- Data for Name: schema; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.schema VALUES (22);


--
-- TOC entry 3596 (class 0 OID 49533)
-- Dependencies: 228
-- Data for Name: server; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.server VALUES ('desk-0ur080r05:26700:458257d4-da44-49bb-a6b3-664ac7376840', '{"Queues": ["default"], "StartedAt": "2024-11-17T22:39:21.9505858Z", "WorkerCount": 20}', '2024-11-17 17:46:52.671737-05', 0);


--
-- TOC entry 3598 (class 0 OID 49541)
-- Dependencies: 230
-- Data for Name: set; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--



--
-- TOC entry 3591 (class 0 OID 49502)
-- Dependencies: 223
-- Data for Name: state; Type: TABLE DATA; Schema: hangfire; Owner: postgres
--

INSERT INTO hangfire.state VALUES (1, 1, 'Scheduled', NULL, '2024-10-09 11:52:11.167669-05', '{"EnqueueAt": "1728492730986", "ScheduledAt": "1728492730989"}', 0);
INSERT INTO hangfire.state VALUES (2, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 11:52:23.8056-05', '{"Queue": "default", "EnqueuedAt": "1728492743518"}', 0);
INSERT INTO hangfire.state VALUES (3, 1, 'Processing', NULL, '2024-10-09 11:52:23.852042-05', '{"ServerId": "desk-0ur080r05:30236:11dc6dca-b10c-436a-9c5d-6a795945beab", "WorkerId": "62ec3fdb-3913-4851-86c4-6e9cc98d1c3e", "StartedAt": "1728492743817"}', 0);
INSERT INTO hangfire.state VALUES (4, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 11:52:34.411124-05', '{"FailedAt": "1728492754315", "ServerId": "desk-0ur080r05:30236:11dc6dca-b10c-436a-9c5d-6a795945beab", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Update.Internal.NpgsqlModificationCommandBatch.Consume(RelationalDataReader reader, Boolean async, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Plagiarisms\r\n    ConstraintName: IX_Plagiarisms_CodeId_Algorithm\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Update.Internal.NpgsqlModificationCommandBatch.Consume(RelationalDataReader reader, Boolean async, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 151\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (5, 1, 'Scheduled', 'Retry attempt 1 of 10: An error occurred while saving the entity changes…', '2024-10-09 11:52:34.420234-05', '{"EnqueueAt": "1728492785383", "ScheduledAt": "1728492754383"}', 0);
INSERT INTO hangfire.state VALUES (6, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 11:53:08.87344-05', '{"Queue": "default", "EnqueuedAt": "1728492788851"}', 0);
INSERT INTO hangfire.state VALUES (7, 1, 'Processing', NULL, '2024-10-09 11:53:08.892315-05', '{"ServerId": "desk-0ur080r05:30236:11dc6dca-b10c-436a-9c5d-6a795945beab", "WorkerId": "62ec3fdb-3913-4851-86c4-6e9cc98d1c3e", "StartedAt": "1728492788878"}', 0);
INSERT INTO hangfire.state VALUES (118, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-11 23:31:03.256229-05', '{"Queue": "default", "EnqueuedAt": "1728707462966"}', 0);
INSERT INTO hangfire.state VALUES (145, 12, 'Scheduled', NULL, '2024-11-17 05:24:57.660418-05', '{"EnqueueAt": "1731839097391", "ScheduledAt": "1731839097393"}', 0);
INSERT INTO hangfire.state VALUES (147, 12, 'Processing', NULL, '2024-11-17 05:25:00.431154-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "b1d43a4a-7d60-4313-b730-0ef774dfaee1", "StartedAt": "1731839100425"}', 0);
INSERT INTO hangfire.state VALUES (13, 1, 'Processing', NULL, '2024-10-09 12:28:21.082542-05', '{"ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "WorkerId": "e50f6f0c-6d52-48fe-a8b0-b566f387397b", "StartedAt": "1728494900777"}', 0);
INSERT INTO hangfire.state VALUES (213, 29, 'Scheduled', NULL, '2024-11-17 05:44:16.780541-05', '{"EnqueueAt": "1731840256775", "ScheduledAt": "1731840256775"}', 0);
INSERT INTO hangfire.state VALUES (291, 48, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:49:19.068472-05', '{"Queue": "default", "EnqueuedAt": "1731840559066"}', 0);
INSERT INTO hangfire.state VALUES (30, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 12:30:51.618373-05', '{"FailedAt": "1728495051496", "ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Plagiarisms\r\n    ConstraintName: IX_Plagiarisms_CodeId_Algorithm\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 165\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (292, 49, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:49:19.075041-05', '{"Queue": "default", "EnqueuedAt": "1731840559072"}', 0);
INSERT INTO hangfire.state VALUES (295, 50, 'Scheduled', NULL, '2024-11-17 05:49:20.99541-05', '{"EnqueueAt": "1731840560993", "ScheduledAt": "1731840560993"}', 0);
INSERT INTO hangfire.state VALUES (340, 60, 'Processing', NULL, '2024-11-17 07:43:29.11571-05', '{"ServerId": "desk-0ur080r05:19576:3a121bf3-c721-4416-b4fa-7595b273209c", "WorkerId": "c123c449-644e-499d-a83b-6811d5de7458", "StartedAt": "1731847408979"}', 0);
INSERT INTO hangfire.state VALUES (16, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 12:28:44.882536-05', '{"FailedAt": "1728494924801", "ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "ExceptionType": "System.InvalidOperationException", "ExceptionDetails": "System.InvalidOperationException: An exception has been raised that is likely due to a transient failure.\r\n ---> Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 40P01: deadlock detected\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 40P01\r\n    MessageText: deadlock detected\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    Hint: See server log for query details.\r\n    Where: while inserting index tuple (0,2) in relation \"IX_Codes_SubmissionId_FileName\"\r\n    File: deadlock.c\r\n    Line: 1152\r\n    Routine: DeadLockReport\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   --- End of inner exception stack trace ---\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 87\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An exception has been raised that is likely due to a transient failure."}', 0);
INSERT INTO hangfire.state VALUES (17, 1, 'Scheduled', 'Retry attempt 2 of 10: An exception has been raised that is likely due t…', '2024-10-09 12:28:44.925845-05', '{"EnqueueAt": "1728494968854", "ScheduledAt": "1728494924854"}', 0);
INSERT INTO hangfire.state VALUES (119, 1, 'Processing', NULL, '2024-10-11 23:31:03.675383-05', '{"ServerId": "desk-0ur080r05:5256:7b90f114-1409-4330-9e0d-fd6e3958b559", "WorkerId": "0f6acd77-c01c-44e9-a602-3c77a6e0a4a8", "StartedAt": "1728707463621"}', 0);
INSERT INTO hangfire.state VALUES (20, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 12:29:40.355568-05', '{"Queue": "default", "EnqueuedAt": "1728494980335"}', 0);
INSERT INTO hangfire.state VALUES (21, 1, 'Processing', NULL, '2024-10-09 12:29:40.382149-05', '{"ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "WorkerId": "e50f6f0c-6d52-48fe-a8b0-b566f387397b", "StartedAt": "1728494980360"}', 0);
INSERT INTO hangfire.state VALUES (22, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 12:29:42.755523-05', '{"FailedAt": "1728494982720", "ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Codes\r\n    ConstraintName: IX_Codes_SubmissionId_FileName\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 87\r\n   at InvokeStub_TaskAwaiter.GetResult(Object, Object, IntPtr*)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (23, 1, 'Scheduled', 'Retry attempt 3 of 10: An error occurred while saving the entity changes…', '2024-10-09 12:29:42.76901-05', '{"EnqueueAt": "1728495034742", "ScheduledAt": "1728494982742"}', 0);
INSERT INTO hangfire.state VALUES (146, 12, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:25:00.382582-05', '{"Queue": "default", "EnqueuedAt": "1731839100313"}', 0);
INSERT INTO hangfire.state VALUES (31, 1, 'Scheduled', 'Retry attempt 4 of 10: An error occurred while saving the entity changes…', '2024-10-09 12:30:51.622148-05', '{"EnqueueAt": "1728495183605", "ScheduledAt": "1728495051605"}', 0);
INSERT INTO hangfire.state VALUES (36, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 12:33:13.985329-05', '{"Queue": "default", "EnqueuedAt": "1728495193967"}', 0);
INSERT INTO hangfire.state VALUES (37, 1, 'Processing', NULL, '2024-10-09 12:33:14.016791-05', '{"ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "WorkerId": "fa682321-018f-4806-ab38-b2a0e4bdfc2e", "StartedAt": "1728495193990"}', 0);
INSERT INTO hangfire.state VALUES (214, 29, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:44:18.469603-05', '{"Queue": "default", "EnqueuedAt": "1731840258462"}', 0);
INSERT INTO hangfire.state VALUES (216, 29, 'Succeeded', NULL, '2024-11-17 05:44:21.978361-05', '{"Latency": "1715", "SucceededAt": "1731840261974", "PerformanceDuration": "3482"}', 0);
INSERT INTO hangfire.state VALUES (298, 50, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:49:34.096076-05', '{"Queue": "default", "EnqueuedAt": "1731840574091"}', 0);
INSERT INTO hangfire.state VALUES (304, 51, 'Succeeded', NULL, '2024-11-17 05:53:23.185904-05', '{"Latency": "224", "SucceededAt": "1731840803180", "PerformanceDuration": "3862"}', 0);
INSERT INTO hangfire.state VALUES (341, 60, 'Succeeded', NULL, '2024-11-17 07:43:33.092415-05', '{"Latency": "5819275", "SucceededAt": "1731847413064", "PerformanceDuration": "3931"}', 0);
INSERT INTO hangfire.state VALUES (120, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-11 23:31:06.059815-05', '{"FailedAt": "1728707465975", "ServerId": "desk-0ur080r05:5256:7b90f114-1409-4330-9e0d-fd6e3958b559", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Codes\r\n    ConstraintName: IX_Codes_SubmissionId_FileName\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 90\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (28, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 12:30:43.806438-05', '{"Queue": "default", "EnqueuedAt": "1728495043789"}', 0);
INSERT INTO hangfire.state VALUES (29, 1, 'Processing', NULL, '2024-10-09 12:30:43.846251-05', '{"ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "WorkerId": "fa682321-018f-4806-ab38-b2a0e4bdfc2e", "StartedAt": "1728495043822"}', 0);
INSERT INTO hangfire.state VALUES (148, 12, 'Succeeded', NULL, '2024-11-17 05:25:05.386413-05', '{"Latency": "3015", "SucceededAt": "1731839105351", "PerformanceDuration": "4915"}', 0);
INSERT INTO hangfire.state VALUES (215, 29, 'Processing', NULL, '2024-11-17 05:44:18.484709-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840258476"}', 0);
INSERT INTO hangfire.state VALUES (299, 50, 'Processing', NULL, '2024-11-17 05:49:34.106013-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840574101"}', 0);
INSERT INTO hangfire.state VALUES (300, 50, 'Succeeded', NULL, '2024-11-17 05:49:37.708133-05', '{"Latency": "13116", "SucceededAt": "1731840577699", "PerformanceDuration": "3590"}', 0);
INSERT INTO hangfire.state VALUES (301, 51, 'Scheduled', NULL, '2024-11-17 05:53:19.112916-05', '{"EnqueueAt": "1731840799092", "ScheduledAt": "1731840799092"}', 0);
INSERT INTO hangfire.state VALUES (42, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 12:33:50.186136-05', '{"FailedAt": "1728495230089", "ServerId": "desk-0ur080r05:20752:f0e0173e-49c0-41fb-8ae6-3f38ec21819d", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Plagiarisms\r\n    ConstraintName: IX_Plagiarisms_CodeId_Algorithm\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 165\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (43, 1, 'Scheduled', 'Retry attempt 5 of 10: An error occurred while saving the entity changes…', '2024-10-09 12:33:50.19032-05', '{"EnqueueAt": "1728495581163", "ScheduledAt": "1728495230163"}', 0);
INSERT INTO hangfire.state VALUES (48, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 12:54:41.085562-05', '{"Queue": "default", "EnqueuedAt": "1728496481070"}', 0);
INSERT INTO hangfire.state VALUES (50, 1, 'Processing', NULL, '2024-10-09 12:54:41.148788-05', '{"ServerId": "desk-0ur080r05:30116:e74558f4-fd52-4267-9873-9d8b114d2459", "WorkerId": "158bacc6-42ff-4373-b40c-86348f43d4b2", "StartedAt": "1728496481089"}', 0);
INSERT INTO hangfire.state VALUES (149, 13, 'Scheduled', NULL, '2024-11-17 05:39:28.690412-05', '{"EnqueueAt": "1731839968670", "ScheduledAt": "1731839968670"}', 0);
INSERT INTO hangfire.state VALUES (217, 30, 'Scheduled', NULL, '2024-11-17 05:44:38.533383-05', '{"EnqueueAt": "1731840278515", "ScheduledAt": "1731840278515"}', 0);
INSERT INTO hangfire.state VALUES (231, 33, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:46:48.720291-05', '{"Queue": "default", "EnqueuedAt": "1731840408717"}', 0);
INSERT INTO hangfire.state VALUES (232, 34, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:46:48.726025-05', '{"Queue": "default", "EnqueuedAt": "1731840408723"}', 0);
INSERT INTO hangfire.state VALUES (236, 33, 'Succeeded', NULL, '2024-11-17 05:46:53.021241-05', '{"Latency": "10871", "SucceededAt": "1731840413016", "PerformanceDuration": "4288"}', 0);
INSERT INTO hangfire.state VALUES (239, 35, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:03.753416-05', '{"Queue": "default", "EnqueuedAt": "1731840423740"}', 0);
INSERT INTO hangfire.state VALUES (240, 36, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:03.760144-05', '{"Queue": "default", "EnqueuedAt": "1731840423756"}', 0);
INSERT INTO hangfire.state VALUES (242, 36, 'Processing', NULL, '2024-11-17 05:47:03.766429-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840423764"}', 0);
INSERT INTO hangfire.state VALUES (251, 37, 'Succeeded', NULL, '2024-11-17 05:47:22.426776-05', '{"Latency": "12337", "SucceededAt": "1731840442423", "PerformanceDuration": "3614"}', 0);
INSERT INTO hangfire.state VALUES (261, 41, 'Scheduled', NULL, '2024-11-17 05:47:40.142083-05', '{"EnqueueAt": "1731840460140", "ScheduledAt": "1731840460140"}', 0);
INSERT INTO hangfire.state VALUES (263, 41, 'Processing', NULL, '2024-11-17 05:47:48.952673-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840468950"}', 0);
INSERT INTO hangfire.state VALUES (264, 41, 'Succeeded', NULL, '2024-11-17 05:47:53.129888-05', '{"Latency": "8814", "SucceededAt": "1731840473126", "PerformanceDuration": "4171"}', 0);
INSERT INTO hangfire.state VALUES (267, 42, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:48:33.996985-05', '{"Queue": "default", "EnqueuedAt": "1731840513992"}', 0);
INSERT INTO hangfire.state VALUES (268, 43, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:48:34.001353-05', '{"Queue": "default", "EnqueuedAt": "1731840513999"}', 0);
INSERT INTO hangfire.state VALUES (270, 43, 'Processing', NULL, '2024-11-17 05:48:34.005669-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840514004"}', 0);
INSERT INTO hangfire.state VALUES (274, 45, 'Scheduled', NULL, '2024-11-17 05:48:47.882822-05', '{"EnqueueAt": "1731840527879", "ScheduledAt": "1731840527879"}', 0);
INSERT INTO hangfire.state VALUES (275, 44, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:48:49.019315-05', '{"Queue": "default", "EnqueuedAt": "1731840529016"}', 0);
INSERT INTO hangfire.state VALUES (276, 45, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:48:49.023716-05', '{"Queue": "default", "EnqueuedAt": "1731840529021"}', 0);
INSERT INTO hangfire.state VALUES (279, 44, 'Succeeded', NULL, '2024-11-17 05:48:54.342547-05', '{"Latency": "8324", "SucceededAt": "1731840534338", "PerformanceDuration": "5312"}', 0);
INSERT INTO hangfire.state VALUES (302, 51, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:53:19.30687-05', '{"Queue": "default", "EnqueuedAt": "1731840799299"}', 0);
INSERT INTO hangfire.state VALUES (303, 51, 'Processing', NULL, '2024-11-17 05:53:19.315162-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840799312"}', 0);
INSERT INTO hangfire.state VALUES (305, 52, 'Scheduled', NULL, '2024-11-17 05:54:22.500345-05', '{"EnqueueAt": "1731840862493", "ScheduledAt": "1731840862493"}', 0);
INSERT INTO hangfire.state VALUES (306, 52, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:54:34.380563-05', '{"Queue": "default", "EnqueuedAt": "1731840874378"}', 0);
INSERT INTO hangfire.state VALUES (307, 52, 'Processing', NULL, '2024-11-17 05:54:34.52959-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840874527"}', 0);
INSERT INTO hangfire.state VALUES (308, 52, 'Succeeded', NULL, '2024-11-17 05:54:38.949751-05', '{"Latency": "12037", "SucceededAt": "1731840878944", "PerformanceDuration": "4413"}', 0);
INSERT INTO hangfire.state VALUES (310, 53, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:57:04.542502-05', '{"Queue": "default", "EnqueuedAt": "1731841024540"}', 0);
INSERT INTO hangfire.state VALUES (55, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 13:24:27.213511-05', '{"FailedAt": "1728498267166", "ServerId": "desk-0ur080r05:30116:e74558f4-fd52-4267-9873-9d8b114d2459", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Plagiarisms\r\n    ConstraintName: IX_Plagiarisms_CodeId_Algorithm\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 168\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (56, 1, 'Scheduled', 'Retry attempt 6 of 10: An error occurred while saving the entity changes…', '2024-10-09 13:24:27.22339-05', '{"EnqueueAt": "1728499039200", "ScheduledAt": "1728498267200"}', 0);
INSERT INTO hangfire.state VALUES (150, 13, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:39:33.061689-05', '{"Queue": "default", "EnqueuedAt": "1731839973051"}', 0);
INSERT INTO hangfire.state VALUES (154, 14, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:41:03.132082-05', '{"Queue": "default", "EnqueuedAt": "1731840063128"}', 0);
INSERT INTO hangfire.state VALUES (171, 18, 'Processing', NULL, '2024-11-17 05:41:48.229233-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840108227"}', 0);
INSERT INTO hangfire.state VALUES (173, 18, 'Succeeded', NULL, '2024-11-17 05:41:51.71712-05', '{"Latency": "6955", "SucceededAt": "1731840111712", "PerformanceDuration": "3481"}', 0);
INSERT INTO hangfire.state VALUES (181, 21, 'Scheduled', NULL, '2024-11-17 05:42:45.460032-05', '{"EnqueueAt": "1731840165455", "ScheduledAt": "1731840165455"}', 0);
INSERT INTO hangfire.state VALUES (184, 21, 'Succeeded', NULL, '2024-11-17 05:42:51.875701-05', '{"Latency": "2871", "SucceededAt": "1731840171866", "PerformanceDuration": "3539"}', 0);
INSERT INTO hangfire.state VALUES (186, 22, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:03.332863-05', '{"Queue": "default", "EnqueuedAt": "1731840183329"}', 0);
INSERT INTO hangfire.state VALUES (205, 28, 'Scheduled', NULL, '2024-11-17 05:43:48.419533-05', '{"EnqueueAt": "1731840228415", "ScheduledAt": "1731840228415"}', 0);
INSERT INTO hangfire.state VALUES (207, 27, 'Processing', NULL, '2024-11-17 05:43:48.425466-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840228422"}', 0);
INSERT INTO hangfire.state VALUES (209, 28, 'Processing', NULL, '2024-11-17 05:43:48.435267-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "9b482651-7d19-40e6-97da-04aa32d3369e", "StartedAt": "1731840228433"}', 0);
INSERT INTO hangfire.state VALUES (211, 27, 'Succeeded', NULL, '2024-11-17 05:43:52.736064-05', '{"Latency": "6545", "SucceededAt": "1731840232732", "PerformanceDuration": "4301"}', 0);
INSERT INTO hangfire.state VALUES (218, 30, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:44:48.528684-05', '{"Queue": "default", "EnqueuedAt": "1731840288520"}', 0);
INSERT INTO hangfire.state VALUES (221, 31, 'Scheduled', NULL, '2024-11-17 05:46:04.164932-05', '{"EnqueueAt": "1731840364160", "ScheduledAt": "1731840364160"}', 0);
INSERT INTO hangfire.state VALUES (224, 31, 'Succeeded', NULL, '2024-11-17 05:46:22.185335-05', '{"Latency": "14468", "SucceededAt": "1731840382179", "PerformanceDuration": "3550"}', 0);
INSERT INTO hangfire.state VALUES (225, 32, 'Scheduled', NULL, '2024-11-17 05:46:28.458403-05', '{"EnqueueAt": "1731840388454", "ScheduledAt": "1731840388454"}', 0);
INSERT INTO hangfire.state VALUES (227, 32, 'Processing', NULL, '2024-11-17 05:46:33.709106-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840393706"}', 0);
INSERT INTO hangfire.state VALUES (234, 34, 'Processing', NULL, '2024-11-17 05:46:48.730779-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840408729"}', 0);
INSERT INTO hangfire.state VALUES (238, 36, 'Scheduled', NULL, '2024-11-17 05:46:59.952172-05', '{"EnqueueAt": "1731840419946", "ScheduledAt": "1731840419946"}', 0);
INSERT INTO hangfire.state VALUES (243, 37, 'Scheduled', NULL, '2024-11-17 05:47:06.473183-05', '{"EnqueueAt": "1731840426471", "ScheduledAt": "1731840426471"}', 0);
INSERT INTO hangfire.state VALUES (257, 39, 'Processing', NULL, '2024-11-17 05:47:33.911535-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840453909"}', 0);
INSERT INTO hangfire.state VALUES (259, 39, 'Succeeded', NULL, '2024-11-17 05:47:37.46725-05', '{"Latency": "11159", "SucceededAt": "1731840457461", "PerformanceDuration": "3547"}', 0);
INSERT INTO hangfire.state VALUES (273, 44, 'Scheduled', NULL, '2024-11-17 05:48:40.704536-05', '{"EnqueueAt": "1731840520700", "ScheduledAt": "1731840520700"}', 0);
INSERT INTO hangfire.state VALUES (281, 45, 'Succeeded', NULL, '2024-11-17 05:48:56.293211-05', '{"Latency": "1150", "SucceededAt": "1731840536290", "PerformanceDuration": "7259"}', 0);
INSERT INTO hangfire.state VALUES (309, 53, 'Scheduled', NULL, '2024-11-17 05:56:51.239436-05', '{"EnqueueAt": "1731841011233", "ScheduledAt": "1731841011233"}', 0);
INSERT INTO hangfire.state VALUES (312, 53, 'Succeeded', NULL, '2024-11-17 05:57:08.331148-05', '{"Latency": "13315", "SucceededAt": "1731841028315", "PerformanceDuration": "3765"}', 0);
INSERT INTO hangfire.state VALUES (313, 54, 'Scheduled', NULL, '2024-11-17 05:59:24.425854-05', '{"EnqueueAt": "1731841164422", "ScheduledAt": "1731841164422"}', 0);
INSERT INTO hangfire.state VALUES (151, 13, 'Processing', NULL, '2024-11-17 05:39:33.078907-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731839973070"}', 0);
INSERT INTO hangfire.state VALUES (170, 18, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:41:48.223556-05', '{"Queue": "default", "EnqueuedAt": "1731840108220"}', 0);
INSERT INTO hangfire.state VALUES (175, 19, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:42:03.237765-05', '{"Queue": "default", "EnqueuedAt": "1731840123233"}', 0);
INSERT INTO hangfire.state VALUES (176, 20, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:42:03.260853-05', '{"Queue": "default", "EnqueuedAt": "1731840123258"}', 0);
INSERT INTO hangfire.state VALUES (187, 22, 'Processing', NULL, '2024-11-17 05:43:03.340592-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840183336"}', 0);
INSERT INTO hangfire.state VALUES (190, 23, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:18.369063-05', '{"Queue": "default", "EnqueuedAt": "1731840198365"}', 0);
INSERT INTO hangfire.state VALUES (199, 26, 'Scheduled', NULL, '2024-11-17 05:43:35.836423-05', '{"EnqueueAt": "1731840215834", "ScheduledAt": "1731840215834"}', 0);
INSERT INTO hangfire.state VALUES (68, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 17:44:26.770398-05', '{"Queue": "default", "EnqueuedAt": "1728513866748"}', 0);
INSERT INTO hangfire.state VALUES (203, 26, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:48.414253-05', '{"Queue": "default", "EnqueuedAt": "1731840228409"}', 0);
INSERT INTO hangfire.state VALUES (70, 1, 'Processing', NULL, '2024-10-09 17:44:26.795382-05', '{"ServerId": "desk-0ur080r05:30984:d485bc95-19a4-4211-be38-437a16f9b498", "WorkerId": "b2790584-86fd-4400-9138-7a3998cd8bb6", "StartedAt": "1728513866775"}', 0);
INSERT INTO hangfire.state VALUES (204, 27, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:48.419264-05', '{"Queue": "default", "EnqueuedAt": "1731840228416"}', 0);
INSERT INTO hangfire.state VALUES (219, 30, 'Processing', NULL, '2024-11-17 05:44:48.539091-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840288534"}', 0);
INSERT INTO hangfire.state VALUES (223, 31, 'Processing', NULL, '2024-11-17 05:46:18.627196-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840378625"}', 0);
INSERT INTO hangfire.state VALUES (226, 32, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:46:33.702272-05', '{"Queue": "default", "EnqueuedAt": "1731840393698"}', 0);
INSERT INTO hangfire.state VALUES (229, 33, 'Scheduled', NULL, '2024-11-17 05:46:37.864769-05', '{"EnqueueAt": "1731840397856", "ScheduledAt": "1731840397856"}', 0);
INSERT INTO hangfire.state VALUES (76, 1, 'Processing', NULL, '2024-10-09 18:23:02.953368-05', '{"ServerId": "desk-0ur080r05:10424:60bb1872-70ae-4ec6-8a63-1c94189f608f", "WorkerId": "12020572-fcb4-442c-ba70-dd0d8ca9cd0c", "StartedAt": "1728516182682"}', 0);
INSERT INTO hangfire.state VALUES (237, 35, 'Scheduled', NULL, '2024-11-17 05:46:54.341042-05', '{"EnqueueAt": "1731840414339", "ScheduledAt": "1731840414339"}', 0);
INSERT INTO hangfire.state VALUES (244, 36, 'Succeeded', NULL, '2024-11-17 05:47:07.531857-05', '{"Latency": "3822", "SucceededAt": "1731840427523", "PerformanceDuration": "3755"}', 0);
INSERT INTO hangfire.state VALUES (245, 35, 'Succeeded', NULL, '2024-11-17 05:47:08.095071-05', '{"Latency": "9423", "SucceededAt": "1731840428092", "PerformanceDuration": "4329"}', 0);
INSERT INTO hangfire.state VALUES (247, 37, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:18.794374-05', '{"Queue": "default", "EnqueuedAt": "1731840438788"}', 0);
INSERT INTO hangfire.state VALUES (248, 38, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:18.805183-05', '{"Queue": "default", "EnqueuedAt": "1731840438799"}', 0);
INSERT INTO hangfire.state VALUES (250, 38, 'Processing', NULL, '2024-11-17 05:47:18.812785-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840438810"}', 0);
INSERT INTO hangfire.state VALUES (252, 39, 'Scheduled', NULL, '2024-11-17 05:47:22.756623-05', '{"EnqueueAt": "1731840442754", "ScheduledAt": "1731840442754"}', 0);
INSERT INTO hangfire.state VALUES (255, 39, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:33.906675-05', '{"Queue": "default", "EnqueuedAt": "1731840453904"}', 0);
INSERT INTO hangfire.state VALUES (256, 40, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:33.911256-05', '{"Queue": "default", "EnqueuedAt": "1731840453908"}', 0);
INSERT INTO hangfire.state VALUES (260, 40, 'Succeeded', NULL, '2024-11-17 05:47:37.894813-05', '{"Latency": "1448", "SucceededAt": "1731840457891", "PerformanceDuration": "3974"}', 0);
INSERT INTO hangfire.state VALUES (262, 41, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:47:48.936997-05', '{"Queue": "default", "EnqueuedAt": "1731840468932"}', 0);
INSERT INTO hangfire.state VALUES (265, 42, 'Scheduled', NULL, '2024-11-17 05:48:24.881417-05', '{"EnqueueAt": "1731840504860", "ScheduledAt": "1731840504860"}', 0);
INSERT INTO hangfire.state VALUES (266, 43, 'Scheduled', NULL, '2024-11-17 05:48:31.915014-05', '{"EnqueueAt": "1731840511913", "ScheduledAt": "1731840511913"}', 0);
INSERT INTO hangfire.state VALUES (269, 42, 'Processing', NULL, '2024-11-17 05:48:34.001601-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840513999"}', 0);
INSERT INTO hangfire.state VALUES (271, 43, 'Succeeded', NULL, '2024-11-17 05:48:37.296635-05', '{"Latency": "2093", "SucceededAt": "1731840517292", "PerformanceDuration": "3284"}', 0);
INSERT INTO hangfire.state VALUES (272, 42, 'Succeeded', NULL, '2024-11-17 05:48:38.451524-05', '{"Latency": "9143", "SucceededAt": "1731840518447", "PerformanceDuration": "4443"}', 0);
INSERT INTO hangfire.state VALUES (280, 46, 'Scheduled', NULL, '2024-11-17 05:48:55.345579-05', '{"EnqueueAt": "1731840535343", "ScheduledAt": "1731840535343"}', 0);
INSERT INTO hangfire.state VALUES (311, 53, 'Processing', NULL, '2024-11-17 05:57:04.547548-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841024545"}', 0);
INSERT INTO hangfire.state VALUES (152, 13, 'Succeeded', NULL, '2024-11-17 05:39:36.964655-05', '{"Latency": "4410", "SucceededAt": "1731839976951", "PerformanceDuration": "3868"}', 0);
INSERT INTO hangfire.state VALUES (159, 15, 'Processing', NULL, '2024-11-17 05:41:18.173975-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840078172"}', 0);
INSERT INTO hangfire.state VALUES (82, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 18:23:31.946821-05', '{"FailedAt": "1728516211861", "ServerId": "desk-0ur080r05:10424:60bb1872-70ae-4ec6-8a63-1c94189f608f", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Plagiarisms_CodeId_Algorithm\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Plagiarisms\r\n    ConstraintName: IX_Plagiarisms_CodeId_Algorithm\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 168\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (83, 1, 'Scheduled', 'Retry attempt 7 of 10: An error occurred while saving the entity changes…', '2024-10-09 18:23:31.96064-05', '{"EnqueueAt": "1728517543924", "ScheduledAt": "1728516211925"}', 0);
INSERT INTO hangfire.state VALUES (167, 17, 'Succeeded', NULL, '2024-11-17 05:41:36.713194-05', '{"Latency": "235", "SucceededAt": "1731840096709", "PerformanceDuration": "3501"}', 0);
INSERT INTO hangfire.state VALUES (178, 20, 'Processing', NULL, '2024-11-17 05:42:03.268052-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840123264"}', 0);
INSERT INTO hangfire.state VALUES (182, 21, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:42:48.319611-05', '{"Queue": "default", "EnqueuedAt": "1731840168316"}', 0);
INSERT INTO hangfire.state VALUES (189, 23, 'Scheduled', NULL, '2024-11-17 05:43:09.790877-05', '{"EnqueueAt": "1731840189789", "ScheduledAt": "1731840189789"}', 0);
INSERT INTO hangfire.state VALUES (195, 24, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:33.396854-05', '{"Queue": "default", "EnqueuedAt": "1731840213394"}', 0);
INSERT INTO hangfire.state VALUES (196, 25, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:33.401395-05', '{"Queue": "default", "EnqueuedAt": "1731840213399"}', 0);
INSERT INTO hangfire.state VALUES (212, 28, 'Succeeded', NULL, '2024-11-17 05:43:53.222897-05', '{"Latency": "21", "SucceededAt": "1731840233219", "PerformanceDuration": "4781"}', 0);
INSERT INTO hangfire.state VALUES (220, 30, 'Succeeded', NULL, '2024-11-17 05:44:52.598775-05', '{"Latency": "10033", "SucceededAt": "1731840292593", "PerformanceDuration": "4044"}', 0);
INSERT INTO hangfire.state VALUES (222, 31, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:46:18.621651-05', '{"Queue": "default", "EnqueuedAt": "1731840378618"}', 0);
INSERT INTO hangfire.state VALUES (228, 32, 'Succeeded', NULL, '2024-11-17 05:46:37.564105-05', '{"Latency": "5256", "SucceededAt": "1731840397559", "PerformanceDuration": "3848"}', 0);
INSERT INTO hangfire.state VALUES (230, 34, 'Scheduled', NULL, '2024-11-17 05:46:48.545476-05', '{"EnqueueAt": "1731840408543", "ScheduledAt": "1731840408543"}', 0);
INSERT INTO hangfire.state VALUES (233, 33, 'Processing', NULL, '2024-11-17 05:46:48.726494-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840408724"}', 0);
INSERT INTO hangfire.state VALUES (235, 34, 'Succeeded', NULL, '2024-11-17 05:46:52.513504-05', '{"Latency": "188", "SucceededAt": "1731840412506", "PerformanceDuration": "3774"}', 0);
INSERT INTO hangfire.state VALUES (241, 35, 'Processing', NULL, '2024-11-17 05:47:03.760237-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840423757"}', 0);
INSERT INTO hangfire.state VALUES (246, 38, 'Scheduled', NULL, '2024-11-17 05:47:14.603672-05', '{"EnqueueAt": "1731840434600", "ScheduledAt": "1731840434600"}', 0);
INSERT INTO hangfire.state VALUES (249, 37, 'Processing', NULL, '2024-11-17 05:47:18.805492-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840438801"}', 0);
INSERT INTO hangfire.state VALUES (253, 38, 'Succeeded', NULL, '2024-11-17 05:47:22.948875-05', '{"Latency": "4214", "SucceededAt": "1731840442945", "PerformanceDuration": "4130"}', 0);
INSERT INTO hangfire.state VALUES (254, 40, 'Scheduled', NULL, '2024-11-17 05:47:32.473241-05', '{"EnqueueAt": "1731840452468", "ScheduledAt": "1731840452468"}', 0);
INSERT INTO hangfire.state VALUES (258, 40, 'Processing', NULL, '2024-11-17 05:47:33.915402-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840453913"}', 0);
INSERT INTO hangfire.state VALUES (277, 44, 'Processing', NULL, '2024-11-17 05:48:49.023819-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840529022"}', 0);
INSERT INTO hangfire.state VALUES (278, 45, 'Processing', NULL, '2024-11-17 05:48:49.028389-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840529026"}', 0);
INSERT INTO hangfire.state VALUES (314, 54, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:59:34.672655-05', '{"Queue": "default", "EnqueuedAt": "1731841174663"}', 0);
INSERT INTO hangfire.state VALUES (315, 54, 'Processing', NULL, '2024-11-17 05:59:34.739178-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841174737"}', 0);
INSERT INTO hangfire.state VALUES (316, 54, 'Succeeded', NULL, '2024-11-17 05:59:39.043723-05', '{"Latency": "10318", "SucceededAt": "1731841179037", "PerformanceDuration": "4296"}', 0);
INSERT INTO hangfire.state VALUES (319, 55, 'Processing', NULL, '2024-11-17 06:00:34.738023-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841234736"}', 0);
INSERT INTO hangfire.state VALUES (320, 55, 'Succeeded', NULL, '2024-11-17 06:00:38.39864-05', '{"Latency": "11154", "SucceededAt": "1731841238393", "PerformanceDuration": "3653"}', 0);
INSERT INTO hangfire.state VALUES (322, 56, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:03:19.900114-05', '{"Queue": "default", "EnqueuedAt": "1731841399897"}', 0);
INSERT INTO hangfire.state VALUES (325, 57, 'Scheduled', NULL, '2024-11-17 06:03:54.050059-05', '{"EnqueueAt": "1731841434046", "ScheduledAt": "1731841434046"}', 0);
INSERT INTO hangfire.state VALUES (326, 57, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:04:04.943039-05', '{"Queue": "default", "EnqueuedAt": "1731841444939"}', 0);
INSERT INTO hangfire.state VALUES (153, 14, 'Scheduled', NULL, '2024-11-17 05:40:48.874235-05', '{"EnqueueAt": "1731840048865", "ScheduledAt": "1731840048865"}', 0);
INSERT INTO hangfire.state VALUES (155, 14, 'Processing', NULL, '2024-11-17 05:41:03.138036-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840063135"}', 0);
INSERT INTO hangfire.state VALUES (158, 15, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:41:18.168773-05', '{"Queue": "default", "EnqueuedAt": "1731840078151"}', 0);
INSERT INTO hangfire.state VALUES (174, 20, 'Scheduled', NULL, '2024-11-17 05:41:54.858077-05', '{"EnqueueAt": "1731840114855", "ScheduledAt": "1731840114855"}', 0);
INSERT INTO hangfire.state VALUES (192, 24, 'Scheduled', NULL, '2024-11-17 05:43:20.183191-05', '{"EnqueueAt": "1731840200178", "ScheduledAt": "1731840200178"}', 0);
INSERT INTO hangfire.state VALUES (93, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-09 19:39:29.261408-05', '{"Queue": "default", "EnqueuedAt": "1728520769243"}', 0);
INSERT INTO hangfire.state VALUES (200, 24, 'Succeeded', NULL, '2024-11-17 05:43:37.05056-05', '{"Latency": "13224", "SucceededAt": "1731840217046", "PerformanceDuration": "3643"}', 0);
INSERT INTO hangfire.state VALUES (206, 26, 'Processing', NULL, '2024-11-17 05:43:48.419677-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840228417"}', 0);
INSERT INTO hangfire.state VALUES (96, 1, 'Processing', NULL, '2024-10-09 19:39:29.46723-05', '{"ServerId": "desk-0ur080r05:1776:50bc233b-01f0-4b11-86a7-92ebae5d1365", "WorkerId": "2e9559ad-b9b5-461c-b414-279c69a4ba40", "StartedAt": "1728520769443"}', 0);
INSERT INTO hangfire.state VALUES (282, 47, 'Scheduled', NULL, '2024-11-17 05:49:01.713512-05', '{"EnqueueAt": "1731840541711", "ScheduledAt": "1731840541711"}', 0);
INSERT INTO hangfire.state VALUES (98, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-09 19:39:33.949685-05', '{"FailedAt": "1728520773855", "ServerId": "desk-0ur080r05:1776:50bc233b-01f0-4b11-86a7-92ebae5d1365", "ExceptionType": "System.InvalidOperationException", "ExceptionDetails": "System.InvalidOperationException: An exception has been raised that is likely due to a transient failure.\r\n ---> Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 40P01: deadlock detected\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 40P01\r\n    MessageText: deadlock detected\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    Hint: See server log for query details.\r\n    Where: while inserting index tuple (18,2) in relation \"IX_Codes_SubmissionId_FileName\"\r\n    File: deadlock.c\r\n    Line: 1152\r\n    Routine: DeadLockReport\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   --- End of inner exception stack trace ---\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 90\r\n   at InvokeStub_TaskAwaiter.GetResult(Object, Object, IntPtr*)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An exception has been raised that is likely due to a transient failure."}', 0);
INSERT INTO hangfire.state VALUES (101, 1, 'Scheduled', 'Retry attempt 8 of 10: An exception has been raised that is likely due t…', '2024-10-09 19:39:33.98946-05', '{"EnqueueAt": "1728523421887", "ScheduledAt": "1728520773887"}', 0);
INSERT INTO hangfire.state VALUES (285, 46, 'Processing', NULL, '2024-11-17 05:49:04.045236-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840544043"}', 0);
INSERT INTO hangfire.state VALUES (287, 48, 'Scheduled', NULL, '2024-11-17 05:49:07.839685-05', '{"EnqueueAt": "1731840547819", "ScheduledAt": "1731840547819"}', 0);
INSERT INTO hangfire.state VALUES (297, 48, 'Succeeded', NULL, '2024-11-17 05:49:23.784383-05', '{"Latency": "11256", "SucceededAt": "1731840563781", "PerformanceDuration": "4704"}', 0);
INSERT INTO hangfire.state VALUES (317, 55, 'Scheduled', NULL, '2024-11-17 06:00:23.590065-05', '{"EnqueueAt": "1731841223585", "ScheduledAt": "1731841223585"}', 0);
INSERT INTO hangfire.state VALUES (318, 55, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:00:34.732605-05', '{"Queue": "default", "EnqueuedAt": "1731841234730"}', 0);
INSERT INTO hangfire.state VALUES (321, 56, 'Scheduled', NULL, '2024-11-17 06:03:16.541153-05', '{"EnqueueAt": "1731841396538", "ScheduledAt": "1731841396538"}', 0);
INSERT INTO hangfire.state VALUES (323, 56, 'Processing', NULL, '2024-11-17 06:03:19.905289-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841399903"}', 0);
INSERT INTO hangfire.state VALUES (324, 56, 'Succeeded', NULL, '2024-11-17 06:03:23.578668-05', '{"Latency": "3368", "SucceededAt": "1731841403574", "PerformanceDuration": "3666"}', 0);
INSERT INTO hangfire.state VALUES (327, 57, 'Processing', NULL, '2024-11-17 06:04:04.947471-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841444945"}', 0);
INSERT INTO hangfire.state VALUES (328, 57, 'Succeeded', NULL, '2024-11-17 06:04:08.78546-05', '{"Latency": "10902", "SucceededAt": "1731841448782", "PerformanceDuration": "3833"}', 0);
INSERT INTO hangfire.state VALUES (329, 58, 'Scheduled', NULL, '2024-11-17 06:04:29.64448-05', '{"EnqueueAt": "1731841469642", "ScheduledAt": "1731841469642"}', 0);
INSERT INTO hangfire.state VALUES (156, 14, 'Succeeded', NULL, '2024-11-17 05:41:06.81457-05', '{"Latency": "14274", "SucceededAt": "1731840066808", "PerformanceDuration": "3668"}', 0);
INSERT INTO hangfire.state VALUES (157, 15, 'Scheduled', NULL, '2024-11-17 05:41:14.432697-05', '{"EnqueueAt": "1731840074412", "ScheduledAt": "1731840074412"}', 0);
INSERT INTO hangfire.state VALUES (163, 16, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:41:33.195072-05', '{"Queue": "default", "EnqueuedAt": "1731840093191"}', 0);
INSERT INTO hangfire.state VALUES (164, 17, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:41:33.201143-05', '{"Queue": "default", "EnqueuedAt": "1731840093198"}', 0);
INSERT INTO hangfire.state VALUES (172, 19, 'Scheduled', NULL, '2024-11-17 05:41:48.456802-05', '{"EnqueueAt": "1731840108453", "ScheduledAt": "1731840108453"}', 0);
INSERT INTO hangfire.state VALUES (177, 19, 'Processing', NULL, '2024-11-17 05:42:03.264146-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840123258"}', 0);
INSERT INTO hangfire.state VALUES (109, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-10 03:59:04.786036-05', '{"Queue": "default", "EnqueuedAt": "1728550744708"}', 0);
INSERT INTO hangfire.state VALUES (180, 20, 'Succeeded', NULL, '2024-11-17 05:42:07.978309-05', '{"Latency": "8413", "SucceededAt": "1731840127975", "PerformanceDuration": "4705"}', 0);
INSERT INTO hangfire.state VALUES (110, 1, 'Processing', NULL, '2024-10-10 03:59:04.834594-05', '{"ServerId": "desk-0ur080r05:6004:563e2901-c434-4b7a-a8f9-ef5901b49f59", "WorkerId": "334b7435-0b4c-43e0-9790-a3631f59cab6", "StartedAt": "1728550744793"}', 0);
INSERT INTO hangfire.state VALUES (111, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-10 03:59:08.539216-05', '{"FailedAt": "1728550748477", "ServerId": "desk-0ur080r05:6004:563e2901-c434-4b7a-a8f9-ef5901b49f59", "ExceptionType": "System.InvalidOperationException", "ExceptionDetails": "System.InvalidOperationException: An exception has been raised that is likely due to a transient failure.\r\n ---> Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 40P01: deadlock detected\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 40P01\r\n    MessageText: deadlock detected\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    Hint: See server log for query details.\r\n    Where: while inserting index tuple (0,16) in relation \"IX_Codes_SubmissionId_FileName\"\r\n    File: deadlock.c\r\n    Line: 1152\r\n    Routine: DeadLockReport\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   --- End of inner exception stack trace ---\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 90\r\n   at InvokeStub_TaskAwaiter.GetResult(Object, Object, IntPtr*)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An exception has been raised that is likely due to a transient failure."}', 0);
INSERT INTO hangfire.state VALUES (112, 1, 'Scheduled', 'Retry attempt 9 of 10: An exception has been raised that is likely due t…', '2024-10-10 03:59:08.570704-05', '{"EnqueueAt": "1728555075520", "ScheduledAt": "1728550748520"}', 0);
INSERT INTO hangfire.state VALUES (191, 23, 'Processing', NULL, '2024-11-17 05:43:18.375075-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840198372"}', 0);
INSERT INTO hangfire.state VALUES (114, 1, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-10-11 21:37:44.497893-05', '{"Queue": "default", "EnqueuedAt": "1728700663904"}', 0);
INSERT INTO hangfire.state VALUES (115, 1, 'Processing', NULL, '2024-10-11 21:37:44.633971-05', '{"ServerId": "desk-0ur080r05:18584:234b8529-fb5e-43ac-8015-302471f82311", "WorkerId": "92b33af3-70c9-4380-a732-0faef3acaf5a", "StartedAt": "1728700664589"}', 0);
INSERT INTO hangfire.state VALUES (193, 23, 'Succeeded', NULL, '2024-11-17 05:43:21.597139-05', '{"Latency": "8587", "SucceededAt": "1731840201592", "PerformanceDuration": "3215"}', 0);
INSERT INTO hangfire.state VALUES (197, 24, 'Processing', NULL, '2024-11-17 05:43:33.401441-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840213399"}', 0);
INSERT INTO hangfire.state VALUES (198, 25, 'Processing', NULL, '2024-11-17 05:43:33.406138-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840213404"}', 0);
INSERT INTO hangfire.state VALUES (208, 28, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:43:48.430131-05', '{"Queue": "default", "EnqueuedAt": "1731840228424"}', 0);
INSERT INTO hangfire.state VALUES (210, 26, 'Succeeded', NULL, '2024-11-17 05:43:51.894592-05', '{"Latency": "12586", "SucceededAt": "1731840231891", "PerformanceDuration": "3469"}', 0);
INSERT INTO hangfire.state VALUES (283, 46, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:49:04.037851-05', '{"Queue": "default", "EnqueuedAt": "1731840544035"}', 0);
INSERT INTO hangfire.state VALUES (284, 47, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 05:49:04.045067-05', '{"Queue": "default", "EnqueuedAt": "1731840544042"}', 0);
INSERT INTO hangfire.state VALUES (286, 47, 'Processing', NULL, '2024-11-17 05:49:04.051196-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840544049"}', 0);
INSERT INTO hangfire.state VALUES (290, 49, 'Scheduled', NULL, '2024-11-17 05:49:14.227555-05', '{"EnqueueAt": "1731840554224", "ScheduledAt": "1731840554224"}', 0);
INSERT INTO hangfire.state VALUES (293, 48, 'Processing', NULL, '2024-11-17 05:49:19.07501-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840559073"}', 0);
INSERT INTO hangfire.state VALUES (294, 49, 'Processing', NULL, '2024-11-17 05:49:19.079586-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "2bf407a2-65ad-4ab7-8d7f-66cf08a063d7", "StartedAt": "1731840559077"}', 0);
INSERT INTO hangfire.state VALUES (330, 58, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:04:35.045269-05', '{"Queue": "default", "EnqueuedAt": "1731841475025"}', 0);
INSERT INTO hangfire.state VALUES (331, 58, 'Processing', NULL, '2024-11-17 06:04:35.10721-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841475105"}', 0);
INSERT INTO hangfire.state VALUES (332, 58, 'Succeeded', NULL, '2024-11-17 06:04:38.699564-05', '{"Latency": "5466", "SucceededAt": "1731841478692", "PerformanceDuration": "3583"}', 0);
INSERT INTO hangfire.state VALUES (334, 59, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:05:35.091791-05', '{"Queue": "default", "EnqueuedAt": "1731841535084"}', 0);
INSERT INTO hangfire.state VALUES (337, 60, 'Scheduled', NULL, '2024-11-17 06:06:29.869067-05', '{"EnqueueAt": "1731841589857", "ScheduledAt": "1731841589857"}', 0);
INSERT INTO hangfire.state VALUES (339, 60, 'Processing', NULL, '2024-11-17 06:06:35.163588-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841595161"}', 0);
INSERT INTO hangfire.state VALUES (116, 1, 'Failed', 'An exception occurred during performance of the job.', '2024-10-11 21:37:49.866387-05', '{"FailedAt": "1728700669810", "ServerId": "desk-0ur080r05:18584:234b8529-fb5e-43ac-8015-302471f82311", "ExceptionType": "Microsoft.EntityFrameworkCore.DbUpdateException", "ExceptionDetails": "Microsoft.EntityFrameworkCore.DbUpdateException: An error occurred while saving the entity changes. See the inner exception for details.\r\n ---> Npgsql.PostgresException (0x80004005): 23505: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n\r\nDETAIL: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n   at Npgsql.Internal.NpgsqlConnector.ReadMessageLong(Boolean async, DataRowLoadingMode dataRowLoadingMode, Boolean readingNotifications, Boolean isReadingPrependedMessage)\r\n   at System.Runtime.CompilerServices.PoolingAsyncValueTaskMethodBuilder`1.StateMachineBox`1.System.Threading.Tasks.Sources.IValueTaskSource<TResult>.GetResult(Int16 token)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlDataReader.NextResult(Boolean async, Boolean isConsuming, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteReader(Boolean async, CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Npgsql.NpgsqlCommand.ExecuteDbDataReaderAsync(CommandBehavior behavior, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Storage.RelationalCommand.ExecuteReaderAsync(RelationalCommandParameterObject parameterObject, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n  Exception data:\r\n    Severity: ERROR\r\n    SqlState: 23505\r\n    MessageText: duplicate key value violates unique constraint \"IX_Codes_SubmissionId_FileName\"\r\n    Detail: Detail redacted as it may contain sensitive data. Specify ''Include Error Detail'' in the connection string to include this information.\r\n    SchemaName: public\r\n    TableName: Codes\r\n    ConstraintName: IX_Codes_SubmissionId_FileName\r\n    File: nbtinsert.c\r\n    Line: 671\r\n    Routine: _bt_check_unique\r\n   --- End of inner exception stack trace ---\r\n   at Microsoft.EntityFrameworkCore.Update.ReaderModificationCommandBatch.ExecuteAsync(IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.Update.Internal.BatchExecutor.ExecuteAsync(IEnumerable`1 commandBatches, IRelationalConnection connection, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(IList`1 entriesToSave, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.ChangeTracking.Internal.StateManager.SaveChangesAsync(StateManager stateManager, Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Npgsql.EntityFrameworkCore.PostgreSQL.Storage.Internal.NpgsqlExecutionStrategy.ExecuteAsync[TState,TResult](TState state, Func`4 operation, Func`4 verifySucceeded, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at Microsoft.EntityFrameworkCore.DbContext.SaveChangesAsync(Boolean acceptAllChangesOnSuccess, CancellationToken cancellationToken)\r\n   at PlagiTracker.WebAPI.HangFire.HangFireServices.SavePlagiarismReport(Guid assignmentId, String analysisResultJson, Dictionary`2 analysisResult) in E:\\UNI\\semester-9\\Configuration and Change Management\\Plagitracker\\Backend\\PlagiTracker\\PlagiTracker.WebAPI\\HangFire\\HangFireServices.cs:line 90\r\n   at System.RuntimeMethodHandle.InvokeMethod(Object target, Void** arguments, Signature sig, Boolean isConstructor)\r\n   at System.Reflection.MethodBaseInvoker.InvokeWithNoArgs(Object obj, BindingFlags invokeAttr)", "ExceptionMessage": "An error occurred while saving the entity changes. See the inner exception for details."}', 0);
INSERT INTO hangfire.state VALUES (117, 1, 'Scheduled', 'Retry attempt 10 of 10: An error occurred while saving the entity changes…', '2024-10-11 21:37:49.926613-05', '{"EnqueueAt": "1728707455839", "ScheduledAt": "1728700669839"}', 0);
INSERT INTO hangfire.state VALUES (160, 15, 'Succeeded', NULL, '2024-11-17 05:41:21.715062-05', '{"Latency": "3763", "SucceededAt": "1731840081703", "PerformanceDuration": "3528"}', 0);
INSERT INTO hangfire.state VALUES (161, 16, 'Scheduled', NULL, '2024-11-17 05:41:23.59098-05', '{"EnqueueAt": "1731840083583", "ScheduledAt": "1731840083583"}', 0);
INSERT INTO hangfire.state VALUES (162, 17, 'Scheduled', NULL, '2024-11-17 05:41:32.999289-05', '{"EnqueueAt": "1731840092972", "ScheduledAt": "1731840092972"}', 0);
INSERT INTO hangfire.state VALUES (165, 16, 'Processing', NULL, '2024-11-17 05:41:33.201111-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840093198"}', 0);
INSERT INTO hangfire.state VALUES (166, 17, 'Processing', NULL, '2024-11-17 05:41:33.20613-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "9b482651-7d19-40e6-97da-04aa32d3369e", "StartedAt": "1731840093204"}', 0);
INSERT INTO hangfire.state VALUES (168, 16, 'Succeeded', NULL, '2024-11-17 05:41:37.275528-05', '{"Latency": "9619", "SucceededAt": "1731840097272", "PerformanceDuration": "4069"}', 0);
INSERT INTO hangfire.state VALUES (169, 18, 'Scheduled', NULL, '2024-11-17 05:41:41.277063-05', '{"EnqueueAt": "1731840101275", "ScheduledAt": "1731840101275"}', 0);
INSERT INTO hangfire.state VALUES (179, 19, 'Succeeded', NULL, '2024-11-17 05:42:06.792014-05', '{"Latency": "14812", "SucceededAt": "1731840126774", "PerformanceDuration": "3508"}', 0);
INSERT INTO hangfire.state VALUES (183, 21, 'Processing', NULL, '2024-11-17 05:42:48.32592-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731840168323"}', 0);
INSERT INTO hangfire.state VALUES (185, 22, 'Scheduled', NULL, '2024-11-17 05:43:01.358252-05', '{"EnqueueAt": "1731840181352", "ScheduledAt": "1731840181352"}', 0);
INSERT INTO hangfire.state VALUES (188, 22, 'Succeeded', NULL, '2024-11-17 05:43:06.886955-05', '{"Latency": "1991", "SucceededAt": "1731840186881", "PerformanceDuration": "3538"}', 0);
INSERT INTO hangfire.state VALUES (194, 25, 'Scheduled', NULL, '2024-11-17 05:43:28.650845-05', '{"EnqueueAt": "1731840208648", "ScheduledAt": "1731840208648"}', 0);
INSERT INTO hangfire.state VALUES (201, 25, 'Succeeded', NULL, '2024-11-17 05:43:37.52151-05', '{"Latency": "4759", "SucceededAt": "1731840217518", "PerformanceDuration": "4110"}', 0);
INSERT INTO hangfire.state VALUES (202, 27, 'Scheduled', NULL, '2024-11-17 05:43:41.887832-05', '{"EnqueueAt": "1731840221885", "ScheduledAt": "1731840221885"}', 0);
INSERT INTO hangfire.state VALUES (288, 46, 'Succeeded', NULL, '2024-11-17 05:49:07.889098-05', '{"Latency": "8703", "SucceededAt": "1731840547886", "PerformanceDuration": "3839"}', 0);
INSERT INTO hangfire.state VALUES (289, 47, 'Succeeded', NULL, '2024-11-17 05:49:08.392613-05', '{"Latency": "2341", "SucceededAt": "1731840548387", "PerformanceDuration": "4334"}', 0);
INSERT INTO hangfire.state VALUES (296, 49, 'Succeeded', NULL, '2024-11-17 05:49:22.603857-05', '{"Latency": "4856", "SucceededAt": "1731840562600", "PerformanceDuration": "3519"}', 0);
INSERT INTO hangfire.state VALUES (333, 59, 'Scheduled', NULL, '2024-11-17 06:05:31.239353-05', '{"EnqueueAt": "1731841531234", "ScheduledAt": "1731841531234"}', 0);
INSERT INTO hangfire.state VALUES (335, 59, 'Processing', NULL, '2024-11-17 06:05:35.106758-05', '{"ServerId": "desk-0ur080r05:13200:51949358-c0ef-483c-ac7e-0e138ad5717f", "WorkerId": "d5f1f54a-97f8-4c6a-bbd9-e8bfea76fb69", "StartedAt": "1731841535103"}', 0);
INSERT INTO hangfire.state VALUES (336, 59, 'Succeeded', NULL, '2024-11-17 06:05:38.685654-05', '{"Latency": "3874", "SucceededAt": "1731841538678", "PerformanceDuration": "3568"}', 0);
INSERT INTO hangfire.state VALUES (338, 60, 'Enqueued', 'Triggered by DelayedJobScheduler', '2024-11-17 06:06:35.158099-05', '{"Queue": "default", "EnqueuedAt": "1731841595155"}', 0);


--
-- TOC entry 3609 (class 0 OID 49935)
-- Dependencies: 241
-- Data for Name: Assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Assignments" VALUES ('ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '', 'Programación Orientada a Objetos', '2024-12-07 10:14:26.713-05', '2024-10-09 18:40:04.711558-05', true, '5500125e-16f5-4b77-9220-cc4dab69c100', '-infinity', true, '-infinity');


--
-- TOC entry 3615 (class 0 OID 50036)
-- Dependencies: 247
-- Data for Name: Classes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3612 (class 0 OID 49977)
-- Dependencies: 244
-- Data for Name: Codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Codes" VALUES ('29198014-716f-4601-9fa4-bd1c8438b389', '6e701991-2a14-4493-a170-f4fe910e9c4a', 'Calculadora.java', 'package com.example;

public class Calculadora {
public static double dividir(int numerador, int denominador) throws DivisionPorCeroException {
if (denominador == 0) {
throw new DivisionPorCeroException("Error: División por cero no permitida.");
}
return (double) numerador / denominador;
}

public static void main(String[] args) {
try {
System.out.println("Resultado: " + dividir(10, 0));
} catch (DivisionPorCeroException e) {
System.err.println(e.getMessage());
}
}
}

', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('b3cff7d1-c24d-4814-a541-aa0c5c435a03', '6e701991-2a14-4493-a170-f4fe910e9c4a', 'DivisionPorCeroException.java', '

















package com.example;

public class DivisionPorCeroException extends Exception {
public DivisionPorCeroException(String mensaje) {
super(mensaje);
}
}
', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('e3f3df6d-866b-47a0-9ba8-57a34456a1db', '6e701991-2a14-4493-a170-f4fe910e9c4a', 'Main.java', '

























package com.example;

class Main {

public static void main(String[] args) {

System.out.println("Hello World!");
}
}', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('4abb984e-aead-4b40-88b0-8c801fdde54c', '31edb16a-feb4-4cab-812c-e8a4bdb6ad45', 'HelloCodiva.java', '
package com.example;

class HelloCodiva {
public static void main(String[] args) {
int a = 15;
int b = 20; // will generate an error
int c = 654;
System.out.println(a+b+c);
}
}
', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', '31edb16a-feb4-4cab-812c-e8a4bdb6ad45', 'Main.java', '










package com.example;

public class Main {
public static void main(String[] args) {
int myNum = 5;               // integer (whole number)
float myFloatNum = 5.99f;    // floating point number
char myLetter = ''D'';         // character
boolean myBool = true;       // boolean
String myText = "Hello";     // String
System.out.println(myNum);
System.out.println(myFloatNum);
System.out.println(myLetter);
System.out.println(myBool);
System.out.println(myText);
}
}', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('301e8585-ac92-4bd2-809b-262228bcc1c1', 'e0d30fd2-1027-4af3-be3b-238a579dacb8', 'HelloCodiva.java', 'package com.example;

class HelloCodiva {

public static void main(String[] args) {

String greeting = "Hello World";
System.out.println(greeting);

}
}
', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('32914a3b-9b54-4e6b-ad27-033693f8e181', 'e0d30fd2-1027-4af3-be3b-238a579dacb8', 'Main.java', '










package com.example;

class Main {
public static void main(String[] args) {
char myLetter = ''D'';         // character
boolean myBool = true;       // boolean
String myText = "Hello";     // String

int myNum = 5;
float myFloatNum = 5.99f;

System.out.println(myNum);
System.out.println(myFloatNum);
System.out.println(myLetter);
System.out.println(myBool);
System.out.println(myText);
}
}', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('114d5b4c-dc7d-4236-8a25-3ea837565ccb', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'Diccionario.java', '
























import java.util.HashMap;

public class Diccionario {
public static void main(String[] args) {
// Crear un HashMap para almacenar palabras y sus definiciones
HashMap<String, String> diccionario = new HashMap<>();

// Añadir elementos al diccionario
diccionario.put("Java", "Lenguaje de programación orientado a objetos.");
diccionario.put("Python", "Lenguaje de programación de alto nivel.");
diccionario.put("HTML", "Lenguaje de marcado para crear páginas web.");

// Buscar y mostrar una definición
String palabra = "Java";
if (diccionario.containsKey(palabra)) {
System.out.println(palabra + ": " + diccionario.get(palabra));
} else {
System.out.println("Palabra no encontrada en el diccionario.");
}

// Mostrar todas las palabras en el diccionario
System.out.println("\nPalabras en el diccionario:");
for (String key : diccionario.keySet()) {
System.out.println(key + ": " + diccionario.get(key));
}
}
}



', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('6086a89a-4585-4fe3-9e27-eaa3d95aa880', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'asf.java', '













































































































class asf {
public static void main(String[] args) {

System.out.println("Hello Codiva");

}
}

', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'FileHandler.java', '



















































import java.io.*;

public class FileHandler {
public static void main(String[] args) {
String fileName = "example.txt";

// Escribir en un archivo
try (BufferedWriter writer = new BufferedWriter(new FileWriter(fileName))) {
writer.write("Este es un ejemplo de escritura en archivo.");
writer.newLine();
writer.write("Java es genial para manejar archivos.");
System.out.println("Escritura en archivo completada.");
} catch (IOException e) {
System.err.println("Error al escribir en el archivo: " + e.getMessage());
}

// Leer desde un archivo
try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
String line;
while ((line = reader.readLine()) != null) {
System.out.println("Contenido del archivo: " + line);
}
} catch (IOException e) {
System.err.println("Error al leer el archivo: " + e.getMessage());
}
}
}



', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('8de526ca-eba8-4411-980c-c4f777032172', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'TestAnimales.java', '















































































class Animal {
public void sonido() {
System.out.println("El animal hace un sonido");
}
}

class Perro extends Animal {
@Override
public void sonido() {
System.out.println("El perro ladra");
}
}

class Gato extends Animal {
@Override
public void sonido() {
System.out.println("El gato maúlla");
}
}

public class TestAnimales {
public static void main(String[] args) {
Animal miPerro = new Perro();
Animal miGato = new Gato();

miPerro.sonido();
miGato.sonido();
}
}


', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'Calculadora.java', 'class DivisionPorCeroException extends Exception {
public DivisionPorCeroException(String mensaje) {
super(mensaje);
}
}

public class Calculadora {
public static double dividir(int numerador, int denominador) throws DivisionPorCeroException {
if (denominador == 0) {
throw new DivisionPorCeroException("Error: División por cero no permitida.");
}
return (double) numerador / denominador;
}

public static void main(String[] args) {
try {
System.out.println("Resultado: " + dividir(10, 0));
} catch (DivisionPorCeroException e) {
System.err.println(e.getMessage());
}
}
}






', '-infinity', false, '-infinity');
INSERT INTO public."Codes" VALUES ('fbfa56bc-81f8-49cf-81fc-80847ba2d664', 'b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'asfsadasd.java', '






















































































































class asfsadasd {
public static void main(String[] args) {

System.out.println("Hello Codiva");

}
}
', '-infinity', false, '-infinity');


--
-- TOC entry 3608 (class 0 OID 49925)
-- Dependencies: 240
-- Data for Name: Courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Courses" VALUES ('5500125e-16f5-4b77-9220-cc4dab69c100', 'Programming Language I', '0392d24c-a1f5-4022-8278-cfa4efb14b8c', '2024-10-10 10:10:10.1-05', true, '-infinity', false, '5500125e-16f5-4b77-9220-cc4dab69c100');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88a1', 'Programming Language II', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88a2');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88a3', 'Programming Language III', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88a4');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88a5', 'Data Structure I', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88a6');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88a7', 'Data Structure II', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88a8');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88a9', 'Analysis and Design of Algorithms I', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88e0');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88b1', 'Analysis and Design of Algorithms II', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88b1');
INSERT INTO public."Courses" VALUES ('aa597a6c-b219-4743-b5c6-8740551e88b2', 'Fundamentals of Programming Languages', 'aa597a6c-b219-4743-b5c6-8740551e79e0', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'aa597a6c-b219-4743-b5c6-8740551e88d2');
INSERT INTO public."Courses" VALUES ('bf9ee4c7-b051-4dd8-ba56-101f2688888c', 'Introduction to Programming', '0392d24c-a1f5-4022-8278-cfa4efb14b8c', '2024-10-10 10:10:10.1-05', true, '-infinity', false, 'bf9ee4c7-b051-4dd8-ba56-101f2688888c');


--
-- TOC entry 3610 (class 0 OID 49945)
-- Dependencies: 242
-- Data for Name: Enrollments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Enrollments" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b8', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '2024-11-05 23:08:45.690141-05', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b2', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '2024-11-05 23:56:54.940662-05', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('a37b3252-3e54-4199-8c4b-728238fc76b8', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '2024-11-05 23:59:06.498981-05', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('8d676dc9-1a50-48f6-aa83-cb47535c5af3', 'bf9ee4c7-b051-4dd8-ba56-101f2688888c', 0.00, '2024-11-17 07:49:21.232978-05', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('8d676dc9-1a50-48f6-aa83-cb47535c5af3', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '2024-11-17 07:59:31.081327-05', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('1979d2a7-de35-4d83-9aa9-857171cba7fa', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('12bedd1a-d7c6-4b54-aeb5-507ef12d4f83', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('239e66d0-16c3-4ce4-b321-058b64269f5e', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('9b934e06-3abd-4b8d-b45f-7e2106b4bc74', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('af2eff91-54b0-43b4-91c4-57b7e2d62f15', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('e7c43279-2bcc-4c09-9165-b824041166fc', '5500125e-16f5-4b77-9220-cc4dab69c100', 0.00, '-infinity', true, '-infinity');
INSERT INTO public."Enrollments" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b8', 'bf9ee4c7-b051-4dd8-ba56-101f2688888c', 0.00, '2024-11-05 23:08:40.787882-05', true, '-infinity');


--
-- TOC entry 3614 (class 0 OID 50024)
-- Dependencies: 246
-- Data for Name: Exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3617 (class 0 OID 50120)
-- Dependencies: 249
-- Data for Name: Methods; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3616 (class 0 OID 50102)
-- Dependencies: 248
-- Data for Name: Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3613 (class 0 OID 49989)
-- Dependencies: 245
-- Data for Name: Plagiarisms; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Plagiarisms" VALUES ('548d3de9-6a7e-42f2-9db0-df8294921a2b', 17.12, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('592e583a-596f-4d86-80db-0d01c2a25366', 55.56, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('59560671-2eb3-447e-a774-afa7136fe0f0', 57.89, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5c0191b8-97fc-41c8-b186-0bc3f221e264', 77.14, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5c025ca4-7a5b-4739-8942-27788907372f', 5.64, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5c916fc3-0e90-4268-9be2-44ee90394fb1', 0.00, 40, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('612ce6c7-5e3d-4ace-8831-15088d0c4056', 0.00, 26, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('61deef75-4944-41dc-8bc6-bb3acd7e0646', 26.76, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('65fa5e49-a152-484e-843d-5d1134d23920', 0.00, 64, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('685821b1-c006-4fc0-a3a0-a22a0871d215', 22.28, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('68c89337-7846-436e-83e9-4d699242cb7f', 30.88, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6a1dcef7-fca6-46b6-9699-4326c3aa8835', 0.00, 78, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6baf26fd-69df-4e16-9bb4-81b1491ba84a', 92.59, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6d2b8095-8b4a-4de9-8cb6-741c2e7195a0', 13.66, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('725227a8-fe59-49a1-9c7b-3ccc80dc4a77', 0.00, 62, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('73378496-ae96-4eef-aa3d-9c3e4fbcc59d', 0.00, 47, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('757fbda3-a5e2-4ce1-88c0-dc4c86aef296', 45.45, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('76128988-a0d2-472e-b2c6-7ab9c9819f3c', 0.00, 76, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('77f36ed9-c2b5-4ded-8787-689b8cfcc0b8', 20.83, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7856a814-51d9-4753-92fc-0bb8bce0f801', 56.25, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7ada9a00-1807-4411-9f9f-a8bf064fa06e', 44.00, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7c5ff07e-659e-4097-bbcb-3c3c4ecc283d', 14.13, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7ce3fa3a-8100-4e68-8e99-ce62fe197395', 20.25, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7d1a7bce-7924-4a9b-b1d5-920971706eab', 0.00, 65, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7e09db2b-b205-49be-82c4-a60e6cd4b7a6', 22.52, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('81d68bef-ce3f-47cb-97d6-d7932181df0a', 0.00, 130, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8218216a-bb37-4b4f-acba-42e5a594af39', 44.00, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('85e88942-d4fd-4eea-bc44-f4b0b3c46e0f', 0.00, 62, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8913a80f-a88f-4078-bd85-153497c41a3a', 68.89, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8d1b5c44-60c5-4685-b04d-4a5506d8edb2', 9.49, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8f741b32-2784-4f0e-97d4-229730af973e', 19.05, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9297a1ae-6f4b-453a-a4f0-a5e3e9ae7d67', 53.85, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('947a84c6-7dd9-4b9f-8859-d8191ea4d4d7', 89.29, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9a6e91c4-f08e-4f97-9d36-4bb4345c804f', 13.39, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9b188a48-0f87-4b35-a191-412ba1f020d0', 39.42, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a271ebbf-069a-483e-a88c-3aea97d70636', 65.52, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a7626e70-cf92-45b6-a4e7-fd20c22287cc', 17.72, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('aa519e6e-3050-4ef6-a960-5aedd3e792fd', 26.09, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('aafa67a6-22cd-4bbc-b12e-cc6674eaeead', 82.86, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ab47a9c6-1732-49ce-a12f-1f1c0c47216c', 0.00, 82, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('af50b6a0-a50d-4a1e-ba4b-971b975d5c9a', 16.82, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b3440071-0446-4b64-b8ed-41befdc95cc5', 33.33, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b3902040-1725-4a7e-82bf-d603c717ec28', 13.64, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b57025dd-33ee-4887-a59f-b468ddc2f988', 0.00, 25, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b65fe2d0-367c-45d3-9922-169031abffe4', 0.00, 91, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b67ff43c-cdc5-4500-971d-c725af6b96fb', 39.25, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b806effa-511c-492e-b758-1dd25893f40f', 0.00, 80, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c46c7d2e-ab56-4b5e-a9f4-909944c66c6d', 3.63, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c66d4467-3f10-40d0-829b-a78d451e0d9a', 0.00, 91, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ce79315f-e4be-4823-b3f5-2cabdbd67d4f', 30.43, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d5e6f680-a240-49ac-809c-6002727e5711', 32.76, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d7fadea3-23fe-4c30-8f33-b6cc8395f906', 21.74, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d9ab3ac3-6b52-47ad-b01e-f4049895787a', 63.64, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ddcb021e-6537-4da4-9424-4ab0d7f5ed5e', 34.55, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e17d8ae1-72dc-4a16-8182-4a3fcdf015ed', 54.70, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e338937c-0c19-44f8-977f-2b6f8bb7e22f', 70.37, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e8bbd6b4-f981-459c-b73b-15cffe568963', 40.00, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e98becc9-c7fe-46a9-8cf8-b58ff2555743', 0.00, 95, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e9ac1ff1-a015-4bca-877a-320fc21de243', 13.86, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('eae31911-0345-48e0-82ab-f7cde3f8d2b2', 22.22, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('edcd87b4-7821-4443-84b7-9794d7d72ce4', 22.64, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ef67e5fc-e1dd-4abe-9a4c-c0616d120f81', 27.78, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f0189d62-e09a-4337-974a-cfa7fcf15f07', 0.00, 34, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f0670dad-2fa5-46e4-a24b-abb3b4f97819', 10.96, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f08da1a2-a821-4f8a-bfa4-aec2d2512860', 0.00, 31, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f2202392-fadf-44c1-ad4f-35c883dd091c', 0.00, 92, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f332bba0-91df-4b47-80fa-7646ed63128a', 18.92, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f9c011a5-c331-4929-b73b-5c3c17a7cc84', 42.68, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('013bfca8-a76d-4213-b43c-21dec4b6925f', 14.97, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('036bb6a2-d78d-4615-a758-13b7aaba04fc', 12.30, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('03f20346-316a-43bf-b023-2de81e3e8b3b', 26.09, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('05f1e314-2d5f-4e29-9796-a8d8c82adaa9', 42.47, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0ac6efa5-7dec-4e01-9f02-c95d30c20279', 23.17, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0c1f9292-540b-4d2c-9912-3a407bac4841', 57.89, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0e483047-5e5d-4969-bfaa-c8411fb3362e', 0.00, 75, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('12134776-1723-407a-b9e7-97de33c6675b', 0.00, 35, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 3, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1bdb6281-e0b1-4f74-a005-a662129a7153', 7.69, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1be500ef-7576-4cc9-b61f-5145be923f64', 76.60, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2a700708-da40-4ff7-bc34-eb017134c48b', 9.71, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2ace5284-0a66-4670-a900-f50df0cf54d6', 31.53, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2d8235ec-baaf-40b6-847a-405d3afc2958', 86.21, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('33a7837a-d4b5-45cf-8508-966a11a2fac6', 80.00, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('34f63386-dfed-4e69-8b0f-ff6d3a50d91c', 30.49, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('36b35205-db0c-412f-86bb-dec9cebdb8ee', 11.66, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('38b3424a-bf0e-4522-8825-e589a454689e', 0.00, 343, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3da297ca-1eb1-4ddc-b545-fba8dfbcdcf1', 17.58, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('44c32a87-7ef1-4340-9272-dce16b23621d', 12.30, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('45547a77-3683-4f85-88af-910efe73183c', 52.50, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('48338196-1beb-4a64-943a-356efe9366b3', 67.86, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4970426e-ee22-47c1-8527-f553be48e440', 31.43, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4e836d77-2cd9-4a7e-8072-4dd92387b7be', 51.61, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0736b606-d46a-4b27-b001-4dd842784044', 0.00, 76, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0d27714b-c17d-4c1e-820d-880faf9cdfba', 96.43, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('185039cc-c34e-4ac2-9fd3-dcfed2369173', 77.14, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1930a4f8-8f89-4ceb-82af-c08ac4c0e7e8', 16.98, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('19fa622b-0d56-4e74-99be-4eb713bec4cc', 30.00, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1cc8783e-c400-42e9-a286-09585674bc77', 12.42, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1fc1e562-61c5-473d-978d-e50813adbd34', 8.59, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1fc7593e-483b-4c29-abf2-b3cbb0cf7389', 10.75, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('210eef9c-0ee4-45f4-ba12-758a2b5fe0ea', 12.97, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2658dcfc-b13e-4280-8cca-8f4a20838a95', 32.93, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2afafc65-0574-44c9-ba3b-02c8607edca1', 0.00, 80, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('30fd84c3-2612-4ec6-91f4-e285075a38e3', 0.00, 63, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3220aaea-17f2-4ec7-aa86-a36c335c89ba', 92.59, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3484cc7e-1f4c-479e-baee-52aa49f87f6b', 39.42, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('34c150bc-1795-4088-aa8f-961ce6a874df', 36.59, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('359fb148-f1ac-432c-9979-7efcf7dd5a35', 10.05, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('36ca001d-55f6-4b8f-8a49-cb9bd6d53a5e', 21.82, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('38c124f7-4ea9-4389-b1b2-30a0967aa529', 9.78, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4db0e518-1e81-4b66-932b-51619bb8f864', 0.00, 88, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('509f72a5-43bb-4680-93a4-17c25a63c1a6', 57.89, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5928dae6-3342-4751-8f7d-366beffbd5b3', 22.64, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('63401b87-eb6f-43e7-b815-9a41f5e88ba0', 27.52, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('643b8968-7bff-492d-ad18-6eaf6042f61e', 20.29, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('66352e98-82ba-4e5f-a853-728f872a9223', 0.00, 91, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('68b8a02f-7029-48c0-b59a-e3fae9668b72', 0.00, 84, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6a05d718-0573-49a5-814d-f4f0eb7db103', 0.00, 247, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6a532a9c-3604-4b4a-952a-67dc8f410c30', 70.37, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6d816f85-0bad-4dd0-a08c-59550894e4b1', 13.39, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6dc5635b-ca78-4213-9a84-c4a99c74311b', 6.56, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6f5ce76f-f4d7-4242-b303-57b813db4f54', 0.00, 61, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('70e12e33-87dd-4505-9f98-7146a992a70a', 0.00, 65, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('741d4717-caa4-47b7-af71-25212119ce13', 49.09, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('78984850-2233-4966-97b3-9e7719b4dba1', 37.93, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('78c9644f-8163-4641-8298-20986547b0be', 40.74, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7a334ba4-f5ce-4271-a1da-cc24041fe3cb', 17.58, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7cfc61ea-941e-4cb3-b03d-c54993b9dd9a', 24.36, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7d973b72-76b0-42a1-85f0-02fb44532c46', 0.00, 72, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7e1ba2aa-ef55-425a-a8ed-c1eb5ec4a3b5', 0.00, 47, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('81a28236-e890-4bf1-a481-1aa016a78436', 15.15, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8278cf58-8802-40f0-9b58-02802d3903aa', 0.00, 34, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8705ab7f-864c-4fc5-849c-4d82752382c4', 21.74, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8ab406bf-81ab-467a-b4d4-00790a651715', 20.00, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('90782841-e64a-4419-85d8-3873f37aa170', 27.78, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9b00a60d-e68e-4694-aec9-39d9a26b15af', 0.00, 62, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9e0badac-adea-4072-9ca7-1f3577035c8a', 0.00, 72, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a2a655ec-cdb1-41b6-8f5c-a4186d73b62d', 31.43, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ac86af99-2148-4899-b3d4-9a129c7d7003', 0.00, 82, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ae26f17a-b837-44fc-83c3-afe0cf2bb326', 24.32, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ae376332-c222-4ba2-a1c3-67214e07fe0b', 100.00, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b08b250c-2a70-4385-8b0b-587a53076641', 13.41, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b1ee6ae4-733f-484c-87dd-01d363a24a49', 57.69, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b4218d73-8409-490a-a721-fa219d442e79', 33.33, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b931ada1-ac77-4cd2-a96c-376a3f57d239', 11.43, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bb3495e0-44ae-4477-953c-642287934baf', 10.26, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bf18841a-8e5d-481b-a412-860584d231ae', 44.00, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c2258e3d-1ca0-4ec4-8035-06f059f126bb', 8.62, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c3f32fdb-de80-4ac2-8f5c-14a29efdd46e', 39.29, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c6da6465-fb28-43e1-914a-5532fcaa5fc7', 54.55, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c7fe2630-7287-4d55-b355-d23e5314e1f8', 51.61, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c8aa4381-1c7e-4a8c-8e21-08abfe65a89b', 0.00, 86, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c8b0b9aa-3f27-43d7-82dd-0d41637e764e', 0.00, 66, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d69f70fa-c845-48b8-96c4-df8c740b40a5', 74.17, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('da6a4d55-172f-4d1e-817a-aedae515ee80', 26.76, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('dce1ed6f-de1b-45b2-8c36-e167becb2a1b', 42.73, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e1849892-e57e-4ef8-9fa0-877f835b08c9', 85.71, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f016c31e-9d66-4e82-bca2-a02ddd4f4e0b', 0.00, 94, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f27631f3-4180-4fa6-acd3-3423c86774b0', 26.32, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f37cd476-74b1-4f0f-8953-69885c99007b', 9.91, 0, '', '4abb984e-aead-4b40-88b0-8c801fdde54c', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fb99df9c-e77d-4d32-951e-175d780c695b', 93.10, 0, '', '5c96bfec-28ba-4c23-b9da-fbf4cf835e0d', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('000604c9-2251-4b1c-8fd6-1471abe38547', 39.29, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0245d46d-e2e6-454a-895f-76382b4f8305', 35.37, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('025555e4-5f94-4db9-b6fb-0a1d1e4a967b', 0.00, 78, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0329d643-5058-44c0-bd1d-96c78a148b67', 14.13, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('048effaa-2817-47c4-92f8-8ea352757a3d', 0.00, 76, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('08fd436e-eb48-4bd1-95cb-8defbdc74b96', 22.64, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0991480e-8c08-43d9-a4cf-05f37e1520da', 10.81, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0f8b9623-f502-4850-a314-cbffaa0cf000', 13.66, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1251b900-87af-43fe-a790-d9304d8398f6', 25.64, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('18fd6abf-5d8a-4a7d-a89e-4b69f3e0f750', 22.22, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1ce46b0c-5c45-4db9-a11d-2b185cb934cf', 30.00, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('203ddfe2-ad71-46e5-8ee1-95a2cd1444be', 0.00, 65, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('211dda16-038f-457a-ae40-7fcb7bbf8398', 9.50, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('23b16fa5-c1c8-41ea-87ca-a57a0157ab25', 0.00, 86, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('24222af1-401d-48d3-877c-83e8287aa9d3', 85.71, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2f0b1182-adac-44b0-a42a-312da5bea6d5', 40.48, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('33b67c7b-4a4c-4e39-bab7-80f7742fb8dc', 0.00, 31, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('361a8205-2cb4-41ec-b22b-5d0a50325987', 0.00, 84, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3c928f1f-1ebe-45ad-a17d-192050414880', 0.00, 94, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3d5b833f-7879-4539-bdf6-13d88ed1f379', 21.21, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('433b40de-775e-4dc3-b36a-d5cec008df69', 8.84, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('44f860fc-f030-4dd0-b8d7-454b88b3d7f6', 26.13, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4731b9c6-cb48-4e10-8768-65afb6184c67', 32.76, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4c5cd58f-acb2-4930-a2e9-052f144a04c2', 56.25, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4c622238-bbeb-4fa9-8bc1-5eb5f90cbb8a', 20.00, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5f2e1c2d-1f3a-4c43-84fd-17767e706d1c', 22.86, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6241d293-36e0-4216-882a-2a5de0940ca7', 54.55, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6662046a-b3fd-4bd3-b61b-c3689f83d492', 0.00, 63, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('68a28763-b6ec-45df-b25f-b836ca61f06a', 0.00, 59, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('69f75949-2673-4d23-a370-efbe9dc79534', 65.52, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6d951bbf-ccbd-491d-bccd-6f9c329699ce', 0.00, 95, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6e386dde-8596-47a7-a20a-6f3006cd7a4e', 10.36, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('72931c0b-633f-4550-9a98-63bacc26e6f0', 0.00, 70, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('76593d08-4eb9-4976-a468-a29df4911fff', 0.00, 64, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7ad430c5-0c9f-4f80-8489-c7be34b12e81', 0.00, 247, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('853db97b-de17-46e8-8d81-dd8dc2bb19f3', 11.66, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('867113d2-dfa6-479c-84e6-12d3d773dfb8', 9.91, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8817ca6a-b51e-4c7e-afa3-87baae84abc4', 42.73, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('89c714f0-eec6-46af-b36b-e7d9ed7c12c7', 37.93, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8a6960fd-6ba0-4d51-b234-ce1800fcc127', 53.85, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8cde6944-d7d7-4a30-9725-1431b4f86346', 17.72, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8e4a89c3-83c5-477e-8017-0083fa2dadc3', 40.74, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8f5c3f0f-670a-4b44-8980-4c3045fa2a4e', 30.63, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('903dd336-3bfd-47d9-99c0-ae569d87b78f', 0.00, 40, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('91b0fbc3-a21e-4fd2-b0cd-8dde00101a14', 0.00, 64, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('98e9a488-cd55-464e-8749-ad001d465f85', 96.55, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9dc6c534-be5d-4837-9c74-60c539852487', 24.36, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9eda53d2-7da6-4454-a285-e0e9876fc16c', 0.00, 60, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a421f9f8-8980-4d39-96f0-d945b5349ba7', 93.10, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a8009789-048b-468d-a5d8-4f8fceadf6d5', 30.43, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b37da630-4ebc-47d7-9dec-61ce87a84055', 31.43, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b6d09ecd-7844-4dc6-b1dd-2131d269b5bf', 55.56, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b6f175d4-efd3-4d60-9f8a-e503cde4c92d', 13.52, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b81066b3-3091-4996-b895-66a4ed72ed3f', 82.86, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bd480c82-7dd1-42b0-b0c0-0bad23615d17', 12.50, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bddb11ad-82bb-47b3-a491-b12c51a1f200', 0.00, 91, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bfb130e8-f08f-4d58-987b-b3a205331d9c', 100.00, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c43958d5-980c-4009-ad3a-6a84ac061071', 13.41, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c4fb56dd-073b-47b4-ae2b-0486302414bf', 9.84, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c577f45f-62b7-406b-bd22-e6df0e4f1a87', 0.00, 60, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c602170c-1126-44e4-ba04-fe25d323a456', 26.32, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c88c73bd-d17d-4a92-99a8-96f324d60b75', 21.05, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('cdba3510-4d26-47a9-b4f4-7b47382899cc', 17.44, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d03b6bbe-36f8-4826-b0d9-962db9ca05dc', 74.17, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d3b9792e-f24a-4243-8206-644acc1a32fc', 20.83, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d7807a6c-9c9b-403f-97c3-b175a6ce6a68', 44.00, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('dcaf743c-5eae-4bdf-b30c-8562fb6ddf67', 86.21, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e10c5498-c73d-4384-928d-0cd1ce59b9c7', 52.73, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('eaaa7d5f-6fe1-4d27-9ffe-a9f723408433', 15.05, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fc0e16bb-f3d2-45e0-8242-9d0fe59cdd0e', 8.14, 0, '', '32914a3b-9b54-4e6b-ad27-033693f8e181', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fe55cb35-1b9c-4c6e-a547-3763888e7456', 40.00, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fef824e4-9fe0-4796-be93-e2129a02d199', 57.89, 0, '', '301e8585-ac92-4bd2-809b-262228bcc1c1', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('04f2b0f0-85be-44de-a2b7-7df2e53a59e9', 66.67, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('094ad04a-40cb-4ffd-a09e-a3aebcd780f2', 0.00, 63, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('096e803b-6026-49fd-a907-88c1c5ad825c', 26.13, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0a3ce927-9e14-4f64-9d26-12e1beacd864', 7.39, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0a690a33-c3bc-4719-9517-c02ca2420856', 24.32, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0cb06eea-df95-49c2-9dca-ce775db92640', 0.00, 72, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0dda2486-61a8-4bf0-87c8-c53a7a5dea5d', 34.55, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('11c6005a-8bc5-468b-a207-69d18675bb82', 0.00, 62, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('11e66649-55a2-4df2-9d8e-4cce294be201', 10.96, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('135dba81-855e-4a53-b679-981b10ce66ec', 0.00, 75, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('146c78f4-a452-4f4d-8ff2-9d4b2576b6f2', 0.00, 59, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('15c363a6-c5f8-4ff6-abc8-785e13d6f2b4', 13.41, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('16e61d31-2e3c-4078-8340-bef78000911e', 0.00, 66, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('18f34dff-7d2e-4412-93cb-93564c4f438e', 20.29, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('1db68e60-3eaf-4578-b316-5a3549f86c37', 49.09, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('20fdd0d0-f93a-468f-be7c-8ba8e86550d6', 12.50, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('219c1f78-96c2-474b-a5d6-45efe0155f2b', 13.64, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('246d2962-d298-4d7c-9a87-9f076ea7c965', 83.86, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('252f4409-5f42-44d3-8cb8-7a8c8e3a4358', 9.91, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('27b2b8ae-a49d-43b7-9b23-065f99faff29', 12.42, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('29316e75-f15b-48c3-9c85-4f3388885046', 0.00, 62, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2d9e4727-7185-49e5-9af3-010e812261bd', 8.59, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('35b1bedb-0025-4dd0-ac00-4aee8fac3190', 0.00, 64, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3a10cd85-7073-4269-9d8c-84021ffaa4ab', 30.88, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3ba2df20-d33c-49c0-bfad-ba8f57dcbeea', 31.53, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3ec5dbf8-1abd-4792-aa6f-39adf916d2ab', 22.86, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('3f0c463a-26c7-462c-9926-fd96fe10858c', 16.98, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4071c472-8e87-4ab6-b81f-41396151fbe2', 22.28, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4384a36f-2248-46a9-a094-74c7faf06a44', 9.71, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('453c288f-ab4b-4a7b-aa1d-67cb396303c6', 32.93, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('47a6da29-f85f-4a43-a3b5-e5fa855a9537', 10.75, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('48e4b33a-2c25-49c5-b3a7-d5d6e1f0e01b', 19.05, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4a071ad8-358e-468d-9ada-f4c07393a35a', 10.26, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4e855d5a-338a-401a-b027-487e1af6f697', 11.43, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('4f445940-c021-445a-bf52-090d528a460c', 21.05, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5552d99b-03d1-4eb3-9bda-872ec90ec987', 9.50, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('558df7d4-29d4-4612-bb6f-2536d4aa5de7', 96.43, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('55fb278b-0c16-40db-bf2a-e2015df09c46', 10.05, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('56043001-4604-4a37-81da-497f65569223', 22.52, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('56dc7fd3-a5a4-462c-8184-b5234b7ec417', 13.86, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5c4e9b25-99ae-4d48-ba21-6da3c35f9b6c', 12.90, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('5e2f3d3a-3074-4d44-886f-7cdd3c091311', 16.82, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('62c60fc8-89f1-41e4-8fb2-9a6266293e5f', 10.81, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('644062b4-f7bf-41ea-b643-ef7a47d05f61', 0.00, 61, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('65e627ab-19d1-44d5-86e2-fd161af99ffc', 0.00, 76, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('676c78a5-21c5-4a62-872d-f7d847e6b064', 20.00, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('68efb068-061f-4264-a89d-617fe03c06bb', 13.93, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('69833275-edff-4bf8-b0f0-d9bb91acbd50', 22.64, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6bf35977-abcd-47ba-95db-d5f55bdc4930', 0.00, 85, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6cb15185-0e5a-43f7-859b-a399eab1d2d0', 89.29, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6da49339-771c-490e-b51b-e5c010851baf', 17.44, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('6def4118-6134-446e-a1c0-cc1252ef9b85', 0.00, 343, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('71f427ac-4c16-418f-b965-2c00cf5fdf12', 18.18, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('78831d99-9a44-4b95-b28c-f9ca1ce9d403', 0.00, 65, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7acf83bd-5667-4350-9491-1c4d2da7c856', 5.64, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('7fb3074a-58a2-42f8-ad34-6f37c36d7dd2', 0.00, 64, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('88a9eb98-4883-445e-9c6e-b79b0139bbbc', 21.82, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('890dd1b9-38d0-412e-ab98-ed6397e98323', 0.00, 63, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8b753c70-5916-4ae0-b14e-92d143a9047a', 0.00, 65, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8ba0f558-1d43-4e5d-8361-33da92714a21', 0.00, 92, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8cda615a-a51b-46ff-8fa0-a2484bfb6873', 15.15, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('8e1b26b3-f892-49d2-833f-555baeebd1da', 39.29, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('96cd813b-1318-4e9c-a6e9-fb204339b603', 0.00, 65, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('98804a9e-2e95-4863-8866-49a2ff1269ba', 63.64, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9c9ea9e5-a83b-4dd6-887c-4e0df6dda623', 30.49, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('9dbdeeb9-0643-4232-a130-b5e7004a9106', 7.69, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a0e549a9-cf30-49f4-9daa-45ff68043605', 96.55, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a10fd236-a0ad-4841-927f-4a4ac35eddb2', 27.52, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a2ef8bb3-7264-4e3f-9e1a-94f9d078b58e', 17.12, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a2f7e83d-83a8-4637-a458-3b5c5c79a348', 36.59, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a3278a06-9eac-4e32-a878-3d8dd8b0dbdd', 42.47, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a7cc90e2-edba-4727-975e-c8fd5b004b2b', 13.52, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a7d6fe1e-c610-43e8-990e-1fe30b333a07', 52.99, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a904b81c-8483-4fd8-a89a-c9e3361c8410', 76.60, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('a93d51d4-e1eb-4df1-a6b3-aa91fb3b126d', 0.00, 25, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ab067c4d-4aad-47c5-a3bb-6a89a3eafe0c', 0.00, 60, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ab402a3e-b50c-48ce-b627-ae4401364364', 0.00, 62, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ae23da33-0820-43a6-aaad-7a060d52bed1', 67.86, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b06929f6-3018-4836-9f60-43ae19bdd656', 6.56, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b5c05926-526d-42e5-b7f8-9d5b49a78e82', 20.00, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b627c725-1e09-4a33-9997-9b603bf5c33d', 0.00, 130, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b669dfeb-3e7d-4190-8e85-2cb9abc68f57', 18.92, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('b77270c1-a9f7-42bc-8c94-5d67f3e8fbb5', 39.29, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('bfe34453-b74b-4fac-a64b-5244f0cbe2d3', 28.83, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c666f5bf-400a-4074-b4a9-21744ee5f16d', 10.26, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('c97c8e64-385c-43a8-beb4-23006351b6c5', 12.97, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('cacebf1c-4df5-46ce-98e1-7dc742b5def4', 39.25, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('cdbaec52-2253-4f51-beec-637f0a4b6073', 0.00, 60, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('cdd862c1-4aec-4445-9483-5a18dcfadb94', 8.62, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('cdf104bc-7fe3-4726-be50-2782a1690981', 0.00, 35, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ce7cd51f-f263-428b-b5ec-a25c9ab78858', 20.25, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ceeb4d58-451b-4c19-b01e-a048035b6154', 35.37, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d1d852ef-d74d-4ac8-9ff8-57330a772964', 9.91, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('d918d7f3-b543-456c-a123-27567b6f80ae', 0.00, 72, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('db9e3dd6-d4e0-4bb7-8ee4-1d4d7ca2235e', 9.49, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('dee1a71c-573d-4b37-919e-0771e3e283bf', 45.45, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e15e2e3b-2466-4bcd-9a30-7d3608a359cd', 0.00, 64, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e31cb156-f136-42be-803a-741db3e4263a', 42.68, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e4d28389-23e5-446d-9a2d-80352398fd1e', 8.84, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e765e1fc-4d2d-4fca-9c90-1453f4c0df92', 3.63, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e798604d-756b-4e6b-a079-923827677a64', 13.41, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('e8a3b33e-67e7-45ac-9411-bb792fc8fbe8', 80.00, 0, '', 'a6f6fc1d-a887-475e-9abf-1db2c8e6bb52', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ea99a9f7-27b4-4e76-a7d5-7459f1852db3', 23.17, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('eea3c188-083d-46bc-83d9-fd21497c7454', 10.36, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f10597c8-8afe-42cb-ad5c-405c26f711d0', 8.14, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f1408bcb-dd7e-4088-93cd-5105e59cf4e4', 52.73, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 2, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('f876a214-b4bf-4849-b7ac-0a0091e1c72d', 0.00, 26, '', '8de526ca-eba8-4411-980c-c4f777032172', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fafd70dd-025c-443c-9647-3af766bafc3d', 9.78, 0, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 0, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fbbe71d1-0224-4149-b8a2-92e10ba5fe5d', 0.00, 70, '', '840757b3-4bf7-45ed-9f7c-fc5611f4fba2', 3, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('fc3d9cbc-dec2-4d91-90a7-7c811224d0dd', 9.84, 0, '', '8de526ca-eba8-4411-980c-c4f777032172', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ff599f5a-5b3a-4129-ac58-12252e739653', 52.50, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('ff8b9503-7387-48ca-a06e-8ec7c6d20e19', 38.10, 0, '', '114d5b4c-dc7d-4236-8a25-3ea837565ccb', 1, '-infinity', false, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('05350a77-ab25-4276-88d0-154ed647ee5d', 57.69, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 1, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0a559ff5-4cb4-4316-a5bd-11609b965fd5', 0.00, 85, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('0ecdbc4e-28d7-4302-86d1-f7738c90c380', 83.86, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('282834c0-b58c-4d94-98d3-5a6c69b2183c', 7.39, 0, '', 'b3cff7d1-c24d-4814-a541-aa0c5c435a03', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('2bf15512-2cf0-4754-bb3c-dd615d0ed0da', 13.93, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 0, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('36a45e95-b79a-4854-b99d-3366cc0b3fc2', 31.43, 0, '', 'e3f3df6d-866b-47a0-9ba8-57a34456a1db', 2, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('417535d6-fd03-4c0e-834a-1b9f51253bb2', 0.00, 88, '', '29198014-716f-4601-9fa4-bd1c8438b389', 3, '-infinity', true, '-infinity');
INSERT INTO public."Plagiarisms" VALUES ('486c640d-bb06-41b8-ac27-ee24b1652151', 14.97, 0, '', '29198014-716f-4601-9fa4-bd1c8438b389', 0, '-infinity', true, '-infinity');


--
-- TOC entry 3606 (class 0 OID 49905)
-- Dependencies: 238
-- Data for Name: Students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Students" VALUES ('1979d2a7-de35-4d83-9aa9-857171cba7fa');
INSERT INTO public."Students" VALUES ('12bedd1a-d7c6-4b54-aeb5-507ef12d4f83');
INSERT INTO public."Students" VALUES ('239e66d0-16c3-4ce4-b321-058b64269f5e');
INSERT INTO public."Students" VALUES ('9b934e06-3abd-4b8d-b45f-7e2106b4bc74');
INSERT INTO public."Students" VALUES ('af2eff91-54b0-43b4-91c4-57b7e2d62f15');
INSERT INTO public."Students" VALUES ('e7c43279-2bcc-4c09-9165-b824041166fc');
INSERT INTO public."Students" VALUES ('39c36d0b-2f1e-40b0-b2a4-aea67bc1c2cf');
INSERT INTO public."Students" VALUES ('8d676dc9-1a50-48f6-aa83-cb47535c5af3');
INSERT INTO public."Students" VALUES ('a6861511-c29c-4133-b21f-33f9316995b1');
INSERT INTO public."Students" VALUES ('a37b3252-3e54-4199-8c4b-728238fc76b8');
INSERT INTO public."Students" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b8');
INSERT INTO public."Students" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b2');
INSERT INTO public."Students" VALUES ('a279b603-3953-40cd-82bf-50b9e59b712f');
INSERT INTO public."Students" VALUES ('ca96a324-7516-4d11-a412-1aa465f9fd2e');
INSERT INTO public."Students" VALUES ('c64a9876-00c6-4032-9d10-c64a0773663a');
INSERT INTO public."Students" VALUES ('742ea535-cb8a-4bc7-978c-9af386c206ac');
INSERT INTO public."Students" VALUES ('a8d13f61-99a3-47cc-a041-c93d6daa6aac');
INSERT INTO public."Students" VALUES ('8933cdee-671a-4b5e-bf2c-76cdf0ed0c4a');
INSERT INTO public."Students" VALUES ('53993a93-95af-409d-ac7c-15e586de1339');
INSERT INTO public."Students" VALUES ('df37ad47-69e1-4ba6-86eb-31f05d4f1683');
INSERT INTO public."Students" VALUES ('8ecb8941-a677-40d4-812c-581947c628f0');
INSERT INTO public."Students" VALUES ('b1fb23e1-f576-4942-87ac-588155abc80a');
INSERT INTO public."Students" VALUES ('e1be6201-c7b0-4127-84f3-c13697a53666');
INSERT INTO public."Students" VALUES ('c9e28154-eed0-4576-a261-043b03bbaa89');
INSERT INTO public."Students" VALUES ('c4676ea8-63ef-4947-ba3c-788df4608789');
INSERT INTO public."Students" VALUES ('b2610c53-94a4-4794-bf88-8eb18d3d6609');
INSERT INTO public."Students" VALUES ('78588a8b-5070-4279-a0a6-c6223a914a40');
INSERT INTO public."Students" VALUES ('7aabd57c-965c-470f-9ce6-e1da190d483e');
INSERT INTO public."Students" VALUES ('85c27d2a-56ae-4d5f-9477-10af41ce7892');
INSERT INTO public."Students" VALUES ('1dbee534-4cb4-496f-8cb8-ecad64540925');
INSERT INTO public."Students" VALUES ('0c99c267-71c7-451a-8793-41b4fa6b9fa4');
INSERT INTO public."Students" VALUES ('011efd87-33d5-481c-b285-e30318b6e667');
INSERT INTO public."Students" VALUES ('9483dad2-a35c-4581-a24f-4b512cdb8dd9');
INSERT INTO public."Students" VALUES ('d9179c62-9742-4378-9e51-dcb3bf7777a5');
INSERT INTO public."Students" VALUES ('8f554465-ff8d-4a89-9955-3f31d29928ec');
INSERT INTO public."Students" VALUES ('13bb2c00-653e-4e9f-b79d-85693e00f43c');
INSERT INTO public."Students" VALUES ('4feec7b4-13dc-4d52-a613-24a7f938ba3c');
INSERT INTO public."Students" VALUES ('e8f29dba-0efb-4380-a49f-a3fead0a1586');
INSERT INTO public."Students" VALUES ('038b1091-9328-4381-a90a-2ee4b2648f74');
INSERT INTO public."Students" VALUES ('94eb5aaa-4df3-4c66-b985-d5b1ea5ed3b2');
INSERT INTO public."Students" VALUES ('5900613f-641c-41f7-ad66-0df37f9ea5fd');
INSERT INTO public."Students" VALUES ('6ff649f4-518c-49b0-9fbd-20ae55a2c1ed');
INSERT INTO public."Students" VALUES ('9678fc2b-99ad-4974-a915-1eb4ab08435d');
INSERT INTO public."Students" VALUES ('0bb0755c-20d5-41f1-a1e4-17290181bcb7');
INSERT INTO public."Students" VALUES ('0ae0cdb8-e9d7-4f42-b141-eb9d4bac9520');
INSERT INTO public."Students" VALUES ('c1f52c72-6189-45a2-9a22-dfa862ea766a');
INSERT INTO public."Students" VALUES ('d53cc6ac-dfc4-4c4a-936c-66d89b451bfb');
INSERT INTO public."Students" VALUES ('9fcc9f8f-3473-4298-98af-1e789d79feee');
INSERT INTO public."Students" VALUES ('b89f3040-6273-4773-aacb-2282d24e6982');
INSERT INTO public."Students" VALUES ('eaafdab3-e32e-4753-9843-da73e1654e5a');
INSERT INTO public."Students" VALUES ('14adcf2c-feda-46ef-b71e-15f23894f3cb');
INSERT INTO public."Students" VALUES ('f160a77d-4625-4202-acde-67c49ee605d2');


--
-- TOC entry 3611 (class 0 OID 49960)
-- Dependencies: 243
-- Data for Name: Submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Submissions" VALUES ('6e701991-2a14-4493-a170-f4fe910e9c4a', 'https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700', '2024-10-07 10:35:31.051-05', 0.00, '12bedd1a-d7c6-4b54-aeb5-507ef12d4f83', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('e0d30fd2-1027-4af3-be3b-238a579dacb8', 'https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8', '2024-10-07 10:35:31.051-05', 0.00, '9b934e06-3abd-4b8d-b45f-7e2106b4bc74', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3', '2024-10-07 10:35:31.051-05', 0.00, 'af2eff91-54b0-43b4-91c4-57b7e2d62f15', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('31edb16a-feb4-4cab-812c-e8a4bdb6ad45', 'https://www.codiva.io/p/925bfea6-e307-4cbb-8e43-dbf634ec7325', '2024-10-07 10:35:31.051-05', 0.00, '239e66d0-16c3-4ce4-b321-058b64269f5e', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('6252ac2f-e197-4ec3-821f-56ef3dffc72c', 'https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c4', '2024-10-07 10:35:31.051-05', 0.00, 'e7c43279-2bcc-4c09-9165-b824041166fc', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);


--
-- TOC entry 3607 (class 0 OID 49915)
-- Dependencies: 239
-- Data for Name: Teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Teachers" VALUES ('5500125e-16f5-4b77-9220-cc4dab69c102');
INSERT INTO public."Teachers" VALUES ('0392d24c-a1f5-4022-8278-cfa4efb14b8c');
INSERT INTO public."Teachers" VALUES ('5557682e-def4-406e-b37f-421217165e81');
INSERT INTO public."Teachers" VALUES ('865bf0cc-1fe7-4203-944e-f353540d7210');
INSERT INTO public."Teachers" VALUES ('6d321cca-f17c-4858-8b02-52c00c19ecbe');
INSERT INTO public."Teachers" VALUES ('be1a96da-8e34-400c-ac24-db15611ee1ef');
INSERT INTO public."Teachers" VALUES ('3c386667-e0b2-4685-aa50-733e8ab9e487');
INSERT INTO public."Teachers" VALUES ('aa597a6c-b219-4743-b5c6-8740551e79e0');
INSERT INTO public."Teachers" VALUES ('cad5f0e3-b6e4-4a61-864b-3559e067a4bd');
INSERT INTO public."Teachers" VALUES ('64ce4a85-b138-4389-9021-c3a86ce0ca87');
INSERT INTO public."Teachers" VALUES ('703f3eb3-fa50-44a2-b5c3-573a7f9334f3');
INSERT INTO public."Teachers" VALUES ('0227ce3a-de20-47fc-a84e-f44332e838ec');


--
-- TOC entry 3605 (class 0 OID 49898)
-- Dependencies: 237
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Users" VALUES ('39c36d0b-2f1e-40b0-b2a4-aea67bc1c2cf', 'Luisfelipe', 'Rodrich', 'luisfeliperodrigo3@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('a37b3252-3e54-4199-8c4b-728238fc76b8', 'Daoblur', 'Álvarez', 'kpachac@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 10000000, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('5500125e-16f5-4b77-9220-cc4dab69c102', 'Pablo', 'Illanes', 'pillanes@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('a279b603-3953-40cd-82bf-50b9e59b712f', 'Lionel Andrés', 'Messi Cuccitini', 'lmessic@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:24:55.719252-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('ca96a324-7516-4d11-a412-1aa465f9fd2e', 'Diego Armando', 'Maradona Franco', 'dmaradonaf@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:39:28.619451-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('c64a9876-00c6-4032-9d10-c64a0773663a', 'Cristiano Ronaldo', 'Dos Santos Aveiro', 'cdossantosa@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:40:48.828837-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('742ea535-cb8a-4bc7-978c-9af386c206ac', 'Kylian', 'Mbappé Lottin', 'kmbappel@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:14.376123-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('e7c43279-2bcc-4c09-9165-b824041166fc', 'August', 'von Kageneck', 'avonkageneck@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('12bedd1a-d7c6-4b54-aeb5-507ef12d4f83', 'Ben', 'Tennyson', 'btennyson@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 3, true, '2024-10-27 05:50:01.462304-05', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('239e66d0-16c3-4ce4-b321-058b64269f5e', 'Khvicha', 'Kvaratskhelia', 'kkvaratskhelia@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('a8d13f61-99a3-47cc-a041-c93d6daa6aac', 'Erling', 'Haaland Braut', 'ehaalandb@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:23.552476-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('7aabd57c-965c-470f-9ce6-e1da190d483e', 'Pele', 'Nascimento Arantes', 'pnascimentoa@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:41.873565-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('85c27d2a-56ae-4d5f-9477-10af41ce7892', 'Ronaldinho', 'De Assis Moreira', 'rdeassism@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:48.404901-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('1dbee534-4cb4-496f-8cb8-ecad64540925', 'Johan', 'Cruyff Hendrik', 'jcruyffh@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:44:16.737164-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('8933cdee-671a-4b5e-bf2c-76cdf0ed0c4a', 'Neymar da Silva', 'Santos Júnior', 'nsantosj@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:32.955895-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('9b934e06-3abd-4b8d-b45f-7e2106b4bc74', 'Khabib ', 'Nurmagomedov', 'knurmagomedov@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('53993a93-95af-409d-ac7c-15e586de1339', 'Luka', 'Modric Valcic', 'lmodricv@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:41.242832-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('df37ad47-69e1-4ba6-86eb-31f05d4f1683', 'Zinedine', 'Zidane Yazid', 'zzidaney@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:48.416295-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('8ecb8941-a677-40d4-812c-581947c628f0', 'Andrea', 'Pirlo Baldini', 'apirlob@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:41:54.846497-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('af2eff91-54b0-43b4-91c4-57b7e2d62f15', 'Ramzan', 'Kadyrov', 'rkadyrov@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('a6861511-c29c-4133-b21f-33f9316995b1', 'Lars', 'Stindl', 'lstindl@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('0c99c267-71c7-451a-8793-41b4fa6b9fa4', 'Frank', 'Lampard Henry', 'flampardh@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:44:38.498835-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('b1fb23e1-f576-4942-87ac-588155abc80a', 'Thierry', 'Henry Alexandre', 'thenrya@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:42:45.436676-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('e1be6201-c7b0-4127-84f3-c13697a53666', 'Samuel', 'Eto''o Fils', 'setoof@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:01.34295-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('011efd87-33d5-481c-b285-e30318b6e667', 'Gianluigi', 'Buffon Italiano', 'gbuffoni@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:04.137791-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b2', 'Aron', 'Hurtado', 'ahurtadoc@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('9483dad2-a35c-4581-a24f-4b512cdb8dd9', 'Andrés', 'Iniesta Luján', 'ainiestal@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:28.442165-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('c9e28154-eed0-4576-a261-043b03bbaa89', 'George', 'Best Harrison', 'gbesth@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:09.757841-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('c4676ea8-63ef-4947-ba3c-788df4608789', 'Raúl', 'González Blanco', 'rgonzalezb@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:20.148788-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('b2610c53-94a4-4794-bf88-8eb18d3d6609', 'David', 'Beckham Golden', 'dbeckhamg@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:28.615299-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('78588a8b-5070-4279-a0a6-c6223a914a40', 'Iker', 'Casillas Fernández', 'icasillasf@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:43:35.8228-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('d9179c62-9742-4378-9e51-dcb3bf7777a5', 'Gerard', 'Piqué Bernabeu', 'gpiqueb@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:37.846761-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('8f554465-ff8d-4a89-9955-3f31d29928ec', 'Sergio', 'Ramos García', 'sramosg@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:48.514457-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('13bb2c00-653e-4e9f-b79d-85693e00f43c', 'Paul', 'Pogba Ndombele', 'ppogban@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:54.329169-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('0392d24c-a1f5-4022-8278-cfa4efb14b8c', 'Luisfelipe', 'Kennedy', 'lkennedy@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 2, false, '2024-10-07 19:53:02.247-05', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('5557682e-def4-406e-b37f-421217165e81', 'Luisfelipe', 'de Lama', 'ldelama@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 1, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('1979d2a7-de35-4d83-9aa9-857171cba7fa', 'Pedro', 'Torres', 'ptorres@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('38141a4f-bc22-4514-8f9b-139a11b004b8', 'Bastian', 'Schweinsteiger', 'bschweinsteiger@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '-infinity', true, '-infinity');
INSERT INTO public."Users" VALUES ('4feec7b4-13dc-4d52-a613-24a7f938ba3c', 'Gareth', 'Bale Thomas', 'gbalet@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:46:59.929037-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('e8f29dba-0efb-4380-a49f-a3fead0a1586', 'Wayne', 'Rooney Marcus', 'wrooneym@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:47:06.461472-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('5900613f-641c-41f7-ad66-0df37f9ea5fd', 'Carlos', 'Tevez Martínez', 'ctevezm@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:47:32.310816-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('9678fc2b-99ad-4974-a915-1eb4ab08435d', 'James', 'Rodríguez Rubio', 'jrodriguezr@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:48:24.84284-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('0bb0755c-20d5-41f1-a1e4-17290181bcb7', 'Harry', 'Kane Thompson', 'hkaneet@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:48:31.905511-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('14adcf2c-feda-46ef-b71e-15f23894f3cb', 'Fernando', 'Torres Sanz', 'ftorress@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:49:20.954386-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('038b1091-9328-4381-a90a-2ee4b2648f74', 'Xavi', 'Hernández Creus', 'xhernandezc@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:47:14.580998-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('0ae0cdb8-e9d7-4f42-b141-eb9d4bac9520', 'Mohamed', 'Salah Ghaly', 'msalahg@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:48:40.674043-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('eaafdab3-e32e-4753-9843-da73e1654e5a', 'Edinson', 'Cavani Gómez', 'ecavanig@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:49:14.193713-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('94eb5aaa-4df3-4c66-b985-d5b1ea5ed3b2', 'Roberto', 'Carlos Da Silva', 'rcarlosd@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:47:22.745055-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('6ff649f4-518c-49b0-9fbd-20ae55a2c1ed', 'Philippe', 'Coutinho Correia', 'pcoutinhoc@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:47:40.131063-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('9fcc9f8f-3473-4298-98af-1e789d79feee', 'Zlatan', 'Ibrahimović Hansson', 'zibrahimovich@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:49:01.681361-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('b89f3040-6273-4773-aacb-2282d24e6982', 'Victor', 'Valdés Aguilar', 'vvaldesa@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:49:07.779789-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('c1f52c72-6189-45a2-9a22-dfa862ea766a', 'Karim', 'Benzema Hafid', 'kbenzema@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:48:47.848067-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('d53cc6ac-dfc4-4c4a-936c-66d89b451bfb', 'Luis', 'Suárez Díaz', 'lsuarezd@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:48:55.312637-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('865bf0cc-1fe7-4203-944e-f353540d7210', 'Luis Fernando', 'Luque Nieto', 'lluquen@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:53:19.075619-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('6d321cca-f17c-4858-8b02-52c00c19ecbe', 'Elmerson Ramith', 'Portugal Carpio', 'eportugalc@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:54:22.482719-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('be1a96da-8e34-400c-ac24-db15611ee1ef', 'Olger Antonio Jose', 'Quispe Vilca', 'oquispev@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:56:51.221956-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('3c386667-e0b2-4685-aa50-733e8ab9e487', 'Luisfelipe Rodrigo', 'Mamani Arosquipa', 'lmamania@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 05:59:24.402625-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('aa597a6c-b219-4743-b5c6-8740551e79e0', 'Isabel Karina', 'Ttito Campos', 'ittitoc@ulasalle.edu.pe', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:00:23.568829-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('cad5f0e3-b6e4-4a61-864b-3559e067a4bd', 'Miguel', 'Grau', 'mgrau@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:03:16.520624-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('64ce4a85-b138-4389-9021-c3a86ce0ca87', 'Francisco', 'Bolognesi', 'fbolognesi@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:03:54.015378-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('0227ce3a-de20-47fc-a84e-f44332e838ec', 'Rafael', 'Grau', 'rgrau@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:05:31.217513-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('703f3eb3-fa50-44a2-b5c3-573a7f9334f3', 'Andrés', 'Avelino Cáceres', 'aavelino@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:04:29.593486-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('f160a77d-4625-4202-acde-67c49ee605d2', 'Micaela', 'Bastidas', 'mbastidas@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 0, false, '-infinity', false, 10000000, '-infinity', 0, '2024-11-17 06:06:29.838703-05', true, '-infinity');
INSERT INTO public."Users" VALUES ('8d676dc9-1a50-48f6-aa83-cb47535c5af3', 'Elmerson', 'Ferito', 'elmerson30@plagitracker.com', '\x5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8afdc750cfdb758772fc05a624917c76c', 0, false, '-infinity', false, 0, '-infinity', 0, '-infinity', true, '-infinity');


--
-- TOC entry 3604 (class 0 OID 49893)
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


--
-- TOC entry 3633 (class 0 OID 0)
-- Dependencies: 234
-- Name: aggregatedcounter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.aggregatedcounter_id_seq', 49, true);


--
-- TOC entry 3634 (class 0 OID 0)
-- Dependencies: 216
-- Name: counter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.counter_id_seq', 180, true);


--
-- TOC entry 3635 (class 0 OID 0)
-- Dependencies: 218
-- Name: hash_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.hash_id_seq', 1, false);


--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 220
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.job_id_seq', 60, true);


--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 231
-- Name: jobparameter_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.jobparameter_id_seq', 63, true);


--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 224
-- Name: jobqueue_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.jobqueue_id_seq', 84, true);


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 226
-- Name: list_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.list_id_seq', 1, false);


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 229
-- Name: set_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.set_id_seq', 108, true);


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 222
-- Name: state_id_seq; Type: SEQUENCE SET; Schema: hangfire; Owner: postgres
--

SELECT pg_catalog.setval('hangfire.state_id_seq', 341, true);


--
-- TOC entry 3376 (class 2606 OID 49767)
-- Name: aggregatedcounter aggregatedcounter_key_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter
    ADD CONSTRAINT aggregatedcounter_key_key UNIQUE (key);


--
-- TOC entry 3378 (class 2606 OID 49765)
-- Name: aggregatedcounter aggregatedcounter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.aggregatedcounter
    ADD CONSTRAINT aggregatedcounter_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2606 OID 49601)
-- Name: counter counter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.counter
    ADD CONSTRAINT counter_pkey PRIMARY KEY (id);


--
-- TOC entry 3343 (class 2606 OID 49736)
-- Name: hash hash_key_field_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash
    ADD CONSTRAINT hash_key_field_key UNIQUE (key, field);


--
-- TOC entry 3345 (class 2606 OID 49610)
-- Name: hash hash_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.hash
    ADD CONSTRAINT hash_pkey PRIMARY KEY (id);


--
-- TOC entry 3350 (class 2606 OID 49620)
-- Name: job job_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 49670)
-- Name: jobparameter jobparameter_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter
    ADD CONSTRAINT jobparameter_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 49693)
-- Name: jobqueue jobqueue_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobqueue
    ADD CONSTRAINT jobqueue_pkey PRIMARY KEY (id);


--
-- TOC entry 3361 (class 2606 OID 49713)
-- Name: list list_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.list
    ADD CONSTRAINT list_pkey PRIMARY KEY (id);


--
-- TOC entry 3374 (class 2606 OID 49592)
-- Name: lock lock_resource_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.lock
    ADD CONSTRAINT lock_resource_key UNIQUE (resource);

ALTER TABLE ONLY hangfire.lock REPLICA IDENTITY USING INDEX lock_resource_key;


--
-- TOC entry 3337 (class 2606 OID 49471)
-- Name: schema schema_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.schema
    ADD CONSTRAINT schema_pkey PRIMARY KEY (version);


--
-- TOC entry 3363 (class 2606 OID 49739)
-- Name: server server_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.server
    ADD CONSTRAINT server_pkey PRIMARY KEY (id);


--
-- TOC entry 3367 (class 2606 OID 49741)
-- Name: set set_key_value_key; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set
    ADD CONSTRAINT set_key_value_key UNIQUE (key, value);


--
-- TOC entry 3369 (class 2606 OID 49722)
-- Name: set set_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.set
    ADD CONSTRAINT set_pkey PRIMARY KEY (id);


--
-- TOC entry 3353 (class 2606 OID 49647)
-- Name: state state_pkey; Type: CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id);


--
-- TOC entry 3396 (class 2606 OID 49939)
-- Name: Assignments PK_Assignments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "PK_Assignments" PRIMARY KEY ("Id");


--
-- TOC entry 3417 (class 2606 OID 50042)
-- Name: Classes PK_Classes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "PK_Classes" PRIMARY KEY ("Id");


--
-- TOC entry 3406 (class 2606 OID 49983)
-- Name: Codes PK_Codes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "PK_Codes" PRIMARY KEY ("Id");


--
-- TOC entry 3392 (class 2606 OID 49929)
-- Name: Courses PK_Courses; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "PK_Courses" PRIMARY KEY ("Id");


--
-- TOC entry 3399 (class 2606 OID 49949)
-- Name: Enrollments PK_Enrollments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "PK_Enrollments" PRIMARY KEY ("StudentId", "CourseId");


--
-- TOC entry 3413 (class 2606 OID 50030)
-- Name: Exercises PK_Exercises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "PK_Exercises" PRIMARY KEY ("Id");


--
-- TOC entry 3423 (class 2606 OID 50126)
-- Name: Methods PK_Methods; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "PK_Methods" PRIMARY KEY ("Id");


--
-- TOC entry 3420 (class 2606 OID 50108)
-- Name: Parameter PK_Parameter; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "PK_Parameter" PRIMARY KEY ("Id");


--
-- TOC entry 3410 (class 2606 OID 49995)
-- Name: Plagiarisms PK_Plagiarisms; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "PK_Plagiarisms" PRIMARY KEY ("Id");


--
-- TOC entry 3385 (class 2606 OID 49909)
-- Name: Students PK_Students; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "PK_Students" PRIMARY KEY ("Id");


--
-- TOC entry 3403 (class 2606 OID 49966)
-- Name: Submissions PK_Submissions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "PK_Submissions" PRIMARY KEY ("Id");


--
-- TOC entry 3387 (class 2606 OID 49919)
-- Name: Teachers PK_Teachers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "PK_Teachers" PRIMARY KEY ("Id");


--
-- TOC entry 3383 (class 2606 OID 49904)
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- TOC entry 3380 (class 2606 OID 49897)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 3340 (class 1259 OID 49775)
-- Name: ix_hangfire_counter_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_counter_expireat ON hangfire.counter USING btree (expireat);


--
-- TOC entry 3341 (class 1259 OID 49730)
-- Name: ix_hangfire_counter_key; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_counter_key ON hangfire.counter USING btree (key);


--
-- TOC entry 3346 (class 1259 OID 49784)
-- Name: ix_hangfire_hash_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_hash_expireat ON hangfire.hash USING btree (expireat);


--
-- TOC entry 3347 (class 1259 OID 49801)
-- Name: ix_hangfire_job_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_job_expireat ON hangfire.job USING btree (expireat);


--
-- TOC entry 3348 (class 1259 OID 49737)
-- Name: ix_hangfire_job_statename; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_job_statename ON hangfire.job USING btree (statename);


--
-- TOC entry 3370 (class 1259 OID 49742)
-- Name: ix_hangfire_jobparameter_jobidandname; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobparameter_jobidandname ON hangfire.jobparameter USING btree (jobid, name);


--
-- TOC entry 3354 (class 1259 OID 49887)
-- Name: ix_hangfire_jobqueue_fetchedat_queue_jobid; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobqueue_fetchedat_queue_jobid ON hangfire.jobqueue USING btree (fetchedat NULLS FIRST, queue, jobid);


--
-- TOC entry 3355 (class 1259 OID 49702)
-- Name: ix_hangfire_jobqueue_jobidandqueue; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobqueue_jobidandqueue ON hangfire.jobqueue USING btree (jobid, queue);


--
-- TOC entry 3356 (class 1259 OID 49810)
-- Name: ix_hangfire_jobqueue_queueandfetchedat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_jobqueue_queueandfetchedat ON hangfire.jobqueue USING btree (queue, fetchedat);


--
-- TOC entry 3359 (class 1259 OID 49821)
-- Name: ix_hangfire_list_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_list_expireat ON hangfire.list USING btree (expireat);


--
-- TOC entry 3364 (class 1259 OID 49841)
-- Name: ix_hangfire_set_expireat; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_set_expireat ON hangfire.set USING btree (expireat);


--
-- TOC entry 3365 (class 1259 OID 49756)
-- Name: ix_hangfire_set_key_score; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_set_key_score ON hangfire.set USING btree (key, score);


--
-- TOC entry 3351 (class 1259 OID 49655)
-- Name: ix_hangfire_state_jobid; Type: INDEX; Schema: hangfire; Owner: postgres
--

CREATE INDEX ix_hangfire_state_jobid ON hangfire.state USING btree (jobid);


--
-- TOC entry 3393 (class 1259 OID 50001)
-- Name: IX_Assignments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Assignments_CourseId" ON public."Assignments" USING btree ("CourseId");


--
-- TOC entry 3394 (class 1259 OID 50002)
-- Name: IX_Assignments_Title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Assignments_Title" ON public."Assignments" USING btree ("Title");


--
-- TOC entry 3414 (class 1259 OID 50065)
-- Name: IX_Classes_ExerciseId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Classes_ExerciseId_Name" ON public."Classes" USING btree ("ExerciseId", "Name");


--
-- TOC entry 3415 (class 1259 OID 50066)
-- Name: IX_Classes_ParentClassId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Classes_ParentClassId" ON public."Classes" USING btree ("ParentClassId");


--
-- TOC entry 3404 (class 1259 OID 50003)
-- Name: IX_Codes_SubmissionId_FileName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Codes_SubmissionId_FileName" ON public."Codes" USING btree ("SubmissionId", "FileName");


--
-- TOC entry 3388 (class 1259 OID 50178)
-- Name: IX_Courses_InvitationId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_InvitationId" ON public."Courses" USING btree ("InvitationId");


--
-- TOC entry 3389 (class 1259 OID 50119)
-- Name: IX_Courses_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_Name" ON public."Courses" USING btree ("Name");


--
-- TOC entry 3390 (class 1259 OID 50004)
-- Name: IX_Courses_TeacherId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Courses_TeacherId" ON public."Courses" USING btree ("TeacherId");


--
-- TOC entry 3397 (class 1259 OID 50005)
-- Name: IX_Enrollments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Enrollments_CourseId" ON public."Enrollments" USING btree ("CourseId");


--
-- TOC entry 3411 (class 1259 OID 50067)
-- Name: IX_Exercises_AssignmentId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Exercises_AssignmentId_Name" ON public."Exercises" USING btree ("AssignmentId", "Name");


--
-- TOC entry 3421 (class 1259 OID 50133)
-- Name: IX_Methods_ClassId_Type_Name_ParameterTypes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Methods_ClassId_Type_Name_ParameterTypes" ON public."Methods" USING btree ("ClassId", "Type", "Name", "ParameterTypes");


--
-- TOC entry 3418 (class 1259 OID 50132)
-- Name: IX_Parameter_MethodId_Type_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Parameter_MethodId_Type_Name" ON public."Parameter" USING btree ("MethodId", "Type", "Name");


--
-- TOC entry 3407 (class 1259 OID 50015)
-- Name: IX_Plagiarisms_CodeId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Plagiarisms_CodeId" ON public."Plagiarisms" USING btree ("CodeId");


--
-- TOC entry 3408 (class 1259 OID 50016)
-- Name: IX_Plagiarisms_Id_CodeId_Algorithm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Plagiarisms_Id_CodeId_Algorithm" ON public."Plagiarisms" USING btree ("Id", "CodeId", "Algorithm");


--
-- TOC entry 3400 (class 1259 OID 50007)
-- Name: IX_Submissions_AssignmentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Submissions_AssignmentId" ON public."Submissions" USING btree ("AssignmentId");


--
-- TOC entry 3401 (class 1259 OID 50180)
-- Name: IX_Submissions_StudentId_AssignmentId_Url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Submissions_StudentId_AssignmentId_Url" ON public."Submissions" USING btree ("StudentId", "AssignmentId", "Url");


--
-- TOC entry 3381 (class 1259 OID 50070)
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- TOC entry 3425 (class 2606 OID 49679)
-- Name: jobparameter jobparameter_jobid_fkey; Type: FK CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.jobparameter
    ADD CONSTRAINT jobparameter_jobid_fkey FOREIGN KEY (jobid) REFERENCES hangfire.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3424 (class 2606 OID 49656)
-- Name: state state_jobid_fkey; Type: FK CONSTRAINT; Schema: hangfire; Owner: postgres
--

ALTER TABLE ONLY hangfire.state
    ADD CONSTRAINT state_jobid_fkey FOREIGN KEY (jobid) REFERENCES hangfire.job(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3429 (class 2606 OID 49940)
-- Name: Assignments FK_Assignments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "FK_Assignments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3437 (class 2606 OID 50043)
-- Name: Classes FK_Classes_Classes_ParentClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Classes_ParentClassId" FOREIGN KEY ("ParentClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3438 (class 2606 OID 50048)
-- Name: Classes FK_Classes_Exercises_ExerciseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Exercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES public."Exercises"("Id") ON DELETE CASCADE;


--
-- TOC entry 3434 (class 2606 OID 49984)
-- Name: Codes FK_Codes_Submissions_SubmissionId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "FK_Codes_Submissions_SubmissionId" FOREIGN KEY ("SubmissionId") REFERENCES public."Submissions"("Id") ON DELETE CASCADE;


--
-- TOC entry 3428 (class 2606 OID 49930)
-- Name: Courses FK_Courses_Teachers_TeacherId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "FK_Courses_Teachers_TeacherId" FOREIGN KEY ("TeacherId") REFERENCES public."Teachers"("Id") ON DELETE CASCADE;


--
-- TOC entry 3430 (class 2606 OID 49950)
-- Name: Enrollments FK_Enrollments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3431 (class 2606 OID 49955)
-- Name: Enrollments FK_Enrollments_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3436 (class 2606 OID 50031)
-- Name: Exercises FK_Exercises_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "FK_Exercises_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3440 (class 2606 OID 50127)
-- Name: Methods FK_Methods_Classes_ClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "FK_Methods_Classes_ClassId" FOREIGN KEY ("ClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3439 (class 2606 OID 50134)
-- Name: Parameter FK_Parameter_Methods_MethodId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "FK_Parameter_Methods_MethodId" FOREIGN KEY ("MethodId") REFERENCES public."Methods"("Id") ON DELETE CASCADE;


--
-- TOC entry 3435 (class 2606 OID 49996)
-- Name: Plagiarisms FK_Plagiarisms_Codes_CodeId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "FK_Plagiarisms_Codes_CodeId" FOREIGN KEY ("CodeId") REFERENCES public."Codes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3426 (class 2606 OID 49910)
-- Name: Students FK_Students_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "FK_Students_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- TOC entry 3432 (class 2606 OID 49967)
-- Name: Submissions FK_Submissions_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3433 (class 2606 OID 49972)
-- Name: Submissions FK_Submissions_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3427 (class 2606 OID 49920)
-- Name: Teachers FK_Teachers_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "FK_Teachers_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-11-17 17:47:06

--
-- PostgreSQL database dump complete
--

