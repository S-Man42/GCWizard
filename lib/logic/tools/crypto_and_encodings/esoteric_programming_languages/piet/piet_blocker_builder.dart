import 'dart:core';

//import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/piet/Models/piet_block.dart';

class PietBlockerBuilder {
    // we if want to support custom colours and operations going forward
    // we'll need to allow extensions to add to this collection
    List<int> _knownColours;

    int[,] _data;
    int _width;
    int _height;

    PietBlockerBuilder(int[,] data) {
        _data = data;
        _width = _data.GetLength(1);
        _height = _data.GetLength(0);

        _knownColours =
        {
            // reds
            0xFFC0C0,
            0xFF0000,
            0xC00000,
            // yellows
            0xFFFFC0,
            0xFFFF00,
            0x0C0C000,
            // greens
            0xC0FFC0,
            0x00FF00,
            0x00C000,
            // cyans
            0xC0FFFF,
            0x00FFFF,
            0x00C0C0,
            // blues
            0xC0C0FF,
            0x0000FF,
            0x0000C0,
            // magentas
            0xFFC0FF,
            0xFF00FF,
            0xC000C0,
            // white
            0xFFFFFF,
            // black
            0X000000
        };
    }

    PietBlock GetBlockAt(int x, int y) {
        return _BuildPietBlock(x, y);
    }

    PietBlock _BuildPietBlock(int x, int y) {
        int targetColour = _data[y, x];
        var knownColour = _knownColours.Contains(targetColour);
        PietBlock block = new PietBlock(targetColour, knownColour);

        return BuildPietBlockRec(block, x, y, 0, 0);
    }

    PietBlock BuildPietBlockRec(PietBlock block, int x, int y, int xOffset, int yOffset) {
        var newX = x + xOffset;
        var newY = y + yOffset;

        if (newX < 0 || newX >= _width || newY < 0 || newY >= _height) // out of bounds
            return block;

        var currentColour = _data[newY, newX];
        if (currentColour != block.Colour) // colours don't match - you hit an edge
            return block;

        // int countBefore = block.BlockCount;
        if (!block.AddPixel(newX, newY))
            return block;

        if (yOffset != 1)
            // top
            BuildPietBlockRec(block, newX, newY, 0, -1);

        if (yOffset != -1)
            // bottom
            BuildPietBlockRec(block, newX, newY, 0, 1);

        if (xOffset != 1)
            // left
            BuildPietBlockRec(block, newX, newY, -1, 0);

        if (xOffset != -1)
            // right
            BuildPietBlockRec(block, newX, newY, 1, 0);

        return block;
    }

}

