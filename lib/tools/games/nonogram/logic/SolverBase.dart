using System.Collections.Generic;
using Picross.Helpers;
using Picross.Model;

    class SolverBase
    {
        protected Puzzle Puzzle;
        protected readonly List<int>[] Rows, Cols;
        protected readonly ThreadHelper ThreadHelper;

        protected SolverBase(Puzzle puzzle, Puzzle puzzleForNumbers, ThreadHelper threadHelper) {
            this.Puzzle = puzzle;
            this.ThreadHelper = threadHelper;

            puzzleForNumbers.ComputeRowAndColNumbers(out this.Rows, out this.Cols);
        }

        protected bool CheckHorizontalSoFar(int x, int y) {
            return CheckHorizontalSoFar_Mirror(x, y, this.Rows[y], false);
        }
        protected bool CheckVerticalSoFar(int x, int y) {
            return CheckHorizontalSoFar_Mirror(y, x, this.Cols[x], true);
        }

        protected bool CheckHorizontalSoFar_Mirror(int x, int y, List<int> row, bool mirror) {
            int groupSize = 0; // The number of black boxes next to each other (so far)
            int listIndex = 0; // The number of black-box-groups we have had so far

            // Check if the completed groups (untill x) are valid
            for (int i = 0; i <= x; i++) {
                // Count Black pixels (Red pixels count as Black for now)
                if (this.Puzzle[i, y, mirror].IsOn()) {
                    groupSize++;
                }
                // Check off the black pixels we've had so far
                else if (groupSize != 0) {
                    if (listIndex >= row.Count || groupSize != row[listIndex])
                        return false;
                    listIndex++;
                    groupSize = 0;
                }
            }

            // If there is an incomplete group left, check if it's (possible to make it) valid
            if (groupSize != 0) {
                if (listIndex >= row.Count || groupSize > row[listIndex])
                    return false;
            }

            // Check if we have enough left to harbor the next pixels
            int boxesStillNecessary = -groupSize - 1;
            for (int i = listIndex; i < row.Count; i++) {
                boxesStillNecessary += row[i] + 1;
            }

            if (boxesStillNecessary >= this.Puzzle.GetWidth(mirror) - x) {
                return false;
            }

            return true;
        }
    }
