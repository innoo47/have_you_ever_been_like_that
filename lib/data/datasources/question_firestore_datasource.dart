import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/question.dart';

class QuestionFirestoreDatasource {
  final _firestore = FirebaseFirestore.instance;

  Future<Question?> getTodayQuestion() async {
    final today = DateTime.now();
    final query =
        await _firestore
            .collection('questions')
            .where(
              'date',
              isEqualTo: DateTime(today.year, today.month, today.day),
            )
            .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return Question.fromJson(doc.id, doc.data());
    }
    return null;
  }

  Future<void> addQuestion(Question question) async {
    await _firestore.collection('questions').add(question.toJson());
  }
}
