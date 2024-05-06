import 'dart:convert';
import 'dart:math';

import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/utils/data_type_utils/object_type_utils.dart';
import 'package:gc_wizard/utils/json_utils.dart';

enum LogicPuzzleFillType { USER_FILLED, CALCULATED }

enum LogicalState {
	Ok, // no data errors
	InvalidData, // data errors
	InvalidItemData // Items data errors
}

class LogicalValue {
	LogicPuzzleFillType type;
	int? value;

	LogicalValue(this.value, this.type);
}

class _LogicalBlock {
	late List<List<LogicalValue?>> block;
	int itemsCount;

	_LogicalBlock(this.itemsCount) {
		block = List<List<LogicalValue?>>.generate(
				itemsCount, (index) => List<LogicalValue?>.generate(itemsCount, (index) => null));
	}

	int? getValue(int x, int y) {
		return block[y][x]?.value;
	}

	LogicPuzzleFillType? getFillType(int x, int y) {
		return block[y][x]?.type;
	}

	/// return valid change
	bool setValue(int x, int y, int? value, LogicPuzzleFillType type) {
		if (value== null || getValue(x, y) == null) {
			block[y][x] = value == null ? null : LogicalValue(value, type);
			return true;
		} else if (getValue(x, y) == value) {
			if (getFillType(x, y) == LogicPuzzleFillType.CALCULATED) {
				block[y][x] = LogicalValue(value, type);
			}
			return true;
		} else {
			return false;
		}
	}
}


class Logical {
	late List<List<_LogicalBlock>> blocks;
	late List<List<String>> logicalItems;
	List<_LogicalSolverSolution>? solutions;
	int categoriesCount = 4;
	int itemsCount = 5;
	LogicalState state = LogicalState.Ok;

	static const plusValue = 1;
	static const minusValue = -1;

	Logical(this.categoriesCount, this.itemsCount, {Logical? logical}) {
		categoriesCount = max(2, categoriesCount);
		itemsCount = max(2, itemsCount);

		_generateBlocks();
		_generateItems();

		if (logical != null) {
			for (var yBlock = 0; yBlock < min(logical.getMaxBlockLength(), getMaxBlockLength()); yBlock++) {
				for (var xBlock = 0; xBlock < min(logical.getBlockLength(yBlock), getBlockLength(yBlock)); xBlock++) {
					for (var y = 0; y < min(logical.itemsCount, itemsCount); y++) {
						for (var x = 0; x < min(logical.itemsCount, itemsCount); x++) {
							var value = logical.blocks[yBlock][xBlock].getValue(x, y);
							if (value != null) {
								_setBlockValue(blocks[yBlock][xBlock], x, y, value,
										type: logical.blocks[yBlock][xBlock].getFillType(x, y) ?? LogicPuzzleFillType.CALCULATED);
							}
						}
					}
				}
			}
			for (var itemBlock = 0; itemBlock < min(logical.logicalItems.length, logicalItems.length); itemBlock++) {
				for (var item = 0; item < min(logical.logicalItems[itemBlock].length, logicalItems[itemBlock].length); item++) {
					logicalItems[itemBlock][item] = logical.logicalItems[itemBlock][item];
				}
			}
		} else if (categoriesCount == 4 && itemsCount == 5) {
			logicalItems[0][0] = 'Steffi';
			logicalItems[0][1] = 'George';
			logicalItems[0][2] = 'Barack';
			logicalItems[0][3] = 'Carla';
			logicalItems[0][4] = 'Roger';

			logicalItems[1][0] = 'Cambridge';
			logicalItems[1][1] = 'Obama';
			logicalItems[1][2] = 'Graf';
			logicalItems[1][3] = 'Federer';
			logicalItems[1][4] = 'Bruni';

			logicalItems[2][0] = '1969';
			logicalItems[2][1] = '2013';
			logicalItems[2][2] = '1961';
			logicalItems[2][3] = '1967';
			logicalItems[2][4] = '1981';

			logicalItems[3][0] = 'CH';
			logicalItems[3][1] = 'UK';
			logicalItems[3][2] = 'D';
			logicalItems[3][3] = 'USA';
			logicalItems[3][4] = 'F';
		}
	}

	int getMaxLineLength() {
		return (categoriesCount - 1) * itemsCount;
	}

	int getLineLength(int line) {
		return (categoriesCount - 1 - (line / itemsCount).floor()) * itemsCount;
	}

	int getMaxBlockLength() {
		return categoriesCount - 1;
	}

	int getBlockLength(int block) {
		return categoriesCount - 1 - block;
	}

