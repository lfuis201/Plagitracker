--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 15.7

-- Started on 2024-11-18 11:19:30

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
-- TOC entry 5 (class 2615 OID 49346)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

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
    "UpdatedAt" timestamp with time zone DEFAULT '-infinity'::timestamp with time zone NOT NULL,
    "DolosURLId" character varying(20)
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
-- TOC entry 3513 (class 0 OID 49935)
-- Dependencies: 241
-- Data for Name: Assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Assignments" VALUES ('ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '', 'Programación Orientada a Objetos', '2024-12-07 10:14:26.713-05', '2024-10-09 18:40:04.711558-05', true, '5500125e-16f5-4b77-9220-cc4dab69c100', '-infinity', true, '-infinity', NULL);
INSERT INTO public."Assignments" VALUES ('e4be8d12-8d5e-43d2-817c-b5997043304d', 'Ninguna', 'Programación Orientada a Objetos 2', '2024-12-24 19:43:58.85-05', '-infinity', false, '5500125e-16f5-4b77-9220-cc4dab69c100', '2024-11-17 19:46:30.389352-05', true, '-infinity', NULL);
INSERT INTO public."Assignments" VALUES ('025f1811-79ec-43b2-9693-652fa2f7bdb1', NULL, 'Programación Orientada a Objetos 3', '2024-12-24 19:43:58.85-05', '-infinity', false, '5500125e-16f5-4b77-9220-cc4dab69c100', '2024-11-17 19:48:36.691752-05', true, '-infinity', '555330002685787655');


