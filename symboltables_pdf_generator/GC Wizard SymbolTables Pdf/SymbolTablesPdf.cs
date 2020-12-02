using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.IO;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using PdfSharp.Pdf.IO;
using System.Collections;
using System.Resources;

namespace GC_Wizard_SymbolTables_Pdf
{

    // dll from http://www.pdfsharp.net/
    public class SymbolTablesPdf
    {

        public EventHandler SymbolTablesCount_Changed;

        public EventHandler SymbolImagesCount_Changed;

        public EventHandler Progress_Changed;

        public Single BorderWidthTop { get; set; }
        public Single BorderWidthLeft { get; set; }
        public Single BorderWidthRight { get; set; }
        public Single BorderWidthBottom { get; set; }

        public int ImageSize { get; set; }


        public int HeadingDistance { get; set; } = 10;
        public int RowDistance { get; set; } = 12;
        public int ColumnDistance { get; set; } = 10;

        public LanguageEnum Language { get; set; }

        public double FontSizeName { get; set; }

        public double FontSizeOverlay { get; set; }

        public bool NewPage { get; set; }

        public PdfSharp.PageOrientation Orientation { get; set; }

        private PdfOutline Outline { get; set; }
        private String ProjectPath { get; set; }

        private double _Progress = 0;
        public double Progress
        {
            get
            {
                return _Progress;
            }
            internal set
            {
                if (_Progress != value)
                {
                    _Progress = value;
                    if (Progress_Changed != null)
                        Progress_Changed(this, EventArgs.Empty);
                }
            }
        }

        private int _SymbolTablesCount = 0;
        public int SymbolTablesCount
        {
            get
            {
                return _SymbolTablesCount;
            }
            internal set
            {
                if (_SymbolTablesCount != value)
                {
                    _SymbolTablesCount = value;
                    if (SymbolTablesCount_Changed != null)
                        SymbolTablesCount_Changed(this, EventArgs.Empty);
                }
            }
        }

        private int _SymbolImagesCount = 0;
        public int SymbolImagesCount
        {
            get
            {
                return _SymbolImagesCount;
            }
            internal set
            {
                if (_SymbolImagesCount != value)
                {
                    _SymbolImagesCount = value;
                    if (SymbolTablesCount_Changed != null)
                        SymbolImagesCount_Changed(this, EventArgs.Empty);
                }
            }
        }


        public enum LanguageEnum
        {
            de,
            en
        }

        public SymbolTablesPdf()
        {
            BorderWidthTop = 35;
            BorderWidthLeft = 35;
            BorderWidthRight = 20;
            BorderWidthBottom = 20;
            ImageSize = 50;
            Language = LanguageEnum.de;
            FontSizeName = 20;
            FontSizeOverlay = 5;
            Orientation = PdfSharp.PageOrientation.Portrait;
        }

