using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CAI.Business.Interfaces;
using CAI.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CAI.WebAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        IUserManager _userManager;
       
        public UserController(IUserManager userManager)
        {
            _userManager = userManager;
        }
        // GET<td style="border<td style="border: 1px dashed #ababab;"> 1px dashed #ababab;"> api/user  
        [HttpGet]
        public IEnumerable<UserEntity> Get()
        {
            return _userManager.GetAllUser();
        }
        // GET api/user/5  
        [HttpGet("{id}")]
        public UserEntity Get(int id)
        {
            return _userManager.GetUserById(id);
        }
        // POST api/user  
        [HttpPost]
        public void Post([FromBody] UserEntity user)
        {
              _userManager.AddUser(user);
        }
        // PUT api/user/5  
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] UserEntity user)
        {
            _userManager.UpdateUser(user);
        }
        // DELETE api/user/5  
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _userManager.DeleteUser(id);
        }
    }
}