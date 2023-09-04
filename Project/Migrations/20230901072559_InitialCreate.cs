using System;
using Microsoft.EntityFrameworkCore.Migrations;
using MySql.EntityFrameworkCore.Metadata;

#nullable disable

namespace Project.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterDatabase()
                .Annotation("MySQL:Charset", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "user",
                columns: table => new
                {
                    userId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    username = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: false),
                    password = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: false),
                    firstname = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_user", x => x.userId);
                })
                .Annotation("MySQL:Charset", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "tasks",
                columns: table => new
                {
                    taskId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySQL:ValueGenerationStrategy", MySQLValueGenerationStrategy.IdentityColumn),
                    title = table.Column<string>(type: "varchar(255)", maxLength: 255, nullable: false),
                    description = table.Column<string>(type: "longtext", nullable: false),
                    dueDate = table.Column<DateTime>(type: "datetime(6)", nullable: true),
                    iscompleted = table.Column<bool>(type: "tinyint(1)", nullable: false),
                    createDate = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    modifyDate = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    userId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_tasks", x => x.taskId);
                    table.ForeignKey(
                        name: "FK_tasks_user_userId",
                        column: x => x.userId,
                        principalTable: "user",
                        principalColumn: "userId",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySQL:Charset", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_tasks_userId",
                table: "tasks",
                column: "userId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "tasks");

            migrationBuilder.DropTable(
                name: "user");
        }
    }
}
