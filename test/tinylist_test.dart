import 'package:test/test.dart';
import 'package:tinylist2/tinylist2.dart';

void main() {
  final List<String> bagOfItems = <String>["a", "b", "c", "d", "e"];

  group(
    "TinyList.combination()",
    () {
      final TinyList<String> combos = TinyList.combination(bagOfItems, 3);
      /*
      for (final combo in combos.getRange(BigInt.zero, combos.length)) {
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
      test(
        "[]",
        () {
          expect(
            combos[BigInt.from(4)],
            ["a", "c", "e"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            combos.sublist(BigInt.from(4), BigInt.from(5)),
            [["a", "c", "e"]],
          );
        },
      );
    },
  );

  group(
    "TinyList.permutation()",
    () {
      final TinyList<String> perms = TinyList.permutation(bagOfItems, 3);
      /*
      for (final perm in perms.getRange(BigInt.zero, perms.length)) {
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
      test(
        "[]",
        () {
          expect(
            perms[BigInt.from(24)],
            ["a", "c", "e"],
          );
          expect(
            perms[BigInt.from(27)],
            ["e", "c", "a"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            perms.sublist(BigInt.from(24), BigInt.from(25)),
            [["a", "c", "e"]],
          );
          expect(
            perms.sublist(BigInt.from(27), BigInt.from(28)),
            [["e", "c", "a"]],
          );
        },
      );
    },
  );

  group(
    "TinyList.composition()",
    () {
      final TinyList<String> compos = TinyList.composition(bagOfItems, 3);
      /*
      for (final compo in compos.getRange(BigInt.zero, compos.length)) {
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
      test(
        "[]",
        () {
          expect(
            compos[BigInt.from(11)],
            ["a", "c", "e"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            compos.sublist(BigInt.from(11), BigInt.from(12)),
            [["a", "c", "e"]],
          );
        },
      );
    },
  );

  group(
    "TinyList.amalgam()",
    () {
      final TinyList<String> amals = TinyList.amalgam(bagOfItems, 3);
      /*
      for (final amal in amals.getRange(BigInt.zero, amals.length)) {
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
      test(
        "[]",
        () {
          expect(
            amals[BigInt.from(14)],
            ["a", "c", "e"],
          );
          expect(
            amals[BigInt.from(110)],
            ["e", "c", "a"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            amals.sublist(BigInt.from(14), BigInt.from(15)),
            [["a", "c", "e"]],
          );
          expect(
            amals.sublist(BigInt.from(110), BigInt.from(111)),
            [["e", "c", "a"]],
          );
        },
      );
    },
  );

  group(
    "TinyList.subset()",
    () {
      final TinyList<String> subs = TinyList.subset(bagOfItems);
      /*
      for (final sub in subs.getRange(BigInt.zero, subs.length)) {
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
      test(
        "[]",
        () {
          expect(
            subs[BigInt.from(4)],
            ["c"],
          );
          expect(
            subs[BigInt.from(21)],
            ["a", "c", "e"],
          );
          expect(
            subs[BigInt.from(31)],
            ["a", "b", "c", "d", "e"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            subs.sublist(BigInt.from(4), BigInt.from(5)),
            [["c"]],
          );
          expect(
            subs.sublist(BigInt.from(21), BigInt.from(22)),
            [["a", "c", "e"]],
          );
          expect(
            subs.sublist(BigInt.from(31), BigInt.from(32)),
            [["a", "b", "c", "d", "e"]],
          );
        },
      );
    },
  );

  group(
    "TinyList.compound()",
    () {
      final TinyList<String> comps = TinyList.compound(bagOfItems);
      /*
      for (final comp in comps.getRange(BigInt.zero, comps.length)) {
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
      test(
        "[]",
        () {
          expect(
            comps[BigInt.from(3)],
            ["c"],
          );
          expect(
            comps[BigInt.from(50)],
            ["a", "c", "e"],
          );
          expect(
            comps[BigInt.from(206)],
            ["a", "b", "c", "d", "e"],
          );
        },
      );
      test(
        ".sublist()",
        () {
          expect(
            comps.sublist(BigInt.from(3), BigInt.from(4)),
            [["c"]],
          );
          expect(
            comps.sublist(BigInt.from(50), BigInt.from(51)),
            [["a", "c", "e"]],
          );
          expect(
            comps.sublist(BigInt.from(206), BigInt.from(207)),
            [["a", "b", "c", "d", "e"]],
          );
        },
      );
    },
  );
}
