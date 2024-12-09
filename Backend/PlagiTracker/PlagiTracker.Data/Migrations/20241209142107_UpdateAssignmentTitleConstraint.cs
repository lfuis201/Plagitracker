using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class UpdateAssignmentTitleConstraint : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Assignments_CourseId",
                table: "Assignments");

            migrationBuilder.DropIndex(
                name: "IX_Assignments_Title",
                table: "Assignments");

            migrationBuilder.CreateIndex(
                name: "IX_Assignments_CourseId_Title",
                table: "Assignments",
                columns: new[] { "CourseId", "Title" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Assignments_CourseId_Title",
                table: "Assignments");

            migrationBuilder.CreateIndex(
                name: "IX_Assignments_CourseId",
                table: "Assignments",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Assignments_Title",
                table: "Assignments",
                column: "Title",
                unique: true);
        }
    }
}
