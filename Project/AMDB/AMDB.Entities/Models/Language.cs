using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class Language
    {
        public Language()
        {
            MovieLanguages = new HashSet<MovieLanguage>();
        }

        public int LanguageId { get; set; }
        public string Language1 { get; set; } = null!;

        public virtual ICollection<MovieLanguage> MovieLanguages { get; set; }
    }
}
