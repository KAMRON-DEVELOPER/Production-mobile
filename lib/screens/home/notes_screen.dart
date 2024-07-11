import 'package:flutter/material.dart';
import '../../services/notes_api.dart';
import '../../widgets/appbar.dart';
import '../../widgets/navbar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<int> selectedIndexes = [];
  NoteApiService noteApiService = NoteApiService();

  @override
  void initState() {
    super.initState();
    var notess = noteApiService.getNotes();
    print("notess: $notess");
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
        print('selectedIndex: $selectedIndexes');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff353b4d),
      appBar: buildAppBar(context, "Notes screen"),
      body: MasonryGridView.custom(
        padding: const EdgeInsets.all(12),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        childrenDelegate: SliverChildBuilderDelegate(
          childCount: notes.length,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: true,
          addSemanticIndexes: false,
          (BuildContext context, int index) {
            return BuildNote(
              index: index,
              title: notes[index]['title'].toString(),
              body: notes[index]['body'].toString(),
              isSelected: selectedIndexes.contains(index),
              onLongPress: toggleSelection,
              selectedIndexes: selectedIndexes,
            );
          },
        ),
      ),
      bottomNavigationBar: const Navbar(),
    );
  }
}

class BuildNote extends StatelessWidget {
  final String title;
  final String body;
  final int index;
  final bool isSelected;
  final Function(int) onLongPress;
  final List<int> selectedIndexes;
  const BuildNote({
    super.key,
    required this.title,
    required this.body,
    required this.index,
    required this.isSelected,
    required this.onLongPress,
    required this.selectedIndexes,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => onLongPress(index),
      onTap: () => selectedIndexes.isNotEmpty ? onLongPress(index) : null,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff424a61),
          boxShadow: const [BoxShadow(color: Color(0xff362e47), blurRadius: 3)],
          border: Border.all(
            color: isSelected ? const Color(0xff6e45fe) : Colors.transparent,
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(body),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> notes = [
  {'title': 'GITHUB TOKEN', 'body': 'ghp_hezdfsdfl3e7Ge6'},
  {'title': 'GITHUB password', 'body': '@kamronbek2003'},
  {'title': 'Steam password', 'body': '@kamronbek2003'},
  {'title': 'Dennis Richie', 'body': '1941-2011'},
  {'title': 'sophisticated', 'body': 'sophisticated - murakkab'},
  {
    'title': 'account passwords',
    'body': 'kamronbekatajanovdev@gmail.com >> @kamronbekdev2003,'
        'atajanovkamronbek2003@gmail.com >> @kamronbek2003,'
        'dangersenator577@gmail.com@gmail.com >> @Senator12,'
  },
  {
    'title': 'my laptop',
    'body': 'acer aspire e1-571, i3-3120m, 8gb ddr3 ram, 256gb ssd'
  },
  {
    'title': 'staggered',
    'body':
        'To use the flutter_staggered_grid_view package with the StaggeredGrid.custom widget, you need to provide a StaggeredGridDelegate that defines the layout of the grid. This delegate controls how the tiles in the grid are positioned.'
  },
  {
    'title': 'my skills',
    'body':
        'Python, Django, DRF, PostgreSQL, Javascript, React, Flutter, Dart, Redux',
  },
  {
    'title': 'reminder',
    'body': 'lets break down this problem',
  },
  {
    'title': 'some note',
    'body':
        "This layout emphasizes certain items over others in a collection. It creates hierarchy using varied container sizes and ratios.",
  },
  {
    'title': 'SE4',
    'body':
        'In a flashback Jean witnesses her mother’s boyfriend making sexual advances towards twelve-year-old Joanna. The radio show is put on hiatus in the wake of Ruby’s complaint against O, but Jean decides to quit to focus on being a mother. She offers Joanna money to repay her debts, but accompanies the money with a detailed contract dictating how Joanna needs to behave going forward. Maeve and Otis agree to have dinner with Jean so that she can get to know Maeve.',
  },
  {
    'title': 'Maeve',
    'body':
        'two confess their love for each other and finally have xxx, knowing that they cannot be together.',
  },
  {
    'title': 'Otis',
    'body': "Otis that she cannot be friends with him anymore",
  }
];
