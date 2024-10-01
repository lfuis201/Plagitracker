using System;

namespace PlagiTracker.Analyzer.PlaginDetector
{
    public class Detector
    {
        public JaccardDetector Jaccard { get; set; }
        public LevenshteinDetector Levenshtein { get; set; }
        public SemanticDetector Semantica { get; set; }

        public Detector(double similitudJaccard, double similitudLevenshtein, double similitudSemantica)
        {
            Jaccard = new JaccardDetector(similitudJaccard);
            Levenshtein = new LevenshteinDetector(similitudLevenshtein);
            Semantica = new SemanticDetector(similitudSemantica);
        }
    }

    public class JaccardDetector
    {
        public double SimilitudJaccard { get; private set; }
        public double Jaccard => Math.Round(SimilitudJaccard * 100, 3);

        public JaccardDetector(double similitudJaccard)
        {
            SimilitudJaccard = similitudJaccard;
        }
    }

    public class LevenshteinDetector
    {
        public double SimilitudLevenshtein { get; private set; }
        public double Levenshtein => Math.Round(SimilitudLevenshtein, 3);

        public LevenshteinDetector(double similitudLevenshtein)
        {
            SimilitudLevenshtein = similitudLevenshtein;
        }
    }

    public class SemanticDetector
    {
        public double SimilitudSemantica { get; private set; }
        public double Semantica => Math.Round(SimilitudSemantica * 100, 3);

        public SemanticDetector(double similitudSemantica)
        {
            SimilitudSemantica = similitudSemantica;
        }
    }
}