import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_datetime_picker.dart';

class SunRiseSet extends StatefulWidget {
  @override
  SunRiseSetState createState() => SunRiseSetState();
}

class SunRiseSetState extends State<SunRiseSet> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Expanded(
              child: GCWDateTimePicker(
                type: DateTimePickerType.DATETIME,
                withTimezones: true,
              )
            )
          ],
        ),
        GCWDefaultOutput(
          text: _buildOutput()
        )
      ],
    );
  }

  _buildOutput() {
    return 'Test';
  }
}