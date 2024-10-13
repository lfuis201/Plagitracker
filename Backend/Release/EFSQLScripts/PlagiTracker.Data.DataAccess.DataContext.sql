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

