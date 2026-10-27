import 'package:flutter/foundation.dart';
import '../models/student.dart';
import '../logic/skill_match.dart';

class SkillStore extends ChangeNotifier {
  final List<Student> students = const [
    Student(id: 1, name: 'Ayesha Silva', initials: 'AS', campus: 'Colombo', bio: 'Flutter enthusiast, learning backend engineering.', teaches: ['Flutter', 'UI/UX'], learns: ['Python', 'Git']),
    Student(id: 2, name: 'Kavindu Perera', initials: 'KP', campus: 'Kandy', bio: 'Frontend developer passionate about design.', teaches: ['React', 'UI/UX'], learns: ['Python', 'Linux']),
    Student(id: 3, name: 'Nethmi Fernando', initials: 'NF', campus: 'Galle', bio: 'Data science and statistics learner.', teaches: ['Statistics', 'Excel'], learns: ['Python', 'Flutter']),
    Student(id: 4, name: 'Ravindu Jay', initials: 'RJ', campus: 'Colombo', bio: 'Linux tinkerer and system builder.', teaches: ['Linux', 'Git'], learns: ['UI/UX', 'Python']),
    Student(id: 5, name: 'Senu Abey', initials: 'SA', campus: 'Kandy', bio: 'Creative designer exploring software development.', teaches: ['UI/UX', 'Figma'], learns: ['Git', 'Python']),
  ];
  final List<String> myTeaches = ['Python', 'Git'];
  final List<String> myLearns = ['UI/UX', 'Flutter'];
  final List<SwapRequest> requests = [];
  String query = '';

  List<Student> get rankedStudents {
    final sorted = students.where((s) =>
        s.name.toLowerCase().contains(query.toLowerCase()) ||
        s.teaches.any((skill) => skill.toLowerCase().contains(query.toLowerCase())) ||
        s.learns.any((skill) => skill.toLowerCase().contains(query.toLowerCase()))).toList();
    sorted.sort((a, b) => score(b).compareTo(score(a)));
    return sorted;
  }

  int score(Student peer) => matchScore(myTeaches: myTeaches, myLearns: myLearns, peer: peer);
  SwapRequest? requestFor(int id) {
    for (final r in requests) {
      if (r.studentId == id) return r;
    }
    return null;
  }
  void setQuery(String value) { query = value; notifyListeners(); }
  void sendRequest(int studentId) {
    if (requestFor(studentId) != null) return;
    requests.add(SwapRequest(studentId: studentId, createdAt: DateTime.now()));
    notifyListeners();
  }
  void markAccepted(int studentId) {
    final r = requestFor(studentId);
    if (r == null) return;
    r.status = 'Accepted (demo)';
    notifyListeners();
  }
  void addMessage(int studentId, String text) {
    final r = requestFor(studentId);
    if (r == null || text.trim().isEmpty) return;
    r.messages.add(text.trim());
    notifyListeners();
  }
  void addSkill(String skill, {required bool teaches}) {
    final normalized = skill.trim();
    if (normalized.isEmpty || normalized.length > 30) return;
    final list = teaches ? myTeaches : myLearns;
    if (list.any((s) => s.toLowerCase() == normalized.toLowerCase())) return;
    list.add(normalized);
    notifyListeners();
  }
  void removeSkill(String skill, {required bool teaches}) {
    (teaches ? myTeaches : myLearns).remove(skill);
    notifyListeners();
  }
}
