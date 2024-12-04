using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddInvitatiovIdToCourse4 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "InvitationId",
                table: "Courses",
                type: "text",
                nullable: false,
                oldClrType: typeof(Guid),
                oldType: "uuid");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<Guid>(
                name: "InvitationId",
                table: "Courses",
                type: "uuid",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "text");
        }
    }
}
