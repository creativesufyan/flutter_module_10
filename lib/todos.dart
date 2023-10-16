class ToDO {
  String details;
  DateTime createdDateTime, UpdatedDateTime;
  String status;

  ToDO({
    required this.details,
    required this.createdDateTime,
    required this.UpdatedDateTime,
    this.status = 'pending',
  });
}
