import 'tinylist.dart';

// Convenience methods to create combinatorics instances from any lists.
extension TinyListExtensions<T> on List<T> {
  TinyList<T> combination(int r) => TinyList<T>.combination(this, r);

  TinyList<T> permutation(int r) => TinyList<T>.permutation(this, r);

  TinyList<T> composition(int r) => TinyList<T>.composition(this, r);

  TinyList<T> amalgam(int r) => TinyList<T>.amalgam(this, r);

  TinyList<T> subset() => TinyList<T>.subset(this);

  TinyList<T> compound() => TinyList<T>.compound(this);
}
