import 'dart:math';

enum LogicPuzzleFillType { USER_FILLED, CALCULATED }


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

	static const plusValue = 1;
	static const minusValue = -1;

	Logical(this.categoriesCount, this.itemsCount, {Logical? logical}) {
		categoriesCount = max(2, categoriesCount);
		itemsCount = max(2, itemsCount);

		_generateBlocks();
		_generateItems();

		if (logical != null) {
			for (var row = 0; row < min(logical.getRowsCount(), getRowsCount()); row++) {
				for (var column = 0; column < getColumnsCount(row); column++) {
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

	int getRowsCount() {
	 	return (categoriesCount - 1) * itemsCount;
	}

	int getColumnsCount(int y) {
		return (categoriesCount - 1 - (y / itemsCount).floor()) * itemsCount;
	}

	int getBlockRowsCount() {
		return categoriesCount - 1;
	}

	int getBlockColumnsCount(int y) {
		return categoriesCount - y - 1;
	}

	int? getValue(int x, int y) {
		if (!validPosition(x, y)) {
			return null;
		}

		return blocks[blockIndex(y)][blockIndex(x)].getValue(blockItem(x), blockItem(y));
	}

	/// return valid change
	bool setValue(int x, int y, int? value, LogicPuzzleFillType type) {
		if (!validPosition(x, y) || !_checkPossibleValue(x, y, value)) return false;

		var oldValue = getValue(x, y);

		var result = blocks[blockIndex(y)][blockIndex(x)].setValue(blockItem(x), blockItem(y), value, type);
		_cloneValues();
		// if ((value == null && oldValue == plusValue) || (value == plusValue && oldValue == null)) {
		// 	_setBlockPlusValue(x, y, value);
		// 	return result;
		// }
		return result;
	}

	void _setBlockPlusValue(int x, int y, int? value) {
		var block = blocks[blockIndex(y)][blockIndex(x)];
		x = blockItem(x);
		y = blockItem(y);

		// row
		for (var i = 0; i < itemsCount; i++) {
			if (block.getFillType(i, y) != LogicPuzzleFillType.USER_FILLED) {
				block.setValue(i, y, i == x ? plusValue : minusValue, LogicPuzzleFillType.CALCULATED);
			}
		}
		// column
		for (var i = 0; i < itemsCount; i++) {
			if (block.getFillType(x, i) != LogicPuzzleFillType.USER_FILLED) {
				block.setValue(x, i, i == y ? plusValue : minusValue, LogicPuzzleFillType.CALCULATED);
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

		for (var y = 0; y < getRowsCount(); y++) {
			for (var x = 0; x < getColumnsCount(y); x++) {
				var _value = getValue(x, y);
				if (_value == plusValue) {
					_setBlockPlusValue(x, y, _value);
					_cloneBlocks(x, y);
				}
				// if (value != null || block.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
				// 	block.setValue(i, y, value == null ? null : i == x ? plusValue : minusValue, LogicPuzzleFillType.USER_FILLED);
				// }
			}
		}
		// // column
		// for (var i = 0; i < itemsCount; i++) {
		// 	if (value != null || block.getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) {
		// 		block.setValue(x, i, value == null ? null : i == y ? plusValue : minusValue, LogicPuzzleFillType.USER_FILLED);
		// 	}
		// }
	}

	void _cloneBlocks(int x, int y) {
		var xBlockIndex = blockIndex(x);
		var yBlockIndex = blockIndex(y);
		var xBlockItem = blockItem(x);
		var yBlockItem = blockItem(y);

		for (var row = 0; row < getBlockColumnsCount(xBlockIndex); row++) {
			if (row != yBlockIndex && mapRowColumBlockIndex(yBlockIndex) < blocks[yBlockIndex].length) { //??
				_cloneBlockValues(xBlockItem, yBlockItem,
						blocks[row][xBlockIndex], blocks[yBlockIndex][mapRowColumBlockIndex(row)]);
			}
		}
		for (var column = 0; column < getBlockColumnsCount(yBlockIndex); column++) {
			if (column != xBlockIndex && mapRowColumBlockIndex(xBlockIndex) < blocks.length) { //??
				_cloneBlockValues(xBlockItem, yBlockItem,
						blocks[yBlockIndex][column], blocks[mapRowColumBlockIndex(column)][yBlockIndex]);
			}
		}
	}

	void _cloneBlockValues(int x, int y, _LogicalBlock xBlock, _LogicalBlock yBlock) {
		for (var _y = 0; _y < itemsCount; _y++) {
			var _value = xBlock.getValue(x, _y);
			if (_value != null && yBlock.getFillType(_y, y) != LogicPuzzleFillType.USER_FILLED) {
				yBlock.setValue(_y, y, _value, LogicPuzzleFillType.CALCULATED);
			}
		}

		for (var _x = 0; _x < itemsCount; _x++) {
			var _value = yBlock.getValue(_x, y);
			if (_value != null && xBlock.getFillType(x, _x) != LogicPuzzleFillType.USER_FILLED) {
				xBlock.setValue(x, _x, _value, LogicPuzzleFillType.CALCULATED);
			}
		}
	}

	int mapRowColumBlockIndex(int value) {
		return  categoriesCount - value - 2;
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
		x = blockItem(x);
		y = blockItem(y);

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

	int blockIndex(int value) {
		return (value / itemsCount).floor();
	}

	int blockItem(int value) {
		return value % itemsCount;
	}

	LogicPuzzleFillType? getFillType(int x, int y) {
		if (!validPosition(x, y)) return null;

		return blocks[blockIndex(y)][blockIndex(x)].getFillType(blockItem(x), blockItem(y));
	}

	bool validPosition(int x, int y) {
		return !(y < 0 || y >= getRowsCount() || x < 0 || x >= getColumnsCount(y));
	}

	void removeRelations() {
		_generateBlocks();
	}

	void removeItems() {
		_generateItems();
	}

	void _generateBlocks() {
		blocks = List<List<_LogicalBlock>>.generate(
				getBlockRowsCount(), (index) => List<_LogicalBlock>.generate(
				getBlockColumnsCount(index), (index) => _LogicalBlock(itemsCount)));
	}

	void _generateItems() {
		logicalItems = List<List<String>>.generate(
				categoriesCount, (index) => List<String>.generate(
				itemsCount, (index) => 'ybcdhjhhh jhjhjMB'));
	}

	void mergeSolution(int solutionIndex) {
		if (solutions == null || solutionIndex < 0 || solutionIndex >= solutions!.length) return;
		for (var y = 0; y < blocks.length; y++) {
			for (var x = 0; x < blocks[y].length; x++) {
				if (getFillType(x, y) == LogicPuzzleFillType.USER_FILLED) continue;
				setValue(x, y, solutions![solutionIndex].getValue(x, y), LogicPuzzleFillType.CALCULATED);
			}
		}
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
