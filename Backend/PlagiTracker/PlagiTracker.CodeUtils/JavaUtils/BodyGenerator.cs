// Ignore Spelling: Utils

using System;
using System.Text.RegularExpressions;
using System.Text;
using Antlr4.Runtime.Tree;
using PlagiTracker.CodeUtils.GrammarFiles;
using Antlr4.Runtime;
using PlagiTracker.Data.Requests;

namespace PlagiTracker.CodeUtils.JavaUtils
{
    public class BodyGenerator
    {
        private static readonly int[] RuleDeclarationIndexes = {
            JavaParser.RULE_classDeclaration,
            JavaParser.RULE_methodDeclaration,
            JavaParser.RULE_formalParameters,
            JavaParser.RULE_formalParameterList,
            JavaParser.RULE_formalParameter,
        };

        private static readonly int[] RuleIdentifierIndexes = {
            JavaParser.RULE_identifier,
        };

        private static readonly int[] RuleIndexes = {
            JavaParser.RULE_classBody,
            JavaParser.RULE_block,
            JavaParser.RULE_typeIdentifier,
            JavaParser.RULE_typeType,
            JavaParser.RULE_primitiveType,
            JavaParser.RULE_typeTypeOrVoid,
            JavaParser.RULE_formalParameters,
        };

        private static readonly Type[] RuleTypes = {
            typeof(JavaParser.MethodDeclarationContext),
            typeof(JavaParser.MethodBodyContext),
            typeof(JavaParser.FormalParameterContext),
            typeof(JavaParser.FormalParameterListContext),
            typeof(JavaParser.FormalParameterContext),
            typeof(JavaParser.FieldDeclarationContext),
            typeof(JavaParser.TypeTypeContext),
        };

        private const string
            CLASS_DECLARATION = "class",
            COMMA = ",",
            LEFT_KEY = "{",
            RIGHT_KEY = "}",
            LEFT_PARENTHESIS = "(",
            RIGHT_PARENTHESIS = ")",
            LEFT_BRACKET = "[",
            RIGHT_BRACKET = "]"
            ;

        public enum StructureType
        {
            Class,
            Method,
            Parameter,
            None
        }

