// Cache to store calculated factorials.
Map<int, BigInt> factCache = {};

// Calculates `n`!
BigInt fact(int n) {
  if (factCache.containsKey(n)) {
    return factCache[n]!;
  }
  if (n < 2) {
    return BigInt.one;
  }
  return factCache[n] = BigInt.from(n) * fact(n - 1);
}

// Calculates the number of permutations of `r` items taken from `n`.
BigInt nPr(int n, int r) => fact(n) ~/ fact(n - r);

// Calculates the number of combinations of `r` items taken from `n`.
BigInt nCr(int n, int r) => nPr(n, r) ~/ fact(r);

// Returns the items in `arrangement` in the same order as they appear in `items`.
List<T> sortedArrangement<T>(List<T> arrangement, List<T> items) =>
    (List<T>.of(arrangement))
      ..sort((x, y) => items.indexOf(x).compareTo(items.indexOf(y)));

// Checks whether the items in `items` are unique.
bool isListUnique<T>(List<T> items) => items.toSet().length == items.length;

// Checks whether all items in `items` are in `universal`.
bool itemsExistInUniversal<T>(List<T> items, List<T> universal) =>
    items.every((item) => universal.contains(item));

// Gives `k`th permutation in the ordered list of permutations of items taken from `items`.
List<T> permutationWorker<T>(BigInt k, List<T> items) {
  final int n = items.length;
  if (n <= 1) {
    return items;
  }
  final BigInt biN = BigInt.from(n);
  final BigInt group = k ~/ biN;
  final BigInt mod = k % biN;
  final BigInt position =
      group % BigInt.two == BigInt.zero ? biN - mod - BigInt.one : mod;
  return permutationWorker<T>(
    group,
    items.sublist(0, n - 1),
  )..insert(position.toInt(), items[n - 1]);
}

// Gives the index of `permutation` in the ordered list of permutations of items taken from `items`.
BigInt inversePermutationWorker<T>(List<T> permutation, List<T> items) {
  if (permutation.length == 1) {
    return BigInt.zero;
  }
  final int n = items.length;
  final BigInt biN = BigInt.from(n);
  final BigInt index = BigInt.from(permutation.indexOf(items.last));
  final BigInt group = inversePermutationWorker<T>(
    permutation.where((x) => x != items.last).toList(),
    items.sublist(0, items.length - 1),
  );
  return biN * group +
      (group % BigInt.two == BigInt.zero ? biN - index - BigInt.one : index);
}

// Gives `k`th combination in the ordered list of combinations of `r` items taken from `items`.
List<T> combination<T>(BigInt kCombination, int r, List<T> items) {
  BigInt k = kCombination;
  if (r == 0) {
    return <T>[];
  }
  final int n = items.length;
  int position = 0;
  BigInt d = nCr(n - position - 1, r - 1);
  while (k >= d) {
    k -= d;
    position += 1;
    d = nCr(n - position - 1, r - 1);
  }
  final List<T> tail = items.sublist(position + 1);
  return <T>[
    items[position],
    ...combination<T>(k, r - 1, tail),
  ];
}

// Gives the index of `combination` in the ordered list of combinations of items taken from `items`.
BigInt inverseCombination<T>(List<T> combination, List<T> items) {
  BigInt helper(List<T> combination, List<T> items) {
    if (combination.isEmpty) {
      return BigInt.zero;
    }
    final int r = combination.length;
    final int n = items.length;
    int itemIndex = 0;
    BigInt k = BigInt.zero;
    while (combination[0] != items[itemIndex]) {
      k += nCr(n - itemIndex - 1, r - 1);
      itemIndex += 1;
    }
    return k +
        helper(
          combination.sublist(1),
          items.sublist(itemIndex + 1),
        );
  }

  return helper(
    sortedArrangement<T>(combination, items),
    items,
  );
}

// Gives `k`th composition in the ordered list of compositions of `r` items taken from `items`.
List<T> composition<T>(BigInt kComposition, int r, List<T> items) {
  BigInt k = kComposition;
  final int n = items.length;
  int position = 0;
  BigInt d = nCr(n + r - position - 2, r - 1);
  while (k >= d) {
    k -= d;
    position += 1;
    d = nCr(n + r - position - 2, r - 1);
  }
  if (r == 0) {
    return <T>[];
  }
  final List<T> tail = items.sublist(position);
  return <T>[
    items[position],
    ...composition<T>(k, r - 1, tail),
  ];
}

