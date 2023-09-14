using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

namespace Project.Controllers
{


    [ApiController]
    [Route("[controller]")]
    public class LoginPagecontroller : ControllerBase
    {

        private string GenerateJwtToken(string username, IConfiguration configuration, int id)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(configuration["JwtSettings:SecretKey"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                new Claim(ClaimTypes.Name, username),
                new Claim(ClaimTypes.Email,id.ToString()),
                
                //new Claim(ClaimTypes.Name
                
                // You can add more claims here if needed
                }),
                Audience = configuration["JwtSettings:Audience"],
                Issuer = configuration["JwtSettings:Issuer"],
                Expires = DateTime.UtcNow.AddHours(10), // Set token expiration time
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        MyDbContext _context;
        public LoginPagecontroller(MyDbContext context)
        {
            _context = context;

        }

        [HttpGet("getUsers")]
        public IActionResult get()
        {
            var userlist = _context.user.ToList();
            return Ok(userlist);
        }

        [HttpPost("Signup")]
        public IActionResult post([FromBody] user userObj)
        {
            var existingUser = _context.user.FirstOrDefault(u => u.username == userObj.username);
            if(string.IsNullOrEmpty( userObj.username)  ||string.IsNullOrEmpty( userObj.password)){
                return BadRequest("Username and Password field cannot be empty");
            }

            if (existingUser != null)
            {
                
                return BadRequest("Username is already taken.");
            }
            if(userObj.password.Length<4){
                return BadRequest("Password should be of minimum 4 characters!");
            }
            
            
            _context.user.Add(userObj);
            _context.SaveChanges();
            return Ok("You're all set! Hello "+userObj.username+".");
        }

        [HttpPost("Authentication")]
        public IActionResult auth([FromBody] login loginObj, IConfiguration configuration)
        {

            var userObj = _context.user.FirstOrDefault(p => p.username == loginObj.username);
           // 
            {
                 if(string.IsNullOrEmpty( loginObj.username)  ||string.IsNullOrEmpty( loginObj.password)){
                return BadRequest("Username and Password field cannot be empty");
            }
                if(userObj!=null){

                if (userObj.password == loginObj.password)
                {

                    var token = GenerateJwtToken(loginObj.username, configuration, userObj.userId);
                    return Ok(new { Token = token, Message = "You have logged in successfully! Welcome back "+loginObj.username.ToUpper(),Name=userObj.firstname});
                }
                else
                {
                    return BadRequest("Invalid username/password");
                }
            }
            else
            {
                return BadRequest("Invalid username/password");

            }
        }
    }





}}