abstract class BaseMapper<T, R>{
  T map(R r);
  R revertMap(T t);

  T? tryMap(R? r){
    return r != null ? map(r) : null;
  }

  R? tryRevertMap(T? t){
    return t != null ? revertMap(t) : null;
  }

  Iterable<T> mapIterable(Iterable<R> iterableR) => iterableR.map((r) => map(r));

  Iterable<R> revertMapIterable(Iterable<T> iterableT) => iterableT.map((t) => revertMap(t));
}