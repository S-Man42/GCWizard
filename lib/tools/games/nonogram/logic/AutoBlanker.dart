using Picross.Model;

namespace Picross.Solvers
{
    class AutoBlanker : LogicalSolver
    {
        private AutoBlanker(Puzzle puzzleForNumbers)
            : base(null, puzzleForNumbers, null) { }

        public static bool[] GetRow(Puzzle puzzle, Puzzle puzzleForNumbers, int y) {
            var solver = new AutoBlanker(puzzleForNumbers);

            var result = solver.GetRow(puzzle, null, Field.Black, y);
            return result.Result;
        }

        public static bool[] GetCol(Puzzle puzzle, Puzzle puzzleForNumbers, int x) {
            var solver = new AutoBlanker(puzzleForNumbers);

            var result = solver.GetCol(puzzle, null, Field.Black, x);
            return result.Result;
        }
    }
}