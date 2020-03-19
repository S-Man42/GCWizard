import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/utils/crosstotals.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWCrosstotalOutput extends StatefulWidget {
  final values;
  final String text;

  const GCWCrosstotalOutput(this.text, this.values, {Key key}) : super(key: key);

  @override
  _GCWCrosstotalOutputState createState() => _GCWCrosstotalOutputState();
}

class _GCWCrosstotalOutputState extends State<GCWCrosstotalOutput> {

  @override
  Widget build(BuildContext context) {
    return Column (
        children: <Widget>[
          Container(
            height: 30
          ),
          _buildCrosstotalContent(context)
        ]
    );
  }

  Widget _buildCrosstotalContent(BuildContext context) {
    var text = widget.text;
    List<int> values = List.from(widget.values);

    var crosstotalValues = {
      'crosstotal_count_characters' : countCharacters(text),
      'crosstotal_count_letters' : countLetters(text),
      'crosstotal_count_digits' : countDigits(text),

      'crosstotal_sum' : sum(values),
      'crosstotal_sum_alternated_back' : sumAlternatedBackward(values),
      'crosstotal_sum_alternated_forward' : sumAlternatedForward(values),

      'crosstotal_crosssum' : crossSum(values),
      'crosstotal_crosssum_iterated' : crossSumIterated(values),
      'crosstotal_crosssum_alternated_back' : crossSumAlternatedBackward(values),
      'crosstotal_crosssum_alternated_forward' : crossSumAlternatedForward(values),
      
      'crosstotal_sum_crosssum' : sumCrossSum(values),
      'crosstotal_sum_crosssum_iterated' : sumCrossSumIterated(values),
      'crosstotal_sum_crosssum_alternated_back' : sumCrossSumAlternatedBackward(values),
      'crosstotal_sum_crosssum_alternated_forward' : sumCrossSumAlternatedForward(values),

      'crosstotal_product' : product(values),
      'crosstotal_product_alternated' : productAlternated(values),

      'crosstotal_product_crosssum' : productCrossSum(values),
      'crosstotal_product_crosssum_iterated' : productCrossSumIterated(values),
      'crosstotal_product_crosssum_alternated_back' : productCrossSumAlternatedBackward(values),
      'crosstotal_product_crosssum_alternated_forward' : productCrossSumAlternatedForward(values),

      'crosstotal_crossproduct' : crossProduct(values),
      'crosstotal_crossproduct_iterated' : crossProductIterated(values),
      'crosstotal_crossprocut_alternated' : crossProductAlternated(values),
    };

    return Column(
      children: twoColumnMultiLineOutput(context, crosstotalValues, flexLeft: 2, flexRight: 1)
    );
  }
}