	/// map row block index to column block index
	////@block block index
	int mapRowToColumnBlockIndex(int block) {
		return block < 1 ? 0 : categoriesCount - 1 - block;
	}

	/// map column block index to row block index
	////@block block index
	int mapColumnToRowBlockIndex(int block) {
		return block < 1 ? 0 : categoriesCount - block;
	}

	int blockIndex(int line) {
		return (line / itemsCount).floor();
	}

	int blockLine(int value) {
		return value % itemsCount;
	}

	int? getValue(int x, int y) {
		if (!_validPosition(x, y)) {
			return null;
		}
		return blocks[blockIndex(y)][blockIndex(x)].getValue(blockLine(x), blockLine(y));
	}

	/// return valid change
	bool setValue(int x, int y, int? value, LogicPuzzleFillType type) {
		if (!_validPosition(x, y)) return false;
		var block = blocks[blockIndex(y)][blockIndex(x)];
		var valueTmp = block.getValue(blockLine(x), blockLine(y));
		var typeTmp = block.getFillType(blockLine(x), blockLine(y));

		var result = block.setValue(blockLine(x), blockLine(y), value, type);
		result &= _cloneValues();

		if (!result) {
			// reset changes
			setValue(x, y, valueTmp, typeTmp ?? LogicPuzzleFillType.CALCULATED);
		}
		return result;
	}

	LogicPuzzleFillType? getFillType(int x, int y) {
		if (!_validPosition(x, y)) return null;

		return blocks[blockIndex(y)][blockIndex(x)].getFillType(blockLine(x), blockLine(y));
	}

	List<List<String>> getSolution() {
		List<List<String>> solution = List<List<String>>.generate(
				itemsCount, (index) => List<String>.generate(
				categoriesCount, (index) => ''));

		for (var y = 0; y < getMaxLineLength(); y++) {
			for (var x = 0; x < getLineLength(y); x++) {
				if (getValue(x, y) == plusValue) {
					var yB = blockIndex(y);
					var yL = blockLine(y);
					var xB = blockIndex(x);
					var xL = blockLine(x);
					var ys1 = mapColumnToRowBlockIndex(xB);
					var ys2 = yB + 1;
					var xt2 = yB + 1;
					var solution1 = logicalItems[ys1][xL];
					var solution2 = logicalItems[ys2][yL];

					var tL = 0;
					while(!(solution[tL].every((element) => element == '') ||
							solution[tL][ys1] == solution1 || solution[tL][xt2] == solution2 )) {
						tL++;
						if (tL >= solution.length) {
							solution.add(List<String>.generate(categoriesCount, (index) => ''));
						}
					}

					if (tL < solution.length) {
						solution[tL][ys1] = solution1;
						solution[tL][xt2] = solution2;
					}
				}
			}
		}
		solution.removeWhere((line) => line.every((element) => element == ''));

		return solution;
	}

	void removeRelations() {
		_generateBlocks();
	}

	void removeItems() {
		_generateItems();
	}

	bool _setBlockPlusValue(int xPlus, int yPlus) {
		return __setBlockPlusValue(blocks[blockIndex(yPlus)][blockIndex(xPlus)], blockLine(xPlus), blockLine(yPlus),
				LogicPuzzleFillType.CALCULATED);
	}

	bool __setBlockPlusValue(_LogicalBlock block, int xPlus, int yPlus, LogicPuzzleFillType type) {
		var result = true;
		// row
		for (var i = 0; i < itemsCount; i++) {
			if (i == xPlus) {
				result &= block.setValue(i, yPlus, plusValue, type);
			} else {
				result &= block.setValue(i, yPlus, minusValue, LogicPuzzleFillType.CALCULATED);
			}
		}
		// column
		for (var i = 0; i < itemsCount; i++) {
			if (i == yPlus) {
				result &= block.setValue(xPlus, i, plusValue, type);
			} else {
				result &= block.setValue(xPlus, i, minusValue, LogicPuzzleFillType.CALCULATED);
			}
		}
		return result;
	}

	bool _cloneValues() {
		var result = true;

		// remove all calculated values
		for (var y = 0; y < blocks.length; y++) {
			for (var x = 0; x < blocks[y].length; x++) {
				_removeCalculatedValues(blocks[y][x]);
			}
		}

		for (var y = 0; y < getMaxLineLength(); y++) {
			for (var x = 0; x < getLineLength(y); x++) {
				var _value = getValue(x, y);
				if (_value == plusValue) {
					result &= _setBlockPlusValue(x, y);
					result &= _cloneBlocks(x, y);
				}
			}
		}
		return result;
	}

