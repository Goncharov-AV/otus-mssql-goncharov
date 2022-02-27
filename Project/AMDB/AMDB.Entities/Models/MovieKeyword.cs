using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class MovieKeyword
    {
        public int MovieKeywordsId { get; set; }
        public int MovieId { get; set; }
        public int KeywordId { get; set; }

        public virtual Keyword Keyword { get; set; } = null!;
        public virtual Movie Movie { get; set; } = null!;
    }
}