--
-- TOC entry 3519 (class 0 OID 50036)
-- Dependencies: 247
-- Data for Name: Classes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3516 (class 0 OID 49977)
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
INSERT INTO public."Codes" VALUES ('a7b61980-fb3c-46b6-8471-46c7c80b55fd', '7d0f9c15-9e1b-4301-8b6e-7812cca1d451', 'Person.java', 'public class Person {
private String name;
private int age;

// Constructor for the Person class that initializes the name and age variables
public Person(String name, int age) {
this.name = name;
this.age = age;
}

// Method to retrieve the name of the person
public String getName() {
return name;
}

// Method to retrieve the age of the person
public int getAge() {
return age;
}

// Method to set the name of the person
public void setName(String name) {
this.name = name;
}

', '2024-11-17 19:27:48.358448-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('b0eeb1d1-9e34-4157-9744-b9ee629a61c2', '7d0f9c15-9e1b-4301-8b6e-7812cca1d451', 'Main.java', 'public class Main
{
public static void main(String[] args) {
System.out.println("Hello PlagiTracker");
}
}', '2024-11-17 19:27:48.334268-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('09b35d8c-a153-4a9a-a218-84a379fe868c', '7397a9ce-94a9-4e5b-9cbb-215f061b197e', 'Persona.java', 'public class Persona {
private String nombre;
int edad;

public Persona(String name, int age) {
this.nombre = name;
this.edad = age;
}

public String getName() {
return nombre;
}

public int getAge() {
return edad;
}

public void setName(String name) {
this.nombre = name;
}

public void setAge(int age) {
this.edad = age;
}
}', '2024-11-17 20:28:57.782538-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('bab848e0-1ce8-4d0f-83b4-8b95afda5047', '7397a9ce-94a9-4e5b-9cbb-215f061b197e', 'Main.java', 'public class Main
{
public static void main(String[] args) {

// con esto imprimo
System.out.println("Hello My Friend!");
}
}', '2024-11-17 20:28:57.76432-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('83bafa2e-f925-4ab5-a1d7-be8d030eb0b9', '14cabe76-3398-4429-ad34-01679f08acb9', 'Main.java', 'public class Main
{
public static void main(String[] args) {
System.out.println("Hello PlagiTracker");
}
}', '2024-11-18 09:36:13.451974-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('a3c6fd63-81e7-4bca-8a49-b163f292400b', '14cabe76-3398-4429-ad34-01679f08acb9', 'Person.java', 'public class Person
{
private String fname;
private String lname;
private int age;


public String getFname()
{
return fname;
}


public String getLname()
{
return lname;
}


public int getAge()
{
return age;
}


', '2024-11-18 09:36:13.473267-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('ae9c9b0d-8af5-4125-b0f0-dfc96b2e57e4', '7d0f9c15-9e1b-4301-8b6e-7812cca1d451', 'Square.java', 'public class Square {
/** the width of square*/
int width;

/** construct the square*/
Square(){
}

/**construct a square */
Square(int newWidth){
width = newWidth;
}

/**show the square*/
void draw(){
for (int i=0; i<width; i++)
{
for (int j=0; j<width; j++)
{    System.out.print("* ");}

System.out.println();
}

}', '2024-11-17 19:27:48.358653-05', true, '-infinity');
INSERT INTO public."Codes" VALUES ('f8783fdd-7adc-4ab1-9a68-867f875cf3c7', '7397a9ce-94a9-4e5b-9cbb-215f061b197e', 'Cuadrado.java', 'public class Cuadrado {
/** the width of square*/
int ancho;

/** construct the square*/
Cuadrado(){
}

/**construct a square */
Cuadrado(int newWidth){
ancho = newWidth;
}

/**show the square*/
void draw(){
for (int i=0; i<ancho; i++)
{
for (int j=0; j<ancho; j++)
{    System.out.print("* ");}

System.out.println();
}

}', '2024-11-17 20:28:57.782764-05', true, '-infinity');


--
-- TOC entry 3512 (class 0 OID 49925)
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
-- TOC entry 3514 (class 0 OID 49945)
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
-- TOC entry 3518 (class 0 OID 50024)
-- Dependencies: 246
-- Data for Name: Exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3521 (class 0 OID 50120)
-- Dependencies: 249
-- Data for Name: Methods; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3520 (class 0 OID 50102)
-- Dependencies: 248
-- Data for Name: Parameter; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3517 (class 0 OID 49989)
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
-- TOC entry 3510 (class 0 OID 49905)
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
-- TOC entry 3515 (class 0 OID 49960)
-- Dependencies: 243
-- Data for Name: Submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Submissions" VALUES ('6e701991-2a14-4493-a170-f4fe910e9c4a', 'https://www.codiva.io/p/9f4e0e63-82d0-4241-b0bf-e12ae7a9b700', '2024-10-07 10:35:31.051-05', 0.00, '12bedd1a-d7c6-4b54-aeb5-507ef12d4f83', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('e0d30fd2-1027-4af3-be3b-238a579dacb8', 'https://www.codiva.io/p/e0f1785e-40a2-4174-a00d-e76fbcfc95f8', '2024-10-07 10:35:31.051-05', 0.00, '9b934e06-3abd-4b8d-b45f-7e2106b4bc74', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('b6c2d5e1-33c4-4048-820b-03d25fe674b9', 'https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c3', '2024-10-07 10:35:31.051-05', 0.00, 'af2eff91-54b0-43b4-91c4-57b7e2d62f15', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('31edb16a-feb4-4cab-812c-e8a4bdb6ad45', 'https://www.codiva.io/p/925bfea6-e307-4cbb-8e43-dbf634ec7325', '2024-10-07 10:35:31.051-05', 0.00, '239e66d0-16c3-4ce4-b321-058b64269f5e', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('6252ac2f-e197-4ec3-821f-56ef3dffc72c', 'https://www.codiva.io/p/dbc162b6-5afe-46bf-b4b3-ee42f11c37c4', '2024-10-07 10:35:31.051-05', 0.00, 'e7c43279-2bcc-4c09-9165-b824041166fc', 'ac85b4e5-33ea-4d2c-a281-f7ec41da15f7', '-infinity', true, '-infinity', 0, 0);
INSERT INTO public."Submissions" VALUES ('7d0f9c15-9e1b-4301-8b6e-7812cca1d451', 'https://www.onlinegdb.com/cky2lPU84', '2024-11-17 19:12:19.911-05', 0.00, '8d676dc9-1a50-48f6-aa83-cb47535c5af3', '025f1811-79ec-43b2-9693-652fa2f7bdb1', '2024-11-17 19:27:21.610589-05', true, '-infinity', 3, 0);
INSERT INTO public."Submissions" VALUES ('7397a9ce-94a9-4e5b-9cbb-215f061b197e', 'https://www.onlinegdb.com/zWDNPiT9M', '2024-11-17 20:27:14.246-05', 0.00, '38141a4f-bc22-4514-8f9b-139a11b004b8', '025f1811-79ec-43b2-9693-652fa2f7bdb1', '2024-11-17 20:28:27.708371-05', true, '-infinity', 3, 0);
INSERT INTO public."Submissions" VALUES ('14cabe76-3398-4429-ad34-01679f08acb9', 'https://www.onlinegdb.com/bdoucGuWb', '2024-11-18 09:28:25.801-05', 0.00, '9b934e06-3abd-4b8d-b45f-7e2106b4bc74', '025f1811-79ec-43b2-9693-652fa2f7bdb1', '2024-11-18 09:35:49.879123-05', true, '-infinity', 3, 0);


--
-- TOC entry 3511 (class 0 OID 49915)
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
-- TOC entry 3509 (class 0 OID 49898)
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
-- TOC entry 3508 (class 0 OID 49893)
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
-- TOC entry 3323 (class 2606 OID 49939)
-- Name: Assignments PK_Assignments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "PK_Assignments" PRIMARY KEY ("Id");


--
-- TOC entry 3344 (class 2606 OID 50042)
-- Name: Classes PK_Classes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "PK_Classes" PRIMARY KEY ("Id");


--
-- TOC entry 3333 (class 2606 OID 49983)
-- Name: Codes PK_Codes; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "PK_Codes" PRIMARY KEY ("Id");


--
-- TOC entry 3319 (class 2606 OID 49929)
-- Name: Courses PK_Courses; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "PK_Courses" PRIMARY KEY ("Id");


--
-- TOC entry 3326 (class 2606 OID 49949)
-- Name: Enrollments PK_Enrollments; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "PK_Enrollments" PRIMARY KEY ("StudentId", "CourseId");


--
-- TOC entry 3340 (class 2606 OID 50030)
-- Name: Exercises PK_Exercises; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "PK_Exercises" PRIMARY KEY ("Id");


--
-- TOC entry 3350 (class 2606 OID 50126)
-- Name: Methods PK_Methods; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "PK_Methods" PRIMARY KEY ("Id");


--
-- TOC entry 3347 (class 2606 OID 50108)
-- Name: Parameter PK_Parameter; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "PK_Parameter" PRIMARY KEY ("Id");


--
-- TOC entry 3337 (class 2606 OID 49995)
-- Name: Plagiarisms PK_Plagiarisms; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "PK_Plagiarisms" PRIMARY KEY ("Id");


--
-- TOC entry 3312 (class 2606 OID 49909)
-- Name: Students PK_Students; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "PK_Students" PRIMARY KEY ("Id");


--
-- TOC entry 3330 (class 2606 OID 49966)
-- Name: Submissions PK_Submissions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "PK_Submissions" PRIMARY KEY ("Id");


--
-- TOC entry 3314 (class 2606 OID 49919)
-- Name: Teachers PK_Teachers; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "PK_Teachers" PRIMARY KEY ("Id");


--
-- TOC entry 3310 (class 2606 OID 49904)
-- Name: Users PK_Users; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "PK_Users" PRIMARY KEY ("Id");


--
-- TOC entry 3307 (class 2606 OID 49897)
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- TOC entry 3320 (class 1259 OID 50001)
-- Name: IX_Assignments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Assignments_CourseId" ON public."Assignments" USING btree ("CourseId");


--
-- TOC entry 3321 (class 1259 OID 50002)
-- Name: IX_Assignments_Title; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Assignments_Title" ON public."Assignments" USING btree ("Title");


--
-- TOC entry 3341 (class 1259 OID 50065)
-- Name: IX_Classes_ExerciseId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Classes_ExerciseId_Name" ON public."Classes" USING btree ("ExerciseId", "Name");


--
-- TOC entry 3342 (class 1259 OID 50066)
-- Name: IX_Classes_ParentClassId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Classes_ParentClassId" ON public."Classes" USING btree ("ParentClassId");


--
-- TOC entry 3331 (class 1259 OID 50003)
-- Name: IX_Codes_SubmissionId_FileName; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Codes_SubmissionId_FileName" ON public."Codes" USING btree ("SubmissionId", "FileName");


--
-- TOC entry 3315 (class 1259 OID 50178)
-- Name: IX_Courses_InvitationId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_InvitationId" ON public."Courses" USING btree ("InvitationId");


--
-- TOC entry 3316 (class 1259 OID 50119)
-- Name: IX_Courses_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Courses_Name" ON public."Courses" USING btree ("Name");


--
-- TOC entry 3317 (class 1259 OID 50004)
-- Name: IX_Courses_TeacherId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Courses_TeacherId" ON public."Courses" USING btree ("TeacherId");


--
-- TOC entry 3324 (class 1259 OID 50005)
-- Name: IX_Enrollments_CourseId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Enrollments_CourseId" ON public."Enrollments" USING btree ("CourseId");


--
-- TOC entry 3338 (class 1259 OID 50067)
-- Name: IX_Exercises_AssignmentId_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Exercises_AssignmentId_Name" ON public."Exercises" USING btree ("AssignmentId", "Name");


--
-- TOC entry 3348 (class 1259 OID 50133)
-- Name: IX_Methods_ClassId_Type_Name_ParameterTypes; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Methods_ClassId_Type_Name_ParameterTypes" ON public."Methods" USING btree ("ClassId", "Type", "Name", "ParameterTypes");


--
-- TOC entry 3345 (class 1259 OID 50132)
-- Name: IX_Parameter_MethodId_Type_Name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Parameter_MethodId_Type_Name" ON public."Parameter" USING btree ("MethodId", "Type", "Name");


--
-- TOC entry 3334 (class 1259 OID 50015)
-- Name: IX_Plagiarisms_CodeId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Plagiarisms_CodeId" ON public."Plagiarisms" USING btree ("CodeId");


--
-- TOC entry 3335 (class 1259 OID 50016)
-- Name: IX_Plagiarisms_Id_CodeId_Algorithm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Plagiarisms_Id_CodeId_Algorithm" ON public."Plagiarisms" USING btree ("Id", "CodeId", "Algorithm");


--
-- TOC entry 3327 (class 1259 OID 50007)
-- Name: IX_Submissions_AssignmentId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IX_Submissions_AssignmentId" ON public."Submissions" USING btree ("AssignmentId");


--
-- TOC entry 3328 (class 1259 OID 50180)
-- Name: IX_Submissions_StudentId_AssignmentId_Url; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Submissions_StudentId_AssignmentId_Url" ON public."Submissions" USING btree ("StudentId", "AssignmentId", "Url");


--
-- TOC entry 3308 (class 1259 OID 50070)
-- Name: IX_Users_Email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "IX_Users_Email" ON public."Users" USING btree ("Email");


--
-- TOC entry 3354 (class 2606 OID 49940)
-- Name: Assignments FK_Assignments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Assignments"
    ADD CONSTRAINT "FK_Assignments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3362 (class 2606 OID 50043)
-- Name: Classes FK_Classes_Classes_ParentClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Classes_ParentClassId" FOREIGN KEY ("ParentClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3363 (class 2606 OID 50048)
-- Name: Classes FK_Classes_Exercises_ExerciseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Classes"
    ADD CONSTRAINT "FK_Classes_Exercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES public."Exercises"("Id") ON DELETE CASCADE;


--
-- TOC entry 3359 (class 2606 OID 49984)
-- Name: Codes FK_Codes_Submissions_SubmissionId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Codes"
    ADD CONSTRAINT "FK_Codes_Submissions_SubmissionId" FOREIGN KEY ("SubmissionId") REFERENCES public."Submissions"("Id") ON DELETE CASCADE;


--
-- TOC entry 3353 (class 2606 OID 49930)
-- Name: Courses FK_Courses_Teachers_TeacherId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Courses"
    ADD CONSTRAINT "FK_Courses_Teachers_TeacherId" FOREIGN KEY ("TeacherId") REFERENCES public."Teachers"("Id") ON DELETE CASCADE;


--
-- TOC entry 3355 (class 2606 OID 49950)
-- Name: Enrollments FK_Enrollments_Courses_CourseId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES public."Courses"("Id") ON DELETE CASCADE;


--
-- TOC entry 3356 (class 2606 OID 49955)
-- Name: Enrollments FK_Enrollments_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Enrollments"
    ADD CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3361 (class 2606 OID 50031)
-- Name: Exercises FK_Exercises_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Exercises"
    ADD CONSTRAINT "FK_Exercises_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3365 (class 2606 OID 50127)
-- Name: Methods FK_Methods_Classes_ClassId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Methods"
    ADD CONSTRAINT "FK_Methods_Classes_ClassId" FOREIGN KEY ("ClassId") REFERENCES public."Classes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3364 (class 2606 OID 50134)
-- Name: Parameter FK_Parameter_Methods_MethodId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Parameter"
    ADD CONSTRAINT "FK_Parameter_Methods_MethodId" FOREIGN KEY ("MethodId") REFERENCES public."Methods"("Id") ON DELETE CASCADE;


--
-- TOC entry 3360 (class 2606 OID 49996)
-- Name: Plagiarisms FK_Plagiarisms_Codes_CodeId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Plagiarisms"
    ADD CONSTRAINT "FK_Plagiarisms_Codes_CodeId" FOREIGN KEY ("CodeId") REFERENCES public."Codes"("Id") ON DELETE CASCADE;


--
-- TOC entry 3351 (class 2606 OID 49910)
-- Name: Students FK_Students_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Students"
    ADD CONSTRAINT "FK_Students_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- TOC entry 3357 (class 2606 OID 49967)
-- Name: Submissions FK_Submissions_Assignments_AssignmentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES public."Assignments"("Id") ON DELETE CASCADE;


--
-- TOC entry 3358 (class 2606 OID 49972)
-- Name: Submissions FK_Submissions_Students_StudentId; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Submissions"
    ADD CONSTRAINT "FK_Submissions_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES public."Students"("Id") ON DELETE CASCADE;


--
-- TOC entry 3352 (class 2606 OID 49920)
-- Name: Teachers FK_Teachers_Users_Id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Teachers"
    ADD CONSTRAINT "FK_Teachers_Users_Id" FOREIGN KEY ("Id") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-11-18 11:19:31

--
-- PostgreSQL database dump complete
--

