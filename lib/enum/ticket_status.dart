enum TicketStatus {
  waiting(0, "Waiting"),
  inProgress(1, "In Progress"),
  accepted(2, "Accepted"),
  cancelled(3, "Cancelled"),
  onTheWay(4, "On The Way"),
  delivered(5, "Delivered");

  final int statusCode;
  final String text;

  const TicketStatus(this.statusCode, this.text);

  // Get the text representation of the status
  String getText() {
    return text;
  }

  // Get the TicketStatus by status code
  static TicketStatus? getStatus(int code) {
    return TicketStatus.values.firstWhere(
      (status) => status.statusCode == code,
      orElse: () => TicketStatus.waiting,
    );
  }

  // Get the text representation of the status by code
  static String getStatusText(int code) {
    final status = getStatus(code);
    return status?.getText() ?? "Unknown Status";
  }
}