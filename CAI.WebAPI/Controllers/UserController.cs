using CAI.Business.Contracts;
using CAI.Entities;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using WebApi.Models;

namespace CAI.WebAPI.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        IUserManager _userManager;

        public UserController(IUserManager userManager)
        {
            _userManager = userManager;
        }

        [AllowAnonymous]
        [HttpPost("authenticate")]
        public IActionResult Authenticate([FromBody]AuthenticateModel model)
        {
            var user = _userManager.AuthenticateUser(model.Username, model.Password);

            if (user == null)
                return BadRequest(new { message = "Username or password is incorrect" });
            else if (!user.IsEmailVerified)
                return BadRequest(new { message = "Please verify email" });

            return Ok(user);
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
        [AllowAnonymous]
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
        [AllowAnonymous]
        [HttpPost("confirmemail")]
        public bool Post([FromBody]EmailEntity emailModel)
        {
            return _userManager.ConfirmEmail(emailModel);
        }
        [HttpPost("confirmphoneno")]
        public bool Post([FromBody]PhoneNoEntity phoneNoEntity)
        {
            return _userManager.ConfirmPhoneNo(phoneNoEntity);
        }
        [HttpPost("generateotp")]
        public bool Get([FromBody]PhoneNoEntity phoneNoEntity)
        {
            return _userManager.GenerateOtp(phoneNoEntity.UserId,phoneNoEntity.PhoneNo);
        }
        [HttpPost("validateotp")]
        public bool ValidateOtp([FromBody]PhoneNoEntity phoneNoEntity)
        {
            return _userManager.ValidateOtp(phoneNoEntity);
        }
        [HttpPost("updatepan")]
        public bool Post([FromBody]PanNoEntity panNoEntity)
        {
            return _userManager.UpdatePanNo(panNoEntity);
        }
    }
}