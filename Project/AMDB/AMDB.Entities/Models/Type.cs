using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Type
    {
        public Type()
        {
            Movies = new HashSet<Movie>();
        }

        public int TypeId { get; set; }
        public string Type1 { get; set; } = null!;

        public virtual ICollection<Movie> Movies { get; set; }
    }
}
