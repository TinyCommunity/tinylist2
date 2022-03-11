import 'helpers.dart';

class TinyList<T> {
  late final List<T> originalItems;
  late final int? _r;
  late final BigInt _length;
  late final List<T> Function(BigInt) _operatorSubscriptRef;
  late final bool Function(List<T>) _containsRef;
  late final BigInt Function(List<T>) _indexOfRef;

  // A pseudo-list of combinations.
  //
  // A pseudo-list 'containing' all the `r`-combinations of objects taken from the list `items`.
  TinyList.combination(List<T> items, int r) {
    originalItems = List<T>.unmodifiable(items);
    _r = r;
    if (_r! < 0 || _r! > originalItems.length) {
      throw RangeError.range(_r!, 0, originalItems.length, "r");
    }
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = nCr(originalItems.length, _r!);
    _operatorSubscriptRef = (BigInt index) => combination(adjustedIndex(index, _length), _r!, originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems) && isListUnique(arrangement);
    _indexOfRef = (List<T> arrangement) => inverseCombination(arrangement, originalItems);
  }

  // A pseudo-list of permutations.
  //
  // A pseudo-list 'containing' all the `r`-permutations of objects taken from the list `items`.
  TinyList.permutation(List<T> items, int r) {
    originalItems = List<T>.unmodifiable(items);
    _r = r;
    if (_r! < 0 || _r! > originalItems.length) {
      throw RangeError.range(_r!, 0, originalItems.length, "r");
    }
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = nPr(originalItems.length, _r!);
    _operatorSubscriptRef = (BigInt index) => permutation(adjustedIndex(index, _length), _r!, originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems) && isListUnique(arrangement);
    _indexOfRef = (List<T> arrangement) => inversePermutation(arrangement, originalItems);
  }

  // A pseudo-list of compositions (combinations with repetition).
  //
  // A pseudo-list 'containing' all the `r`-compositions of objects taken from the list `items`.
  TinyList.composition(List<T> items, int r) {
    originalItems = List<T>.unmodifiable(items);
    _r = r;
    if (_r! < 0) {
      throw RangeError.range(_r!, 0, null, "r");
    }
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = nCr(originalItems.length + _r! - 1, _r!);
    _operatorSubscriptRef = (BigInt index) => composition(adjustedIndex(index, _length), _r!, originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems);
    _indexOfRef = (List<T> arrangement) => inverseComposition(arrangement, originalItems);
  }

  // A pseudo-list of amalgams (permutations with repetition).
  //
  // A pseudo-list 'containing' all the `r`-amalgams (order important, repitition allowed) of
  // objects taken from the list `items`.
  TinyList.amalgam(List<T> items, int r) {
    originalItems = List<T>.unmodifiable(items);
    _r = r;
    if (_r! < 0) {
      throw RangeError.range(_r!, 0, null, "r");
    }
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = BigInt.from(originalItems.length).pow(_r!);
    _operatorSubscriptRef = (BigInt index) => amalgam(adjustedIndex(index, _length), _r!, originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems);
    _indexOfRef = (List<T> arrangement) => inverseAmalgam(arrangement, originalItems);
  }

  // A pseudo-list of subsets.
  //
  // A pseudo-list 'containing' all the subsets of objects taken from the list `items`.
  TinyList.subset(List<T> items) {
    originalItems = List<T>.unmodifiable(items);
    _r = null;
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = BigInt.one << originalItems.length;
    _operatorSubscriptRef = (BigInt index) => subset(adjustedIndex(index, _length), originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems) && isListUnique(arrangement);
    _indexOfRef = (List<T> arrangement) => inverseSubset(arrangement, originalItems);
  }

  // A pseudo-list of compounds.
  //
  // A pseudo-list 'containing' all the compounds (permutations of unspecified length) of
  // objects taken from the list `items`.
  TinyList.compound(List<T> items) {
    originalItems = List<T>.unmodifiable(items);
    _r = null;
    if (!isListUnique(originalItems)) {
      throw ArgumentError.value(originalItems, "items", "Items are not unique.");
    }
    _length = List<BigInt>.generate(
      items.length + 1,
      (int r) => nPr(originalItems.length, r),
    ).fold<BigInt>(BigInt.zero, (a, b) => a + b);
    _operatorSubscriptRef = (BigInt index) => compound(adjustedIndex(index, _length), originalItems);
    _containsRef = (List<T> arrangement) => itemsExistInUniversal(arrangement, originalItems) && isListUnique(arrangement);
    _indexOfRef = (List<T> arrangement) => inverseCompound(arrangement, originalItems);
  }

  // The number of items taken from `items`
  int? get r => _r;

  // The number of arrangements 'contained' in this pseudo-list
  BigInt get length => _length;

  List<T> operator [](BigInt index) => _operatorSubscriptRef(index);
  // Finding whether the structure contains `arrangement`
  bool contains(List<T> arrangement) => _containsRef(arrangement);

  // Finding the index of `arrangement`
  BigInt indexOf(List<T> arrangement, [BigInt? start]) {
    start ??= BigInt.zero;
    if (contains(arrangement)) {
      final BigInt result = _indexOfRef(arrangement);
      if (result >= start) {
        return result;
      } else {
        return BigInt.from(-1);
      }
    } else {
      return BigInt.from(-1);
    }
  }

  BigInt _checkValidRange(BigInt start, BigInt? end) {
    if (BigInt.zero > start || start > _length) {
      throw RangeError("${start.toString()} is smaller than zero or larger than length.");
    }
    if (end != null) {
      if (start > end || end > _length) {
        throw RangeError("${start.toString()} is larger than ${end.toString()} or ${end.toString()} is larger than length.");
      }
      return end;
    }
    return _length;
  }

  List<List<T>> sublist(BigInt start, [BigInt? end]) => getRange(
    start,
    _checkValidRange(start, end),
  ).toList();

  Iterable<List<T>> getRange(BigInt start, BigInt end) sync* {
    _checkValidRange(start, end);
    BigInt index = start;
    do {
      yield this[adjustedIndex(index, _length)];
    } while (adjustedIndex(index += BigInt.one, _length) != adjustedIndex(end, _length));
  }
/*
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TinyList &&
          runtimeType == other.runtimeType &&
          originalItems == other.originalItems && //todo
          r == other.r &&
          length == other.length &&
          sublist(BigInt.zero, BigInt.one) == other.sublist(BigInt.zero, BigInt.one) && //todo
          sublist(length - BigInt.one) == other.sublist(other.length - BigInt.one); //todo
*/
  @override
  String toString() =>
      "Pseudo-list containing all $_length arrangements ($_r- of items from $originalItems)";
}
