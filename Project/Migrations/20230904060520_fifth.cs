using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Project.Migrations
{
    /// <inheritdoc />
    public partial class fifth : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_tasks_user_userId",
                table: "tasks");

            migrationBuilder.DropIndex(
                name: "IX_tasks_userId",
                table: "tasks");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_tasks_userId",
                table: "tasks",
                column: "userId");

            migrationBuilder.AddForeignKey(
                name: "FK_tasks_user_userId",
                table: "tasks",
                column: "userId",
                principalTable: "user",
                principalColumn: "userId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
