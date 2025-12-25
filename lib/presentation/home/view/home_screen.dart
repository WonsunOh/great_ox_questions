import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/models.dart';
import '../../../data/services/encryption_service.dart';
import '../../../providers/question_providers.dart';
import '../../../router/route_paths.dart';
import '../../quiz/viewmodel/quiz_viewmodel.dart';

/// 홈 화면 - 과목/챕터 선택 및 파일 불러오기
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // 저장된 문제 세트 목록 (앱 내부 저장소)
  final List<QuestionSet> _savedQuestionSets = [];

  // 숨긴 기본 문제 목록
  Set<String> _hiddenDefaultFiles = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  /// 저장된 데이터 로드
  Future<void> _loadSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 숨긴 기본 문제 목록 로드
      _hiddenDefaultFiles = (prefs.getStringList('hidden_default_files') ?? []).toSet();

      // 저장된 파일 목록 로드
      final savedFiles = prefs.getStringList('saved_files') ?? [];
      final dir = await getApplicationDocumentsDirectory();

      for (final fileName in savedFiles) {
        try {
          final file = File('${dir.path}/questions/$fileName');
          if (await file.exists()) {
            final bytes = await file.readAsBytes();
            String jsonString;

            if (EncryptionService.isEncryptedFileName(fileName) ||
                EncryptionService.isEncryptedFile(bytes)) {
              jsonString = await EncryptionService.decryptFromBytes(bytes);
            } else {
              jsonString = utf8.decode(bytes);
            }

            final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
            _savedQuestionSets.add(QuestionSet.fromJson(jsonMap));
          }
        } catch (e) {
          // 개별 파일 로드 실패 시 스킵
          continue;
        }
      }
    } catch (e) {
      // 로드 실패 시 무시
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 파일 불러오기 및 저장
  Future<void> _loadFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );

      if (result != null) {
        final dir = await getApplicationDocumentsDirectory();
        final questionsDir = Directory('${dir.path}/questions');
        if (!await questionsDir.exists()) {
          await questionsDir.create(recursive: true);
        }

        final prefs = await SharedPreferences.getInstance();
        final savedFiles = prefs.getStringList('saved_files') ?? [];

        int loadedCount = 0;

        for (final file in result.files) {
          if (file.path == null) continue;

          final ext = file.name.toLowerCase();
          if (!ext.endsWith('.json') && !ext.endsWith('.oxq')) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('지원하지 않는 파일: ${file.name}'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
            continue;
          }

          final fileData = File(file.path!);
          final bytes = await fileData.readAsBytes();

          String jsonString;
          if (EncryptionService.isEncryptedFileName(file.name) ||
              EncryptionService.isEncryptedFile(bytes)) {
            jsonString = await EncryptionService.decryptFromBytes(bytes);
          } else {
            jsonString = utf8.decode(bytes);
          }

          final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
          final questionSet = QuestionSet.fromJson(jsonMap);

          // 중복 체크
          final isDuplicate = _savedQuestionSets.any(
            (qs) =>
                qs.subjectInfo.subjectName == questionSet.subjectInfo.subjectName &&
                qs.subjectInfo.chapterMajor == questionSet.subjectInfo.chapterMajor,
          );

          if (!isDuplicate) {
            // 파일 복사
            final savedFile = File('${questionsDir.path}/${file.name}');
            await savedFile.writeAsBytes(bytes);

            // 목록에 추가
            if (!savedFiles.contains(file.name)) {
              savedFiles.add(file.name);
            }

            setState(() {
              _savedQuestionSets.add(questionSet);
            });
            loadedCount++;
          }
        }

        // 저장
        await prefs.setStringList('saved_files', savedFiles);

        if (mounted && loadedCount > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$loadedCount개 파일을 저장했습니다.'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('파일 로드 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 저장된 파일 삭제
  Future<void> _removeSavedQuestionSet(int index) async {
    final questionSet = _savedQuestionSets[index];

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedFiles = prefs.getStringList('saved_files') ?? [];
      final dir = await getApplicationDocumentsDirectory();

      // 파일명 찾기 (subject_name으로 매칭)
      for (final fileName in savedFiles.toList()) {
        final file = File('${dir.path}/questions/$fileName');
        if (await file.exists()) {
          final bytes = await file.readAsBytes();
          String jsonString;

          if (EncryptionService.isEncryptedFileName(fileName) ||
              EncryptionService.isEncryptedFile(bytes)) {
            jsonString = await EncryptionService.decryptFromBytes(bytes);
          } else {
            jsonString = utf8.decode(bytes);
          }

          final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
          final qs = QuestionSet.fromJson(jsonMap);

          if (qs.subjectInfo.subjectName == questionSet.subjectInfo.subjectName &&
              qs.subjectInfo.chapterMajor == questionSet.subjectInfo.chapterMajor) {
            await file.delete();
            savedFiles.remove(fileName);
            break;
          }
        }
      }

      await prefs.setStringList('saved_files', savedFiles);

      setState(() {
        _savedQuestionSets.removeAt(index);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('삭제 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  /// 기본 문제 숨기기
  Future<void> _hideDefaultQuestionSet(String subjectName) async {
    final prefs = await SharedPreferences.getInstance();
    _hiddenDefaultFiles.add(subjectName);
    await prefs.setStringList('hidden_default_files', _hiddenDefaultFiles.toList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final questionSetsAsync = ref.watch(allQuestionSetsProvider);

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : questionSetsAsync.when(
                data: (questionSets) => _buildContent(context, ref, questionSets),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => _buildError(context, ref, error),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loadFile,
        icon: const Icon(Icons.folder_open),
        label: const Text('파일 불러오기'),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<QuestionSet> questionSets,
  ) {
    // 숨기지 않은 기본 문제만 표시
    final visibleDefaultSets = questionSets
        .where((qs) => !_hiddenDefaultFiles.contains(qs.subjectInfo.subjectName))
        .toList();

    final allQuestionSets = [..._savedQuestionSets, ...visibleDefaultSets];

    if (allQuestionSets.isEmpty) {
      return _buildEmptyState(context);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final maxWidth = isWide ? 800.0 : double.infinity;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(context),
                ),

                // 저장된 파일
                if (_savedQuestionSets.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      context,
                      '저장된 문제',
                      Icons.save,
                      _savedQuestionSets.length,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildQuestionSetCard(
                            context,
                            ref,
                            _savedQuestionSets[index],
                            onRemove: () => _removeSavedQuestionSet(index),
                          ),
                        ),
                        childCount: _savedQuestionSets.length,
                      ),
                    ),
                  ),
                ],

                // 기본 문제
                if (visibleDefaultSets.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: _buildSectionHeader(
                      context,
                      '샘플 문제',
                      Icons.library_books,
                      visibleDefaultSets.length,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildQuestionSetCard(
                            context,
                            ref,
                            visibleDefaultSets[index],
                            onRemove: () => _hideDefaultQuestionSet(
                              visibleDefaultSets[index].subjectInfo.subjectName,
                            ),
                          ),
                        ),
                        childCount: visibleDefaultSets.length,
                      ),
                    ),
                  ),
                ],

                // 하단 여백
                if (_savedQuestionSets.isNotEmpty && visibleDefaultSets.isEmpty)
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    int count,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.quiz_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'O/X 퀴즈',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '빠르고 효과적인 학습',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '아래에서 학습할 과목을 선택하거나 파일을 불러오세요',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionSetCard(
    BuildContext context,
    WidgetRef ref,
    QuestionSet questionSet, {
    VoidCallback? onRemove,
  }) {
    final subjectInfo = questionSet.subjectInfo;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      shadowColor: colorScheme.shadow.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _startQuiz(context, ref, questionSet),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        subjectInfo.subjectName,
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.quiz_outlined,
                              size: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${questionSet.questionCount}문제',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (onRemove != null) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: onRemove,
                          tooltip: '삭제',
                          visualDensity: VisualDensity.compact,
                          style: IconButton.styleFrom(
                            backgroundColor:
                                colorScheme.errorContainer.withValues(alpha: 0.5),
                            foregroundColor: colorScheme.error,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                subjectInfo.chapterMajor,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                subjectInfo.chapterMinor,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 14,
                          color: colorScheme.outline,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            subjectInfo.sourceReference,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => _startQuiz(context, ref, questionSet),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('시작'),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.quiz_outlined,
                size: 64,
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '등록된 문제가 없습니다',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '파일 불러오기 버튼을 눌러\n.json 또는 .oxq 파일을 선택하세요',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: _loadFile,
              icon: const Icon(Icons.folder_open),
              label: const Text('파일 불러오기'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, WidgetRef ref, Object error) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '문제를 불러오는데 실패했습니다',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  onPressed: () => ref.invalidate(allQuestionSetsProvider),
                  icon: const Icon(Icons.refresh),
                  label: const Text('다시 시도'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: _loadFile,
                  icon: const Icon(Icons.folder_open),
                  label: const Text('파일 불러오기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _startQuiz(
    BuildContext context,
    WidgetRef ref,
    QuestionSet questionSet,
  ) {
    ref.read(selectedQuestionSetProvider.notifier).select(questionSet);
    ref.read(quizViewModelProvider.notifier).startQuiz(questionSet.questions);
    context.go(RoutePaths.quiz);
  }
}
