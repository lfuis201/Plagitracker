// Ignore Spelling: Jaccard Usuario Similitud Nombre Levenshtein Semantica

namespace PlagiTracker.Analyzer.PlagiDetector
{
    public class PlagiResult
    {
        public int Coincidencias { get; set; }
        public int Coincidences { get => Coincidencias; }

        public string Nombre1 { get; set; }
        public string FileName1 { get => Nombre1; }

        public string Nombre2 { get; set; }
        public string FileName2 { get => Nombre2; }

        public string Usuario_Id1 { get; set; }
        public string UserId1 { get => Usuario_Id1; }

        public string Usuario_Id2 { get; set; }
        public string UserId2 { get => Usuario_Id2; }

        public double Similitud_Jaccard { get; set; }
        public double JaccardSimilitude { get =>  Math.Round(Similitud_Jaccard * 100, 2); }

        public double Similitud_Levenshtein { get; set; }
        public double LevenshteinSimilitude { get => Math.Round(Similitud_Levenshtein, 2); }

        public double Similitud_Semantica { get; set; }
        public double SemanticSimilitude { get => Math.Round(Similitud_Semantica * 100, 2); }
    }

    public class PlagiResultGrouper
    {
        public static Dictionary<string, Dictionary<string, PlagiResult>> GroupByUserId1(List<PlagiResult> plagiResults)
        {
            int groupsNumber = plagiResults.GroupBy(pR => pR.UserId1).Count();

            plagiResults.OrderBy(pR => pR.UserId1);

            string userId = plagiResults[0].UserId1;

            // usuarioid1 -> usuarioid2 -> PlagiResult
            Dictionary<string, Dictionary<string, PlagiResult>> groupedResults = new();

            for(int i = 0; i < plagiResults.Count; i++)
            {
                if (!groupedResults.ContainsKey(plagiResults[i].UserId1))
                {
                    groupedResults.TryAdd(plagiResults[i].UserId1, new());
                }

                string key = $"{plagiResults[i].Usuario_Id2}_{plagiResults[i].FileName1}_{plagiResults[i].FileName2}";
                groupedResults[plagiResults[i].UserId1].TryAdd(key, plagiResults[i]);
            }

            return groupedResults;
        }
    }
}