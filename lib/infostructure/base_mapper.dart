abstract class BaseMapper<T, R>{
  T map(R r);
  R revertMap(T t);

  Iterable<T> mapIterable(Iterable<R> iterableR) => iterableR.map((r) => map(r));

  Iterable<R> revertMapIterable(Iterable<T> iterableT) => iterableT.map((t) => revertMap(t));
}