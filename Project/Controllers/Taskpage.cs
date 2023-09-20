using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.IdentityModel.Tokens.Jwt;

namespace Project.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class Taskcontroller : ControllerBase
    {
        public MyDbContext _context;
        public IHttpContextAccessor _http;
        public string tokenuserId;
        private string username;
        public Taskcontroller(MyDbContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _http = httpContextAccessor;

            var token = _http.HttpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");
            var tokenHandler = new JwtSecurityTokenHandler();
            var jwtToken = tokenHandler.ReadJwtToken(token);

            // Accessing claims
            var usernameClaim = jwtToken.Claims.FirstOrDefault(c => c.Type == "unique_name"); // jwtToken.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Name);
            var userIdClaim = jwtToken.Claims.FirstOrDefault(c => c.Type == "email"); // jwtToken.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Email);

            // Access the values from the claims
            username = usernameClaim?.Value;
            if (userIdClaim == null){
                throw new Exception("Null");
            }
            tokenuserId = userIdClaim.Value;
        }

        [HttpGet("getTasks")]
        public IActionResult GetTasks()
        {
            var tasklist = _context.tasks.ToList();
            return Ok(tasklist);
        }

        [HttpGet("getUserTask")]
        [Authorize]


        public IActionResult GetUserTask()
        {
            
            var userTasks = _context.tasks.Where(task => task.userId.ToString() == tokenuserId).ToList();
            if (userTasks != null)
            {
                return Ok(userTasks);
            }
           
            else
            {
                return BadRequest("no records");
            }
            


        }

        [HttpPost("insertUserTask")]
        [Authorize]
        public IActionResult Post([FromBody] tasks obj){
            if (obj == null)
                throw new ArgumentNullException("Null Exception");
            if (tokenuserId == null)
                throw new ArgumentException("Invalid tokenuser Id");
            obj.userId = int.Parse(tokenuserId);
            obj.createDate=DateTime.Now;
            _context.tasks.Add(obj);
            _context.SaveChanges();
            return Ok(obj);
        }

        [HttpDelete("deleteUserTask")]
        [Authorize]
        public IActionResult Delete(int id){
            var delete=_context.tasks.Find(id);

            _context.tasks.Remove(delete);
            _context.SaveChanges();
            return Ok(delete);
        }

        [HttpPut("updateTask")]
        [Authorize]
        public IActionResult update(int id, [FromBody] updateTask updateTaskobj){
            var record=_context.tasks.Find(id);
            record.title=updateTaskobj.title;
            record.description=updateTaskobj.description;
            record.dueDate=updateTaskobj.dueDate;
            _context.SaveChanges();
            return Ok(record);
        }

        [HttpPut("completeUserTask")]
        [Authorize]
        public IActionResult complete(int id){
            var record=_context.tasks.Find(id);
            record.iscompleted=true;
            _context.SaveChanges();
            return Ok(record.iscompleted);
        }
        
    }
}
