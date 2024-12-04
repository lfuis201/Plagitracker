// Ignore Spelling: Utils

using Antlr4.Runtime;

namespace PlagiTracker.CodeUtils.JavaUtils
{
    public class CustomErrorListener
    {
        public class LexerErrorListener : IAntlrErrorListener<int>
        {
            public List<string> Errors { get; } = new List<string>();

            public void SyntaxError(IRecognizer recognizer, int offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
            {
                Errors.Add($"line {line}:{charPositionInLine} {msg}");
            }
        }

        public class ParserErrorListener : BaseErrorListener
        {
            public List<string> Errors { get; } = [];

            public override void SyntaxError(IRecognizer recognizer, IToken offendingSymbol, int line, int charPositionInLine, string msg, RecognitionException e)
            {
                Errors.Add($"line {line}:{charPositionInLine} {msg}");
            }
        }
    }
}