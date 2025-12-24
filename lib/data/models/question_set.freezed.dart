// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionSet {

/// 과목 정보
@JsonKey(name: 'subject_info') SubjectInfo get subjectInfo;/// 문제 목록
 List<Question> get questions;
/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionSetCopyWith<QuestionSet> get copyWith => _$QuestionSetCopyWithImpl<QuestionSet>(this as QuestionSet, _$identity);

  /// Serializes this QuestionSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuestionSet&&(identical(other.subjectInfo, subjectInfo) || other.subjectInfo == subjectInfo)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subjectInfo,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'QuestionSet(subjectInfo: $subjectInfo, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $QuestionSetCopyWith<$Res>  {
  factory $QuestionSetCopyWith(QuestionSet value, $Res Function(QuestionSet) _then) = _$QuestionSetCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subject_info') SubjectInfo subjectInfo, List<Question> questions
});


$SubjectInfoCopyWith<$Res> get subjectInfo;

}
/// @nodoc
class _$QuestionSetCopyWithImpl<$Res>
    implements $QuestionSetCopyWith<$Res> {
  _$QuestionSetCopyWithImpl(this._self, this._then);

  final QuestionSet _self;
  final $Res Function(QuestionSet) _then;

/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectInfo = null,Object? questions = null,}) {
  return _then(_self.copyWith(
subjectInfo: null == subjectInfo ? _self.subjectInfo : subjectInfo // ignore: cast_nullable_to_non_nullable
as SubjectInfo,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}
/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectInfoCopyWith<$Res> get subjectInfo {
  
  return $SubjectInfoCopyWith<$Res>(_self.subjectInfo, (value) {
    return _then(_self.copyWith(subjectInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuestionSet].
extension QuestionSetPatterns on QuestionSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuestionSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuestionSet value)  $default,){
final _that = this;
switch (_that) {
case _QuestionSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuestionSet value)?  $default,){
final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_info')  SubjectInfo subjectInfo,  List<Question> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
return $default(_that.subjectInfo,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_info')  SubjectInfo subjectInfo,  List<Question> questions)  $default,) {final _that = this;
switch (_that) {
case _QuestionSet():
return $default(_that.subjectInfo,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subject_info')  SubjectInfo subjectInfo,  List<Question> questions)?  $default,) {final _that = this;
switch (_that) {
case _QuestionSet() when $default != null:
return $default(_that.subjectInfo,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuestionSet extends QuestionSet {
  const _QuestionSet({@JsonKey(name: 'subject_info') required this.subjectInfo, final  List<Question> questions = const []}): _questions = questions,super._();
  factory _QuestionSet.fromJson(Map<String, dynamic> json) => _$QuestionSetFromJson(json);

/// 과목 정보
@override@JsonKey(name: 'subject_info') final  SubjectInfo subjectInfo;
/// 문제 목록
 final  List<Question> _questions;
/// 문제 목록
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionSetCopyWith<_QuestionSet> get copyWith => __$QuestionSetCopyWithImpl<_QuestionSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuestionSet&&(identical(other.subjectInfo, subjectInfo) || other.subjectInfo == subjectInfo)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subjectInfo,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'QuestionSet(subjectInfo: $subjectInfo, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$QuestionSetCopyWith<$Res> implements $QuestionSetCopyWith<$Res> {
  factory _$QuestionSetCopyWith(_QuestionSet value, $Res Function(_QuestionSet) _then) = __$QuestionSetCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subject_info') SubjectInfo subjectInfo, List<Question> questions
});


@override $SubjectInfoCopyWith<$Res> get subjectInfo;

}
/// @nodoc
class __$QuestionSetCopyWithImpl<$Res>
    implements _$QuestionSetCopyWith<$Res> {
  __$QuestionSetCopyWithImpl(this._self, this._then);

  final _QuestionSet _self;
  final $Res Function(_QuestionSet) _then;

/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectInfo = null,Object? questions = null,}) {
  return _then(_QuestionSet(
subjectInfo: null == subjectInfo ? _self.subjectInfo : subjectInfo // ignore: cast_nullable_to_non_nullable
as SubjectInfo,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}

/// Create a copy of QuestionSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubjectInfoCopyWith<$Res> get subjectInfo {
  
  return $SubjectInfoCopyWith<$Res>(_self.subjectInfo, (value) {
    return _then(_self.copyWith(subjectInfo: value));
  });
}
}

// dart format on
