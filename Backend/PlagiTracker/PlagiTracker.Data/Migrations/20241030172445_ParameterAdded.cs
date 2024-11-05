using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class ParameterAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Functions_ClassId_Name_Parameters_Type",
                table: "Functions");

            migrationBuilder.CreateTable(
                name: "Parameter",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: false),
                    Type = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    FunctionId = table.Column<Guid>(type: "uuid", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Parameter", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Parameter_Functions_FunctionId",
                        column: x => x.FunctionId,
                        principalTable: "Functions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Functions_ClassId_Name_Type_Parameters",
                table: "Functions",
                columns: new[] { "ClassId", "Name", "Type", "Parameters" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Parameter_FunctionId_Name_Type",
                table: "Parameter",
                columns: new[] { "FunctionId", "Name", "Type" },
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Parameter");

            migrationBuilder.DropIndex(
                name: "IX_Functions_ClassId_Name_Type_Parameters",
                table: "Functions");

            migrationBuilder.CreateIndex(
                name: "IX_Functions_ClassId_Name_Parameters_Type",
                table: "Functions",
                columns: new[] { "ClassId", "Name", "Parameters", "Type" },
                unique: true);
        }
    }
}
