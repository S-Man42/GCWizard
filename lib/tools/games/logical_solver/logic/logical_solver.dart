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
		if (block[y][x] == null) {
			return null;
		}
		return block[y][x]?.value;
	}

	/// return valid change
	bool setValue(int x, int y, int? value, LogicPuzzleFillType type) {
		bool valueChanged = false;

		if (value != getValue(x, y) || type != getFillType(x, y)) {
			valueChanged = true;
		}

		block[y][x] = value == null ? null : LogicalValue(value, type);

		return valueChanged;
	}

	LogicPuzzleFillType? getFillType(int x, int y) {
		return (block[y][x] == null || block[y][x]!.type == LogicPuzzleFillType.CALCULATED)
				? LogicPuzzleFillType.CALCULATED
				: LogicPuzzleFillType.USER_FILLED;
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
			for (var row = 0; row < min(logical.getMaxLineLength(), getMaxLineLength()); row++) {
				for (var column = 0; column < getLineLength(row); column++) {
					if (logical.getValue(row, column) != null) {
						setValue(column, row, logical.getValue(column, row),
								logical.getFillType(column, row) ?? LogicPuzzleFillType.CALCULATED);
					}
				}
			}
			for (var itemBlock = 0; itemBlock < min(logical.logicalItems.length, logicalItems.length); itemBlock++) {
				for (var item = 0; item < min(logical.logicalItems[itemBlock].length, logicalItems[itemBlock].length); item++) {
					logicalItems[itemBlock][item] = logical.logicalItems[itemBlock][item];
				}
			}
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
	////@yBlock block index (<=0 invalid)
	int mapRowColumnBlockIndex(int block) {
		return block < 1 ? 0 : categoriesCount - 1 - block;
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
		if (!_validPosition(x, y) || !_checkPossibleValue(x, y, value)) return false;

		var result = blocks[blockIndex(y)][blockIndex(x)].setValue(blockLine(x), blockLine(y), value, type);
		_cloneValues();

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
				var _value = getValue(x, y);
				if (_value == plusValue) {
					solution[blockLine(y)][mapRowColumnBlockIndex(blockIndex(x))] =
					logicalItems[mapRowColumnBlockIndex(blockIndex(x)) + 1][blockLine(x)];
					solution[blockLine(y)][blockIndex(y) + 1] = logicalItems[blockIndex(y)][blockLine(y)];
				}
			}
		}

		solution.removeWhere((line) => line.every((element) => element == ''));

		return solution;
	}

	void _setBlockPlusValue(int xPlus, int yPlus, int? value) {
		var block = blocks[blockIndex(yPlus)][blockIndex(xPlus)];
		xPlus = blockLine(xPlus);
		yPlus = blockLine(yPlus);

		// row
		for (var i = 0; i < itemsCount; i++) {
			if (block.getFillType(i, yPlus) != LogicPuzzleFillType.USER_FILLED) {
				block.setValue(i, yPlus, i == xPlus ? plusValue : minusValue, LogicPuzzleFillType.CALCULATED);
			}
		}
		// column
		for (var i = 0; i < itemsCount; i++) {
			if (block.getFillType(xPlus, i) != LogicPuzzleFillType.USER_FILLED) {
				block.setValue(xPlus, i, i == yPlus ? plusValue : minusValue, LogicPuzzleFillType.CALCULATED);
			}
		}
	}

	void _cloneValues() {
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
					_setBlockPlusValue(x, y, _value);
					_cloneBlocks(x, y);
				}
			}
		}
	}

	void _cloneBlocks(int xPlus, int yPlus) {
		var xBlockIndex = blockIndex(xPlus);
		var yBlockIndex = blockIndex(yPlus);
		var xBlockLine = blockLine(xPlus);
		var yBlockline = blockLine(yPlus);

		for (var blockRow = 0; blockRow < getBlockLength(xBlockIndex); blockRow++) {
			if (blockRow != yBlockIndex) {
				if (blockRow < yBlockIndex) {
					_cloneVericalBlockValues(xBlockLine, yBlockline,
							blocks[blockRow][xBlockIndex], blocks[blockRow][mapRowColumnBlockIndex(yBlockIndex)], false);
				} else {
					_cloneVericalBlockValues(xBlockLine, yBlockline,
							blocks[blockRow][xBlockIndex], blocks[yBlockIndex][mapRowColumnBlockIndex(blockRow)], true);
				}
			}
		}
		for (var blockColumn = 0; blockColumn < getBlockLength(yBlockIndex); blockColumn++) {
			if (blockColumn != xBlockIndex) {
				if (blockColumn < xBlockIndex) {
					_cloneHorizontalBlockValues(xBlockLine, yBlockline,
							blocks[mapRowColumnBlockIndex(xBlockIndex)][blockColumn], blocks[yBlockIndex][blockColumn], false);
				} else {
					_cloneHorizontalBlockValues(xBlockLine, yBlockline,
							blocks[mapRowColumnBlockIndex(blockColumn)][xBlockIndex], blocks[yBlockIndex][blockColumn], true);
				}
			}
		}
	}

	void _cloneVericalBlockValues(int xPlus, int yPlus, _LogicalBlock xBlock, _LogicalBlock yBlock, bool afterPlus) {
		// copy from xBlock to yBlock (search in xPlus Column)
		for (var _y = 0; _y < itemsCount; _y++) {
			var _value = xBlock.getValue(xPlus, _y);
			if (_value != null) {
				if (afterPlus) {
					// bottom from +
					_setBlockValue(yBlock, _y, yPlus, _value);
				} else {
					// top from +
					_setBlockValue(yBlock, yPlus, _y, _value);
				}
			}
		}
	}

	void _cloneHorizontalBlockValues(int xPlus, int yPlus, _LogicalBlock xBlock, _LogicalBlock yBlock, bool afterPlus) {
		// copy from yBlock to xBlock (search in yPlus Row)
		for (var _x = 0; _x < itemsCount; _x++) {
			var _value = yBlock.getValue(_x, yPlus);
			if (_value != null) {
				if (afterPlus) {
					// right from +
					_setBlockValue(xBlock, xPlus, _x, _value);
				} else {
					// left from +
					_setBlockValue(xBlock, _x, xPlus, _value);
				}
			}
		}
	}

	void _setBlockValue(_LogicalBlock block, int xLine, int yLine, int _value) {
		if (block.getFillType(xLine, yLine) != LogicPuzzleFillType.USER_FILLED) {
			block.setValue(xLine, yLine, _value, LogicPuzzleFillType.CALCULATED);
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

	bool _checkPossibleValue(int x, int y, int? value) {
		if (value == null || value == minusValue ) return true;

		var block = blocks[blockIndex(y)][blockIndex(x)];
		x = blockLine(x);
		y = blockLine(y);

		// row
		for (var i = 0; i < itemsCount; i++) {
			if (block.getValue(i, y) == plusValue) return false;
		}
		// column
		for (var i = 0; i < itemsCount; i++) {
			if (block.getValue(x, i) == plusValue) return false;
		}

		return true;
	}

	bool _validPosition(int x, int y) {
		return !(y < 0 || y >= getMaxLineLength() || x < 0 || x >= getLineLength(y));
	}

	void removeRelations() {
		_generateBlocks();
	}

	void removeItems() {
		_generateItems();
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
