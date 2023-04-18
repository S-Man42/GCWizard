import 'dart:convert';
import 'dart:math';

import 'package:gc_wizard/tools/games/number_pyramid/logic/dennistreysa_number_pyramid_solver/pyramid.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

enum NumberPyramidFillType { USER_FILLED, CALCULATED }

class NumberPyramidBoardValue {
	NumberPyramidFillType type;
	int? value;

	NumberPyramidBoardValue(this.value, this.type);
}


class NumberPyramid {
	late List<List<NumberPyramidBoardValue?>> pyramid;
	List<_NumberPyramidSolution>? solutions;
	int rowCount = 1;

	NumberPyramid(this.rowCount, {NumberPyramid? pyramid, List<List<int?>>? pyramidList}) {
		this.pyramid = List<List<NumberPyramidBoardValue?>>.generate(
				rowCount, (index) => List<NumberPyramidBoardValue?>.generate(index + 1, (index) => null));

		if (pyramid != null) {
			for (var layer=0; layer < min(pyramid.getRowsCount(), rowCount); layer++) {
				for (var brick=0; brick < this.pyramid[layer].length; brick++) {
					if (pyramid.pyramid[layer][brick] != null) {
            this.pyramid[layer][brick] = pyramid.pyramid[layer][brick];
          }
        }
			}
		} else if (pyramidList != null) {
			for (var layer = 0; layer < min(pyramidList.length, rowCount); layer++) {
				for (var brick = 0; brick < min(pyramidList[layer].length, this.pyramid[layer].length); brick++) {
					if (pyramidList[layer][brick] != null) {
						setValue(layer, brick, pyramidList[layer][brick], NumberPyramidFillType.USER_FILLED);
          }
        }
			}
		}
	}

	int getRowsCount() {
		return rowCount;
	}

	int getColumnsCount(int row) {
		return row + 1;
	}

	int? getValue(int x, int y) {
		if (!validPosition(x, y) || pyramid[y][x] == null) {
      return null;
    }
    return pyramid[y][x]?.value;
	}

	/// return valid position
	bool setValue(int x, int y, int? value, NumberPyramidFillType type) {
		int? oldValue;
		bool valueChanged = false;
		if (!validPosition(x, y)) return false;

		oldValue = getValue(x, y);
		if (value != oldValue) {
      valueChanged = true;
    }

    pyramid[y][x] =NumberPyramidBoardValue(value, type);

		return valueChanged;
	}

	NumberPyramidFillType? getFillType(int x, int y) {
		if (!validPosition(x, y)) return null;

		return (pyramid[y][x] == null || pyramid[y][x]!.type == NumberPyramidFillType.CALCULATED)
				? NumberPyramidFillType.CALCULATED
				: NumberPyramidFillType.USER_FILLED;
	}

	bool validPosition(int x, int y) {
		return !(y < 0 || y >= pyramid.length || x < 0 || x >= pyramid[y].length);
	}

	void solvePyramid(int maxSolutions) {
		var solutions = solve(_solveableBoard(), maxSolutions: maxSolutions);
		if (solutions == null) return;

		this.solutions = solutions.map((solution) => _NumberPyramidSolution(solution)).toList();
	}

	List<List<int?>> _solveableBoard() {
		var _pyramid = <List<int?>>[];
		for (var y = 0; y < pyramid.length; y++) {
			var row = <int?>[];
			for (var x = 0; x < pyramid[y].length; x++) {
				row.add(getFillType(x, y) == NumberPyramidFillType.USER_FILLED ? getValue(x, y) : null);
			}
			_pyramid.add(row);
		}
		return _pyramid;
	}

	void removeCalculated() {
		for (var y = 0; y < pyramid.length; y++) {
			for (var x = 0; x < pyramid[y].length; x++) {
				if (getFillType(x, y) == NumberPyramidFillType.CALCULATED) setValue(x, y, null, NumberPyramidFillType.CALCULATED);
			}
		}
	}

	void mergeSolution(int solutionIndex) {
		if (solutions == null || solutionIndex < 0 || solutionIndex >= solutions!.length) return;
		for (var y = 0; y < pyramid.length; y++) {
			for (var x = 0; x < pyramid[y].length; x++) {
				if (getFillType(x, y) == NumberPyramidFillType.USER_FILLED) continue;
				setValue(x, y, solutions![solutionIndex].getValue(x, y), NumberPyramidFillType.CALCULATED);
			}
		}
	}

	String toJson() {
		var list = <String>[];
		for(var y = 0; y < pyramid.length; y++) {
			for (var x = 0; x < pyramid[y].length; x++) {
				var value = getValue(x, y);
				var type = getFillType(x, y);
				if (value != null) {
					var entryList = <String, dynamic>{'x': x, 'y': y, 'value': value};
					if (type == NumberPyramidFillType.USER_FILLED) entryList.addAll({'ud': true});
					list.add(jsonEncode(entryList));
				}
			}
		}
		var json = jsonEncode({'columns': getColumnsCount(rowCount), 'rows': rowCount, 'values': jsonEncode(list)});

		return json;
	}


	static NumberPyramid? fromJson(String text) {
		var json = asJsonMapOrNull(jsonDecode(text));
		if (json == null) return null;

		NumberPyramid pyramid;
		var rowCount = toIntOrNull(json['rows']);
		var values = toStringListOrNull(json['values']) ;
		if (rowCount == null) return null;

		pyramid = NumberPyramid(rowCount);
		if (values != null) {
			for (var jsonElement in values) {
				var element = jsonDecode(jsonElement);
				var x = toIntOrNull(element['x']);
				var y = toIntOrNull(element['y']);
				var value = toIntOrNull(element['v']);
				var ud = toBoolOrNull(element['ud']);
				if (x != null && y != null && value != null) {
					var type = (ud == true) ? NumberPyramidFillType.USER_FILLED : NumberPyramidFillType.CALCULATED;
					pyramid.setValue(y, x, value, type);
				}
			}
		}
		return pyramid;
	}
}

class _NumberPyramidSolution {
	final List<List<int?>> solution;

	_NumberPyramidSolution(this.solution);

	int? getValue (int i, int j) {
		if (i < 0 || i >= solution.length || j < 0 || j >= solution[i].length) return null;
		return solution[i][j];
	}
}
