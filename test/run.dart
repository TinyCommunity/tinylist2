import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  final bagOfItems = characters('abcde');

  test(
    "Combinations generates a pseudo-list",
    () {
      final combos = Combinations(3, bagOfItems);
      for (final combo in combos()) {
        print('$combo (${combos.indexOf(combo)})');
      }
      expect(
        combos.indexOf(["a", "c", "e"]),
        BigInt.from(4),
      );
      expect(
        combos.indexOf(["e", "c", "a"]),
        BigInt.from(4),
      );
    }
  );

  test(
    "Permutations generates a pseudo-list",
    () {
      final perms = Permutations(3, bagOfItems);
      for (final perm in perms()) {
        print('$perm (${perms.indexOf(perm)})');
      }
      expect(
        perms.indexOf(["a", "c", "e"]),
        BigInt.from(24),
      );
      expect(
        perms.indexOf(["e", "c", "a"]),
        BigInt.from(27),
      );
    }
  );

  test(
    "Compositions generates a pseudo-list",
    () {
      final compos = Compositions(3, bagOfItems);
      for (final compo in compos()) {
        print('$compo (${compos.indexOf(compo)})');
      }
      expect(
        compos.indexOf(["a", "c", "e"]),
        BigInt.from(11),
      );
      expect(
        compos.indexOf(["e", "c", "a"]),
        BigInt.from(11),
      );
    }
  );

  test(
    "Amalgams generates a pseudo-list",
    () {
      final amals = Amalgams(3, bagOfItems);
      for (final amal in amals()) {
        print('$amal (${amals.indexOf(amal)})');
      }
      expect(
        amals.indexOf(["a", "c", "e"]),
        BigInt.from(14),
      );
      expect(
        amals.indexOf(["e", "c", "a"]),
        BigInt.from(110),
      );
    }
  );

  test(
    "Subsets generates a pseudo-list",
    () {
      final subs = Subsets(bagOfItems);
      for (final sub in subs()) {
        print('$sub (${subs.indexOf(sub)})');
      }
      expect(
        subs.indexOf(["c"]),
        BigInt.from(4),
      );
      expect(
        subs.indexOf(["a", "c", "e"]),
        BigInt.from(21),
      );
      expect(
        subs.indexOf(["a", "b", "c", "d", "e"]),
        BigInt.from(31),
      );
    }
  );

  test(
    "Compounds generates a pseudo-list",
    () {
      final comps = Compounds(bagOfItems);
      for (final comp in comps()) {
        print('$comp (${comps.indexOf(comp)})');
      }
      expect(
        comps.indexOf(["c"]),
        BigInt.from(3),
      );
      expect(
        comps.indexOf(["a", "c", "e"]),
        BigInt.from(50),
      );
      expect(
        comps.indexOf(["a", "b", "c", "d", "e"]),
        BigInt.from(206),
      );
    }
  );
}
