using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class PlagiarismAndCodeAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                    Detector = table.Column<int>(type: "integer", nullable: false),
                    SubmissionId1 = table.Column<Guid>(type: "uuid", nullable: false),
                    SubmissionId2 = table.Column<Guid>(type: "uuid", nullable: false),
                    Similarity = table.Column<double>(type: "double precision", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Plagiarisms", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Plagiarisms_Submissions_SubmissionId1",
                        column: x => x.SubmissionId1,
                        principalTable: "Submissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_Plagiarisms_Submissions_SubmissionId2",
                        column: x => x.SubmissionId2,
                        principalTable: "Submissions",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Codes_SubmissionId",
                table: "Codes",
                column: "SubmissionId");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_SubmissionId1",
                table: "Plagiarisms",
                column: "SubmissionId1");

            migrationBuilder.CreateIndex(
                name: "IX_Plagiarisms_SubmissionId2",
                table: "Plagiarisms",
                column: "SubmissionId2");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Codes");

            migrationBuilder.DropTable(
                name: "Plagiarisms");
        }
    }
}
