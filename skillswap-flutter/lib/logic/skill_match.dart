import '../models/student.dart';

/// Transparent demo heuristic; NOT machine learning or a validated recommender.
int matchScore({
  required List<String> myTeaches,
  required List<String> myLearns,
  required Student peer,
}) {
  final teaches = myTeaches.map((s) => s.toLowerCase().trim()).toSet();
  final learns = myLearns.map((s) => s.toLowerCase().trim()).toSet();
  final peerTeaches = peer.teaches.map((s) => s.toLowerCase().trim()).toSet();
  final peerLearns = peer.learns.map((s) => s.toLowerCase().trim()).toSet();
  final canLearn = learns.intersection(peerTeaches).length;
  final canTeach = teaches.intersection(peerLearns).length;
  if (canLearn == 0 && canTeach == 0) return 0;
  // Reward a mutual exchange more than a one-way overlap.
  final double learningCoverage = canLearn / (learns.isEmpty ? 1 : learns.length);
  final double teachingCoverage = canTeach / (teaches.isEmpty ? 1 : teaches.length);
  final mutualBonus = canLearn > 0 && canTeach > 0 ? 20 : 0;
  return (learningCoverage * 40 + teachingCoverage * 40 + mutualBonus)
      .round()
      .clamp(0, 100)
      .toInt();
}
