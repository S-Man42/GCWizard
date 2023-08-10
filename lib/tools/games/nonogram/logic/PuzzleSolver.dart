using System.Collections.Generic;
using System.Diagnostics;
using Picross.Helpers;
using Picross.Model;

namespace Picross.Solvers
{
    class PuzzleSolver
    {
        public enum CheckResult
        {
            Mistake, AllRightSoFar, Finished
        };
        public enum SolveResult
        {
            Cancelled, EditorModeConflict,
            NoSolutionFound, NoSolutionExists,
            MultipleSolutions, NoLogicSolution,
            UniqueOrLogicSolution
        };

        private PuzzleBoard board;
        private Stopwatch stopwatch;

        private Puzzle puzzle => board.Puzzle;
        private Puzzle backUpOriginalPuzzle => board.BackUpOriginalPuzzle;

        public PuzzleSolver(PuzzleBoard board) {
            this.board = board;
            this.stopwatch = new Stopwatch();
        }

        public CheckResult Check(bool strict) {
            bool finished = true;
            for (int y = 0; y < this.puzzle.Height; y++) {
                for (int x = 0; x < this.puzzle.Width; x++) {
                    // Mistake
                    if ((this.puzzle[x, y].IsOn() && this.backUpOriginalPuzzle[x, y] != this.puzzle[x, y]))
                        return CheckResult.Mistake;

                    // Strict mistake (filled in a blank spot while it should be filled).
                    if (strict && this.puzzle[x, y].IsOff() && this.backUpOriginalPuzzle[x, y].IsOn())
                        return CheckResult.Mistake;

                    // Not yet finished
                    if (this.puzzle[x, y].IsNotOn() && this.backUpOriginalPuzzle[x, y].IsOn())
                        finished = false;
                }
            }

            return finished ? CheckResult.Finished : CheckResult.AllRightSoFar;
        }

        public PuzzleSolverDto Solve(ThreadHelper threadHelper) {
            // Check if the original puzzle is not empty (if one accidentally started designing in play mode)
            if (!this.board.EditorMode && (this.backUpOriginalPuzzle == null || this.backUpOriginalPuzzle.IsEmpty())) {
                return new PuzzleSolverDto(SolveResult.EditorModeConflict);
            }

            // Solve or check for uniqueness
            if (this.board.EditorMode)
                return this.solveEditorMode(threadHelper);
            return this.solvePlayMode(threadHelper);
        }

        private PuzzleSolverDto solveEditorMode(ThreadHelper threadHelper) {
            var solveTimes = new List<long>();

            Puzzle solvePuzzle = this.puzzle.EmptyClone();
            if (Settings.Get.Solver.IsOneOf(Settings.SolverSetting.Smart, Settings.SolverSetting.OnlyLogic)) {
                this.stopwatch.Start();

                var logicResult = LogicalSolver.Solve(solvePuzzle, this.puzzle, threadHelper);
                this.addTimeResult(solveTimes);

                if (logicResult == SolveResult.UniqueOrLogicSolution)
                    return new PuzzleSolverDto(logicResult, solveTimes);
            }

            if (Settings.Get.Solver.IsOneOf(Settings.SolverSetting.Smart, Settings.SolverSetting.OnlyBacktracking)) {
                this.stopwatch.Start();

                var backtrackResult = Settings.Get.Solver == Settings.SolverSetting.Smart
                    ? BacktrackSolver.Solve(solvePuzzle, this.puzzle, threadHelper)
                    : BacktrackSolver.CheckUniqueness(solvePuzzle, threadHelper);

                this.addTimeResult(solveTimes);
                if (backtrackResult == SolveResult.UniqueOrLogicSolution && Settings.Get.Solver == Settings.SolverSetting.Smart)
                    return new PuzzleSolverDto(SolveResult.NoLogicSolution, solveTimes);

                return this.adjustNoSolutionResult(backtrackResult, solveTimes);
            }

            return this.adjustNoSolutionResult(SolveResult.NoSolutionFound, solveTimes);
        }

        private PuzzleSolverDto adjustNoSolutionResult(SolveResult result, List<long> solveTimes) {
            if (Settings.Get.Solver == Settings.SolverSetting.Smart && result == SolveResult.NoSolutionFound)
                return new PuzzleSolverDto(SolveResult.NoSolutionExists, solveTimes);
            return new PuzzleSolverDto(result, solveTimes);
        }

        private PuzzleSolverDto solvePlayMode(ThreadHelper threadHelper) {
            if (Settings.Get.Solver.IsOneOf(Settings.SolverSetting.Smart, Settings.SolverSetting.OnlyLogic)) {
                this.stopwatch.Start();
                var result = LogicalSolver.Solve(this.puzzle, this.backUpOriginalPuzzle, threadHelper);
                return this.timeResult(result);
            }

            if (Settings.Get.Solver == Settings.SolverSetting.OnlyBacktracking) {
                this.stopwatch.Start();
                var result = BacktrackSolver.Solve(this.puzzle, this.backUpOriginalPuzzle, threadHelper);
                return this.timeResult(result);
            }

            return new PuzzleSolverDto(SolveResult.NoSolutionFound);
        }

        private PuzzleSolverDto timeResult(SolveResult solverResult) {
            long time = this.stopwatch.ElapsedMilliseconds;
            this.stopwatch.Reset();
            return new PuzzleSolverDto(solverResult, new List<long> { time });
        }

        private void addTimeResult(List<long> stopwatchTimes) {
            stopwatchTimes.Add(this.stopwatch.ElapsedMilliseconds);
            this.stopwatch.Reset();
        }
    }

    struct PuzzleSolverDto
    {
        public PuzzleSolver.SolveResult SolveResult;
        public List<long> ElapsedMilliseconds;

        public PuzzleSolverDto(PuzzleSolver.SolveResult solveResult)
            : this(solveResult, new List<long> { 0 }) { }
        public PuzzleSolverDto(PuzzleSolver.SolveResult solveResult, List<long> elapsedMilliseconds) {
            this.SolveResult = solveResult;
            this.ElapsedMilliseconds = elapsedMilliseconds;
        }
    }
}
