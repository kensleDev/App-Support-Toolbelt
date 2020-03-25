using System;
using System.Collections.Generic;
using System.IO;

namespace Doc_Generaetor
{
    class Program
    {
        static void Main(string[] args)
        {

            var lines = File.ReadLines("E:\\Dev\\repos\\Windows-Helper\\keymap.ahk");
            Console.WriteLine(lines);

            string desc = "";

            desc += "# Keymap" + "\n";
            desc += "Capslock + key + modifer = action " + "\n";

            string header = "|key|modifer|action|" + "\n" + "|----|----|----|" + "\n";
            string content = "";
            List<string> output = new List<string>();

            foreach (var line in lines)
            {
                //Console.WriteLine(line);


           

                if (line.Contains("CapsLock &"))
                {


                    string comboKeyFirstHalf = line.Substring(line.IndexOf("&") + 2);
                    string comboKey = comboKeyFirstHalf.Substring(0, comboKeyFirstHalf.IndexOf("::"));


                    string commandFirstHalf = line.Substring(line.IndexOf("cmd")+5);
                    string command = SantizeCmd(commandFirstHalf.Substring(0, commandFirstHalf.IndexOf("\"")));

                    string shiftCommandFirstHalf = line.Substring(line.IndexOf(",")+3);
                    string shiftCommand = SantizeCmd(shiftCommandFirstHalf.Substring(0, shiftCommandFirstHalf.IndexOf(",") - 1));

                    string altCommandFirstHalf = line.Substring(line.LastIndexOf(",") + 3);
                    string altCommand = SantizeCmd(altCommandFirstHalf.Substring(0, altCommandFirstHalf.IndexOf(")") - 1));


                    string normalCmd = $"|{comboKey}| |{command}| ";
                    string shiftCmd = $"|{comboKey}| Shift |{shiftCommand}| ";
                    string altCmd = $"|{comboKey}| Alt |{altCommand}| ";

                    content += normalCmd + "\n";

                    Console.WriteLine(content);
                        
                    if (shiftCommand != "")
                    {
                        content += shiftCmd + "\n";
                    }

                    if (altCommand != "")
                    {
                        content += altCmd + "\n";
                    }

                    content += "||||" + "\n";

                }

            }

            content = desc + header +  content;

            string[] contentArr = content.Split("\n");

            WriteToFile(@"E:\Dev\repos\Windows-Helper", contentArr, "keymap.md");

        }

        static string SantizeCmd(string cmd)
        {
            cmd = cmd.Replace("+", "Shift + ");
            cmd = cmd.Replace("!", "Alt + ");
            cmd = cmd.Replace("^", "Crtl + ");
            cmd = cmd.Replace("{", "");
            cmd = cmd.Replace("}", "");
            //cmd = cmd.Replace("\"\"", "N/A");

            return cmd;
        }


        static void WriteToFile(string path, string[] input, string fileName)
        {
            // Write the string array to a new file named "WriteLines.txt".
            using (StreamWriter outputFile = new StreamWriter(Path.Combine(path, fileName)))
            {
                foreach (string line in input)
                    outputFile.WriteLine(line);
            }
        }
    }
}
