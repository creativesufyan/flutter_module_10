class ToDO {
  String title;
  String subtitle;
  DateTime createdDateTime, updatedDateTime;
  String status;

  ToDO({
    required this.title,
    required this.subtitle,
    required this.createdDateTime,
    required this.updatedDateTime,
    this.status = 'pending',
  });
}
