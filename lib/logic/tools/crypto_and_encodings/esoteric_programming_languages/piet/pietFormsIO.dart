using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using PietSharp.Core.Contracts;
using Microsoft.VisualBasic;

namespace PietSharp.Core
{
    public interface IPietIO
    {
        /// <summary>
        /// Write out the provided value
        /// </summary>
        /// <param name="value">The value to be written</param>
        void Output(object value);
        /// <summary>
        /// Reads the next integer input.
        /// </summary>
        /// <returns>User input</returns>
        int? ReadInt();
        /// <summary>
        /// Reads the next char input.
        /// </summary>
        /// <returns>User input</returns>
        char? ReadChar();
    }

    public class PietFormsIO: IPietIO
    {
        public void Output(object value)
        {
            Debug.Write(value.ToString());
        }

        public int? ReadInt()
        {
            //Interaction.InputBox(message, title, defaultValue)
            int result;
            if (int.TryParse("3", out result))
                return result;

            return null;
        }

        public char? ReadChar()
        {
            return 'A'; // (char)Console.Read();
        }
    }
}
