import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/crosstotals.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';

class GCWCrosstotalOutput extends StatefulWidget {
  final values;
  final String text;
  final suppressSums;

  const GCWCrosstotalOutput({this.text, this.values, Key key, this.suppressSums: false}) : super(key: key);

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

    var crosstotalValues = [
      widget.suppressSums ? null : [i18n(context, 'crosstotal_count_characters'), countCharacters(values)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_count_letters'), countLetters(text)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_count_digits'), countDigits(text)],

      widget.suppressSums ? null : [i18n(context, 'crosstotal_sum'), sum(values)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_sum_alternated_back'), sumAlternatedBackward(values)],
      widget.suppressSums ? null : [i18n(context, 'crosstotal_sum_alternated_forward'), sumAlternatedForward(values)],

      [i18n(context, 'crosstotal_sum_crosssum'), sumCrossSum(values)],
      [i18n(context, 'crosstotal_sum_crosssum_iterated'), sumCrossSumIterated(values)],
      [i18n(context, 'crosstotal_sum_crosssum_alternated_back'), sumCrossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')],
      [i18n(context, 'crosstotal_sum_crosssum_alternated_forward'), sumCrossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')],

      [i18n(context, 'crosstotal_crosssum'), crossSum(values)],
      [i18n(context, 'crosstotal_crosssum_iterated'), crossSumIterated(values)],
      [i18n(context, 'crosstotal_crosssum_alternated_back'), crossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')],
      [i18n(context, 'crosstotal_crosssum_alternated_forward'), crossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')],

      widget.suppressSums ? null : [i18n(context,  'crosstotal_product'), product(values)],
      widget.suppressSums ? null : [i18n(context,  'crosstotal_product_alternated'), productAlternated(values)],

      [i18n(context, 'crosstotal_product_crosssum'), productCrossSum(values)],
      [i18n(context, 'crosstotal_product_crosssum_iterated'), productCrossSumIterated(values)],
      [i18n(context, 'crosstotal_product_crosssum_alternated_back'), productCrossSumAlternatedBackward(values) ?? i18n(context, 'common_notdefined')],
      [i18n(context, 'crosstotal_product_crosssum_alternated_forward'), productCrossSumAlternatedForward(values) ?? i18n(context, 'common_notdefined')],

      [i18n(context, 'crosstotal_crossproduct'), crossProduct(values)],
      [i18n(context, 'crosstotal_crossproduct_iterated'), crossProductIterated(values)],
      [i18n(context, 'crosstotal_crossproduct_alternated'), crossProductAlternated(values) ?? i18n(context, 'common_notdefined')],
    ];

    return Column(
      children: columnedMultiLineOutput(crosstotalValues, flexValues: [2, 1])
    );
  }
}
