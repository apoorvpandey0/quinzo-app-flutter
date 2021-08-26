import 'package:quiz_app/providers/quiz.dart';
import 'package:random_color/random_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/subjects.dart';
import 'package:quiz_app/screens/quiz_start_screen.dart';

class SubjectsGrid extends StatelessWidget {
  final mQHeight;
  SubjectsGrid(this.mQHeight);

  Future<void> _refreshSubjects(BuildContext context) async {
    await Provider.of<SubjectsProvider>(context, listen: false)
        .getAndSetSubjects();
  }

  @override
  Widget build(BuildContext context) {
    final subjectsData = Provider.of<SubjectsProvider>(context);
    final quizData = Provider.of<Quiz>(context);
    return RefreshIndicator(
      onRefresh: () => _refreshSubjects(context),
      child: subjectsData.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              // Actual subjects grid
              child: GridView.builder(
                itemCount: subjectsData.subjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemBuilder: (ctx, index) {
                  // print(index);
                  final subject = subjectsData.subjects[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(QuizStartScreen.routeName);
                        quizData.selectedSubject = subject.id;
                        quizData.getAndSetQuestions();
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            child: GridTile(
                                child: Image.network(
                                  subject.imageUrl,
                                  fit: BoxFit.fill,
                                ),
                                footer: GridTileBar(
                                  title: Text(subject.title),
                                  backgroundColor: Colors.black54,
                                )),
                          )));
                },
              ),
            ),
    );
  }
}
