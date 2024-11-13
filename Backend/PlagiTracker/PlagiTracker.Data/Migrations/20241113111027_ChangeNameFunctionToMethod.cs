using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class ChangeNameFunctionToMethod : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Parameter_Functions_FunctionId",
                table: "Parameter");

            migrationBuilder.DropTable(
                name: "Functions");

            migrationBuilder.DropIndex(
                name: "IX_Parameter_FunctionId_Name_Type",
                table: "Parameter");

            migrationBuilder.RenameColumn(
                name: "FunctionId",
                table: "Parameter",
                newName: "MethodId");

            migrationBuilder.CreateTable(
                name: "Methods",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    Name = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: false),
                    Type = table.Column<string>(type: "text", nullable: false),
                    ParameterTypes = table.Column<string>(type: "text", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    ClassId = table.Column<Guid>(type: "uuid", nullable: false),
                    IsEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Methods", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Methods_Classes_ClassId",
                        column: x => x.ClassId,
                        principalTable: "Classes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Parameter_MethodId_Type_Name",
                table: "Parameter",
                columns: new[] { "MethodId", "Type", "Name" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Methods_ClassId_Type_Name_ParameterTypes",
                table: "Methods",
                columns: new[] { "ClassId", "Type", "Name", "ParameterTypes" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Parameter_Methods_MethodId",
                table: "Parameter",
                column: "MethodId",
                principalTable: "Methods",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Parameter_Methods_MethodId",
                table: "Parameter");

            migrationBuilder.DropTable(
                name: "Methods");

            migrationBuilder.DropIndex(
                name: "IX_Parameter_MethodId_Type_Name",
                table: "Parameter");

            migrationBuilder.RenameColumn(
                name: "MethodId",
                table: "Parameter",
                newName: "FunctionId");

            migrationBuilder.CreateTable(
                name: "Functions",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    ClassId = table.Column<Guid>(type: "uuid", nullable: false),
                    CreatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false),
                    Description = table.Column<string>(type: "text", nullable: true),
                    IsEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    Name = table.Column<string>(type: "character varying(40)", maxLength: 40, nullable: false),
                    ParameterTypes = table.Column<string>(type: "text", nullable: false),
                    Type = table.Column<string>(type: "text", nullable: false),
                    UpdatedAt = table.Column<DateTime>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Functions", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Functions_Classes_ClassId",
                        column: x => x.ClassId,
                        principalTable: "Classes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Parameter_FunctionId_Name_Type",
                table: "Parameter",
                columns: new[] { "FunctionId", "Name", "Type" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_Functions_ClassId_Name_Type_ParameterTypes",
                table: "Functions",
                columns: new[] { "ClassId", "Name", "Type", "ParameterTypes" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Parameter_Functions_FunctionId",
                table: "Parameter",
                column: "FunctionId",
                principalTable: "Functions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
