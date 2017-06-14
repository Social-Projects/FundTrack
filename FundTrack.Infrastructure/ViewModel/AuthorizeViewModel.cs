﻿
using System.ComponentModel.DataAnnotations;

namespace FundTrack.Infrastructure.ViewModel
{
    /// <summary>
    /// model for registration user on site
    /// </summary>
    public class AuthorizeViewModel
    {
        /// <summary>
        /// login user
        /// </summary>
        [Required]
        [Display(Name = "Login")]
        public string Login { get; set; }
        /// <summary>
        /// password user
        /// </summary>
        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }
    }
}
