class Student {
  final int id;
  final String name;
  final String campus;
  final String bio;
  final List<String> teaches;
  final List<String> learns;
  final String initials;

  const Student({
    required this.id,
    required this.name,
    required this.campus,
    required this.bio,
    required this.teaches,
    required this.learns,
    required this.initials,
  });
}

class SwapRequest {
  final int studentId;
  final DateTime createdAt;
  String status;
  final List<String> messages;

  SwapRequest({required this.studentId, required this.createdAt})
      : status = 'Pending',
        messages = <String>[];
}
