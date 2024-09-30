namespace PlagiTracker.Data.Entities
{
    public class Teacher : User
    {
        public virtual ICollection<Course> Courses { get; set; } = new List<Course>();
    }
}