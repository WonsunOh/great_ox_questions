// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserAnswer {

/// 문제 ID
 int get questionId;/// 사용자가 선택한 답변 (true = O, false = X)
 bool get selectedAnswer;/// 정답 여부
 bool get isCorrect;
/// Create a copy of UserAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserAnswerCopyWith<UserAnswer> get copyWith => _$UserAnswerCopyWithImpl<UserAnswer>(this as UserAnswer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.selectedAnswer, selectedAnswer) || other.selectedAnswer == selectedAnswer)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,selectedAnswer,isCorrect);

@override
String toString() {
  return 'UserAnswer(questionId: $questionId, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class $UserAnswerCopyWith<$Res>  {
  factory $UserAnswerCopyWith(UserAnswer value, $Res Function(UserAnswer) _then) = _$UserAnswerCopyWithImpl;
@useResult
$Res call({
 int questionId, bool selectedAnswer, bool isCorrect
});




}
/// @nodoc
class _$UserAnswerCopyWithImpl<$Res>
    implements $UserAnswerCopyWith<$Res> {
  _$UserAnswerCopyWithImpl(this._self, this._then);

  final UserAnswer _self;
  final $Res Function(UserAnswer) _then;

/// Create a copy of UserAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questionId = null,Object? selectedAnswer = null,Object? isCorrect = null,}) {
  return _then(_self.copyWith(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,selectedAnswer: null == selectedAnswer ? _self.selectedAnswer : selectedAnswer // ignore: cast_nullable_to_non_nullable
as bool,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserAnswer].
extension UserAnswerPatterns on UserAnswer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserAnswer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserAnswer value)  $default,){
final _that = this;
switch (_that) {
case _UserAnswer():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _UserAnswer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int questionId,  bool selectedAnswer,  bool isCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserAnswer() when $default != null:
return $default(_that.questionId,_that.selectedAnswer,_that.isCorrect);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int questionId,  bool selectedAnswer,  bool isCorrect)  $default,) {final _that = this;
switch (_that) {
case _UserAnswer():
return $default(_that.questionId,_that.selectedAnswer,_that.isCorrect);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int questionId,  bool selectedAnswer,  bool isCorrect)?  $default,) {final _that = this;
switch (_that) {
case _UserAnswer() when $default != null:
return $default(_that.questionId,_that.selectedAnswer,_that.isCorrect);case _:
  return null;

}
}

}

/// @nodoc


class _UserAnswer implements UserAnswer {
  const _UserAnswer({required this.questionId, required this.selectedAnswer, required this.isCorrect});
  

/// 문제 ID
@override final  int questionId;
/// 사용자가 선택한 답변 (true = O, false = X)
@override final  bool selectedAnswer;
/// 정답 여부
@override final  bool isCorrect;

/// Create a copy of UserAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserAnswerCopyWith<_UserAnswer> get copyWith => __$UserAnswerCopyWithImpl<_UserAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserAnswer&&(identical(other.questionId, questionId) || other.questionId == questionId)&&(identical(other.selectedAnswer, selectedAnswer) || other.selectedAnswer == selectedAnswer)&&(identical(other.isCorrect, isCorrect) || other.isCorrect == isCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,questionId,selectedAnswer,isCorrect);

@override
String toString() {
  return 'UserAnswer(questionId: $questionId, selectedAnswer: $selectedAnswer, isCorrect: $isCorrect)';
}


}

/// @nodoc
abstract mixin class _$UserAnswerCopyWith<$Res> implements $UserAnswerCopyWith<$Res> {
  factory _$UserAnswerCopyWith(_UserAnswer value, $Res Function(_UserAnswer) _then) = __$UserAnswerCopyWithImpl;
@override @useResult
$Res call({
 int questionId, bool selectedAnswer, bool isCorrect
});




}
/// @nodoc
class __$UserAnswerCopyWithImpl<$Res>
    implements _$UserAnswerCopyWith<$Res> {
  __$UserAnswerCopyWithImpl(this._self, this._then);

  final _UserAnswer _self;
  final $Res Function(_UserAnswer) _then;

/// Create a copy of UserAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questionId = null,Object? selectedAnswer = null,Object? isCorrect = null,}) {
  return _then(_UserAnswer(
questionId: null == questionId ? _self.questionId : questionId // ignore: cast_nullable_to_non_nullable
as int,selectedAnswer: null == selectedAnswer ? _self.selectedAnswer : selectedAnswer // ignore: cast_nullable_to_non_nullable
as bool,isCorrect: null == isCorrect ? _self.isCorrect : isCorrect // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$QuizState {

/// 문제 목록
 List<Question> get questions;/// 현재 문제 인덱스
 int get currentIndex;/// 사용자 답변 기록
 List<UserAnswer> get userAnswers;/// 퀴즈 상태
 QuizStatus get status;/// 마지막 답변의 정답 여부 (피드백 표시용)
 bool? get lastAnswerCorrect;/// 피드백 표시 중 여부
 bool get showingFeedback;
/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizStateCopyWith<QuizState> get copyWith => _$QuizStateCopyWithImpl<QuizState>(this as QuizState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizState&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other.userAnswers, userAnswers)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastAnswerCorrect, lastAnswerCorrect) || other.lastAnswerCorrect == lastAnswerCorrect)&&(identical(other.showingFeedback, showingFeedback) || other.showingFeedback == showingFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(questions),currentIndex,const DeepCollectionEquality().hash(userAnswers),status,lastAnswerCorrect,showingFeedback);

@override
String toString() {
  return 'QuizState(questions: $questions, currentIndex: $currentIndex, userAnswers: $userAnswers, status: $status, lastAnswerCorrect: $lastAnswerCorrect, showingFeedback: $showingFeedback)';
}


}

