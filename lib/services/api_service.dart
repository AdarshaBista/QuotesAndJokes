abstract class ApiService<T> {
  Future<List<T>> fetch();
}
