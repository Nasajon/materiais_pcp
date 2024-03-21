class PaginatorVO<T> {
  final List<T> items;
  final int itemsPerPage;

  const PaginatorVO(this.items, {this.itemsPerPage = 3});

  int get totalPageCount => (items.length / itemsPerPage).ceil();

  List<T> getItemsByPage(int pageNumber) {
    int start = (pageNumber - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    end = end > items.length ? items.length : end;
    if (start < items.length) {
      return items.sublist(start, end);
    } else {
      return [];
    }
  }
}
