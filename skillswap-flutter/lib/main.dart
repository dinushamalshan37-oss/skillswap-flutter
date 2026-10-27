import 'package:flutter/material.dart';
import 'models/student.dart';
import 'state/skill_store.dart';

void main() => runApp(const SkillSwapApp());

const ink = Color(0xFF0B1020);
const pane = Color(0xFF172034);
const accent = Color(0xFF86EAC6);

class SkillSwapApp extends StatefulWidget {
  const SkillSwapApp({super.key});
  @override
  State<SkillSwapApp> createState() => _SkillSwapAppState();
}

class _SkillSwapAppState extends State<SkillSwapApp> {
  final SkillStore store = SkillStore();
  int tab = 0;

  @override
  void dispose() { store.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'SkillSwap',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: ink,
      colorScheme: ColorScheme.fromSeed(seedColor: accent, brightness: Brightness.dark),
      cardTheme: CardThemeData(color: pane, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    ),
    home: AnimatedBuilder(
      animation: store,
      builder: (context, _) => Scaffold(
        appBar: AppBar(backgroundColor: ink, title: const Text('✦ SkillSwap', style: TextStyle(fontWeight: FontWeight.w800)), actions: [
          Padding(padding: const EdgeInsets.only(right: 14), child: Center(child: Text('CAMPUS MVP', style: TextStyle(color: accent, fontSize: 11, letterSpacing: 1.2)))),
        ]),
        body: SafeArea(child: IndexedStack(index: tab, children: [ExploreScreen(store: store), RequestsScreen(store: store), ProfileScreen(store: store)])),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab, onDestinationSelected: (value) => setState(() => tab = value),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.travel_explore), label: 'Discover'),
            NavigationDestination(icon: Icon(Icons.swap_horiz), label: 'Exchanges'),
            NavigationDestination(icon: Icon(Icons.person_outline), label: 'My skills'),
          ],
        ),
      ),
    ),
  );
}

class ExploreScreen extends StatelessWidget {
  final SkillStore store;
  const ExploreScreen({super.key, required this.store});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
    children: [
      const Text('Learn together.\nGrow together.', style: TextStyle(fontSize: 29, height: 1.12, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Find students who can teach what you want to learn.'),
      const SizedBox(height: 22),
      TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Search people or skills', filled: true, fillColor: pane, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))), onChanged: store.setQuery),
      const SizedBox(height: 18),
      Text('${store.rankedStudents.length} students available', style: const TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      ...store.rankedStudents.map((person) => StudentCard(person: person, store: store)),
      if (store.rankedStudents.isEmpty) const Padding(padding: EdgeInsets.all(28), child: Center(child: Text('No students match this search.'))),
    ],
  );
}

class StudentCard extends StatelessWidget {
  final Student person;
  final SkillStore store;
  const StudentCard({super.key, required this.person, required this.store});
  @override
  Widget build(BuildContext context) {
    final request = store.requestFor(person.id);
    return Card(margin: const EdgeInsets.symmetric(vertical: 8), child: Padding(padding: const EdgeInsets.all(17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [CircleAvatar(radius: 24, backgroundColor: const Color(0xFF314F54), child: Text(person.initials, style: const TextStyle(color: accent, fontWeight: FontWeight.bold))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(person.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)), Text('📍 ${person.campus}', style: const TextStyle(color: Colors.white60))])), Chip(label: Text('${store.score(person)}% match'), backgroundColor: const Color(0xFF245043), labelStyle: const TextStyle(color: accent))]),
      const SizedBox(height: 12), Text(person.bio, style: const TextStyle(color: Colors.white70)),
      const SizedBox(height: 12), const Text('CAN TEACH', style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.bold)), SkillChips(skills: person.teaches),
      const Text('WANTS TO LEARN', style: TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)), SkillChips(skills: person.learns),
      const SizedBox(height: 10), SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: request != null ? null : () {store.sendRequest(person.id);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Swap requested with ${person.name}')));}, icon: Icon(request == null ? Icons.send_outlined : Icons.check), label: Text(request == null ? 'Request skill exchange' : 'Request sent'))),
    ])));
  }
}

class SkillChips extends StatelessWidget {
  final List<String> skills;
  const SkillChips({super.key, required this.skills});
  @override
  Widget build(BuildContext context) => Wrap(spacing: 7, runSpacing: 0, children: skills.map((s) => Chip(label: Text(s), visualDensity: VisualDensity.compact)).toList());
}

