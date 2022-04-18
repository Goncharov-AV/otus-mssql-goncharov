using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class TmpEpisode
    {
        public int Id { get; set; }
        public string? Tconst { get; set; }
        public string? ParentTconst { get; set; }
        public int? SeasonNumber { get; set; }
        public int? EpisodeNumber { get; set; }
    }
}
