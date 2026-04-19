import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController noteController = TextEditingController();

  List<String> notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  // Load saved notes
  Future<void> loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      notes = prefs.getStringList("myNotes") ?? [];
    });
  }

  // Save notes locally
  Future<void> saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("myNotes", notes);
  }

  // Add note
  void addNote() {
    if (noteController.text.trim().isNotEmpty) {
      setState(() {
        notes.add(noteController.text.trim());
      });

      saveNotes();
      noteController.clear();
    }
  }

  // Delete note
  void deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });

    saveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Notes App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: "Enter note",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  onPressed: addNote,
                  icon: const Icon(Icons.add),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: notes.isEmpty
                  ? const Center(
                child: Text(
                  "No Notes Yet",
                  style: TextStyle(fontSize: 20),
                ),
              )
                  : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(notes[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteNote(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}