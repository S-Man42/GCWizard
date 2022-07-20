import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/common/base/gcw_textfield/widget/gcw_textfield.dart';
import 'package:gc_wizard/tools/common/gcw_default_output/widget/gcw_default_output.dart';

class RotN extends StatefulWidget {
  final Function rotate;

  RotN({Key key, this.rotate}) : super(key: key);

  @override
  RotNState createState() => RotNState();
}

class RotNState extends State<RotN> {
  String _output = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTextField(
          onChanged: (text) {
            setState(() {
              _output = widget.rotate(text);
            });
          },
        ),
        GCWDefaultOutput(child: _output)
      ],
    );
  }
}