	bool _cloneBlocks(int xPlus, int yPlus) {
		var xBlockIndex = blockIndex(xPlus);
		var yBlockIndex = blockIndex(yPlus);
		var xBlockLine = blockLine(xPlus);
		var yBlockLine = blockLine(yPlus);
		var result = true;

		for (var blockRow = 0; blockRow < getBlockLength(xBlockIndex); blockRow++) {
			if (blockRow != yBlockIndex) {
				if (blockRow < yBlockIndex) {
					result &= _cloneVericalBlockValues(xBlockLine, yBlockLine,
							blocks[blockRow][xBlockIndex], blocks[blockRow][mapRowToColumnBlockIndex(yBlockIndex)], false);
				} else {
					result &= _cloneVericalBlockValues(xBlockLine, yBlockLine,
							blocks[blockRow][xBlockIndex], blocks[yBlockIndex][mapRowToColumnBlockIndex(blockRow)], true);
				}
			}
		}
		for (var blockColumn = 0; blockColumn < getBlockLength(yBlockIndex); blockColumn++) {
			if (blockColumn != xBlockIndex) {
				if (blockColumn < xBlockIndex) {
					result &= _cloneHorizontalBlockValues(xBlockLine, yBlockLine,
							blocks[mapRowToColumnBlockIndex(xBlockIndex)][blockColumn], blocks[yBlockIndex][blockColumn], false);
				} else {
					result &= _cloneHorizontalBlockValues(xBlockLine, yBlockLine,
							blocks[mapRowToColumnBlockIndex(blockColumn)][xBlockIndex], blocks[yBlockIndex][blockColumn], true);
				}
			}
		}
		return result;
	}

	bool _cloneVericalBlockValues(int xPlus, int yPlus, _LogicalBlock xBlock, _LogicalBlock yBlock, bool afterPlus) {
		var result = true;
		// copy from xBlock to yBlock (search in xPlus Column)
		for (var _y = 0; _y < itemsCount; _y++) {
			if (afterPlus) {
				// bottom from +
				result &= _checkBlockValue(xBlock, xPlus, _y, yBlock, _y, yPlus);
			} else {
				// top from +
				result &= _checkBlockValue(xBlock, xPlus, _y, yBlock, yPlus, _y);
			}
		}
		return result;
	}

	bool _cloneHorizontalBlockValues(int xPlus, int yPlus, _LogicalBlock xBlock, _LogicalBlock yBlock, bool afterPlus) {
		var result = true;
		// copy from yBlock to xBlock (search in yPlus Row)
		for (var _x = 0; _x < itemsCount; _x++) {
			if (afterPlus) {
				// right from +
				result &= _checkBlockValue(yBlock, _x, yPlus, xBlock, xPlus, _x);
			} else {
				// left from +
				result &= _checkBlockValue(yBlock, _x, yPlus, xBlock, _x, xPlus);
			}
		}
		return result;
	}

	bool _checkBlockValue(_LogicalBlock sourceBlock, int xSourceLine, int ySourceLine,
												_LogicalBlock targetBlock, int xTargetLine, int yTargetLine) {
		var _value = sourceBlock.getValue(xSourceLine, ySourceLine);
		if (_value != null) {
			return _setBlockValue(targetBlock, xTargetLine, yTargetLine, _value);
		} else {
			_value = targetBlock.getValue(xTargetLine, yTargetLine);
			if (_value != null) {
				return _setBlockValue(sourceBlock, xSourceLine, ySourceLine, _value);
			}
		}
		return true;
	}

	bool _setBlockValue(_LogicalBlock block, int xLine, int yLine, int _value,
			{LogicPuzzleFillType type = LogicPuzzleFillType.CALCULATED}) {
		if (_value == plusValue) {
			return __setBlockPlusValue(block, xLine, yLine, type);
		} else {
			return block.setValue(xLine, yLine, _value, type);
		}
	}

	void _removeCalculatedValues(_LogicalBlock block) {
		for (var x = 0; x < itemsCount; x++) {
			for (var y = 0; y < itemsCount; y++) {
				if (block.getFillType(x, y) == LogicPuzzleFillType.CALCULATED) {
					block.setValue(x, y, null, LogicPuzzleFillType.CALCULATED);
				}
			}
		}
	}

	bool _validPosition(int x, int y) {
		return !(y < 0 || y >= getMaxLineLength() || x < 0 || x >= getLineLength(y));
	}

	void _generateBlocks() {
		blocks = List<List<_LogicalBlock>>.generate(
				getMaxBlockLength(), (index) => List<_LogicalBlock>.generate(
				getBlockLength(index), (index) => _LogicalBlock(itemsCount)));
	}

