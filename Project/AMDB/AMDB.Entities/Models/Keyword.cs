using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Keyword
    {
        public Keyword()
        {
            MovieKeywords = new HashSet<MovieKeyword>();
        }

        public int KeywordId { get; set; }
        public string Keyword1 { get; set; } = null!;

        public virtual ICollection<MovieKeyword> MovieKeywords { get; set; }
    }
}
