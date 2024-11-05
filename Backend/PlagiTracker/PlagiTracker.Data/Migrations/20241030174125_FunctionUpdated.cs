using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class FunctionUpdated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Functions_ClassId_Name_Type_Parameters",
                table: "Functions");

            migrationBuilder.DropColumn(
                name: "Parameters",
                table: "Functions");

            migrationBuilder.AddColumn<string>(
                name: "ParameterTypes",
                table: "Functions",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateIndex(
                name: "IX_Functions_ClassId_Name_Type_ParameterTypes",
                table: "Functions",
                columns: new[] { "ClassId", "Name", "Type", "ParameterTypes" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Functions_ClassId_Name_Type_ParameterTypes",
                table: "Functions");

            migrationBuilder.DropColumn(
                name: "ParameterTypes",
                table: "Functions");

            migrationBuilder.AddColumn<int>(
                name: "Parameters",
                table: "Functions",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Functions_ClassId_Name_Type_Parameters",
                table: "Functions",
                columns: new[] { "ClassId", "Name", "Type", "Parameters" },
                unique: true);
        }
    }
}
