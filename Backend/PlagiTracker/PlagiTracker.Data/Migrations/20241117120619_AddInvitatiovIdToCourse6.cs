using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace PlagiTracker.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddInvitatiovIdToCourse6 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "InvitationId",
                table: "Courses",
                type: "uuid",
                nullable: true,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "InvitationId",
                table: "Courses");
        }
    }
}
