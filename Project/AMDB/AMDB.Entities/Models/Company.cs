using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Company
    {
        public Company()
        {
            MovieCompanies = new HashSet<MovieCompany>();
        }

        public int CompanyId { get; set; }
        public string? CompanyName { get; set; }

        public virtual ICollection<MovieCompany> MovieCompanies { get; set; }
    }
}