	void _generateItems() {
		logicalItems = List<List<String>>.generate(
				categoriesCount, (rowIndex) => List<String>.generate(
				itemsCount, (lineIndex) => rowIndex.toString() + lineIndex.toString()));
	}


	static const String _jsonItems = 'items';
	static const String _jsonDataMinus = 'n';
	static const String _jsonDataPlus = 'p';
	static const String _jsonItemsCount = 'ni';
	static const String _jsonCategoriesCount = 'nc';

	static Logical parseJson(String jsonString) {
		var logical = Logical(2, 2);
		var jsonMap = asJsonMap(json.decode(jsonString));

		var data = jsonMap[_jsonItemsCount];
		if (getJsonType(data) == JsonType.SIMPLE_TYPE) {
			logical.itemsCount = int.tryParse(data.toString()) ?? 2;
		} else {
			logical.state = LogicalState.InvalidData;
		}

		data = jsonMap[_jsonCategoriesCount];
		if (getJsonType(data) == JsonType.SIMPLE_TYPE) {
			logical.categoriesCount = int.tryParse(data.toString()) ?? 2;
		} else {
			logical.state = LogicalState.InvalidData;
		}

		logical = Logical(logical.categoriesCount, logical.itemsCount);

		var list = asJsonArrayOrNull(jsonMap[_jsonItems]);
		if (list != null) {
			logical.logicalItems = _jsonArrayToArrayList(list);
		} else {
			logical.state = LogicalState.InvalidItemData;
		}

		logical = _jsonImportData(jsonMap[_jsonDataPlus], plusValue, logical);
		logical = _jsonImportData(jsonMap[_jsonDataMinus], minusValue, logical);

		return logical;
	}

	static Logical _jsonImportData(Object? data, int values, Logical logical) {
		var list = asJsonArrayOrNull(data);
		if (list != null) {
			for (var element in list) {
				if (element is String) {
					var entry = _jsonValueFromString(element, logical);
					if (entry != null) {
						logical.setValue(entry.x, entry.y, values, LogicPuzzleFillType.USER_FILLED);
					} else {
						logical.state = LogicalState.InvalidData;
					}
				}
			}
		}
		return logical;
	}

	static List<List<String>> _jsonArrayToArrayList(List<Object?> jsonList) {
		var list = <List<String>>[];
		for (var entrys in jsonList) {
			var subList = asJsonArrayOrNull(entrys);
			if (subList != null) {
				list.add(_jsonArrayToList(subList));
			}
		}
		return list;
	}

	static List<String> _jsonArrayToList(List<Object?> jsonList) {
		var list = <String>[];
		for (var entry in jsonList) {
			var value = toStringOrNull(entry);
			if (value != null) list.add(value);
		}
		return list;
	}

	String? toJson() {
		var jsonDataMinus = <String>[];
		var jsonDataPlus = <String>[];
		for (var y = 0; y < getMaxLineLength(); y++) {
			for (var x = 0; x < getLineLength(y); x++) {
				if (getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
					if (getValue(x, y) == minusValue) {
						jsonDataMinus.add(_jsonValueToString(x, y, this));
					} else {
						jsonDataPlus.add(_jsonValueToString(x, y, this));
					}
				}
			}
		}
		Map<String, Object> list = ({
			_jsonItems: logicalItems,
			_jsonDataMinus: jsonDataMinus,
			_jsonCategoriesCount: categoriesCount,
			_jsonItemsCount: itemsCount,
			_jsonDataPlus: jsonDataPlus
		});

		return jsonEncode(list);
	}

	static String _jsonValueToString(int x, int y, Logical logical) {
		//ToDo Check Alphabet Length
		return alphabet_AZIndexes[logical.blockIndex(x) + 1]!.toLowerCase() + logical.blockLine(x).toString() +
				alphabet_AZIndexes[logical.blockIndex(y) + 2]!.toLowerCase() + logical.blockLine(y).toString();
	}

	static Point<int>? _jsonValueFromString(String value, Logical logical) {
		//ToDo Check Alphabet Length
		return Point<int>((alphabet_AZ[value[0].toUpperCase()]! - 1) * logical.itemsCount + (int.tryParse(value[1]) ?? 0),
				(alphabet_AZ[value[2].toUpperCase()]! - 2) * logical.itemsCount + (int.tryParse(value[3]) ?? 0));
	}
}

class _LogicalSolverSolution {
	final List<List<int?>> solution;

	_LogicalSolverSolution(this.solution);

	int? getValue (int x, int y) {
		if (y < 0 || y >= solution.length || x < 0 || x >= solution[y].length) return null;
		return solution[y][x];
	}
}
