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
using System.Collections;

namespace GC_Wizard_SymbolTables_Pdf
{

    // dll from http://www.pdfsharp.net/
    public class SymbolTablesPdf
    {
        const string CONFIG_FILENAME = "config.json";
        const string CONFIG_SPECIALMAPPINGS = "special_mappings";
        const string CONFIG_TRANSLATE = "translate";
        const string CONFIG_CASESENSITIVE = "case_sensitive";
        const string CONFIG_SPECIALSORT = "special_sort";
        const string CONFIG_IGNORE = "ignore";

        public EventHandler SymbolTablesCount_Changed;

        public EventHandler SymbolImagesCount_Changed;

        public EventHandler Progress_Changed;

        private String versionText = "";

        public Single BorderWidthTop { get; set; }
        public Single BorderWidthLeft { get; set; }
        public Single BorderWidthRight { get; set; }
        public Single BorderWidthBottom { get; set; }

        public int ImageSize { get; set; }


        public int HeadingDistance { get; set; }
        public int RowDistance { get; set; }
        public int ColumnDistance { get; set; }

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
                    Progress_Changed?.Invoke(this, EventArgs.Empty);
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

        private Dictionary<String, String> CONFIG_SPECIAL_CHARS = null;


        public enum LanguageEnum
        {
            de,
            en
        }

