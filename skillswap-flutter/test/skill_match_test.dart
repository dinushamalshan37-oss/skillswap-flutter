import 'package:flutter_test/flutter_test.dart';
import 'package:skillswap/logic/skill_match.dart';
import 'package:skillswap/models/student.dart';

void main() {
  const peer = Student(id: 1, name: 'Peer', campus: 'Campus', bio: '', initials: 'PE', teaches: ['Flutter', 'UI/UX'], learns: ['Python', 'Git']);
  test('mutual exchange scores highest', () {
    expect(matchScore(myTeaches: ['Python', 'Git'], myLearns: ['UI/UX', 'Flutter'], peer: peer), 100);
  });
  test('unrelated profiles score zero', () {
    expect(matchScore(myTeaches: ['Java'], myLearns: ['C++'], peer: peer), 0);
  });
  test('one-way skill match is lower than mutual match', () {
    final score = matchScore(myTeaches: ['Java'], myLearns: ['Flutter'], peer: peer);
    expect(score, greaterThan(0));
    expect(score, lessThan(100));
  });
}
