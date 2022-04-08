import 'dart:html';

class PietBlock
{
    int _Colour = 0;
    int get Colour => _Colour;
    bool _KnownColour = false;
    bool get KnownColour => _KnownColour;

    List<Point> _pixels;

    PietBlock(int colour, bool knownColour) {
        _Colour = colour;
        _KnownColour = knownColour;
        _pixels = <Point>[];
    }

    int get BlockCount => _pixels.length;

    bool AddPixel(int x, int y) {
        if (_pixels.contains(Point(x, y))) return false;

        _pixels.add(Point(x, y));
    }

    bool ContainsPixel(Point point) {
        return _pixels.contains(point);
    }

    Point get NorthLeft => _pixels.sort((a, b) => a.X > b.x); //.orderBy(p => p.Y).ThenBy(p => p.X).First();

    Point get NorthRight  => _pixels.OrderBy(p => p.Y).ThenByDescending(p => p.X).First();

    Point get EastLeft  => _pixels.OrderByDescending(p => p.X).ThenBy(p => p.Y).First();

    Point get EastRight => _pixels.OrderByDescending(p => p.X).ThenByDescending(p => p.Y).First();

    Point get SouthLeft => _pixels.OrderByDescending(p => p.Y).ThenByDescending(p => p.X).First();

    Point get SouthRight => _pixels.OrderByDescending(p => p.Y).ThenBy(p => p.X).First();

    Point get WestLeft  => _pixels.OrderBy(p => p.X).ThenByDescending(p => p.Y).First();

    Point get WestRight => _pixels.OrderBy(p => p.X).ThenBy(p => p.Y).First();
}