        public PdfDocument createPdfDocument(String path)
        {
            try
            {
                // Create a new PDF document
                PdfDocument document = new PdfDocument();
                document.Info.Title = "GC Wizard Symbol Tables";

                drawSymbolTables(path, document);

                return document;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Save the document...
        /// </summary>
        /// <param name="path"></param>
        public static bool savePdfDocument(String path, PdfDocument document)
        {
            try
            {
                if (String.IsNullOrEmpty(path) || (document == null))
                    return false;

                document.Save(path);
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return true;
        }


        private void drawSymbolTables(String path, PdfDocument document)
        {
            var offset = new PointF();
            var languagefile = File.ReadAllText(languageFileName(path));
            var licenseEntries = getLicenseEntries(File.ReadAllText(licenseFileName(path)));

            ProjectPath = path;
            PdfPage page = null;
            // Get an XGraphics object for drawing
            XGraphics gfx = null;
            Progress = 0;

            offset = createPage(document, ref page, ref gfx);
            // Create the root bookmark. You can set the style and the color.
            Outline = document.Outlines.Add((Language == LanguageEnum.de) ? "Inhaltsverzeichnis" : "Table of Contents", page, true, PdfOutlineStyle.Bold, XColors.Black);

            var directorys = createDirectoryList(path, languagefile);
            var progress_offset = directorys.Any() ? (100.0 / directorys.Count()) : 100;
            foreach (var entry in directorys)
            {
                offset = drawSymbolTable(path, entry.Value, entry.Key, document, ref page, ref gfx, offset, languagefile, licenseEntries);

                offset.X = BorderWidthLeft;
                offset.Y += ImageSize + 20;

                Progress = Progress + progress_offset;
            }

            Progress = 100;
        }

        private IEnumerable<KeyValuePair<String, String>> createDirectoryList(String path, String languagefile)
        {
            var list = new Dictionary<String, String>();
            foreach (var directory in Directory.GetDirectories(symbolTablesDirectory(path)))
            {
                var folder = @directory.Substring(directory.LastIndexOf(Path.DirectorySeparatorChar) + 1);
                var name = getEntryValue(languagefile, "symboltables_" + folder + "_title");

                if (name != null && directory != "backlog")
                    list.Add(folder, name);
            }

            var query = list.OrderBy(entry => entry.Value);
            return query;
        }

        private PointF drawSymbolTable(String path, String name, String folder, PdfDocument document, ref PdfPage page, ref XGraphics gfx, PointF offset, String languagefile, Dictionary<string, string> licenseEntries)
        {
            var description = getEntryValue(languagefile, "symboltables_" + folder + "_description");
            var license = "";
            if (licenseEntries.ContainsKey(folder))
                license = ((Language == LanguageEnum.de) ? "(Quelle: " : "(Source: ") + licenseEntries[folder] + ")";

            if (name == null)
                name = folder;

            var symbolList = createSymbolList(path, folder, languagefile);
            offset = drawName(name, description, license, symbolList.Count(), document, ref page, ref gfx, offset);
            SymbolTablesCount += 1;

            foreach (var symbol in symbolList)
            {
                offset = drawImage(symbol.Key, document, ref page, ref gfx, offset, symbol.Value);
                SymbolImagesCount += 1;
            }

            return offset;
        }

        private IEnumerable<KeyValuePair<String, String>> createSymbolList(String path, String folder, String languagefile)
        {
            var list = new Dictionary<String, String>();
            var overlay = String.Empty;
            var _path = symbolTablesDirectory(path);
            _path = Path.Combine(_path, folder);

            var configFilePath = Path.Combine(_path, "config.json");
            List<String> translateList = null;
            Dictionary<String, String> mappingList = null;
            bool caseSensitive = false;

            if (File.Exists(Path.Combine(configFilePath)))
            {
                var fileContent = File.ReadAllText(configFilePath);
                translateList = parseTranslateConfig(fileContent);
                mappingList = parseMappingConfig(fileContent);
                caseSensitive = parseCaseSesitiveConfig(fileContent);

            }
            else
                mappingList = parseMappingConfig(null);


            foreach (var symbol in Directory.GetFiles(_path, "*.png"))
            {
                overlay = symbolOverlay(symbol, folder, languagefile, translateList, mappingList, caseSensitive);

                list.Add(symbol, overlay);
            }

            var comparer = new NameSort();
            var listSorted = list.ToList();
            listSorted.Sort(delegate (KeyValuePair<String, String> x, KeyValuePair<String, String> y) { return comparer.Compare(x.Value, y.Value); });
            return listSorted;
        }

        private List<String> parseTranslateConfig(String fileContent)
        {
            var regex = new Regex(@"(translate)(.*?)(\[)(.*?)(\])", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            var regex2 = new Regex(@"\""(.*?)\""");
            var list = new List<String>();

            if (fileContent != null)
            {
                var match = regex.Match(fileContent);
                if (match.Success)
                {
                    var matches = regex2.Matches(match.Groups[4].Value);
                    foreach (Match match2 in matches)
                        list.Add(match2.Groups[1].Value);
                }
            }
            return list;
        }

        private Dictionary<String, String> parseMappingConfig(String fileContent)
        {
            var regex = new Regex(@"(special_mappings)(.*?)(\{)(.*?)(\})", RegexOptions.Singleline | RegexOptions.IgnoreCase);
            var regex2 = new Regex(@"\""(.*?)\""(\s*:\s*)\""(.*?)\""");
            var list = defaultMappingList();

            if (fileContent != null)
            {
                var match = regex.Match(fileContent);
                if (match.Success)
                {
                    foreach (string line in match.Groups[4].Value.Split('\n'))
                    {
                        var match2 = regex2.Match(line);
                        if (match2.Success)
                        {
                            list.Add(match2.Groups[1].Value, match2.Groups[3].Value);
                        }
                    }
                }
            }

            return list;
        }

        private Dictionary<String, String> defaultMappingList()
        {
            var list = new Dictionary<String, String> {
                { "space" , " "},
    { "asterisk" , "*"},
    { "dash" , "-"},
    { "colon" , ","},
    { "semicolon" , ","},
    { "dot" , "."},
    { "slash" , "/"},
    { "apostrophe" , "'"},
    { "apostrophe_in" , "'"},
    { "apostrophe_out" , "'"},
    { "parentheses_open" , "("},
    { "parentheses_close" , ")"},
    { "quotation" , "\""},
    { "quotation_in" , "\""},
    { "quotation_out" , "\""},
    { "dollar" , "$"},
    { "percent" , "%"},
    { "plus" , "+"},
    { "question" , "?"},
    { "exclamation" , "!"},
    { "backslash" , "\\"},
    { "copyright" , "©"},
    { "comma" , "},"},
    { "pound" , "£"},
    { "equals" , "="},
    { "brace_open" , "{"},
    { "brace_close" , "}"},
    { "bracket_open" , "["},
    { "bracket_close" , "]"},
    { "ampersand" , "&"},
    { "hashtag" , "#"},
    { "web_at" , "@"},
    { "paragraph" , "§"},
    { "caret" , "^"},
    { "underscore" , "_"},
    { "backtick" , "`"},
    { "pipe" , "|"},
    { "tilde" , "~"},
    { "lessthan" , "<"},
    { "greaterthan" , ">"},
    { "euro" , "€"},
    { "AE_umlaut" , "Ä"},
    { "OE_umlaut" , "Ö"},
    { "UE_umlaut" , "Ü"},
    { "SZ_umlaut" , "ß"},
    { "A_acute" , "Á"},
    { "A_grave" , "À"},
    { "A_circumflex" , "Â"},
    { "AE_together" , "Æ"},
    { "C_cedille" , "Ç"},
    { "E_acute" , "É"},
    { "E_grave" , "È"},
    { "E_circumflex" , "Ê"},
    { "E_trema" , "Ë"},
    { "I_acute" , "Í"},
    { "I_grave" , "Ì"},
    { "I_circumflex" , "Î"},
    { "I_trema" , "Ï"},
    { "N_tilde" , "Ñ"},
    { "O_acute" , "Ó"},
    { "O_grave" , "Ò"},
    { "O_circumflex" , "Ô"},
    { "U_acute" , "Ú"},
    { "U_grave" , "Ù"},
    { "U_circumflex" , "Û"},

    { "ae_umlaut" , "ä"},
    { "oe_umlaut" , "ö"},
    { "ue_umlaut" , "ü"},
  };

            var path = Path.Combine(ProjectPath, @"lib\widgets\tools\symbol_tables\symbol_table_data.dart");
            if (File.Exists(path))
            {

                try
                {
                    var fileContent = File.ReadAllText(path);
                    var regex = new Regex(@"(CONFIG_SPECIAL_CHARS)(.*?)(\{)(.*?)(\};)", RegexOptions.Singleline | RegexOptions.IgnoreCase);
                    var regex2 = new Regex(@"\""(.*?)\""(\s*:\s*)\""(.*?)\""");
                    var list2 = new Dictionary<String, String>();

                    var match = regex.Match(fileContent);
                    if (match.Success)
                    {
                        foreach (string line in match.Groups[4].Value.Split('\n'))
                        {
                            var match2 = regex2.Match(line);
                            if (match2.Success)
                            {
                                var value = match2.Groups[3].Value;
                                if (value.StartsWith(@"\"))
                                    value = value.Substring(1);
                                list2.Add(match2.Groups[1].Value, value);
                            }
                        }
                        list = list2;
                    }
                }
                catch (Exception)
                {
                }
            }
            return list;
        }

        private bool parseCaseSesitiveConfig(String fileContent)
        {
            var regex = new Regex(@"(\""case_sensitive\""\s *:)\s(true)");
            bool value = false;

            if (fileContent != null)
            {
                var match = regex.Match(fileContent);
                value = match.Success;
            }
            return value;
        }


        private String symbolOverlay(String symbolPath, String folder, String languagefile, List<String> translateList, Dictionary<String, String> mappingList, bool caseSensitive)
        {
            var fileName = Path.GetFileNameWithoutExtension(symbolPath);
            var overlay = fileName;
            var lowerCase = false;
            if (overlay.StartsWith("_"))
            {
                lowerCase = true;
                overlay = overlay.Substring(1);
            }

            if (translateList != null && translateList.Contains(fileName))
                overlay = getEntryValue(languagefile, "symboltables_" + folder + "_" + fileName);
            else if (mappingList != null && mappingList.ContainsKey(fileName))
                overlay = mappingList[fileName];

            while (overlay.EndsWith("_"))
                overlay = overlay.Substring(0, overlay.Length - 1);

            if (caseSensitive && lowerCase)
                overlay = overlay.ToLower();
            else
                overlay = overlay.ToUpper();

            return overlay;
        }

        private PointF drawName(String name, string description, string license, int count, PdfDocument document, ref PdfPage page, ref XGraphics gfx, PointF offset)
        {
            // Create a font
            XFont font = new XFont("Verdana", FontSizeName, XFontStyle.BoldItalic);

            var name_offset = font.Height;
            if (!string.IsNullOrEmpty(description))
                name_offset += font.Height / 2;
            if (!string.IsNullOrEmpty(license))
                name_offset += font.Height / 4;

            name_offset += 20;

            if (page == null || NewPage)
                offset = createPage(document, ref page, ref gfx);
            else if (offset.Y + name_offset + (ImageSize + RowDistance) > page.Height - BorderWidthBottom)
            {
                if (count > rowImageCount(ref page))
                    offset = createPage(document, ref page, ref gfx);
            }
            else if (offset.Y + name_offset + 2 * (ImageSize + RowDistance) > page.Height - BorderWidthBottom)
            {
                if (count > 2 * rowImageCount(ref page))
                    offset = createPage(document, ref page, ref gfx);
            }

            // Draw the name
            gfx.DrawString(name, font, XBrushes.Black,
            new XRect(offset.X, offset.Y, page.Width, page.Height),
            XStringFormats.TopLeft);

            offset.Y += font.Height;

            // description
            if (!string.IsNullOrEmpty(description))
            {
                font = new XFont("Verdana", FontSizeName / 2, XFontStyle.Regular);

                // Draw the description
                gfx.DrawString(description, font, XBrushes.Black,
                new XRect(offset.X, offset.Y, page.Width, page.Height),
                XStringFormats.TopLeft);

                offset.Y += font.Height;
            }

            // license
            if (!string.IsNullOrEmpty(license))
            {
                font = new XFont("Verdana", FontSizeName / 4, XFontStyle.Regular);

                // Draw the license
                gfx.DrawString(license, font, XBrushes.Black,
                new XRect(offset.X, offset.Y, page.Width, page.Height),
                XStringFormats.TopLeft);

                offset.Y += font.Height;
            }
            offset.Y += HeadingDistance;

            Outline.Outlines.Add(name, page, true);

            return offset;
        }

        private bool newPageNeeded(PdfPage page, PointF offset, int name_offset)
        {
            // min. 2 image rows
            return (offset.Y + name_offset + HeadingDistance + 2 * ImageSize + RowDistance > page.Height - BorderWidthBottom);
        }

        private PointF drawOverlay(String name, int maxLength, PdfDocument document, ref PdfPage page, ref XGraphics gfx, PointF offset)
        {
            // Create a font
            XFont font = new XFont("Verdana", FontSizeOverlay, XFontStyle.Regular);
            // Draw the name
            name = checkTextLength(name, maxLength, font, gfx);
            if (!name.Contains(Environment.NewLine))
                gfx.DrawString(name, font, XBrushes.Blue,
                    new XRect(offset.X, offset.Y, ImageSize, 10),
                    XStringFormats.TopLeft);
            else
            {
                var text = name.Split('\n');

                for (int i = 0; i < text.Length; i++)
                    gfx.DrawString(text[i], font, XBrushes.Blue,
                        new XRect(offset.X, offset.Y + i * FontSizeOverlay, ImageSize, RowDistance),
                        XStringFormats.TopLeft);
            }

            return offset;
        }

        private string checkTextLength(string text, int maxLength, XFont font, XGraphics gfx)
        {
            var size = gfx.MeasureString(text, font);

            if (size.Width <= maxLength)
                return text;

            Func<string, Char, int> textSplit = (_text, _char) =>
            {
                var _index = text.LastIndexOf(_char);
                while (_index > 0)
                {
                    size = gfx.MeasureString(text.Substring(0, _index), font);
                    if (size.Width <= maxLength)
                        return _index;
                    else
                        _index = text.LastIndexOf(" ", _index - 1);
                }

                return _index;
            };

            var index = textSplit(text, ' ');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            index = textSplit(text, '/');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            index = textSplit(text, ',');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            index = textSplit(text, ',');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            index = textSplit(text, ')');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            for (index = text.Length - 1; index >= 0; index--)
            {
                size = gfx.MeasureString(text.Substring(0, index), font);
                if (size.Width <= maxLength)
                    return text.Substring(0, index) + Environment.NewLine + text.Substring(index + 1);

            }

            return text;
        }

        private PointF drawImage(String symbolPath, PdfDocument document, ref PdfPage page, ref XGraphics gfx, PointF offset, String overlay)
        {
            XImage image = XImage.FromFile(symbolPath);
            XSize size = image.Size;
            var ImageScale = ImageSize / size.Height;
            size.Width *= ImageScale;
            size.Height *= ImageScale;

            if (page == null)
                offset = createPage(document, ref page, ref gfx);
            else if (offset.X + size.Width > page.Width - BorderWidthRight)
            {
                // new Row
                offset.X = BorderWidthLeft;
                offset.Y += (Single)size.Height + RowDistance;
            }

            if (offset.Y + size.Height > page.Height - BorderWidthBottom)
                offset = createPage(document, ref page, ref gfx);

            gfx.DrawImage(image, offset.X, offset.Y, size.Width, size.Height);

            // Border
            gfx.DrawRectangle(new XPen(XColor.FromArgb(Color.Gray.ToArgb()), 0.2), offset.X, offset.Y, size.Width, size.Height);

            // Draw the overlay
            drawOverlay(overlay, (int)(size.Width + ColumnDistance / 2), document, ref page, ref gfx, new PointF(offset.X, (Single)(offset.Y + size.Height)));

            offset.X += (Single)size.Width + ColumnDistance;

            return offset;
        }

        private PointF createPage(PdfDocument document, ref PdfPage page, ref XGraphics gfx)
        {
            // Create a font
            XFont font = new XFont("Verdana", FontSizeOverlay, XFontStyle.Regular);
            XSize textSize;
            String text;

            page = document.AddPage();
            page.Orientation = Orientation;
            gfx = XGraphics.FromPdfPage(page);

            if (document.PageCount == 1)
            {
                text = File.ReadAllText(versionFileName(ProjectPath));
                text = getVersionEntryValue(text, "version");
                textSize = gfx.MeasureString(text, font);

                // Draw the version text
                gfx.DrawString(text, font, XBrushes.Black,
                    new XRect(page.Width - BorderWidthRight - textSize.Width, (BorderWidthTop - font.Height) / 2, page.Width, page.Height),
                    XStringFormats.TopLeft);
            }

            // GC Wicard Icon
            gfx.DrawImage(Properties.Resources.circle_border_128, 5, 5, BorderWidthTop - 5, BorderWidthTop - 5);

            // Draw GC Wizard Text
            // Create a font
            font = new XFont("Verdana", FontSizeName / 2, XFontStyle.Regular);
            text = "GC Wizard";
            textSize = gfx.MeasureString(text, font);

            gfx.DrawString("GC Wizard", font, XBrushes.Black,
                new XRect(BorderWidthTop + 3, (BorderWidthTop - font.Height) / 2, page.Width, page.Height),
                XStringFormats.TopLeft);

            return new PointF(BorderWidthLeft, BorderWidthTop);
        }

        /// <summary>
        /// get text from language-file
        /// </summary>
        /// <param name="fileContent"></param>
        /// <param name="entry"></param>
        /// <returns></returns>
        private static String getEntryValue(String fileContent, String entry)
        {
            var regex = new Regex(@"(""" + entry + @"""\s*:\s*)\""(.*?)\""");
            String value = null;

            foreach (string line in fileContent.Split('\n'))
            {
                var match = regex.Match(line);
                if (match.Success)
                {
                    value = match.Groups[2].Value;
                    break;
                }
            }

            return value;
        }

        /// <summary>
        /// get text from version-file
        /// </summary>
        /// <param name="fileContent"></param>
        /// <param name="entry"></param>
        /// <returns></returns>
        private static String getVersionEntryValue(String fileContent, String entry)
        {
            var regex = new Regex(@"(" + entry + @":)(.*?)(\+)(.*?)(\r)");
            String value = null;

            foreach (string line in fileContent.Split('\n'))
            {
                var match = regex.Match(line);
                if (match.Success)
                {
                    value = "Version: " + match.Groups[2].Value + " (Build: " + match.Groups[4].Value + ")";
                    break;
                }
            }

            return value;
        }

        /// <summary>
        /// get text from license-file
        /// </summary>
        /// <param name="fileContent"></param>
        /// <returns></returns>
        private Dictionary<String, String> getLicenseEntries(String fileContent)
        {
            var start = false;
            var startChildren = false;
            var list = new Dictionary<String, String>();

            foreach (string line in fileContent.Split('\n'))
            {
                if (!start && line.Contains(@"licenses_symboltablesources"))
                {
                    start = true;
                }
                else if (start && !startChildren && line.Contains(@"children"))
                {
                    startChildren = true;
                }
                else if (startChildren && line.TrimStart().StartsWith(@"["))
                {
                    var lineTmp = line.Trim();
                    lineTmp = lineTmp.Replace("[", "").Replace("]", "").Replace("'", "");
                    var entrys = lineTmp.Split(',');
                    if (entrys.Length >= 2)
                    {
                        entrys[0] = entrys[0].Trim();
                        entrys[1] = entrys[1].Trim().ToLower();

                        if (list.ContainsKey(entrys[1]))
                            list[entrys[1]] += ", " + entrys[0];
                        else
                            list[entrys[1]] = entrys[0];
                    }
                }
                else if (startChildren && line.EndsWith(@"),"))
                {
                    break;
                }
            }

            return list;
        }

        int rowImageCount(ref PdfPage page)
        {
            return (int)Math.Floor((page.Width - BorderWidthLeft - BorderWidthRight) / (ImageSize + ColumnDistance));
        }

        public bool validFolder(String path)
        {
            if (!Directory.Exists(languageFileDirectory(path)))
                return false;
            if (!File.Exists(languageFileName(path)))
                return false;

            if (!Directory.Exists(symbolTablesDirectory(path)))
                return false;

            return true;
        }

        private static String languageFileDirectory(String path)
        {
            return Path.Combine(path, @"assets\i18n");
        }

        private String languageFileName(String path)
        {
            return Path.Combine(languageFileDirectory(path), Language + @".json");
        }

        private static String versionFileName(String path)
        {
            return Path.Combine(path, "pubspec.yaml");
        }


        private static String licenseFileName(String path)
        {
            return Path.Combine(path, @"lib\widgets\main_menu\licenses.dart");
        }

        private static String symbolTablesDirectory(String path)
        {
            return Path.Combine(path, @"assets\symbol_tables");
        }

        public class NameSort
        {
            public int Compare(Object _a, Object _b)
            {
                const string SPECIAL_MARKER = "[#*?SPECIAL_MARKER%&]";

                int intA;
                int intB;
                String a = _a.ToString();
                String b = _b.ToString();


                if (!int.TryParse(a, out intA))
                {
                    if (!int.TryParse(b, out intB))
                    {
                        if (a.StartsWith(SPECIAL_MARKER))
                        {
                            if (b.StartsWith(SPECIAL_MARKER))
                                return a.CompareTo(b);
                            else
                                return 1;
                        }
                        else
                        {
                            if (b.StartsWith(SPECIAL_MARKER))
                                return -1;
                            else
                                return lowerCase(a, b);

                        }
                    }
                    else
                        return 1;
                }
                else
                {
                    if (!int.TryParse(b, out intB))
                        return -1;
                    else
                        return intA.CompareTo(intB);
                }
            }

            static int lowerCase(string a, string b)
            {
                if ((a == String.Empty) | (b == String.Empty))
                    return a.CompareTo(b);
                else { }
                var abytes = System.Text.Encoding.Default.GetBytes(a);
                var bbytes = System.Text.Encoding.Default.GetBytes(b);

                if (abytes[0] != bbytes[0])
                    return abytes[0].CompareTo(bbytes[0]);
                else
                    return a.CompareTo(b);


            }
        }
    }
}
