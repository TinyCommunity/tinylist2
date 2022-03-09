import 'dart:math' show Random;
import 'package:tinylist2/tinylist2.dart';

void main() {
  final Random rand = Random();
  final TinyList<String> perms = <String>[
    "Steinhaus",
    "Johnson",
    "Trotter",
  ].permutation(3);
  final List<String> dissent = <String>[
    "No, no, no!",
    "I disagree.",
    "That's absurd",
    "Preposterous!",
  ];

  String exclaim() => dissent[rand.nextInt(dissent.length)];
  String title(List<String> names) => '${names.join('-')} ordering';

  print('Gentlemen, I propose we call the ordering of permutations the ${title(perms[BigInt.zero])}.\n');
  for (final List<String> perm in perms.getRange(BigInt.zero, perms.length).skip(1)) {
    print("${exclaim()} It should be the ${title(perm)}!");
  }
  print("\nOkay then... we'll vote on it!");
}