// Gives the index of `composition` in the ordered list of compositions of items taken from `items`.
BigInt inverseComposition<T>(List<T> composition, List<T> items) {
  BigInt helper(List<T> composition, List<T> items) {
    if (composition.isEmpty) {
      return BigInt.zero;
    }
    final int n = items.length;
    final int r = composition.length;
    int itemIndex = 0;
    BigInt k = BigInt.zero;
    while (composition[0] != items[itemIndex]) {
      k += nCr(n + r - itemIndex - 2, r - 1);
      itemIndex += 1;
    }
    return k +
        helper(
          composition.sublist(1),
          items.sublist(itemIndex),
        );
  }

  return helper(
    sortedArrangement<T>(composition, items),
    items,
  );
}

// Gives `k`th permutation in the ordered list of permutations of `r` items taken from `items`.
List<T> permutation<T>(BigInt kPermutation, int r, List<T> items) {
  final BigInt k = kPermutation;
  final BigInt f = fact(r);
  final BigInt group = k ~/ f;
  final BigInt item = k % f;
  final List<T> comb = combination<T>(group, r, items);
  return permutationWorker<T>(item, comb);
}

// Gives the index of `permutation` in the ordered list of permutations of items taken from `items`.
BigInt inversePermutation<T>(List<T> permutation, List<T> items) {
  final int r = permutation.length;
  if (r == 0) {
    return BigInt.zero;
  }
  final List<T> sortedPermutation = sortedArrangement<T>(permutation, items);
  final BigInt group = inverseCombination<T>(sortedPermutation, items);
  return group * fact(r) +
      inversePermutationWorker<T>(permutation, sortedPermutation);
}

// Gives `k`th amalgam in the ordered list of amalgams of `r` items taken from `items`.
List<T> amalgam<T>(BigInt kAmalgam, int r, List<T> items) {
  BigInt k = kAmalgam;
  return List<T>.generate(
    r,
    (int index) {
      final BigInt p = BigInt.from(items.length).pow(r - index - 1);
      final int position = (k ~/ p).toInt();
      k %= p;
      return items[position];
    },
  );
}

// Gives the index of `amalgam` in the ordered list of amalgams of items taken from `items`.
BigInt inverseAmalgam<T>(List<T> amalgam, List<T> items) {
  final int r = amalgam.length;
  final BigInt n = BigInt.from(items.length);
  final List<BigInt> powers = List<BigInt>.filled(
    r,
    BigInt.one,
  );
  for (int index = 1; index < powers.length; index++) {
    powers[index] = powers[index - 1] * n;
  }
  return List<BigInt>.generate(
    r,
    (int position) =>
        BigInt.from(items.indexOf(amalgam[position])) *
        powers[r - position - 1],
  ).fold<BigInt>(BigInt.zero, (a, b) => a + b);
}

// Gives `k`th subset in the ordered list of subsets of items taken from `items`.
List<T> subset<T>(BigInt kSubset, List<T> items) {
  BigInt k = adjustedIndex(kSubset, BigInt.one << items.length);
  final List<T> r = <T>[];
  for (int index = 0; index < items.length; index++) {
    if (k & (BigInt.one << index) != BigInt.zero) {
      r.add(items[index]);
    }
  }
  return r;
}

// Gives the index of `subset` in the ordered list of subsets of items taken from `items`.
BigInt inverseSubset<T>(List<T> subset, List<T> items) {
  BigInt helper(List<T> subset, List<T> items) {
    BigInt k = BigInt.zero;
    BigInt power = BigInt.one;
    for (int index = 0; index < items.length; index++) {
      if (subset.contains(items[index])) {
        k += power;
      }
      power *= BigInt.two;
    }
    return k;
  }

  return helper(
    sortedArrangement<T>(subset.toSet().toList(), items),
    items,
  );
}

// Gives `k`th compound in the ordered list of compounds of items taken from `items`.
List<T> compound<T>(BigInt kCompound, List<T> items) {
  BigInt k = kCompound;
  final int n = items.length;
  late int r;
  for (r = 0; r < n; r++) {
    final BigInt groupSize = nPr(n, r);
    if (k >= groupSize) {
      k -= groupSize;
    } else {
      break;
    }
  }
  return permutation<T>(k, r, items);
}

// Gives the index of `compound` in the ordered list of compounds of items taken from `items`.
BigInt inverseCompound<T>(List<T> compound, List<T> items) {
  BigInt k = List<BigInt>.generate(
    compound.length,
    (int r) => nPr(items.length, r),
  ).fold<BigInt>(BigInt.zero, (a, b) => a + b);
  return k += inversePermutation<T>(compound, items);
}

// Returns an index in the domain [0, n].
BigInt adjustedIndex(BigInt k, BigInt n) => k % n;
