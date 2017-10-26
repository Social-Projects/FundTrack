//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FundTrack.PrivatImport
{
    using System;
    using System.Collections.Generic;
    
    public partial class BankAccounts
    {
        public BankAccounts()
        {
            this.OrgAccounts = new HashSet<OrgAccounts>();
        }
    
        public int Id { get; set; }
        public string AccNumber { get; set; }
        public string BankName { get; set; }
        public string CardNumber { get; set; }
        public string EDRPOU { get; set; }
        public string MFO { get; set; }
        public Nullable<int> MerchantId { get; set; }
        public string MerchantPassword { get; set; }
        public int OrgId { get; set; }
        public Nullable<bool> IsDonationEnabled { get; set; }
        public Nullable<int> ExtractMerchantId { get; set; }
        public string ExtractMerchantPassword { get; set; }
        public Nullable<bool> IsExtractEnabled { get; set; }
        public int BankId { get; set; }
    
        public virtual ICollection<OrgAccounts> OrgAccounts { get; set; }
    }
}
