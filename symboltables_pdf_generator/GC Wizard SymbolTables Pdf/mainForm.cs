using System;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;
using PdfSharp.Pdf;

namespace GC_Wizard_SymbolTables_Pdf
{
    public partial class mainForm : Form
    {

        private Single BorderWidth { get; set; }

        private int ImageSize { get; set; }

        private SymbolTablesPdf.LanguageEnum Language { get; set; }

        private double FontSizeName { get; set; }

        private double FontSizeOverlay { get; set; }

        private bool NewPage { get; set; }

        private bool Landscape { get; set; }

        private bool ViewPdf { get; set; }

        public String CurrentProjectPath { get; set; }

        private bool OnProcess { get; set; }


        public mainForm()
        {
            InitializeComponent();
        }

        private void openProjectFolderButton_Click(object sender, EventArgs e)
        {
            if (OnProcess)
                return;

            var ofd = new FolderBrowserDialog();

            ofd.Description = "Project Folder";
            ofd.SelectedPath = CurrentProjectPath;

            if (ofd.ShowDialog() == DialogResult.OK)
            {
                CurrentProjectPath = ofd.SelectedPath;
                projectFolderTextBox.Text = CurrentProjectPath;
            }
        }

        private void startButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (OnProcess)
                    return;

                var symbolTablesPdf = new SymbolTablesPdf();
                if (!symbolTablesPdf.validFolder(CurrentProjectPath))
                    return;

