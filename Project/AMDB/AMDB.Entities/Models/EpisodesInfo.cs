using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class EpisodesInfo
    {
        public EpisodesInfo()
        {
            Movies = new HashSet<Movie>();
        }

        public int EpisodeInfoId { get; set; }
        public int SeriesId { get; set; }
        public int SeasonNumber { get; set; }
        public int EpisodeNumber { get; set; }

        public virtual Movie Series { get; set; } = null!;
        public virtual ICollection<Movie> Movies { get; set; }
    }
}
