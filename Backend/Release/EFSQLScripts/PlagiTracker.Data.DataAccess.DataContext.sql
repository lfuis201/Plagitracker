CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Users" (
        "Id" uuid NOT NULL,
        "FirstName" character varying(40) NOT NULL,
        "LastName" character varying(40) NOT NULL,
        "Email" character varying(35) NOT NULL,
        "PasswordHash" bytea NOT NULL,
        "LogInAttempts" integer NOT NULL,
        "IsLocked" boolean NOT NULL,
        "UnlockDate" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_Users" PRIMARY KEY ("Id")
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Students" (
        "Id" uuid NOT NULL,
        CONSTRAINT "PK_Students" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Students_Users_Id" FOREIGN KEY ("Id") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Teachers" (
        "Id" uuid NOT NULL,
        CONSTRAINT "PK_Teachers" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Teachers_Users_Id" FOREIGN KEY ("Id") REFERENCES "Users" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Courses" (
        "Id" uuid NOT NULL,
        "Name" character varying(80) NOT NULL,
        "TeacherId" uuid NOT NULL,
        CONSTRAINT "PK_Courses" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Courses_Teachers_TeacherId" FOREIGN KEY ("TeacherId") REFERENCES "Teachers" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Assignments" (
        "Id" uuid NOT NULL,
        "Description" character varying(250),
        "Title" character varying(50) NOT NULL,
        "SubmissionDate" timestamp with time zone NOT NULL,
        "AnalysisDate" timestamp with time zone NOT NULL,
        "IsAnalyzed" boolean NOT NULL,
        "CourseId" uuid NOT NULL,
        CONSTRAINT "PK_Assignments" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Assignments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Enrollments" (
        "StudentId" uuid NOT NULL,
        "CourseId" uuid NOT NULL,
        "Grade" numeric(4,2) NOT NULL,
        CONSTRAINT "PK_Enrollments" PRIMARY KEY ("StudentId", "CourseId"),
        CONSTRAINT "FK_Enrollments_Courses_CourseId" FOREIGN KEY ("CourseId") REFERENCES "Courses" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_Enrollments_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Submissions" (
        "Id" uuid NOT NULL,
        "Url" text NOT NULL,
        "SubmissionDate" timestamp with time zone NOT NULL,
        "Grade" numeric(4,2) NOT NULL,
        "StudentId" uuid NOT NULL,
        "AssignmentId" uuid NOT NULL,
        CONSTRAINT "PK_Submissions" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Submissions_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES "Assignments" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_Submissions_Students_StudentId" FOREIGN KEY ("StudentId") REFERENCES "Students" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Codes" (
        "Id" uuid NOT NULL,
        "SubmissionId" uuid NOT NULL,
        "FileName" character varying(50) NOT NULL,
        "Content" text NOT NULL,
        CONSTRAINT "PK_Codes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Codes_Submissions_SubmissionId" FOREIGN KEY ("SubmissionId") REFERENCES "Submissions" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE TABLE "Plagiarisms" (
        "Id" uuid NOT NULL,
        "Similarity" numeric(5,2) NOT NULL,
        "Coincidences" integer NOT NULL,
        "CodeSnippet" text,
        "CodeId" uuid NOT NULL,
        "Algorithm" integer NOT NULL,
        CONSTRAINT "PK_Plagiarisms" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Plagiarisms_Codes_CodeId" FOREIGN KEY ("CodeId") REFERENCES "Codes" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE INDEX "IX_Assignments_CourseId" ON "Assignments" ("CourseId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Assignments_Title" ON "Assignments" ("Title");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Codes_SubmissionId_FileName" ON "Codes" ("SubmissionId", "FileName");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE INDEX "IX_Courses_TeacherId" ON "Courses" ("TeacherId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE INDEX "IX_Enrollments_CourseId" ON "Enrollments" ("CourseId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Plagiarisms_CodeId_Algorithm" ON "Plagiarisms" ("CodeId", "Algorithm");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE INDEX "IX_Submissions_AssignmentId" ON "Submissions" ("AssignmentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Submissions_StudentId_AssignmentId" ON "Submissions" ("StudentId", "AssignmentId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Submissions_Url" ON "Submissions" ("Url");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    CREATE UNIQUE INDEX "IX_Users_Email" ON "Users" ("Email");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009172748_UpgradeDataBasev3') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241009172748_UpgradeDataBasev3', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009233022_UndateConstraintPlagiarism') THEN
    DROP INDEX "IX_Plagiarisms_CodeId_Algorithm";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009233022_UndateConstraintPlagiarism') THEN
    CREATE INDEX "IX_Plagiarisms_CodeId" ON "Plagiarisms" ("CodeId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009233022_UndateConstraintPlagiarism') THEN
    CREATE UNIQUE INDEX "IX_Plagiarisms_Id_CodeId_Algorithm" ON "Plagiarisms" ("Id", "CodeId", "Algorithm");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241009233022_UndateConstraintPlagiarism') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241009233022_UndateConstraintPlagiarism', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241014075442_VerificationCodeUserAdded') THEN
    ALTER TABLE "Users" ADD "IsVerified" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241014075442_VerificationCodeUserAdded') THEN
    ALTER TABLE "Users" ADD "VerificationCode" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241014075442_VerificationCodeUserAdded') THEN
    ALTER TABLE "Users" ADD "VerificationCodeExpiration" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241014075442_VerificationCodeUserAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241014075442_VerificationCodeUserAdded', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    ALTER TABLE "Users" ADD "ResetPasswordAttempts" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE TABLE "Exercises" (
        "Id" uuid NOT NULL,
        "Name" character varying(50) NOT NULL,
        "Description" text NOT NULL,
        "AssignmentId" uuid NOT NULL,
        CONSTRAINT "PK_Exercises" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Exercises_Assignments_AssignmentId" FOREIGN KEY ("AssignmentId") REFERENCES "Assignments" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE TABLE "Classes" (
        "Id" uuid NOT NULL,
        "Name" character varying(40) NOT NULL,
        "Description" text,
        "ExerciseId" uuid NOT NULL,
        "ParentClassId" uuid NOT NULL,
        CONSTRAINT "PK_Classes" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Classes_Classes_ParentClassId" FOREIGN KEY ("ParentClassId") REFERENCES "Classes" ("Id") ON DELETE CASCADE,
        CONSTRAINT "FK_Classes_Exercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES "Exercises" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE TABLE "Functions" (
        "Id" uuid NOT NULL,
        "Name" character varying(40) NOT NULL,
        "Parameters" integer NOT NULL,
        "Type" text NOT NULL,
        "Description" text,
        "ClassId" uuid NOT NULL,
        CONSTRAINT "PK_Functions" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Functions_Classes_ClassId" FOREIGN KEY ("ClassId") REFERENCES "Classes" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE UNIQUE INDEX "IX_Classes_ExerciseId_Name" ON "Classes" ("ExerciseId", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE INDEX "IX_Classes_ParentClassId" ON "Classes" ("ParentClassId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE UNIQUE INDEX "IX_Exercises_AssignmentId_Name" ON "Exercises" ("AssignmentId", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    CREATE UNIQUE INDEX "IX_Functions_ClassId_Name_Parameters_Type" ON "Functions" ("ClassId", "Name", "Parameters", "Type");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241024113958_AssigmentCodeEstructureAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241024113958_AssigmentCodeEstructureAdded', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028010654_ExerciseUpdated') THEN
    ALTER TABLE "Users" ALTER COLUMN "LastName" TYPE character varying(50);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028010654_ExerciseUpdated') THEN
    ALTER TABLE "Users" ALTER COLUMN "FirstName" TYPE character varying(50);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028010654_ExerciseUpdated') THEN
    ALTER TABLE "Users" ALTER COLUMN "Email" TYPE character varying(50);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028010654_ExerciseUpdated') THEN
    ALTER TABLE "Exercises" ADD "HaveBody" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028010654_ExerciseUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241028010654_ExerciseUpdated', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Users" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Users" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Users" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Submissions" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Submissions" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Submissions" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Plagiarisms" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Plagiarisms" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Plagiarisms" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Functions" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Functions" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Functions" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Exercises" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Exercises" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Exercises" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Enrollments" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Enrollments" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Enrollments" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Courses" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Courses" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Courses" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Codes" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Codes" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Codes" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Classes" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Classes" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Classes" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Assignments" ADD "CreatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Assignments" ADD "IsEnabled" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    ALTER TABLE "Assignments" ADD "UpdatedAt" timestamp with time zone NOT NULL DEFAULT TIMESTAMPTZ '-infinity';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241028114151_BaseEntityAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241028114151_BaseEntityAdded', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030172445_ParameterAdded') THEN
    DROP INDEX "IX_Functions_ClassId_Name_Parameters_Type";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030172445_ParameterAdded') THEN
    CREATE TABLE "Parameter" (
        "Id" uuid NOT NULL,
        "Name" character varying(40) NOT NULL,
        "Type" text NOT NULL,
        "Description" text,
        "FunctionId" uuid NOT NULL,
        CONSTRAINT "PK_Parameter" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Parameter_Functions_FunctionId" FOREIGN KEY ("FunctionId") REFERENCES "Functions" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030172445_ParameterAdded') THEN
    CREATE UNIQUE INDEX "IX_Functions_ClassId_Name_Type_Parameters" ON "Functions" ("ClassId", "Name", "Type", "Parameters");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030172445_ParameterAdded') THEN
    CREATE UNIQUE INDEX "IX_Parameter_FunctionId_Name_Type" ON "Parameter" ("FunctionId", "Name", "Type");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030172445_ParameterAdded') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241030172445_ParameterAdded', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030174125_FunctionUpdated') THEN
    DROP INDEX "IX_Functions_ClassId_Name_Type_Parameters";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030174125_FunctionUpdated') THEN
    ALTER TABLE "Functions" DROP COLUMN "Parameters";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030174125_FunctionUpdated') THEN
    ALTER TABLE "Functions" ADD "ParameterTypes" text NOT NULL DEFAULT '';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030174125_FunctionUpdated') THEN
    CREATE UNIQUE INDEX "IX_Functions_ClassId_Name_Type_ParameterTypes" ON "Functions" ("ClassId", "Name", "Type", "ParameterTypes");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241030174125_FunctionUpdated') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241030174125_FunctionUpdated', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241106031133_IsArchivedAddedInCourse') THEN
    ALTER TABLE "Courses" ADD "IsArchived" boolean NOT NULL DEFAULT FALSE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241106031133_IsArchivedAddedInCourse') THEN
    CREATE UNIQUE INDEX "IX_Courses_Name" ON "Courses" ("Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241106031133_IsArchivedAddedInCourse') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241106031133_IsArchivedAddedInCourse', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    ALTER TABLE "Parameter" DROP CONSTRAINT "FK_Parameter_Functions_FunctionId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    DROP TABLE "Functions";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    DROP INDEX "IX_Parameter_FunctionId_Name_Type";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    ALTER TABLE "Parameter" RENAME COLUMN "FunctionId" TO "MethodId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    CREATE TABLE "Methods" (
        "Id" uuid NOT NULL,
        "Name" character varying(40) NOT NULL,
        "Type" text NOT NULL,
        "ParameterTypes" text NOT NULL,
        "Description" text,
        "ClassId" uuid NOT NULL,
        "IsEnabled" boolean NOT NULL,
        "CreatedAt" timestamp with time zone NOT NULL,
        "UpdatedAt" timestamp with time zone NOT NULL,
        CONSTRAINT "PK_Methods" PRIMARY KEY ("Id"),
        CONSTRAINT "FK_Methods_Classes_ClassId" FOREIGN KEY ("ClassId") REFERENCES "Classes" ("Id") ON DELETE CASCADE
    );
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    CREATE UNIQUE INDEX "IX_Parameter_MethodId_Type_Name" ON "Parameter" ("MethodId", "Type", "Name");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    CREATE UNIQUE INDEX "IX_Methods_ClassId_Type_Name_ParameterTypes" ON "Methods" ("ClassId", "Type", "Name", "ParameterTypes");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    ALTER TABLE "Parameter" ADD CONSTRAINT "FK_Parameter_Methods_MethodId" FOREIGN KEY ("MethodId") REFERENCES "Methods" ("Id") ON DELETE CASCADE;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241113111027_ChangeNameFunctionToMethod') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241113111027_ChangeNameFunctionToMethod', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117095603_UrlStateAddedToSubmission') THEN
    ALTER TABLE "Submissions" ALTER COLUMN "Url" TYPE character varying(60);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117095603_UrlStateAddedToSubmission') THEN
    ALTER TABLE "Submissions" ADD "UrlState" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117095603_UrlStateAddedToSubmission') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117095603_UrlStateAddedToSubmission', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117115420_AddInvitatiovIdToCourse') THEN
    ALTER TABLE "Courses" ADD "InvitationId" uuid DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117115420_AddInvitatiovIdToCourse') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117115420_AddInvitatiovIdToCourse', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117115641_AddInvitatiovIdToCourse2') THEN
    ALTER TABLE "Courses" ALTER COLUMN "InvitationId" SET DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117115641_AddInvitatiovIdToCourse2') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117115641_AddInvitatiovIdToCourse2', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120015_RemoveInvitatiovIdToCourse') THEN
    ALTER TABLE "Courses" DROP COLUMN "InvitationId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120015_RemoveInvitatiovIdToCourse') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117120015_RemoveInvitatiovIdToCourse', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120112_AddInvitatiovIdToCourse3') THEN
    ALTER TABLE "Courses" ADD "InvitationId" uuid NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120112_AddInvitatiovIdToCourse3') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117120112_AddInvitatiovIdToCourse3', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120226_AddInvitatiovIdToCourse4') THEN
    ALTER TABLE "Courses" ALTER COLUMN "InvitationId" TYPE text;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120226_AddInvitatiovIdToCourse4') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117120226_AddInvitatiovIdToCourse4', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120456_AddInvitatiovIdToCourse5') THEN
    ALTER TABLE "Courses" DROP COLUMN "InvitationId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120456_AddInvitatiovIdToCourse5') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117120456_AddInvitatiovIdToCourse5', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120619_AddInvitatiovIdToCourse6') THEN
    ALTER TABLE "Courses" ADD "InvitationId" uuid DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117120619_AddInvitatiovIdToCourse6') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117120619_AddInvitatiovIdToCourse6', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117121942_AddInvitatiovIdToCourse7') THEN
    UPDATE "Courses" SET "InvitationId" = '00000000-0000-0000-0000-000000000000' WHERE "InvitationId" IS NULL;
    ALTER TABLE "Courses" ALTER COLUMN "InvitationId" SET NOT NULL;
    ALTER TABLE "Courses" ALTER COLUMN "InvitationId" SET DEFAULT '00000000-0000-0000-0000-000000000000';
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117121942_AddInvitatiovIdToCourse7') THEN
    CREATE UNIQUE INDEX "IX_Courses_InvitationId" ON "Courses" ("InvitationId");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117121942_AddInvitatiovIdToCourse7') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117121942_AddInvitatiovIdToCourse7', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117182955_AddUrlCompilerTypeToSubmission') THEN
    DROP INDEX "IX_Submissions_StudentId_AssignmentId";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117182955_AddUrlCompilerTypeToSubmission') THEN
    DROP INDEX "IX_Submissions_Url";
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117182955_AddUrlCompilerTypeToSubmission') THEN
    ALTER TABLE "Submissions" ADD "Compiler" integer NOT NULL DEFAULT 0;
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117182955_AddUrlCompilerTypeToSubmission') THEN
    CREATE UNIQUE INDEX "IX_Submissions_StudentId_AssignmentId_Url" ON "Submissions" ("StudentId", "AssignmentId", "Url");
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241117182955_AddUrlCompilerTypeToSubmission') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241117182955_AddUrlCompilerTypeToSubmission', '8.0.8');
    END IF;
END $EF$;
COMMIT;

START TRANSACTION;


DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241118000907_UpdateAssignmentAndSubmission') THEN
    ALTER TABLE "Assignments" ADD "DolosURLId" character varying(20);
    END IF;
END $EF$;

DO $EF$
BEGIN
    IF NOT EXISTS(SELECT 1 FROM "__EFMigrationsHistory" WHERE "MigrationId" = '20241118000907_UpdateAssignmentAndSubmission') THEN
    INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
    VALUES ('20241118000907_UpdateAssignmentAndSubmission', '8.0.8');
    END IF;
END $EF$;
COMMIT;

