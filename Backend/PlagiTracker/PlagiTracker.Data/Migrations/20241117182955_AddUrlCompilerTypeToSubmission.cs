using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddUrlCompilerTypeToSubmission : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Submissions_StudentId_AssignmentId",
                table: "Submissions");

            migrationBuilder.DropIndex(
                name: "IX_Submissions_Url",
                table: "Submissions");

            migrationBuilder.AddColumn<int>(
                name: "Compiler",
                table: "Submissions",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Submissions_StudentId_AssignmentId_Url",
                table: "Submissions",
                columns: new[] { "StudentId", "AssignmentId", "Url" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Submissions_StudentId_AssignmentId_Url",
                table: "Submissions");

            migrationBuilder.DropColumn(
                name: "Compiler",
                table: "Submissions");

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
        }
    }
}
