// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectInfo {

/// 과목명
@JsonKey(name: 'subject_name') String get subjectName;/// 대단원
@JsonKey(name: 'chapter_major') String get chapterMajor;/// 소단원
@JsonKey(name: 'chapter_minor') String get chapterMinor;/// 출처
@JsonKey(name: 'source_reference') String get sourceReference;/// 버전
 String get version;
/// Create a copy of SubjectInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubjectInfoCopyWith<SubjectInfo> get copyWith => _$SubjectInfoCopyWithImpl<SubjectInfo>(this as SubjectInfo, _$identity);

  /// Serializes this SubjectInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubjectInfo&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.chapterMajor, chapterMajor) || other.chapterMajor == chapterMajor)&&(identical(other.chapterMinor, chapterMinor) || other.chapterMinor == chapterMinor)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subjectName,chapterMajor,chapterMinor,sourceReference,version);

@override
String toString() {
  return 'SubjectInfo(subjectName: $subjectName, chapterMajor: $chapterMajor, chapterMinor: $chapterMinor, sourceReference: $sourceReference, version: $version)';
}


}

/// @nodoc
abstract mixin class $SubjectInfoCopyWith<$Res>  {
  factory $SubjectInfoCopyWith(SubjectInfo value, $Res Function(SubjectInfo) _then) = _$SubjectInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'subject_name') String subjectName,@JsonKey(name: 'chapter_major') String chapterMajor,@JsonKey(name: 'chapter_minor') String chapterMinor,@JsonKey(name: 'source_reference') String sourceReference, String version
});




}
/// @nodoc
class _$SubjectInfoCopyWithImpl<$Res>
    implements $SubjectInfoCopyWith<$Res> {
  _$SubjectInfoCopyWithImpl(this._self, this._then);

  final SubjectInfo _self;
  final $Res Function(SubjectInfo) _then;

/// Create a copy of SubjectInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subjectName = null,Object? chapterMajor = null,Object? chapterMinor = null,Object? sourceReference = null,Object? version = null,}) {
  return _then(_self.copyWith(
subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,chapterMajor: null == chapterMajor ? _self.chapterMajor : chapterMajor // ignore: cast_nullable_to_non_nullable
as String,chapterMinor: null == chapterMinor ? _self.chapterMinor : chapterMinor // ignore: cast_nullable_to_non_nullable
as String,sourceReference: null == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubjectInfo].
extension SubjectInfoPatterns on SubjectInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubjectInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubjectInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubjectInfo value)  $default,){
final _that = this;
switch (_that) {
case _SubjectInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubjectInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SubjectInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_name')  String subjectName, @JsonKey(name: 'chapter_major')  String chapterMajor, @JsonKey(name: 'chapter_minor')  String chapterMinor, @JsonKey(name: 'source_reference')  String sourceReference,  String version)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubjectInfo() when $default != null:
return $default(_that.subjectName,_that.chapterMajor,_that.chapterMinor,_that.sourceReference,_that.version);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'subject_name')  String subjectName, @JsonKey(name: 'chapter_major')  String chapterMajor, @JsonKey(name: 'chapter_minor')  String chapterMinor, @JsonKey(name: 'source_reference')  String sourceReference,  String version)  $default,) {final _that = this;
switch (_that) {
case _SubjectInfo():
return $default(_that.subjectName,_that.chapterMajor,_that.chapterMinor,_that.sourceReference,_that.version);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'subject_name')  String subjectName, @JsonKey(name: 'chapter_major')  String chapterMajor, @JsonKey(name: 'chapter_minor')  String chapterMinor, @JsonKey(name: 'source_reference')  String sourceReference,  String version)?  $default,) {final _that = this;
switch (_that) {
case _SubjectInfo() when $default != null:
return $default(_that.subjectName,_that.chapterMajor,_that.chapterMinor,_that.sourceReference,_that.version);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubjectInfo implements SubjectInfo {
  const _SubjectInfo({@JsonKey(name: 'subject_name') required this.subjectName, @JsonKey(name: 'chapter_major') required this.chapterMajor, @JsonKey(name: 'chapter_minor') required this.chapterMinor, @JsonKey(name: 'source_reference') required this.sourceReference, required this.version});
  factory _SubjectInfo.fromJson(Map<String, dynamic> json) => _$SubjectInfoFromJson(json);

/// 과목명
@override@JsonKey(name: 'subject_name') final  String subjectName;
/// 대단원
@override@JsonKey(name: 'chapter_major') final  String chapterMajor;
/// 소단원
@override@JsonKey(name: 'chapter_minor') final  String chapterMinor;
/// 출처
@override@JsonKey(name: 'source_reference') final  String sourceReference;
/// 버전
@override final  String version;

/// Create a copy of SubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectInfoCopyWith<_SubjectInfo> get copyWith => __$SubjectInfoCopyWithImpl<_SubjectInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubjectInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectInfo&&(identical(other.subjectName, subjectName) || other.subjectName == subjectName)&&(identical(other.chapterMajor, chapterMajor) || other.chapterMajor == chapterMajor)&&(identical(other.chapterMinor, chapterMinor) || other.chapterMinor == chapterMinor)&&(identical(other.sourceReference, sourceReference) || other.sourceReference == sourceReference)&&(identical(other.version, version) || other.version == version));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subjectName,chapterMajor,chapterMinor,sourceReference,version);

@override
String toString() {
  return 'SubjectInfo(subjectName: $subjectName, chapterMajor: $chapterMajor, chapterMinor: $chapterMinor, sourceReference: $sourceReference, version: $version)';
}


}

/// @nodoc
abstract mixin class _$SubjectInfoCopyWith<$Res> implements $SubjectInfoCopyWith<$Res> {
  factory _$SubjectInfoCopyWith(_SubjectInfo value, $Res Function(_SubjectInfo) _then) = __$SubjectInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'subject_name') String subjectName,@JsonKey(name: 'chapter_major') String chapterMajor,@JsonKey(name: 'chapter_minor') String chapterMinor,@JsonKey(name: 'source_reference') String sourceReference, String version
});




}
/// @nodoc
class __$SubjectInfoCopyWithImpl<$Res>
    implements _$SubjectInfoCopyWith<$Res> {
  __$SubjectInfoCopyWithImpl(this._self, this._then);

  final _SubjectInfo _self;
  final $Res Function(_SubjectInfo) _then;

/// Create a copy of SubjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subjectName = null,Object? chapterMajor = null,Object? chapterMinor = null,Object? sourceReference = null,Object? version = null,}) {
  return _then(_SubjectInfo(
subjectName: null == subjectName ? _self.subjectName : subjectName // ignore: cast_nullable_to_non_nullable
as String,chapterMajor: null == chapterMajor ? _self.chapterMajor : chapterMajor // ignore: cast_nullable_to_non_nullable
as String,chapterMinor: null == chapterMinor ? _self.chapterMinor : chapterMinor // ignore: cast_nullable_to_non_nullable
as String,sourceReference: null == sourceReference ? _self.sourceReference : sourceReference // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
