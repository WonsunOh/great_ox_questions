import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/models/models.dart';

part 'sample_data_provider.g.dart';

/// 샘플 문제 데이터 Provider
///
/// 실제 구현 시 Repository에서 JSON 데이터를 로드하도록 변경합니다.
@riverpod
List<Question> sampleQuestions(Ref ref) {
  return const [
    Question(
      id: 1,
      question: '헌법은 국가의 최고 규범이다.',
      answer: 'O',
      explanation: '헌법은 국가의 기본법으로서 최고 규범성을 가지며, 모든 법률과 명령은 헌법에 위반되어서는 안 됩니다.',
      tags: ['헌법총론', '최고규범성'],
      importance: 5,
    ),
    Question(
      id: 2,
      question: '대통령의 임기는 6년이며 중임할 수 있다.',
      answer: 'X',
      explanation: '대통령의 임기는 5년이며, 중임할 수 없습니다.',
      correction: '대통령의 임기는 5년이며, 중임할 수 없다.',
      tags: ['대통령', '임기'],
      importance: 5,
    ),
    Question(
      id: 3,
      question: '국회의원의 임기는 4년이다.',
      answer: 'O',
      explanation: '헌법 제42조에 따라 국회의원의 임기는 4년입니다.',
      tags: ['국회', '임기'],
      importance: 4,
    ),
    Question(
      id: 4,
      question: '헌법재판소 재판관의 임기는 6년이며 연임할 수 있다.',
      answer: 'O',
      explanation: '헌법 제112조 제1항에 따라 헌법재판소 재판관의 임기는 6년이며, 법률이 정하는 바에 의하여 연임할 수 있습니다.',
      tags: ['헌법재판소', '임기'],
      importance: 4,
    ),
    Question(
      id: 5,
      question: '대법원장의 임기는 6년이며 중임할 수 있다.',
      answer: 'X',
      explanation: '대법원장의 임기는 6년이지만, 중임할 수 없습니다.',
      correction: '대법원장의 임기는 6년이며, 중임할 수 없다.',
      tags: ['대법원', '임기'],
      importance: 4,
    ),
  ];
}

/// 샘플 과목 정보 Provider
@riverpod
SubjectInfo sampleSubjectInfo(Ref ref) {
  return const SubjectInfo(
    subjectName: '헌법',
    chapterMajor: '제1편 헌법총론',
    chapterMinor: '제1장 헌법의 의의',
    sourceReference: '2024 공무원 헌법 기출문제집',
    version: '1.0.0',
  );
}
