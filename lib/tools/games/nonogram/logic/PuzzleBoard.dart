using System.Drawing;
using Picross.Solvers;
using Picross.UI;

namespace Picross.Model
{
    class PuzzleBoard
    {
        private bool editorMode;

        public PuzzlePainter Painter { get; private set; }
        public PuzzleSolver Solver { get; private set; }

        public Puzzle Puzzle { get; private set; }
        public Puzzle BackUpOriginalPuzzle { get; private set; }

        public bool EditorMode {
            get { return this.editorMode; }
            set {
                if (this.editorMode == value)
                    return;

                this.editorMode = value;

                if (value) {
                    if (this.BackUpOriginalPuzzle != null && !this.BackUpOriginalPuzzle.IsEmpty())
                        this.Puzzle = this.BackUpOriginalPuzzle;
                    this.BackUpOriginalPuzzle = null;
                }
                else {
                    this.BackUpOriginalPuzzle = this.Puzzle;
                    this.Puzzle = new Puzzle(this.BackUpOriginalPuzzle.Width, this.BackUpOriginalPuzzle.Height);
                }
            }
        }

        public Point PuzzleSize => this.Puzzle.Size;

        // Methods for communication with the outside world
        public PuzzleBoard(int w, int h, bool editormode)
                : this(new Puzzle(w, h), editormode) { }
        public PuzzleBoard(Puzzle puzzle, bool editormode) {
            this.Puzzle = puzzle;
            this.BackUpOriginalPuzzle = null;
            this.Painter = new PuzzlePainter(this);
            this.Solver = new PuzzleSolver(this);
            this.EditorMode = editormode; // This may override the backup puzzle
        }

        public void MouseClick(Point mouse, Field value) {
            Point p = this.Mouse2Point(mouse, this.Painter.CalculateSquareSize());
            doMouseClick(p, value);
        }
        public void MouseClick(Point oldMouse, Point newMouse, Field value) {
            Point from = this.Mouse2Point(oldMouse, this.Painter.CalculateSquareSize());
            Point to = this.Mouse2Point(newMouse, this.Painter.CalculateSquareSize());
            if (from.Y == to.Y) {
                while (to.X != from.X) {
                    doMouseClick(to, value);
                    to.X += (to.X < from.X) ? 1 : -1;
                }
            }
            else if (from.X == to.X) {
                while (to.Y != from.Y) {
                    doMouseClick(to, value);
                    to.Y += (to.Y < from.Y) ? 1 : -1;
                }
            }
            else {
                doMouseClick(to, value);
            }
        }

        public static PuzzleBoard FromString(string puzzleString) {
            Puzzle puzzle = Puzzle.FromString(puzzleString);

            return new PuzzleBoard(puzzle, true);
        }

        public int MouseMoved(Point lastMouse, Point nextMouse) {
            // 0: not moved
            // 1: moved horizontally
            // 2: moved vertically
            // 3: moved both
            if (lastMouse.X == nextMouse.X && lastMouse.Y == nextMouse.Y)
                return 0;
            // Check if both mouse coordinates map to the same point, if not, the mouse moved significantly.
            int squareSize = this.Painter.CalculateSquareSize();
            Point a = this.Mouse2Point(lastMouse, squareSize);
            Point b = this.Mouse2Point(nextMouse, squareSize);
            // Figure out how they moved
            if (a.X == b.X) {
                if (a.Y == b.Y)
                    return 0;
                return 2;
            }
            else {
                if (a.Y == b.Y)
                    return 1;
                return 3;
            }
        }

        public void Clear() {
            this.Puzzle.Clear();
        }

        public void ChangeSize(Point size) {
            this.Puzzle.ChangeSize(size);
        }

        public void Move(Point move) {
            this.Puzzle.Move(move);
        }

        public override string ToString() {
            return (this.BackUpOriginalPuzzle ?? this.Puzzle).ToString();
        }

        // Helper methods
        public Point Mouse2Point(Point mouse, int squareSize) {
            // Get the array index corresponding to the mouse coordinate
            return Mouse2Point(mouse, squareSize, this.Painter);
        }
        public static Point Mouse2Point(Point mouse, int squareSize, PuzzlePainter painter) {
            // Get the array index corresponding to the mouse coordinate
            int numeratorX = mouse.X - painter.Offset.X - painter.InnerOffset.X;
            int numeratorY = mouse.Y - painter.Offset.Y - painter.InnerOffset.Y;
            if (numeratorX < 0)
                numeratorX -= squareSize;
            if (numeratorY < 0)
                numeratorY -= squareSize;
            return new Point(numeratorX / squareSize, numeratorY / squareSize);
        }

        private void doMouseClick(Point p, Field value) {
            // Set the puzzle value at point p
            if (this.Puzzle.IsInRange(p)) {
                if (this.Puzzle[p] == value)
                    this.Puzzle[p] = Field.Unknown;
                else
                    this.Puzzle[p] = value;
            }

            // Or autoblank all columns
            else if (Settings.Get.UseAutoBlanker && !this.EditorMode) {
                if (this.Puzzle.IsInRangeX(p.X)) {
                    bool[] autoblanks = AutoBlanker.GetCol(this.Puzzle, this.BackUpOriginalPuzzle, p.X);
                    for (int y = 0; y < autoblanks.Length; y++)
                        if (autoblanks[y])
                            this.Puzzle[p.X, y] = Field.Empty;
                }
                else if (this.Puzzle.IsInRangeY(p.Y)) {
                    bool[] autoblanks = AutoBlanker.GetRow(this.Puzzle, this.BackUpOriginalPuzzle, p.Y);
                    for (int x = 0; x < autoblanks.Length; x++)
                        if (autoblanks[x])
                            this.Puzzle[x, p.Y] = Field.Empty;
                }
            }
        }
    }
}
