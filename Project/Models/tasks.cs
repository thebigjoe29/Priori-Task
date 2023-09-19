using System.ComponentModel.DataAnnotations;

public class tasks
{
    [Key]
    public int taskId { get; set; }

    [Required]
    [StringLength(255)]
    public string title { get; set; }

    public string description { get; set; }

    [DataType(DataType.Date)] 
    public DateTime? dueDate { get; set; }

    public bool iscompleted { get; set; }=false;

    public DateTime createDate { get; set; }=DateTime.Now;

    public DateTime modifyDate { get; set; }

    // Foreign key to link tasks to users
    public int userId { get; set; }
    //public user user { get; set; }
}