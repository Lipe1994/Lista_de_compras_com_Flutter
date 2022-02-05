class DocumentChanges<T> {
  final T doc;
  final DocumentChangesType type;
  DocumentChanges(this.doc, this.type);
}

enum DocumentChangesType { add, remove, update }
