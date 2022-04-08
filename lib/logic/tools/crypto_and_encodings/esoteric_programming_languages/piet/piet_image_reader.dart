import 'dart:core';
import 'dart:ui';

class PietImageReader
{
    List<List<int>> ReadImage(String path)
    {
        var image = Image.FromFile(path);
        return _ReadImage(image);
    }

    List<List<int>> ReadImage(Stream stream) {
        var image = Image.FromStream(stream);
        return _ReadImage(image);
    }

    List<List<int>> ReadImage(byte[] data)
    {
        var image = Image.FromStream(new MemoryStream(data));
        return _ReadImage(image);
    }

    List<List<int>> _ReadImage(Image image) {
        var bmp = new Bitmap(image);
        var step = codelSize ?? EstimateCodelSize(bmp);
        var pixels = List<int>>[]; //new int[bmp.Height / step, bmp.Width / step];

        int outY = 0;
        for (var y = 0; y < bmp.Height; y += step, outY++)
        {
            pixels.add
            var outX = 0;
            for (var x = 0; x < bmp.Width; x += step, outX++)
            {
                var pix = bmp.GetPixel(x, y);
                pixels[outY].add(_ToRgb(pix));
            }
        }

        return pixels;
    }


    int _ToRgb(Color rgb24) {
        return ((rgb24.red << 16) | (rgb24.green << 8) | rgb24.blue);
    }

    int EstimateCodelSize(Bitmap bmp) {
        // test the first row
        int count = 1;
        int minCount = 9999999999999; //int.MaxValue;

        for (var rowIndex = 0; rowIndex < bmp.Height; rowIndex++)
        {
            var prevColour = _ToRgb(bmp.GetPixel(0, rowIndex));
            for (var i = 1; i < bmp.Width; i++)
            {
                var currentColour = _ToRgb(bmp.GetPixel(i, rowIndex));
                if (currentColour == prevColour)
                    count++;
                else
                {
                    if (count < minCount)
                        minCount = count;

                    prevColour = currentColour;
                    count = 1;
                }
            }

            if (count < minCount)
                minCount = count;
        }
        return minCount;
    }

    int EstimateCodelSize(String path) {
        var image = Image.FromFile(path);
        var rgb = new Bitmap(image);

        return EstimateCodelSize(rgb);
    }
}

