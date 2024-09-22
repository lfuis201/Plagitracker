using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class PlagiarismCodeAddedPlagiarismUpdated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Plagiarisms_Submissions_SubmissionId1",
                table: "Plagiarisms");

            migrationBuilder.DropForeignKey(
                name: "FK_Plagiarisms_Submissions_SubmissionId2",
                table: "Plagiarisms");

            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_SubmissionId1",
                table: "Plagiarisms");

            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_SubmissionId2",
                table: "Plagiarisms");

            migrationBuilder.DropColumn(
                name: "SubmissionId1",
                table: "Plagiarisms");

            migrationBuilder.DropColumn(
                name: "SubmissionId2",
                table: "Plagiarisms");

            migrationBuilder.AddColumn<Guid>(
                name: "TeacherId1",
                table: "Courses",
                type: "uuid",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "TeacherId2",
                table: "Courses",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "PlagiarismCodes",
                columns: table => new
                {
                    PlagiarismId = table.Column<Guid>(type: "uuid", nullable: false),
                    CodeId = table.Column<Guid>(type: "uuid", nullable: false),
                    CodeSnippet = table.Column<string>(type: "text", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PlagiarismCodes", x => new { x.PlagiarismId, x.CodeId });
                    table.ForeignKey(
                        name: "FK_PlagiarismCodes_Codes_CodeId",
                        column: x => x.CodeId,
                        principalTable: "Codes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_PlagiarismCodes_Plagiarisms_PlagiarismId",
                        column: x => x.PlagiarismId,
                        principalTable: "Plagiarisms",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_AssignmentId",
                table: "Submissions",
                column: "AssignmentId");

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_StudentId",
                table: "Submissions",
                column: "StudentId");

            migrationBuilder.CreateIndex(
                name: "IX_Courses_TeacherId1",
                table: "Courses",
                column: "TeacherId1");

            migrationBuilder.CreateIndex(
                name: "IX_PlagiarismCodes_CodeId",
                table: "PlagiarismCodes",
                column: "CodeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Courses_Teachers_TeacherId1",
                table: "Courses",
                column: "TeacherId1",
                principalTable: "Teachers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Submissions_Assignments_AssignmentId",
                table: "Submissions",
                column: "AssignmentId",
                principalTable: "Assignments",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Submissions_Students_StudentId",
                table: "Submissions",
                column: "StudentId",
                principalTable: "Students",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Courses_Teachers_TeacherId1",
                table: "Courses");

            migrationBuilder.DropForeignKey(
                name: "FK_Submissions_Assignments_AssignmentId",
                table: "Submissions");

            migrationBuilder.DropForeignKey(
                name: "FK_Submissions_Students_StudentId",
                table: "Submissions");

            migrationBuilder.DropTable(
                name: "PlagiarismCodes");

            migrationBuilder.DropIndex(
                name: "IX_Submissions_AssignmentId",
                table: "Submissions");

            migrationBuilder.DropIndex(
                name: "IX_Submissions_StudentId",
                table: "Submissions");

            migrationBuilder.DropIndex(
                name: "IX_Courses_TeacherId1",
                table: "Courses");

            migrationBuilder.DropColumn(
                name: "TeacherId1",
                table: "Courses");

            migrationBuilder.DropColumn(
                name: "TeacherId2",
                table: "Courses");

            migrationBuilder.AddColumn<Guid>(
                name: "SubmissionId1",
                table: "Plagiarisms",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<Guid>(
                name: "SubmissionId2",
                table: "Plagiarisms",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_SubmissionId1",
                table: "Plagiarisms",
                column: "SubmissionId1");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_SubmissionId2",
                table: "Plagiarisms",
                column: "SubmissionId2");

            migrationBuilder.AddForeignKey(
                name: "FK_Plagiarisms_Submissions_SubmissionId1",
                table: "Plagiarisms",
                column: "SubmissionId1",
                principalTable: "Submissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Plagiarisms_Submissions_SubmissionId2",
                table: "Plagiarisms",
                column: "SubmissionId2",
                principalTable: "Submissions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
