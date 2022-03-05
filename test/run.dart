import 'package:test/test.dart';
import 'package:trotter/trotter.dart';

void main() {
  final bagOfItems = characters('abcde');

  group(
    "Combinations",
    () {
      final combos = Combinations(3, bagOfItems);
      /*
      for (final combo in combos()) {
        print('$combo (${combos.indexOf(combo)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            combos.length,
            BigInt.from(10),
          );
        },
      );
      test(
        ".indexOf()",
        () {
          expect(
            combos.indexOf(["a", "c", "e"]),
            BigInt.from(4),
          );
          expect(
            combos.indexOf(["e", "c", "a"]),
            BigInt.from(4),
          );
        },
      );
      test(
        ".contains()",
        () {
          expect(
            combos.contains(["a", "c", "e"]),
            true,
          );
          expect(
            combos.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );

  group(
    "Permutations",
    () {
      final perms = Permutations(3, bagOfItems);
      /*
      for (final perm in perms()) {
        print('$perm (${perms.indexOf(perm)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            perms.length,
            BigInt.from(60),
          );
        },
      );
      test(
        ".indexOf()",
        () {
          expect(
            perms.indexOf(["a", "c", "e"]),
            BigInt.from(24),
          );
          expect(
            perms.indexOf(["e", "c", "a"]),
            BigInt.from(27),
          );
        },
      );
      test(
        ".contains()",
        () {
          expect(
            perms.contains(["a", "c", "e"]),
            true,
          );
          expect(
            perms.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );

  group(
    "Compositions",
    () {
      final compos = Compositions(3, bagOfItems);
      /*
      for (final compo in compos()) {
        print('$compo (${compos.indexOf(compo)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            compos.length,
            BigInt.from(35),
          );
        },
      );
      test(
        ".indexOf()",
        () {
          expect(
            compos.indexOf(["a", "c", "e"]),
            BigInt.from(11),
          );
          expect(
            compos.indexOf(["e", "c", "a"]),
            BigInt.from(11),
          );
        },
      );
      test(
        ".contains()",
        () {
          expect(
            compos.contains(["a", "c", "e"]),
            true,
          );
          expect(
            compos.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );

  group(
    "Amalgams",
    () {
      final amals = Amalgams(3, bagOfItems);
      /*
      for (final amal in amals()) {
        print('$amal (${amals.indexOf(amal)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            amals.length,
            BigInt.from(125),
          );
        },
      );
      test(
        ".indexOf()",
        () {
          expect(
            amals.indexOf(["a", "c", "e"]),
            BigInt.from(14),
          );
          expect(
            amals.indexOf(["e", "c", "a"]),
            BigInt.from(110),
          );
        },
      );
      test(
        ".contains()",
        () {
          expect(
            amals.contains(["a", "c", "e"]),
            true,
          );
          expect(
            amals.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );

  group(
    "Subsets",
    () {
      final subs = Subsets(bagOfItems);
      /*
      for (final sub in subs()) {
        print('$sub (${subs.indexOf(sub)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            subs.length,
            BigInt.from(32),
          );
        },
      );
      test(
        ".indexOf()",
        () {
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
        },
      );
      test(
        ".contains()",
        () {
          expect(
            subs.contains(["a", "c", "e"]),
            true,
          );
          expect(
            subs.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );

  group(
    "Compounds",
    () {
      final comps = Compounds(bagOfItems);
      /*
      for (final comp in comps()) {
        print('$comp (${comps.indexOf(comp)})');
      }
      */
      test(
        ".length",
        () {
          expect(
            comps.length,
            BigInt.from(326),
          );
        },
      );
      test(
        ".indexOf()",
        () {
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
        },
      );
      test(
        ".contains()",
        () {
          expect(
            comps.contains(["a", "c", "e"]),
            true,
          );
          expect(
            comps.contains(["a", "e", "g"]),
            false,
          );
        },
      );
    },
  );
}
