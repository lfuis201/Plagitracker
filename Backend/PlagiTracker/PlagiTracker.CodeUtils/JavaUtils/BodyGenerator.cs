// Ignore Spelling: Utils

using System;
using System.Text.RegularExpressions;
using System.Text;
using Antlr4.Runtime.Tree;
using PlagiTracker.CodeUtils.GrammarFiles;
using Antlr4.Runtime;

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
        
        public static string GenerateBody(List<TokenInfo> tokens)
        {
            StringBuilder body = new StringBuilder();
            Stack<string> classStack = new Stack<string>(); // Para rastrear clases anidadas
            bool isMethod = false;
            string methodName = "";
            bool isMethodArgs = false;
            StringBuilder methodArgs = new StringBuilder();
            int indentationLevel = 0;

            foreach (var token in tokens)
            {
                // Detecta el nombre de la clase
                if (token.Type == 9) // Tipo 'class'
                {
                    isMethod = false;
                    methodArgs.Clear();

                    // Buscar nombre de clase
                    var nextTokenIndex = tokens.IndexOf(token) + 2;
                    if (nextTokenIndex < tokens.Count && tokens[nextTokenIndex].Type == 128) // Tipo identificador
                    {
                        string className = tokens[nextTokenIndex].Text;
                        classStack.Push(className);

                        body.AppendLine($"{new string(' ', indentationLevel * 2)}{className} {{");
                        indentationLevel++; // Aumenta la indentación para la siguiente clase o método
                    }
                }
                // Detecta métodos y su declaración
                else if (token.Type == 48) // Tipo 'void'
                {
                    isMethod = true;
                    methodName = tokens[tokens.IndexOf(token) + 2].Text; // El nombre del método viene después del tipo 'void'
                }
                else if (isMethod && token.Type == 78) // Tipo '(' inicio de argumentos
                {
                    isMethodArgs = true;
                }
                else if (isMethodArgs && token.Type != 79) // Mientras esté en los argumentos y no llegue a ')'
                {
                    methodArgs.Append(token.Text);
                }
                else if (isMethodArgs && token.Type == 79) // Fin de argumentos ')'
                {
                    isMethodArgs = false;
                    body.AppendLine($"{new string(' ', indentationLevel * 2)}void {methodName}({methodArgs})");
                    isMethod = false;
                    methodArgs.Clear();
                }
                else if (token.Type == 81) // Fin de bloque '}'
                {
                    if (classStack.Count > 0)
                    {
                        classStack.Pop();
                        indentationLevel--; // Disminuye la indentación al cerrar una clase
                        body.AppendLine($"{new string(' ', indentationLevel * 2)}}}");
                    }
                }
            }

            return body.ToString();
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
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && terminalNode.Symbol.Text != "class" && !CaptureIdentifier)
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"{terminalNode.Symbol.Text} ");
                        CaptureIdentifier = true;
                    }
                    else if (RuleDeclarationIndexes.Contains(terminalNode.Parent.RuleContext.RuleIndex) && terminalNode.Symbol.Text == "class")
                    {
                        //body.Append($"{terminalNode.Symbol.Text} ¿{CaptureIdentifier} {count} {Count}? ");
                        body.Append($"\n{terminalNode.Symbol.Text} ");
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