using System.Collections.Generic;
using System.Drawing;

namespace Picross.Model
{
    class Puzzle
    {
        private Field[,] puzzle;

        public Field this[int x, int y, bool mirror = false] {
            get { return mirror ? this.puzzle[y, x] : this.puzzle[x, y]; }
            set {
                if (mirror)
                    this.puzzle[y, x] = value;
                else
                    this.puzzle[x, y] = value;
            }
        }
        public Field this[Point p, bool mirror = false] {
            get { return this[p.X, p.Y, mirror]; }
            set { this[p.X, p.Y, mirror] = value; }
        }

        public int Width => this.puzzle.GetLength(0);
        public int Height => this.puzzle.GetLength(1);
        public int GetWidth(bool mirror) => mirror ? this.Height : this.Width;
        public int GetHeight(bool mirror) => GetWidth(!mirror);

        public Point Size => new Point(this.Width, this.Height);

        public Puzzle(int width, int height) {
            this.puzzle = new Field[width, height];
        }

        public Puzzle Clone() {
            var result = this.EmptyClone();
            result.puzzle = (Field[,])this.puzzle.Clone();
            return result;
        }
        public Puzzle EmptyClone() {
            return new Puzzle(this.Width, this.Height);
        }

        public override string ToString() {
            // Save the original puzzle to string
            // Json start
            string puzzle = "[\n";
            for (int y = 0; y < this.Height; y++) {
                // Add the outer array beginning
                puzzle += "[";
                for (int x = 0; x < this.Width; x++) {
                    // Add the inner array
                    puzzle += this.puzzle[x, y].ToString();
                    if (x != this.Width - 1)
                        puzzle += ",";
                }
                // Add the outer array ending
                puzzle += "]";
                if (y != this.Height - 1)
                    puzzle += ",";
                puzzle += "\n";
            }
            // Json end
            puzzle += "]";
            return puzzle;
        }

        public static Puzzle FromString(string puzzleString) {
            // Remove whitespace, [ and ] and get the height of the puzzle on the fly
            puzzleString = puzzleString.Replace(" ", "").Replace("\n", "");
            int height = puzzleString.Length - puzzleString.Replace("],", "]").Length + 1;
            puzzleString = puzzleString.Replace("[", "").Replace("]", "");

            // Put everything in a 1D string array, and get the width of the puzzle on the fly
            string[] numbers = puzzleString.Split(',');
            int width = numbers.Length / height;

            // Create the puzzle
            Puzzle result = new Puzzle(width, height);
            int nrIndex = 0;
            for (int y = 0; y < height; y++) {
                for (int x = 0; x < width; x++) {
                    Field field = Field.Parse(numbers[nrIndex++]);
                    if (field == Field.Black || field == Field.Red)
                        result.puzzle[x, y] = field;
                }
            }
            return result;
        }

        public void Clear() {
            for (int y = 0; y < this.Height; y++) {
                for (int x = 0; x < this.Width; x++) {
                    this[x, y] = Field.Unknown;
                }
            }
        }

        public void Move(Point move) {
            Field[,] pzl = new Field[this.Width, this.Height];
            for (int y = 0; y < this.Height; y++) {
                for (int x = 0; x < this.Width; x++) {
                    Point to = new Point(x + move.X, y + move.Y);
                    if (IsInRange(to))
                        pzl[to.X, to.Y] = this[x, y];
                }
            }

            this.puzzle = pzl;
        }

        public void ChangeSize(Point size) {
            Field[,] pzl = new Field[size.X, size.Y];
            for (int y = 0; y < size.Y; y++) {
                for (int x = 0; x < size.X; x++) {
                    if (IsInRange(x, y))
                        pzl[x, y] = this[x, y];
                }
            }

            this.puzzle = pzl;
        }

        public bool IsInRange(Point p) {
            return this.IsInRange(p.X, p.Y);
        }
        public bool IsInRange(int x, int y) {
            return this.IsInRangeX(x) && this.IsInRangeY(y);
        }
        public bool IsInRangeX(int x) {
            return 0 <= x && x < this.Width;
        }
        public bool IsInRangeY(int y) {
            return 0 <= y && y < this.Height;
        }

        public void ComputeRowAndColNumbers(out List<int>[] rows, out List<int>[] cols) {
            rows = new List<int>[this.Height];
            cols = new List<int>[this.Width];
            for (int y = 0; y < this.Height; y++) {
                rows[y] = this.GetRowNumberList(y);
            }
            for (int x = 0; x < this.Width; x++) {
                cols[x] = this.GetColNumberList(x);
            }
        }

        public string GetRowNumbers(int y) {
            List<int> nrs = this.GetRowNumberList(y);
            return string.Join<int>(" ", nrs);
        }
        public string GetColNumbers(int x) {
            List<int> nrs = this.GetColNumberList(x);
            return string.Join<int>("\n", nrs);
        }

        public List<int> GetRowNumberList(int y) {
            return this.GetRowNumberList_Mirror(y, false);
        }
        public List<int> GetColNumberList(int x) {
            return this.GetRowNumberList_Mirror(x, true);
        }

        private List<int> GetRowNumberList_Mirror(int y, bool mirror) {
            // Initialize
            List<int> nrs = new List<int>();
            int counter = 0;

            // Count all numbers
            for (int x = 0; x < this.GetWidth(mirror); x++) {
                if (this[x, y, mirror].IsOn()) {
                    counter++;
                }
                else if (counter != 0) {
                    nrs.Add(counter);
                    counter = 0;
                }
            }
            if (counter != 0) {
                nrs.Add(counter);
                counter = 0;
            }
            return nrs;
        }

        public bool IsEmpty() {
            // Check if the array is an empty array
            for (int y = 0; y < this.Height; y++) {
                for (int x = 0; x < this.Width; x++) {
                    if (this.puzzle[x, y] != Field.Unknown)
                        return false;
                }
            }
            return true;
        }
    }
}
