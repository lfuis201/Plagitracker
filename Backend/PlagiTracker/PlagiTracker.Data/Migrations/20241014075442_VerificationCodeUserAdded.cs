using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class VerificationCodeUserAdded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<bool>(
                name: "IsVerified",
                table: "Users",
                type: "boolean",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<int>(
                name: "VerificationCode",
                table: "Users",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<DateTime>(
                name: "VerificationCodeExpiration",
                table: "Users",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "IsVerified",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "VerificationCode",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "VerificationCodeExpiration",
                table: "Users");
        }
    }
}