/// @nodoc
abstract mixin class $QuizStateCopyWith<$Res>  {
  factory $QuizStateCopyWith(QuizState value, $Res Function(QuizState) _then) = _$QuizStateCopyWithImpl;
@useResult
$Res call({
 List<Question> questions, int currentIndex, List<UserAnswer> userAnswers, QuizStatus status, bool? lastAnswerCorrect, bool showingFeedback
});




}
/// @nodoc
class _$QuizStateCopyWithImpl<$Res>
    implements $QuizStateCopyWith<$Res> {
  _$QuizStateCopyWithImpl(this._self, this._then);

  final QuizState _self;
  final $Res Function(QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? questions = null,Object? currentIndex = null,Object? userAnswers = null,Object? status = null,Object? lastAnswerCorrect = freezed,Object? showingFeedback = null,}) {
  return _then(_self.copyWith(
questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,userAnswers: null == userAnswers ? _self.userAnswers : userAnswers // ignore: cast_nullable_to_non_nullable
as List<UserAnswer>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,lastAnswerCorrect: freezed == lastAnswerCorrect ? _self.lastAnswerCorrect : lastAnswerCorrect // ignore: cast_nullable_to_non_nullable
as bool?,showingFeedback: null == showingFeedback ? _self.showingFeedback : showingFeedback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizState].
extension QuizStatePatterns on QuizState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizState value)  $default,){
final _that = this;
switch (_that) {
case _QuizState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizState value)?  $default,){
final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Question> questions,  int currentIndex,  List<UserAnswer> userAnswers,  QuizStatus status,  bool? lastAnswerCorrect,  bool showingFeedback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.questions,_that.currentIndex,_that.userAnswers,_that.status,_that.lastAnswerCorrect,_that.showingFeedback);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Question> questions,  int currentIndex,  List<UserAnswer> userAnswers,  QuizStatus status,  bool? lastAnswerCorrect,  bool showingFeedback)  $default,) {final _that = this;
switch (_that) {
case _QuizState():
return $default(_that.questions,_that.currentIndex,_that.userAnswers,_that.status,_that.lastAnswerCorrect,_that.showingFeedback);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Question> questions,  int currentIndex,  List<UserAnswer> userAnswers,  QuizStatus status,  bool? lastAnswerCorrect,  bool showingFeedback)?  $default,) {final _that = this;
switch (_that) {
case _QuizState() when $default != null:
return $default(_that.questions,_that.currentIndex,_that.userAnswers,_that.status,_that.lastAnswerCorrect,_that.showingFeedback);case _:
  return null;

}
}

}

/// @nodoc


class _QuizState extends QuizState {
  const _QuizState({final  List<Question> questions = const [], this.currentIndex = 0, final  List<UserAnswer> userAnswers = const [], this.status = QuizStatus.initial, this.lastAnswerCorrect, this.showingFeedback = false}): _questions = questions,_userAnswers = userAnswers,super._();
  

/// 문제 목록
 final  List<Question> _questions;
/// 문제 목록
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

/// 현재 문제 인덱스
@override@JsonKey() final  int currentIndex;
/// 사용자 답변 기록
 final  List<UserAnswer> _userAnswers;
/// 사용자 답변 기록
@override@JsonKey() List<UserAnswer> get userAnswers {
  if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_userAnswers);
}

/// 퀴즈 상태
@override@JsonKey() final  QuizStatus status;
/// 마지막 답변의 정답 여부 (피드백 표시용)
@override final  bool? lastAnswerCorrect;
/// 피드백 표시 중 여부
@override@JsonKey() final  bool showingFeedback;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizStateCopyWith<_QuizState> get copyWith => __$QuizStateCopyWithImpl<_QuizState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizState&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&const DeepCollectionEquality().equals(other._userAnswers, _userAnswers)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastAnswerCorrect, lastAnswerCorrect) || other.lastAnswerCorrect == lastAnswerCorrect)&&(identical(other.showingFeedback, showingFeedback) || other.showingFeedback == showingFeedback));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_questions),currentIndex,const DeepCollectionEquality().hash(_userAnswers),status,lastAnswerCorrect,showingFeedback);

@override
String toString() {
  return 'QuizState(questions: $questions, currentIndex: $currentIndex, userAnswers: $userAnswers, status: $status, lastAnswerCorrect: $lastAnswerCorrect, showingFeedback: $showingFeedback)';
}


}

/// @nodoc
abstract mixin class _$QuizStateCopyWith<$Res> implements $QuizStateCopyWith<$Res> {
  factory _$QuizStateCopyWith(_QuizState value, $Res Function(_QuizState) _then) = __$QuizStateCopyWithImpl;
@override @useResult
$Res call({
 List<Question> questions, int currentIndex, List<UserAnswer> userAnswers, QuizStatus status, bool? lastAnswerCorrect, bool showingFeedback
});




}
/// @nodoc
class __$QuizStateCopyWithImpl<$Res>
    implements _$QuizStateCopyWith<$Res> {
  __$QuizStateCopyWithImpl(this._self, this._then);

  final _QuizState _self;
  final $Res Function(_QuizState) _then;

/// Create a copy of QuizState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? questions = null,Object? currentIndex = null,Object? userAnswers = null,Object? status = null,Object? lastAnswerCorrect = freezed,Object? showingFeedback = null,}) {
  return _then(_QuizState(
questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,userAnswers: null == userAnswers ? _self._userAnswers : userAnswers // ignore: cast_nullable_to_non_nullable
as List<UserAnswer>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,lastAnswerCorrect: freezed == lastAnswerCorrect ? _self.lastAnswerCorrect : lastAnswerCorrect // ignore: cast_nullable_to_non_nullable
as bool?,showingFeedback: null == showingFeedback ? _self.showingFeedback : showingFeedback // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
