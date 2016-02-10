part of trotter;

/** A pseudolist of subsets.
 * 
 * A pseudo-list "containing" all the subsets of objects taken from
 * the list `elements`.
 * 
 * _Example_
 *
 * ```
 * var sub = new Subsets(characters("abcd"));
 * print("There are ${sub.length} subsets of the objects");
 * print("in ${sub.items}.");
 * print("The first subset is ${sub[0]}.");
 * ```
 * 
 */

class Subsets extends _Combinatorics {
  Subsets(List items) {
    if (!_itemsAreUnique(items)) throw new Exception("Items are not unique.");

    _items = new List.from(items);
    _length = 1 << items.length;
  }

  @override List operator [](int k) =>
      _subset(_adjustedIndex(k, length), items);

  /// Returns the index of [subset] in the list of arranged subsets.
  int indexOf(List subset) =>
      contains(subset) ? _inverseSubset(subset, _items) : -1;

  /// returns whether [x] is in the pseudo-list.
  bool contains(List x) =>
      _itemsExistInUniversal(x, _items) && _itemsAreUnique(x);

  @override String toString() =>
      "Pseudo-list containing all $length subsets of items from $items.";
}
