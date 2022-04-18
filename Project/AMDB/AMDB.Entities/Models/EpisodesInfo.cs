using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class EpisodesInfo
    {
        public int EpisodeInfoId { get; set; }
        public int EpisodeId { get; set; }
        public int SeriesId { get; set; }
        public int SeasonNumber { get; set; }
        public int EpisodeNumber { get; set; }

        public virtual Movie Episode { get; set; } = null!;
        public virtual Movie Series { get; set; } = null!;
    }
}
