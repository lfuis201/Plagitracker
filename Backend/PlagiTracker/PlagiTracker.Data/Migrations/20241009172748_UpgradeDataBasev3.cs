using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class UpgradeDataBasev3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    FirstName = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: false),
                    LastName = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: false),
                    Email = table.Column<string>(type: "character varying(35)", maxLength: 35, nullable: false),
                    PasswordHash = table.Column<byte[]>(type: "bytea", nullable: false),
                    LogInAttempts = table.Column<int>(type: "integer", nullable: false),
                    IsLocked = table.Column<bool>(type: "boolean", nullable: false),
                    UnlockDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Students",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Students", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Students_Users_Id",
                        column: x => x.Id,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Teachers",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Teachers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Teachers_Users_Id",
                        column: x => x.Id,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Courses",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(80)", maxLength: 80, nullable: false),
                    TeacherId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Courses", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Courses_Teachers_TeacherId",
                        column: x => x.TeacherId,
                        principalTable: "Teachers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Assignments",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Description = table.Column<string>(type: "character varying(250)", maxLength: 250, nullable: true),
                    Title = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    SubmissionDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    AnalysisDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    IsAnalyzed = table.Column<bool>(type: "boolean", nullable: false),
                    CourseId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Assignments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Assignments_Courses_CourseId",
                        column: x => x.CourseId,
                        principalTable: "Courses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Enrollments",
                columns: table => new
                {
                    StudentId = table.Column<Guid>(type: "uuid", nullable: false),
                    CourseId = table.Column<Guid>(type: "uuid", nullable: false),
                    Grade = table.Column<double>(type: "numeric(4,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Enrollments", x => new { x.StudentId, x.CourseId });
                    table.ForeignKey(
                        name: "FK_Enrollments_Courses_CourseId",
                        column: x => x.CourseId,
                        principalTable: "Courses",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Enrollments_Students_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Students",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Submissions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Url = table.Column<string>(type: "text", nullable: false),
                    SubmissionDate = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Grade = table.Column<double>(type: "numeric(4,2)", nullable: false),
                    StudentId = table.Column<Guid>(type: "uuid", nullable: false),
                    AssignmentId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Submissions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Submissions_Assignments_AssignmentId",
                        column: x => x.AssignmentId,
                        principalTable: "Assignments",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Submissions_Students_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Students",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Codes",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    SubmissionId = table.Column<Guid>(type: "uuid", nullable: false),
                    FileName = table.Column<string>(type: "character varying(50)", maxLength: 50, nullable: false),
                    Content = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Codes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Codes_Submissions_SubmissionId",
                        column: x => x.SubmissionId,
                        principalTable: "Submissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Plagiarisms",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Similarity = table.Column<double>(type: "numeric(5,2)", nullable: false),
                    Coincidences = table.Column<int>(type: "integer", nullable: false),
                    CodeSnippet = table.Column<string>(type: "text", nullable: true),
                    CodeId = table.Column<Guid>(type: "uuid", nullable: false),
                    Algorithm = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Plagiarisms", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Plagiarisms_Codes_CodeId",
                        column: x => x.CodeId,
                        principalTable: "Codes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Assignments_CourseId",
                table: "Assignments",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Assignments_Title",
                table: "Assignments",
                column: "Title",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Codes_SubmissionId_FileName",
                table: "Codes",
                columns: new[] { "SubmissionId", "FileName" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Courses_TeacherId",
                table: "Courses",
                column: "TeacherId");

            migrationBuilder.CreateIndex(
                name: "IX_Enrollments_CourseId",
                table: "Enrollments",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_CodeId_Algorithm",
                table: "Plagiarisms",
                columns: new[] { "CodeId", "Algorithm" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_AssignmentId",
                table: "Submissions",
                column: "AssignmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_StudentId_AssignmentId",
                table: "Submissions",
                columns: new[] { "StudentId", "AssignmentId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_Url",
                table: "Submissions",
                column: "Url",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Users_Email",
                table: "Users",
                column: "Email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Enrollments");

            migrationBuilder.DropTable(
                name: "Plagiarisms");

            migrationBuilder.DropTable(
                name: "Codes");

            migrationBuilder.DropTable(
                name: "Submissions");

            migrationBuilder.DropTable(
                name: "Assignments");

            migrationBuilder.DropTable(
                name: "Students");

            migrationBuilder.DropTable(
                name: "Courses");

            migrationBuilder.DropTable(
                name: "Teachers");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