        private const string 
            classRegex = @"""Name""\s*:\s*""(\w+)""\s*{",
            classNameRegex = @"""Name""\s*:\s*""(\w+)""\s*{"
            ;


        public static List<ClassRequest> ParseClassInput(string inputText)
        {
            List<ClassRequest> classes = [];
            int currentClassLevel = 0;

            int currentClassOpened = 0;
            int currentClassClosed = 0;
            ClassRequest? currentClass = null;
            string currentTest = string.Empty;

            foreach (var line in inputText.Split("\n"))
            {
                
                if (new Regex(classRegex).IsMatch(line))
                {
                    if (currentClass == null)
                    {
                        currentClass = new();
                        currentClassOpened++;
                    }
                    else if (currentClassOpened == currentClassClosed)
                    {
                        classes.Add(currentClass);
                        currentClass = new();
                        currentClassClosed++;
                    }

                    //Console.WriteLine(new Regex(classRegex).Match(line).Value);
                    var className = new Regex(classRegex).Match(line).Groups[1].Value;
                    currentClass.Name = className;
                }
            }

            return classes;
        }


        public static string ParseSyntaxTree(IParseTree parseTree, bool captureIdentifier = false, int count = 0, StructureType currentStructure = StructureType.None)
        {
            StringBuilder body = new();
            bool CaptureIdentifier = captureIdentifier;
            int Count = count;
            StructureType CurrentStructure = currentStructure;
            //  121 82 120 46 44

            for (int i = 0; i < parseTree.ChildCount; i++)
            {
                IParseTree child = parseTree.GetChild(i);
                if (child is TerminalNodeImpl terminalNode)
                {
                    if(terminalNode.Symbol.Text == "void")
                    {
                        //Console.WriteLine($"{CaptureIdentifier}-{CurrentStructure}-{terminalNode.Parent.RuleContext.RuleIndex}");
                        body.AppendLine($"  \"MType\":\"{terminalNode.Symbol.Text}\"");
                    }

                    else if (RuleIdentifierIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && CaptureIdentifier)
                    {
                        //Console.WriteLine($"¿{terminalNode.Symbol.Text}? ");
                        if (CurrentStructure == StructureType.Method)
                        {
                            body.Append($"    \"MName\":\"{terminalNode.Symbol.Text}\"");
                        }
                        else if (CurrentStructure == StructureType.Parameter)
                        {
                            body.Append($"\"PName\":\"{terminalNode.Symbol.Text}\"");
                        }
                        else
                        {
                            //Console.WriteLine($"{CaptureIdentifier} {CurrentStructure}");
                            body.AppendLine($"  \"CName\":\"{terminalNode.Symbol.Text}\"");
                        }

                        CaptureIdentifier = false;
                    }
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) 
                        && terminalNode.Symbol.Text != "class" && terminalNode.Symbol.Text != "," && !CaptureIdentifier)
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text}13");
                        CaptureIdentifier = true;
                    }
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) 
                        && (terminalNode.Symbol.Text == "class" || terminalNode.Symbol.Text == ","))
                    {
                        if (terminalNode.Symbol.Text == CLASS_DECLARATION)
                        {
                            body.AppendLine(LEFT_KEY);
                        }
                        else if (terminalNode.Symbol.Text == COMMA)
                        {
                            body.Append(terminalNode.Symbol.Text);
                        }
                        CaptureIdentifier = true;
                    }
                    else if (RuleIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && CaptureIdentifier)
                    {
                        switch (terminalNode.Symbol.Text)
                        {
                            case LEFT_KEY:
                                //body.AppendLine(LEFT_KEY);
                                break;
                            case RIGHT_KEY:
                                body.AppendLine(RIGHT_KEY);
                                break;
                            case LEFT_PARENTHESIS:
                                CurrentStructure = StructureType.Parameter;
                                //body.AppendLine();
                                break;
                            case RIGHT_PARENTHESIS:
                                //body.Append(RIGHT_PARENTHESIS);
                                CurrentStructure = StructureType.None;
                                break;
                            case LEFT_BRACKET:
                                body.Append(LEFT_BRACKET);
                                //body.AppendLine();
                                break;
                            case RIGHT_BRACKET:
                                body.Append($"{RIGHT_BRACKET}");
                                break;
                            default:
                                if (CurrentStructure == StructureType.Method)
                                {
                                    //Console.WriteLine($"\"Type\":\"{terminalNode.Symbol.Text}\" 245");
                                    body.Append($"{terminalNode.Symbol.Text}");
                                }
                                else if (CurrentStructure == StructureType.Parameter)
                                {
                                    body.Append($"{terminalNode.Symbol.Text}");
                                }
                                else
                                {
                                    //Console.WriteLine($"{terminalNode.Symbol.Text}\" 253");
                                    body.Append($"{terminalNode.Symbol.Text}");
                                }
                                break;
                        }
                    }

                    Count++;
                }
                else
                {
                    if (RuleTypes.Contains(child.GetType()) && child is ParserRuleContext context)
                    {
                        if (context.RuleIndex == JavaParser.RULE_methodDeclaration)
                        {
                            CaptureIdentifier = true;
                            body.AppendLine($"  \"Method\": {{");
                            body.AppendLine($"  {ParseSyntaxTree(child, CaptureIdentifier, Count, StructureType.Method)}}}");
                        }
                        else if (context.RuleIndex == JavaParser.RULE_formalParameterList)
                        {
                            CaptureIdentifier = true;
                            body.AppendLine();
                            body.AppendLine($"    \"Parameters\": [");
                            body.AppendLine($"{ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure)}]");
                        }
                        else if (context.RuleIndex == JavaParser.RULE_formalParameter)
                        {
                            CaptureIdentifier = true;
                            body.AppendLine($"      {{{ParseSyntaxTree(child, CaptureIdentifier, Count, StructureType.Parameter)}}}");

                        }
                        else if (context.RuleIndex == JavaParser.RULE_fieldDeclaration)
                        {
                            CaptureIdentifier = false;
                        }
                        else if (context.RuleIndex == JavaParser.RULE_typeType)
                        {
                            CaptureIdentifier = true;
                            if (CurrentStructure == StructureType.Method)
                            {
                                body.Append($"\"MType\":\"{ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure)}\",");
                            }
                            else
                            {
                                body.Append($"\"PType\":\"{ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure)}\",");
                            }
                            
                        }
                        else if (context.RuleIndex == JavaParser.RULE_typeTypeOrVoid)
                        {
                            CaptureIdentifier = true;
                            if (CurrentStructure == StructureType.Method)
                            {
                                body.Append($"\"MType\":\"{ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure)}\",");
                            }
                        }
                        else if (context.RuleIndex == JavaParser.RULE_methodBody)
                        {
                            CaptureIdentifier = false;
                        }
                        else
                        {
                            //body.Append(ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure));
                        }
                    }
                    else
                    {
                        body.Append(ParseSyntaxTree(child, CaptureIdentifier, Count, CurrentStructure));
                    }
                    //Console.WriteLine($"{child.Parent.GetText()} {0}");

                    //body.Append(ParseSyntaxTree(child, CaptureIdentifier, Count));
                }
            }

            return body.ToString();
        }
    }
}