using Microsoft.EntityFrameworkCore;

public class MyDbContext : DbContext
{
    public MyDbContext(DbContextOptions<MyDbContext> options)
        : base(options)
    {
    }


    public DbSet<user> user { get; set; }
    public DbSet<tasks> tasks { get; set; }

protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<user>().HasIndex(x => x.username).IsUnique();
        modelBuilder.Entity<tasks>();
            // .HasOne(t => t.user)
            // .WithMany(u => u.tasks)
            // .HasForeignKey(t => t.userId)
            // .OnDelete(DeleteBehavior.Cascade);
    }
    

    
}
