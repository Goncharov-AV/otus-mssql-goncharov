using System;
using System.Collections.Generic;

namespace AMDB.Entities.Models
{
    public partial class TmpKnownFor
    {
        public int Id { get; set; }
        public string? PersonImdbId { get; set; }
        public string? KnownFor { get; set; }
    }
}
