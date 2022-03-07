using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class MovieLanguage
    {
        public int MovieLanguageId { get; set; }
        public int MovieId { get; set; }
        public int LanguageId { get; set; }

        public virtual Language Language { get; set; } = null!;
        public virtual Movie Movie { get; set; } = null!;
    }
}
