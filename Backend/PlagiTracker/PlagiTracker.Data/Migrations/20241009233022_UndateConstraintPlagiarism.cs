using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class UndateConstraintPlagiarism : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_CodeId_Algorithm",
                table: "Plagiarisms");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_CodeId",
                table: "Plagiarisms",
                column: "CodeId");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_Id_CodeId_Algorithm",
                table: "Plagiarisms",
                columns: new[] { "Id", "CodeId", "Algorithm" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_CodeId",
                table: "Plagiarisms");

            migrationBuilder.DropIndex(
                name: "IX_Plagiarisms_Id_CodeId_Algorithm",
                table: "Plagiarisms");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_CodeId_Algorithm",
                table: "Plagiarisms",
                columns: new[] { "CodeId", "Algorithm" },
                unique: true);
        }
    }
}
