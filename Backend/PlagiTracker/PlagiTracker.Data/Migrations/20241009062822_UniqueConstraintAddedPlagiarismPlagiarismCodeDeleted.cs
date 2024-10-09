using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class UniqueConstraintAddedPlagiarismPlagiarismCodeDeleted : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "PlagiarismCodes");

            migrationBuilder.DropUniqueConstraint(
                name: "AK_Submissions_StudentId_AssignmentId",
                table: "Submissions");

            migrationBuilder.DropIndex(
                name: "IX_Codes_SubmissionId",
                table: "Codes");

            migrationBuilder.DropColumn(
                name: "Url",
                table: "Codes");

            migrationBuilder.RenameColumn(
                name: "Detector",
                table: "Plagiarisms",
                newName: "Algorithm");

            migrationBuilder.AddColumn<Guid>(
                name: "CodeId",
                table: "Plagiarisms",
                type: "uuid",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.AddColumn<string>(
                name: "CodeSnippet",
                table: "Plagiarisms",
                type: "text",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_StudentId_AssignmentId",
                table: "Submissions",
                columns: new[] { "StudentId", "AssignmentId" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_CodeId_Algorithm",
                table: "Plagiarisms",
                columns: new[] { "CodeId", "Algorithm" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Codes_SubmissionId_FileName",
                table: "Codes",
                columns: new[] { "SubmissionId", "FileName" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Plagiarisms_Codes_CodeId",
                table: "Plagiarisms",
                column: "CodeId",
                principalTable: "Codes",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Plagiarisms_Codes_CodeId",
                table: "Plagiarisms");

            migrationBuilder.DropIndex(
                name: "IX_Submissions_StudentId_AssignmentId",
                table: "Submissions");

            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_CodeId_Algorithm",
                table: "Plagiarisms");

            migrationBuilder.DropIndex(
                name: "IX_Codes_SubmissionId_FileName",
                table: "Codes");

            migrationBuilder.DropColumn(
                name: "CodeId",
                table: "Plagiarisms");

            migrationBuilder.DropColumn(
                name: "CodeSnippet",
                table: "Plagiarisms");

            migrationBuilder.RenameColumn(
                name: "Algorithm",
                table: "Plagiarisms",
                newName: "Detector");

            migrationBuilder.AddColumn<string>(
                name: "Url",
                table: "Codes",
                type: "text",
                nullable: true);

            migrationBuilder.AddUniqueConstraint(
                name: "AK_Submissions_StudentId_AssignmentId",
                table: "Submissions",
                columns: new[] { "StudentId", "AssignmentId" });

            migrationBuilder.CreateTable(
                name: "PlagiarismCodes",
                columns: table => new
                {
                    PlagiarismId = table.Column<Guid>(type: "uuid", nullable: false),
                    CodeId = table.Column<Guid>(type: "uuid", nullable: false),
                    CodeSnippet = table.Column<string>(type: "text", nullable: true)
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
                name: "IX_Codes_SubmissionId",
                table: "Codes",
                column: "SubmissionId");

            migrationBuilder.CreateIndex(
                name: "IX_PlagiarismCodes_CodeId",
                table: "PlagiarismCodes",
                column: "CodeId");
        }
    }
}