                ThreadPool.QueueUserWorkItem(createPdf, CurrentProjectPath);
            }
            catch (Exception)
            {
            }
        }

        public void createPdf(object path)

        {
            try
            {
                OnProcess = true;

                var symbolTablesPdf = new SymbolTablesPdf();

                symbolTablesPdf.SymbolTablesCount_Changed += SymbolTablesCount_Changed;
                symbolTablesPdf.SymbolImagesCount_Changed += SymbolImagesCount_Changed;
                symbolTablesPdf.Progress_Changed += Progress_Changed;

                symbolTablesPdf.BorderWidthTop = 35;// BorderWidth;
                symbolTablesPdf.BorderWidthLeft = 35;// BorderWidth;
                symbolTablesPdf.BorderWidthRight = 30;// BorderWidth;
                symbolTablesPdf.BorderWidthBottom = 20;// BorderWidth;
                symbolTablesPdf.ImageSize = ImageSize;
                symbolTablesPdf.Language = Language;
                symbolTablesPdf.FontSizeName = FontSizeName;
                symbolTablesPdf.FontSizeOverlay = 7; // FontSizeOverlay;
                symbolTablesPdf.Orientation = Landscape ? PdfSharp.PageOrientation.Landscape : PdfSharp.PageOrientation.Portrait;
                symbolTablesPdf.NewPage = NewPage;

                var document = symbolTablesPdf.createPdfDocument((string)path);

                symbolTablesPdf.SymbolTablesCount_Changed -= SymbolTablesCount_Changed;
                symbolTablesPdf.SymbolImagesCount_Changed -= SymbolImagesCount_Changed;
                symbolTablesPdf.Progress_Changed -= Progress_Changed;

                OnProcess = false;
                savePdf(document);
            }
            catch (Exception ex)
            {
                OnProcess = false;
                MessageBox.Show(ex.Message, "save Pdf");
            }
        }

        private void savePdf(PdfDocument document)
        {
            try
            {
                if (this.InvokeRequired)
                    this.BeginInvoke(new Action<PdfDocument>(savePdf), new object[] { document });
                else
                {
                    var sfd = new SaveFileDialog();
                    sfd.FileName = "symboltables_" + Language + ".pdf";
                    sfd.Filter = "pdf files (*.pdf)|*.pdf|All files (*.*)|*.*";


                    if (sfd.ShowDialog() == DialogResult.OK)
                    {
                        if (SymbolTablesPdf.savePdfDocument(sfd.FileName, document))

                            if (ViewPdf)
                                // ...and start a viewer.
                                Process.Start(sfd.FileName);
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "save Pdf");
            }

        }

        void SymbolTablesCount_Changed(object sender, EventArgs e)
        {
            if (this.InvokeRequired)
                this.BeginInvoke(new Action<object, EventArgs>(SymbolTablesCount_Changed), new object[] { sender, e });
            else if (sender is SymbolTablesPdf)
                symbolTablesCount.Text = ((SymbolTablesPdf)sender).SymbolTablesCount.ToString();
        }

        void SymbolImagesCount_Changed(object sender, EventArgs e)
        {
            if (this.InvokeRequired)
                this.BeginInvoke(new Action<object, EventArgs>(SymbolImagesCount_Changed), new object[] { sender, e });
            else if (sender is SymbolTablesPdf)
                symbolTablesImageCount.Text = ((SymbolTablesPdf)sender).SymbolImagesCount.ToString();
        }

        void Progress_Changed(object sender, EventArgs e)
        {
            if (this.InvokeRequired)
                this.BeginInvoke(new Action<object, EventArgs>(Progress_Changed), new object[] { sender, e });
            else if (sender is SymbolTablesPdf)
                createProgressBar.Value = (int)((SymbolTablesPdf)sender).Progress;
        }

        private void mainForm_Shown(object sender, EventArgs e)
        {
            init();
        }

        private void mainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            saveSettings();
        }

        private void init()
        {
            foreach (var item in Enum.GetValues(typeof(SymbolTablesPdf.LanguageEnum)))
                languageComboBox.Items.Add(item);

            BorderWidth = Properties.Settings.Default.BorderWidth;
            ImageSize = Properties.Settings.Default.ImageSize;

            if (Enum.IsDefined(typeof(SymbolTablesPdf.LanguageEnum), Properties.Settings.Default.Language))
                Language = (SymbolTablesPdf.LanguageEnum)Enum.Parse(typeof(SymbolTablesPdf.LanguageEnum), Properties.Settings.Default.Language);

            FontSizeName = Properties.Settings.Default.FontSizeName;
            FontSizeOverlay = Properties.Settings.Default.FontSizeOverlay;
            NewPage = Properties.Settings.Default.NewPage;
            Landscape = Properties.Settings.Default.Landscape;
            ViewPdf = Properties.Settings.Default.ViewPdf;
            CurrentProjectPath = Properties.Settings.Default.LastPath;


            //View
            languageComboBox.Text = Language.ToString();
            imageSizeUpDown.Value = ImageSize;
            newPageCheckBox.Checked = NewPage;
            landscapeCheckBox.Checked = Landscape;
            viewPdfCheckBox.Checked = ViewPdf;
            projectFolderTextBox.Text = CurrentProjectPath;
        }

        private void saveSettings()
        {
            Properties.Settings.Default.BorderWidth = BorderWidth;
            Properties.Settings.Default.ImageSize = ImageSize;
            Properties.Settings.Default.Language = Language.ToString();
            Properties.Settings.Default.FontSizeName = FontSizeName;
            Properties.Settings.Default.FontSizeOverlay = FontSizeOverlay;
            Properties.Settings.Default.NewPage = NewPage;
            Properties.Settings.Default.Landscape = Landscape;
            Properties.Settings.Default.ViewPdf = ViewPdf;
            Properties.Settings.Default.LastPath = CurrentProjectPath;

            Properties.Settings.Default.Save();
        }

        private void languageComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            Language = (SymbolTablesPdf.LanguageEnum)languageComboBox.SelectedItem;
        }

        private void imageSizeUpDown_ValueChanged(object sender, EventArgs e)
        {
            ImageSize = (int)imageSizeUpDown.Value;
        }

        private void newPageCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            NewPage = newPageCheckBox.Checked;
        }

        private void landscapeCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            Landscape = landscapeCheckBox.Checked;
        }

        private void viewPdfCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            ViewPdf = viewPdfCheckBox.Checked;
        }


    }
}
