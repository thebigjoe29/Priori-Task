using System.ComponentModel.DataAnnotations;

public class user
{
    [Key]
    public int userId { get; set; }

   // [Required]
    [StringLength(255)]
    
    public string username { get; set; }

    //[Required]
    [StringLength(255)]
    public string password { get; set; }

    [StringLength(255)]
    public string firstname { get; set; }
    

    // Navigation property to represent the relationship with tasks
    //public ICollection<tasks> tasks { get; set; }
}