class RequestsScreen extends StatelessWidget {
  final SkillStore store;
  const RequestsScreen({super.key, required this.store});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Your exchanges', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
    const SizedBox(height: 6), const Text('Track requests and try the local demo conversation.', style: TextStyle(color: Colors.white60)),
    const SizedBox(height: 16),
    if (store.requests.isEmpty) const Card(child: Padding(padding: EdgeInsets.all(24), child: Text('No requests yet. Find a student in Discover and start a skill exchange.'))),
    ...store.requests.map((r) {
      final p = store.students.firstWhere((student) => student.id == r.studentId);
      return Card(child: Padding(padding: const EdgeInsets.all(17), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        Text(r.status, style: const TextStyle(color: accent)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, children: [
          OutlinedButton(onPressed: () => showChat(context, store, p), child: Text('Demo chat (${r.messages.length})')),
          if (r.status == 'Pending') OutlinedButton(onPressed: () => store.markAccepted(p.id), child: const Text('Simulate acceptance')),
        ]),
      ])));
    }),
    const SizedBox(height: 15), const Text('Demo notice: Requests and messages stay on this device only while the app is open. No other user is contacted.', style: TextStyle(color: Colors.white54, fontSize: 12)),
  ]);
}

void showChat(BuildContext context, SkillStore store, Student person) {
  final controller = TextEditingController();
  showModalBottomSheet<void>(context: context, isScrollControlled: true, backgroundColor: pane, builder: (sheetContext) => AnimatedBuilder(animation: store, builder: (context, _) {
    final request = store.requestFor(person.id)!;
    return Padding(padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: MediaQuery.viewInsetsOf(sheetContext).bottom + 20), child: SizedBox(height: 390, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Demo chat · ${person.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      const Text('Local practice conversation — not sent to a real person', style: TextStyle(fontSize: 12, color: Colors.white60)),
      Expanded(child: ListView(children: [const SizedBox(height: 15), ...request.messages.map((m) => Align(alignment: Alignment.centerRight, child: Card(color: const Color(0xFF225047), child: Padding(padding: const EdgeInsets.all(10), child: Text(m))))])),
      Row(children: [Expanded(child: TextField(controller: controller, decoration: const InputDecoration(hintText: 'Type a message'))), IconButton(onPressed: () {store.addMessage(person.id, controller.text);controller.clear();}, icon: const Icon(Icons.send, color: accent))]),
    ])));
  })).whenComplete(controller.dispose);
}

class ProfileScreen extends StatelessWidget {
  final SkillStore store;
  const ProfileScreen({super.key, required this.store});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const CircleAvatar(radius: 34, backgroundColor: Color(0xFF274C45), child: Icon(Icons.person, size: 38, color: accent)),
    const SizedBox(height: 14), const Center(child: Text('My learning profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800))),
    const Center(child: Text('Demo learner · Edit the skills below', style: TextStyle(color: Colors.white60))),
    const SizedBox(height: 24), SkillEditor(title: 'I can teach', skills: store.myTeaches, onAdd: (s) => store.addSkill(s, teaches: true), onRemove: (s) => store.removeSkill(s, teaches: true)),
    const SizedBox(height: 16), SkillEditor(title: 'I want to learn', skills: store.myLearns, onAdd: (s) => store.addSkill(s, teaches: false), onRemove: (s) => store.removeSkill(s, teaches: false)),
    const SizedBox(height: 12), const Text('Your changes instantly recalculate the match scores. Data resets when the app restarts.', style: TextStyle(color: Colors.white54, fontSize: 12)),
  ]);
}

class SkillEditor extends StatefulWidget {
  final String title;
  final List<String> skills;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;
  const SkillEditor({super.key, required this.title, required this.skills, required this.onAdd, required this.onRemove});
  @override
  State<SkillEditor> createState() => _SkillEditorState();
}
class _SkillEditorState extends State<SkillEditor> {
  final TextEditingController ctrl = TextEditingController();
  @override
  void dispose() { ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    Wrap(spacing: 7, children: widget.skills.map((s) => InputChip(label: Text(s), onDeleted: () => widget.onRemove(s))).toList()),
    Row(children: [Expanded(child: TextField(controller: ctrl, maxLength: 30, decoration: const InputDecoration(hintText: 'Add a skill', counterText: ''))), IconButton(onPressed: () {widget.onAdd(ctrl.text);ctrl.clear();}, icon: const Icon(Icons.add_circle_outline, color: accent))]),
  ])));
}
