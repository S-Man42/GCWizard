import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/science_and_technology/segment_display/base/painters.dart';
import 'package:touchable/touchable.dart';

const _INITIAL_SEGMENTS = <String, bool>{
  'a': false, 'b': false, 'c': false, 'd': false,
  'e': false, 'f': false, 'g': false, 'dp': false
};

class SevenSegmentDisplay extends StatefulWidget {

  Map<String, bool> segments;
  final bool readOnly;
  final Function onChanged;

  SevenSegmentDisplay({Key key, this.segments, this.readOnly: false, this.onChanged}) : super(key: key);

  @override
  SevenSegmentDisplayState createState() => SevenSegmentDisplayState();
}

class SevenSegmentDisplayState extends State<SevenSegmentDisplay> {
  Map<String, bool> _segments;

  @override
  void initState() {
    super.initState();

    if (widget.segments != null) {
      _segments = Map.from(widget.segments);
      _INITIAL_SEGMENTS.keys.forEach((segmentID) {
        if (_segments.containsKey(segmentID))
          return;

        _segments.putIfAbsent(segmentID, () => _INITIAL_SEGMENTS[segmentID]);
      });
    } else {
      _segments = Map.from(_INITIAL_SEGMENTS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row (
      children: <Widget>[
        Expanded(
          child: AspectRatio(
            aspectRatio: RELATIVE_DISPLAY_WIDTH / RELATIVE_DISPLAY_HEIGHT,
            child: CanvasTouchDetector(
              builder: (context) {
                return CustomPaint(
                  painter: SevenSegmentPainter(context, _segments, (key, value) {
                    if (widget.readOnly)
                      return;

                    setState(() {
                      _segments[key] = value;
                      widget.onChanged(_segments);
                    });
                  })
                );
              },
            )
          )
        )
      ],
    );
  }
}


