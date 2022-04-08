using System;
using System.Collections.Generic;
using System.Drawing;
using System.Text;
using PietSharp.Core.Models;

namespace PietSharp.Core
{
    public class PietNavigator
    {
        public Direction Direction { get; private set; } = Direction.East;
        public CodelChoice CodelChooser { get; private set; } = CodelChoice.Left;

        private readonly uint[,] _data;

        private const uint White = 0xFFFFFF;
        private const uint Black = 0x000000;

        private readonly int _width;
        private readonly int _height;

        public PietNavigator(uint[,] data, int maxSteps = 500000)
        {
            _data = data;
            _width = _data.GetLength(1);
            _height = _data.GetLength(0);
            _maxSteps = maxSteps;
        }

        private readonly int _maxSteps;
        public int StepCount { get; private set; } = 0;

        public Point CurrentPoint { get; private set; } =  new Point(0, 0);

        public bool TryNavigate(PietBlock block, out Point result)
        {
            if (StepCount > _maxSteps)
            {
                // todo: aborting purely on step count seems crude - detect cycles rather
                result = new Point(0, 0);
                // todo: log warning
                return false;
            }
            int failureCount = 0;

            bool moveStraight = block.Colour == White || !block.KnownColour;

            while (failureCount < 8)
            {
                var exitPoint = new Point();

                if (moveStraight) exitPoint = CurrentPoint;
                else if (Direction == Direction.East && CodelChooser == CodelChoice.Left) exitPoint = block.EastLeft;
                else if (Direction == Direction.East && CodelChooser == CodelChoice.Right) exitPoint = block.EastRight;

                else if (Direction == Direction.South && CodelChooser == CodelChoice.Left) exitPoint = block.SouthLeft;
                else if (Direction == Direction.South && CodelChooser == CodelChoice.Right) exitPoint = block.SouthRight;

                else if (Direction == Direction.West && CodelChooser == CodelChoice.Left) exitPoint = block.WestLeft;
                else if (Direction == Direction.West && CodelChooser == CodelChoice.Right) exitPoint = block.WestRight;

                else if (Direction == Direction.North && CodelChooser == CodelChoice.Left) exitPoint = block.NorthLeft;
                else if (Direction == Direction.North && CodelChooser == CodelChoice.Right) exitPoint = block.NorthRight;
                else throw new NotImplementedException();

                if (moveStraight)
                {
                    var prevStep = exitPoint;
                    while (StillInBlock(exitPoint, block))
                    {
                        prevStep = exitPoint;
                        switch (Direction)
                        {
                            case Direction.East:
                                exitPoint.X++;
                                break;
                            case Direction.South:
                                exitPoint.Y++;
                                break;
                            case Direction.West:
                                exitPoint.X--;
                                break;
                            case Direction.North:
                                exitPoint.Y--;
                                break;
                            default:
                                throw new NotImplementedException();
                        }
                    }

                    // we've crossed the boundary, one step back to be on the edge
                    exitPoint = prevStep;
                }

                Point nextStep;
                if (Direction == Direction.East) nextStep = new Point(exitPoint.X + 1, exitPoint.Y);
                else if (Direction == Direction.South) nextStep = new Point(exitPoint.X, exitPoint.Y + 1);
                else if (Direction == Direction.West) nextStep = new Point(exitPoint.X - 1, exitPoint.Y);
                else if (Direction == Direction.North) nextStep = new Point(exitPoint.X, exitPoint.Y - 1);
                else throw new ArgumentOutOfRangeException();

                bool isOutOfBounds = nextStep.X < 0 ||
                                     nextStep.Y < 0 ||
                                     nextStep.X >= _width ||
                                     nextStep.Y >= _height;

                // you're blocked if the target is a black codel or you're out of bounds
                bool isBlocked = isOutOfBounds || _data[nextStep.Y, nextStep.X] == Black;

                if (!isBlocked)
                {
                    CurrentPoint = nextStep;
                    result = nextStep;
                    StepCount++;
                    return true;
                }

                CurrentPoint = exitPoint;

                if (failureCount % 2 == 0)
                    ToggleCodelChooser(1);
                else
                    RotateDirectionPointer(1);

                failureCount++;
            }

            result = new Point(0,0);
            return false;
        }

        bool StillInBlock(Point exitPoint, PietBlock block)
        {
            return exitPoint.X >= 0 &&
                   exitPoint.Y >= 0 &&
                   exitPoint.X < _width &&
                   exitPoint.Y < _height &&
                   block.ContainsPixel(new Point(exitPoint.X, exitPoint.Y));
        }

        /// <summary>
        /// Rotates abs(turns) times. In turns is positive rotates clockwise otherwise counter clockwise
        /// </summary>
        /// <param name="turns">I</param>
        public void RotateDirectionPointer(int turns)
        {
            Direction = (Direction)((int)(Direction + turns) % 4);
        }

        public void ToggleCodelChooser(int times)
        {
            CodelChooser = (CodelChoice)((int)(CodelChooser + Math.Abs(times)) % 2);
        }

    }
}
