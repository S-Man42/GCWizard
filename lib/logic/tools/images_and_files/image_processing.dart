class RGBPixel {
  int red;
  int green;
  int blue;

  RGBPixel(this.red, this.green, this.blue);

  @override
  String toString() {
    return 'RGB(${this.red}, ${this.green}, ${this.blue})';
  }
}

// https://www.dfstudios.co.uk/articles/programming/image-programming-algorithms/
RGBPixel contrast(RGBPixel pxl, int contrast) {
  final double factor = 259 * (contrast + 255) / 255 / (259 - contrast);
  pxl.red = (factor * (pxl.red - 128) + 128).clamp(0, 255).toInt();
  pxl.green = (factor * (pxl.green - 128) + 128).clamp(0, 255).toInt();
  pxl.blue = (factor * (pxl.blue - 128) + 128).clamp(0, 255).toInt();

  return pxl;
}

RGBPixel brightness(RGBPixel pxl, int saturation) {
  pxl.red = (pxl.red + saturation).clamp(0, 255);
  pxl.green = (pxl.green + saturation).clamp(0, 255);
  pxl.blue = (pxl.blue + saturation).clamp(0, 255);

  return pxl;
}

RGBPixel grayscale(RGBPixel pxl) {
  var value = 0.299 * pxl.red + 0.587 * pxl.green + 0.114 * pxl.blue;

  pxl.red = value.toInt().clamp(0, 255);
  pxl.green = value.toInt().clamp(0, 255);
  pxl.blue = value.toInt().clamp(0, 255);

  return pxl;
}

RGBPixel invert(RGBPixel pxl) {
  pxl.red = 255 - pxl.red;
  pxl.green = 255 - pxl.green;
  pxl.blue = 255 - pxl.blue;

  return pxl;
}


