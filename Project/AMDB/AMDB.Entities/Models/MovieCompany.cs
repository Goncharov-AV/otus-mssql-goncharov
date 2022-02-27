using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class MovieCompany
    {
        public int MovieCompanyId { get; set; }
        public int MovieId { get; set; }
        public int CompanyId { get; set; }

        public virtual Company Company { get; set; } = null!;
        public virtual Movie Movie { get; set; } = null!;
    }
}
