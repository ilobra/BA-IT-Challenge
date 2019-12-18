using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace _1uzduotis
{
    class Program
    {

        static void Main(string[] args)
        {
            string readDir = "../../ReadmeBA-master";
            string writeDir = "../../Output.txt";
            string searchPattern = "*.*";
            string[] directories = GetFiles(readDir, searchPattern);
            string comment = "";
            //kaskart kompiliuojant programą ištrinamas senas ir sukuriamas naujas tuščias failas
            if (File.Exists(writeDir))
            {
                File.Delete(writeDir);
            }      
            for (int i = 0; i < directories.Length; i++)
            {              
                WriteToFile(directories[i], writeDir, comment);            
            }
            Console.WriteLine("Program compiled succesfully");
            Console.ReadLine();           
        }
        /// <summary>
        /// Gauna visus failus iš nurodyto aplanko
        /// </summary>
        /// <param name="readDir">Nurodytas aplankas</param>
        /// <param name="searchPattern">Failų šablonas</param>
        /// <returns></returns>
        static string[] GetFiles(string readDir, string searchPattern)
        {
            string[] csDirectories = Directory.GetFiles(readDir, searchPattern, SearchOption.AllDirectories);
            var exts = new[] { ".gitignore", ".sln", ".ico" };        
            var dirs = Directory.GetFiles(readDir, searchPattern, SearchOption.AllDirectories).Where(file => !exts.Any(x => file.EndsWith(x, StringComparison.OrdinalIgnoreCase)));
            List<string> csDirsList = dirs.ToList();
            string[] csDirs = csDirsList.ToArray();
            return csDirs;
        }
        /// <summary>
        /// Rezultatų įrašymas į failą
        /// </summary>
        /// <param name="directories">Dabartinio nuskaitomo failo direktorija</param>
        /// <param name="writeDir">Rezultatų failas</param>
        /// <param name="comment">Ištrauktas komentaras iš to failo</param>
        static void WriteToFile(string directories, string writeDir, string comment)
        {                
                comment = GetComments(directories);
                    //jeigu faile komentarų nėra, failo pavadinimas nėra rodomas rezultatų faile
                    if (comment != "") {               
                        File.AppendAllText(writeDir,"==========="+ Path.GetFileName(directories) + "===========\n");
                        File.AppendAllText(writeDir, comment);
                    }        
        }
        /// <summary>
        /// Komentarų išgavimas iš failo
        /// </summary>
        /// <param name="directory">Dabartinis failas</param>
        /// <returns>Išgautas komentaras</returns>
        static string GetComments(string directory)
        {
            string text = File.ReadAllText(directory);
            text = text.Replace("\\\"", "");
            string comments = "";
            /**
             * Nagrinėjamas visas tekstas, ieškomos komentarų žymių pozicijos tekste, jas radus ieškomos komentarų pabaigos žymės, 
             * po to komentaras įtraukiamas į "comments" kintamąjį, o tekstas nagrinėjamas toliau nuo rasto komentaro pabaigos pozicijos
             **/
            while (text.Length > 0)
            {
                int stringPos = text.IndexOf("\"");
                int oneLinePos = text.IndexOf("//");
                int multiLinePos = text.IndexOf("/*");
                int htmlPos = text.IndexOf("<!--");
                int gitPos = text.IndexOf("#");

                if ((stringPos < 0) && (oneLinePos < 0) && (multiLinePos < 0) && (htmlPos < 0) && (gitPos < 0)) break;

                if (stringPos < 0) stringPos = text.Length;
                if (oneLinePos < 0) oneLinePos = text.Length;
                if (multiLinePos < 0) multiLinePos = text.Length;
                if (htmlPos < 0) htmlPos = text.Length;
                if (gitPos < 0) gitPos = text.Length;

                if ((stringPos < oneLinePos) && (stringPos < multiLinePos) && (stringPos < htmlPos) && (stringPos < gitPos))
                {
                    int endPos = text.IndexOf("\"", stringPos + 1);
                    if (endPos < 0) { text = ""; }
                    else { text = text.Substring(endPos + 1); }
                }
                else if (oneLinePos < multiLinePos)
                {                
                    int endPos = text.IndexOf("\n", oneLinePos + 2);                  
                    if (endPos < 0)
                    {
                        comments += text.Substring(oneLinePos) + "\r\n";
                        text = "";
                    }
                    else
                    {
                        comments += text.Substring(oneLinePos, endPos - oneLinePos) + "\r\n";
                        text = text.Substring(endPos + 2);
                    }

                }
                else if (directory.EndsWith(".html")&&htmlPos>0)
                {
                    int endPos = text.IndexOf("-->", htmlPos + 4);
                    if (endPos < 0)
                    {
                        comments += text.Substring(htmlPos) + "\r\n";
                        text = "";
                    }
                    else
                    {
                        comments += text.Substring(htmlPos, endPos - htmlPos + 3) + "\r\n";
                        text = text.Substring(endPos + 3);                      
                    }
                }
                else if ((directory.EndsWith(".gitignore") || directory.EndsWith(".gitattributes")))
                {                  
                    int endPos = text.IndexOf("\"", gitPos + 1);
                    if (endPos < 0)
                    {
                        comments += text.Substring(gitPos) + "\r\n";
                        text = "";
                    }
                    else
                    {
                        comments += text.Substring(gitPos, endPos - gitPos + 1) + "\r\n";
                        text = text.Substring(endPos);

                    }
                }
                else
                {
                    int endPos = text.IndexOf("*/", multiLinePos + 2);

                    if(endPos<0)
                    {
                        comments += text.Substring(multiLinePos) + "\r\n";
                        text = "";
                    }
                    else
                    {
                        comments += text.Substring(multiLinePos, endPos - multiLinePos + 2) + "\r\n";
                        text = text.Substring(endPos + 2);
                    }
                }
            }
            return comments;
        }        
    }
}
