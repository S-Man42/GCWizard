using Picross.Helpers;
using Picross.Model;

namespace Picross.Solvers
{
    class BacktrackSolver : SolverBase
    {
        private BacktrackSolver(Puzzle puzzle, Puzzle puzzleForNumbers, ThreadHelper threadHelper)
            : base(puzzle, puzzleForNumbers, threadHelper) { }

        public static PuzzleSolver.SolveResult Solve(Puzzle puzzle, Puzzle puzzleForNumbers, ThreadHelper threadHelper) {
            var solver = new BacktrackSolver(puzzle, puzzleForNumbers, threadHelper);

            int nrOfSolutions = -1;
            return solver.backTracking(0, 0, ref nrOfSolutions);
        }

        public static PuzzleSolver.SolveResult CheckUniqueness(Puzzle puzzle, ThreadHelper threadHelper) {
            BacktrackSolver solver = new BacktrackSolver(puzzle.Clone(), puzzle, threadHelper);

            int nrOfSolutions = 0;
            return solver.backTracking(0, 0, ref nrOfSolutions);
        }

        private PuzzleSolver.SolveResult backTracking(int x, int y, ref int uniqueness) {
            // Termination criterium
            if (this.ThreadHelper.Cancelling)
                return PuzzleSolver.SolveResult.Cancelled;
            if (uniqueness > 1)
                return PuzzleSolver.SolveResult.MultipleSolutions;
            if (y == this.Puzzle.Height || y == -1) {
                if (uniqueness == -1)   // Don't check on uniqeness, so we can return.
                    return PuzzleSolver.SolveResult.UniqueOrLogicSolution;
                uniqueness++;
                return PuzzleSolver.SolveResult.NoSolutionFound; // Don't return true right now, as we want to continue searching.
            }

            // Try all values
            this.Puzzle[x, y] = Field.Black;
            if (CheckXYSoFar(x, y)) {
                var result = backTracking(nextX(x), nextY(x, y), ref uniqueness);
                if (result.IsOneOf(PuzzleSolver.SolveResult.UniqueOrLogicSolution, PuzzleSolver.SolveResult.Cancelled))
                    return result;
            }
            this.Puzzle[x, y] = Field.Empty;
            if (CheckXYSoFar(x, y)) {
                var result = backTracking(nextX(x), nextY(x, y), ref uniqueness);
                if (result.IsOneOf(PuzzleSolver.SolveResult.UniqueOrLogicSolution, PuzzleSolver.SolveResult.Cancelled))
                    return result;
            }

            // None of the values worked, so start backtracking (unless you are back at the root and have a unique solution).
            if (x == 0 && y == 0 && uniqueness == 1)
                return PuzzleSolver.SolveResult.UniqueOrLogicSolution;
            return PuzzleSolver.SolveResult.NoSolutionFound;
        }

        private int nextX(int x) {
            return ++x == this.Puzzle.Width ? 0 : x;
        }
        private int nextY(int x, int y) {
            return x == this.Puzzle.Width - 1 ? y + 1 : y;
        }

        private bool CheckXYSoFar(int x, int y) {
            // Check whether or not the puzzle up untill (x, y) is valid, and can be made valid for the fields after (x, y).
            return CheckHorizontalSoFar(x, y) && CheckVerticalSoFar(x, y);
        }
    }
}
