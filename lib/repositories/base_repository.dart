abstract class BaseRepository<T> {
  Future<T?> getById(String id);
  Future<void> save(String id, T data);
}