        public SymbolTablesPdf()
        {
            HeadingDistance = 10;
            RowDistance = 18;
            ColumnDistance = 10;

            BorderWidthTop = 35;
            BorderWidthLeft = 35;
            BorderWidthRight = 20;
            BorderWidthBottom = 20;
            ImageSize = 50;
            Language = LanguageEnum.de;
            FontSizeName = 20;
            FontSizeOverlay = 8;
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

        private IEnumerable<KeyValuePair<String, String>> createSymbolList(String path, String _symbolKey, String languagefile)
        {
            var list = new Dictionary<String, String>();
            var overlay = String.Empty;
            var _path = symbolTablesDirectory(path);
            _path = Path.Combine(_path, _symbolKey);

            var configFilePath = Path.Combine(_path, CONFIG_FILENAME);
            List<String> translateList = null;
            List<String> translateables = null;
            List<String> ignoreList = null;
            Dictionary<String, String> mappingList = null;
            bool caseSensitive = false;
            bool specialSort = false;

            if (File.Exists(Path.Combine(configFilePath)))
            {
                var fileContent = File.ReadAllText(configFilePath);
                translateList = parseTranslateConfig(fileContent);
                translateables = new List<String>();
                ignoreList = parseIgnoreConfig(fileContent);
                mappingList = parseMappingConfig(fileContent);
                caseSensitive = parseCaseSesitiveConfig(fileContent);
                specialSort = parseSpecialSortConfig(fileContent);

            }
            else
                mappingList = parseMappingConfig(null);


            foreach (var symbol in Directory.GetFiles(_path, "*.png"))
            {
                if (ignoreList == null || ignoreList.Count == 0 || !ignoreList.Contains(Path.GetFileNameWithoutExtension(symbol)))
                {
                    overlay = symbolOverlay(symbol, _symbolKey, languagefile, translateList, mappingList, caseSensitive, ref translateables);

                    list.Add(symbol, overlay);
                }
            }

            Comparer<object> _sort;
            if (specialSort == false)
            {
                _sort = new NameSort(translateables);
            }
            else
            {
                switch (_symbolKey)
                {
                    case "notes_names_altoclef": _sort = new specialSortNoteNames(translateables); break;
                    case "notes_names_bassclef": _sort = new specialSortNoteNames(translateables); break;
                    case "notes_names_trebleclef": _sort = new specialSortNoteNames(translateables); break;
                    case "notes_notevalues": _sort = new specialSortNoteValues(translateables); break;
                    case "notes_restvalues": _sort = new specialSortNoteValues(translateables); break;
                    case "trafficsigns_germany": _sort = new specialSortTrafficSignsGermany(translateables); break;
                    default: _sort = new NameSort(translateables); break;
                }
            }

            var listSorted = list.ToList();
            if (_sort is specialSortNoteNames || _sort is specialSortNoteValues)
                listSorted.Sort(delegate (KeyValuePair<String, String> x, KeyValuePair<String, String> y) { return _sort.Compare(x.Key, y.Key); });
            else
                listSorted.Sort(delegate (KeyValuePair<String, String> x, KeyValuePair<String, String> y) { return _sort.Compare(x.Value, y.Value); });

            return listSorted;
        }

        private List<String> parseTranslateConfig(String fileContent)
        {
            var regex = new Regex(@"(" + CONFIG_TRANSLATE + @")(.*?)(\[)(.*?)(\])", RegexOptions.Singleline | RegexOptions.IgnoreCase);
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
            var regex = new Regex(@"(" + CONFIG_SPECIALMAPPINGS + @")(.*?)(\{)(.*?)(\})", RegexOptions.Singleline | RegexOptions.IgnoreCase);
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

        private List<String> parseIgnoreConfig(String fileContent)
        {
            var regex = new Regex(@"(" + CONFIG_IGNORE + @")(.*?)(\[)(.*?)(\])", RegexOptions.Singleline | RegexOptions.IgnoreCase);
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

        private Dictionary<String, String> defaultMappingList()
        {
            if (CONFIG_SPECIAL_CHARS == null)
            {
                CONFIG_SPECIAL_CHARS = new Dictionary<String, String>();

                var path = Path.Combine(ProjectPath, @"lib\widgets\tools\symbol_tables\symbol_table_data.dart");
                if (File.Exists(path))
                {

                    try
                    {
                        var fileContent = File.ReadAllText(path);
                        var regex = new Regex(@"(CONFIG_SPECIAL_CHARS)(.*?)(\{)(.*?)(\};)", RegexOptions.Singleline | RegexOptions.IgnoreCase);
                        var regex2 = new Regex(@"\""(.*?)\""(\s*:\s*)\""(.*?)\""");
                        var regex3 = new Regex(@"\""(.*?)\""(\s*:\s*)\""(.*?)\""{2}");

                        var match = regex.Match(fileContent);
                        if (match.Success)
                        {
                            foreach (string line in match.Groups[4].Value.Split('\n'))
                            {
                                var match2 = regex2.Match(line);
                                var match3 = regex3.Match(line);
                                if (match2.Success)
                                {
                                    var value = match2.Groups[3].Value;
                                    if (match3.Success)
                                    {
                                        value += "\"";
                                        if (value.StartsWith("\\"))
                                            value = value.Substring(1);
                                    }

                                    if (value.StartsWith("\\\\") || value.StartsWith("\\$"))
                                        //if (value == "\"")
                                        //    value = "\"";
                                        //else
                                        value = value.Substring(1);

                                    CONFIG_SPECIAL_CHARS.Add(match2.Groups[1].Value, value);
                                }
                            }
                        }
                    }
                    catch (Exception)
                    {
                    }
                }
            }

            return new Dictionary<String, String>(CONFIG_SPECIAL_CHARS);
        }

        private bool parseCaseSesitiveConfig(String fileContent)
        {
            var regex = new Regex(@"(\""" + CONFIG_CASESENSITIVE + @"\""\s *:)\s(true)");
            bool value = false;

            if (fileContent != null)
            {
                var match = regex.Match(fileContent);
                value = match.Success;
            }
            return value;
        }

        private bool parseSpecialSortConfig(String fileContent)
        {
            var regex = new Regex(@"(\""" + CONFIG_SPECIALSORT + @"\""\s *:)\s(true)");
            bool value = false;

            if (fileContent != null)
            {
                var match = regex.Match(fileContent);
                value = match.Success;
            }
            return value;
        }


        private String symbolOverlay(String symbolPath, String folder, String languagefile, List<String> translateList, Dictionary<String, String> mappingList, bool caseSensitive, ref List<String> translateables)
        {
            var fileName = Path.GetFileNameWithoutExtension(symbolPath);
            var overlay = fileName;

            overlay = new Regex("(^_*|_*$)").Replace(overlay, "");


            if (mappingList != null && mappingList.ContainsKey(overlay))
                overlay = mappingList[overlay];
            else if (translateList != null && translateList.Contains(overlay))
            {
                overlay = getEntryValue(languagefile, "symboltables_" + folder + "_" + overlay);
                translateables.Add(overlay);
            }

            if (!caseSensitive)
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
            if (name == " ")
            {
                drawSpaceSymbol(offset, XColors.Blue, font, gfx);
                return offset;
            }

            // Draw the name
            name = checkTextLength(name, maxLength, font, gfx);
            if (!name.Contains(Environment.NewLine))
                gfx.DrawString(name, font, XBrushes.Blue, new XRect(offset.X, offset.Y, ImageSize, 2 * FontSizeOverlay), XStringFormats.TopLeft);
            else
            {
                var text = name.Split('\n');

                for (int i = 0; i < text.Length; i++)
                {
                    text[i] = text[i].Replace("\r", "");
                    gfx.DrawString(text[i], font, XBrushes.Blue, new XRect(offset.X, offset.Y + i * FontSizeOverlay, ImageSize, RowDistance), XStringFormats.TopLeft);
                }
            }

            return offset;
        }

        private void drawSpaceSymbol(PointF position, XColor color, XFont font, XGraphics gfx)
        {
            var size = gfx.MeasureString("M", font);
            var pen = new XPen(color, 1);

            gfx.DrawLine(pen, new XPoint(position.X, position.Y + size.Height), new XPoint(position.X + size.Width, position.Y + size.Height));
            gfx.DrawLine(pen, new XPoint(position.X, position.Y + size.Height), new XPoint(position.X, position.Y + size.Height * 0.8));
            gfx.DrawLine(pen, new XPoint(position.X + size.Width, position.Y + size.Height), new XPoint(position.X + size.Width, position.Y + size.Height * 0.8));

        }

        private string checkTextLength(string text, int maxLength, XFont font, XGraphics gfx)
        {
            text = checkPartTextLength(text, maxLength, font, gfx);

            var index = text.LastIndexOf("\n");


            if (index >= 0)
            {
                var subString = text.Substring(index);
                var size = gfx.MeasureString(subString, font);
                while (size.Width > maxLength)
                {
                    subString = checkPartTextLength(subString, maxLength, font, gfx);

                    text = text.Substring(0, index) + subString;

                    index = text.LastIndexOf("\n");
                    subString = text.Substring(index);
                    size = gfx.MeasureString(subString, font);
                }

            }

            return text;
        }

        private string checkPartTextLength(string text, int maxLength, XFont font, XGraphics gfx)
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
                    {
                        do
                        {
                            _index = text.LastIndexOf(_char, _index - 1, _index - 1);
                            if (_index > 0)
                                size = gfx.MeasureString(text.Substring(0, _index), font);

                        } while (_index > 0 & size.Width >= maxLength);
                    }
                }

                return _index;
            };

            var index = textSplit(text, ' ');
            if (index > 1)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index).Trim();

            index = textSplit(text, '/');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index).Trim();

            index = textSplit(text, ',');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index).Trim();

            index = textSplit(text, ')');
            if (index > 0)
                return text.Substring(0, index) + Environment.NewLine + text.Substring(index).Trim();

            for (index = text.Length - 1; index >= 0; index--)
            {
                size = gfx.MeasureString(text.Substring(0, index), font);
                if (size.Width <= maxLength)
                    return text.Substring(0, index) + Environment.NewLine + text.Substring(index);

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
            drawOverlay(overlay, (int)(size.Width + ColumnDistance - 2), document, ref page, ref gfx, new PointF(offset.X, (Single)(offset.Y + size.Height)));

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
                versionText = getVersionEntryValue(text, "version");
            }

            textSize = gfx.MeasureString(versionText, font);
            // Draw the version text
            gfx.DrawString(versionText, font, XBrushes.Black,
                    new XRect(page.Width - BorderWidthRight - textSize.Width, (BorderWidthTop - font.Height) / 2, page.Width, page.Height),
                    XStringFormats.TopLeft);


            // GC Wicard Icon
            MemoryStream memoryStream = new MemoryStream();
            Properties.Resources.circle_border_128.Save(memoryStream, System.Drawing.Imaging.ImageFormat.Png);
            gfx.DrawImage(XImage.FromStream(memoryStream), 5, 5, BorderWidthTop - 5, BorderWidthTop - 5);

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

        public class NameSort : Comparer<Object>
        {
            List<String> translateables;

            public NameSort(List<String> translateables)
            {
                this.translateables = translateables;
            }

            override public int Compare(Object _a, Object _b)
            {
                int intA;
                int intB;
                String keyA = _a.ToString();
                String keyB = _b.ToString();


                if (!int.TryParse(keyA, out intA))
                {
                    if (!int.TryParse(keyB, out intB))
                    {
                        if (translateables != null && translateables.Contains(keyA))
                        {
                            if (translateables.Contains(keyB))
                            {
                                return keyA.CompareTo(keyB);
                            }
                            else
                            {
                                return 1;
                            }
                        }
                        else
                        {
                            if (translateables != null && translateables.Contains(keyB))
                            {
                                return -1;
                            }
                            else
                            {
                                return lowerCase(keyA, keyB);
                            }
                        }
                    }
                    else
                        return 1;
                }
                else
                {
                    if (!int.TryParse(keyB, out intB))
                        return -1;
                    else
                        return intA.CompareTo(intB);
                }
            }

            static int lowerCase(string a, string b)
            {
                if ((a == String.Empty) | (b == String.Empty))
                    return a.CompareTo(b);

                var abytes = System.Text.Encoding.Default.GetBytes(a);
                var bbytes = System.Text.Encoding.Default.GetBytes(b);

                if (abytes[0] != bbytes[0])
                    return abytes[0].CompareTo(bbytes[0]);
                else
                    return a.CompareTo(b);


            }
        }

        public class specialSortNoteNames : Comparer<Object>
        {
            List<String> translateables;

            public specialSortNoteNames(List<String> translateables)
            {
                this.translateables = translateables;
            }

            override public int Compare(Object _a, Object _b)
            {
                var keyA = Path.GetFileNameWithoutExtension(_a.ToString()); // get filename from path without suffix
                var keyB = Path.GetFileNameWithoutExtension(_b.ToString());


                var aSplit = keyA.Split('_');
                var aMain = 0;
                int.TryParse(aSplit[0], out aMain);
                var aSign = "";
                if (aSplit.Length > 1)
                    aSign = aSplit[1];

                var bSplit = keyB.Split('_');
                var bMain = 0;
                int.TryParse(bSplit[0], out bMain);
                var bSign = "";
                if (bSplit.Length > 1)
                    bSign = bSplit[1];

                var compareSign = aSign.CompareTo(bSign);
                if (compareSign != 0)
                    return compareSign;

                return aMain.CompareTo(bMain);
            }
        }

        public class specialSortNoteValues : Comparer<Object>
        {
            List<String> translateables;

            public specialSortNoteValues(List<String> translateables)
            {
                this.translateables = translateables;
            }

            override public int Compare(Object _a, Object _b)
            {
                var keyA = Path.GetFileNameWithoutExtension(_a.ToString()); // get filename from path without suffix
                var keyB = Path.GetFileNameWithoutExtension(_b.ToString());


                var aSplit = keyA.Split('_');
                int aDotted = 0;
                int aValue = 0;
                int.TryParse(aSplit[0], out aDotted);
                if (aSplit.Length > 1)
                    int.TryParse(aSplit[1], out aValue);

                var bSplit = keyB.Split('_');
                int bDotted = 0;
                int bValue = 0;
                int.TryParse(bSplit[0], out bDotted);
                if (bSplit.Length > 1)
                    int.TryParse(bSplit[1], out bValue);

                var compareDotted = aDotted.CompareTo(bDotted);
                if (compareDotted != 0)
                    return compareDotted;

                return bValue.CompareTo(aValue);
            }
        }

        public class specialSortTrafficSignsGermany : Comparer<Object>
        {
            List<String> translateables;

            public specialSortTrafficSignsGermany(List<String> translateables)
            {
                this.translateables = translateables;
            }

            override public int Compare(Object _a, Object _b)
            {
                var keyA = _a.ToString();
                var keyB = _b.ToString();

                var aSplitDash = keyA.Split('-');
                var bSplitDash = keyB.Split('-');
                var aSplitDot = aSplitDash[0].Split('.');
                var bSplitDot = bSplitDash[0].Split('.');

                int aMain = 0;
                int.TryParse(aSplitDot[0], out aMain);
                var aDot = 0;
                if (aSplitDot.Length > 1)
                    int.TryParse(aSplitDot[1], out aDot);
                var aDash = 0;
                if (aSplitDash.Length > 1)
                    int.TryParse(aSplitDash[1], out aDash);

                var bMain = 0;
                int.TryParse(bSplitDot[0], out bMain);
                var bDot = 0;
                if (bSplitDot.Length > 1)
                    int.TryParse(bSplitDot[1], out bDot);
                var bDash = 0;
                if (bSplitDash.Length > 1)
                    int.TryParse(bSplitDash[1], out bDash);

                var compareMain = aMain.CompareTo(bMain);
                if (compareMain != 0)
                    return compareMain;

                var compareDot = aDot.CompareTo(bDot);
                if (compareDot != 0)
                    return compareDot;

                var compareDash = aDash.CompareTo(bDash);
                if (compareDash != 0)
                    return compareDash;

                return 0;
            }
        }
    }
}
