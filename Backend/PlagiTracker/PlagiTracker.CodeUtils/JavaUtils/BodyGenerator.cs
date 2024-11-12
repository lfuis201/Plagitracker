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
        };

        public enum StructureType
        {
            Class,
            Method,
            Parameter,
            None
        }

        public static List<ClassRequest> ParseClassText(string inputText)
        {
            List<ClassRequest> classes = new List<ClassRequest>();

            // Expresión regular para encontrar clases y métodos
            Regex classRegex = new Regex(@"class\s+(\w+)\s*{([^{}]*(?:{[^{}]*}[^{}]*)*)}");
            Regex methodRegex = new Regex(@"(\w+)\s+(\w+)\s*\(([^)]*)\)");
            Regex paramRegex = new Regex(@"\s*(\w+)\s+(\w+)\s*");

            // Encontrar todas las clases de nivel superior
            MatchCollection classMatches = classRegex.Matches(inputText);
            foreach (Match classMatch in classMatches)
            {
                string className = classMatch.Groups[1].Value;
                string classBody = classMatch.Groups[2].Value;

                // Crear clase externa
                ClassRequest classRequest = new ClassRequest
                {
                    Name = className,
                    Description = $"Description of {className}",
                    Functions = new List<FunctionRequest>(),
                    ChildClasses = new List<ClassRequest>()
                };

                // Procesar funciones y clases internas del cuerpo
                ProcessFunctionsAndClasses(classBody, classRequest);

                classes.Add(classRequest);
            }

            return classes;
        }

        // Función para procesar funciones y clases internas recursivamente
        private static void ProcessFunctionsAndClasses(string body, ClassRequest currentClass)
        {
            Regex classRegex = new Regex(@"class\s+(\w+)\s*{([^{}]*(?:{[^{}]*}[^{}]*)*)}");
            Regex methodRegex = new Regex(@"(\w+)\s+(\w+)\s*\(([^)]*)\)");
            Regex paramRegex = new Regex(@"\s*(\w+)\s+(\w+)\s*");

            // Buscar clases internas dentro del cuerpo
            MatchCollection innerClassMatches = classRegex.Matches(body);
            foreach (Match innerClassMatch in innerClassMatches)
            {
                string innerClassName = innerClassMatch.Groups[1].Value;
                string innerClassBody = innerClassMatch.Groups[2].Value;

                // Crear clase interna y agregarla a la clase actual
                ClassRequest innerClassRequest = new ClassRequest
                {
                    Name = innerClassName,
                    Description = $"Description of {innerClassName}",
                    Functions = new List<FunctionRequest>(),
                    ChildClasses = new List<ClassRequest>()
                };

                currentClass.ChildClasses.Add(innerClassRequest);

                // Procesar funciones y posibles clases internas en la clase interna
                ProcessFunctionsAndClasses(innerClassBody, innerClassRequest);
            }

            // Procesar funciones del nivel actual, excluyendo las que pertenecen a clases internas
            MatchCollection methodMatches = methodRegex.Matches(body);
            foreach (Match methodMatch in methodMatches)
            {
                string methodType = methodMatch.Groups[1].Value;
                string methodName = methodMatch.Groups[2].Value;
                string methodParams = methodMatch.Groups[3].Value;

                FunctionRequest functionRequest = new FunctionRequest
                {
                    Type = methodType,
                    Name = methodName,
                    Description = $"Description of {methodName}",
                    Parameters = new List<ParameterRequest>()
                };

                // Procesar parámetros del método
                MatchCollection paramMatches = paramRegex.Matches(methodParams);
                foreach (Match paramMatch in paramMatches)
                {
                    string paramType = paramMatch.Groups[1].Value;
                    string paramName = paramMatch.Groups[2].Value;

                    functionRequest.Parameters.Add(new ParameterRequest
                    {
                        Type = paramType,
                        Name = paramName,
                        Description = $"Description of {paramName}"
                    });
                }

                // Agregar función solo al nivel actual
                currentClass.Functions.Add(functionRequest);
            }
        }


        public static string ParseSyntaxTree(IParseTree parseTree, bool captureIdentifier = false, int count = 0, StructureType currentStructure = StructureType.None)
        {
            StringBuilder body = new();
            bool CaptureIdentifier = captureIdentifier;
            StructureType CurrentStructure = currentStructure;
            int Count = count;

            //  121 82 120 46 44

            for (int i = 0; i < parseTree.ChildCount; i++)
            {
                IParseTree child = parseTree.GetChild(i);
                if (child is TerminalNodeImpl terminalNode)
                {
                    if (RuleIdentifierIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && CaptureIdentifier)
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text} ");
                        CaptureIdentifier = false;
                    }
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) 
                        && terminalNode.Symbol.Text != "class" && terminalNode.Symbol.Text != "," && !CaptureIdentifier)
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text} ");
                        CaptureIdentifier = true;
                    }
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) 
                        && (terminalNode.Symbol.Text == "class" || terminalNode.Symbol.Text == ","))
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text} ");
                        CaptureIdentifier = true;
                    }
                    else if (RuleIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && CaptureIdentifier)
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text} ");
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
                        }
                        else if (context.RuleIndex == JavaParser.RULE_formalParameter)
                        {
                            CaptureIdentifier = true;
                        }
                        else if (context.RuleIndex == JavaParser.RULE_fieldDeclaration)
                        {
                            CaptureIdentifier = false;
                        }
                        else if (context.RuleIndex == JavaParser.RULE_methodBody)
                        {
                            CaptureIdentifier = false;
                        }
                    }

                    Console.WriteLine($"{child.Parent.GetText()} {0}");

                    body.Append(ParseSyntaxTree(child, CaptureIdentifier, Count));
                }
            }

            return body.ToString();
        }
    }
}