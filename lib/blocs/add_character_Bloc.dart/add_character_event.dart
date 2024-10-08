import 'package:equatable/equatable.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/models/story_model.dart';

// Base Event class
abstract class AddCharacterEvent extends Equatable {
  const AddCharacterEvent();

  @override
  List<Object?> get props => [];
}

// Event for page change
class PageChangeEvent extends AddCharacterEvent {
  final int currentPageIndex;

  const PageChangeEvent(this.currentPageIndex);

  @override
  List<Object?> get props => [currentPageIndex];
}

class LanguageChangeEvent extends AddCharacterEvent {
  final Language language;

  const LanguageChangeEvent(this.language);

  @override
  List<Object?> get props => [language];
}

class AddLovedOnceEvent extends AddCharacterEvent {
  final Lovedonces lovedOnce;
  final int selectedindex;
  const AddLovedOnceEvent(this.lovedOnce, {required this.selectedindex});

  @override
  List<Object?> get props => [lovedOnce, selectedindex];
}

class ResetLovedOnceEvent extends AddCharacterEvent {
  const ResetLovedOnceEvent();

  @override
  List<Object?> get props => [];
}

class AddlessonEvent extends AddCharacterEvent {
  final String lesson;
  final int selectedindexlesson;

  const AddlessonEvent(this.lesson, {required this.selectedindexlesson});

  @override
  List<Object?> get props => [lesson, selectedindexlesson];
}

class ResetlessonEvent extends AddCharacterEvent {
  const ResetlessonEvent();

  @override
  List<Object?> get props => [];
}

class UpdateGenreEvent extends AddCharacterEvent {
  final String genre;
  const UpdateGenreEvent(this.genre);

  @override
  List<Object?> get props => [genre];
}

class UpdateMusicandspeedEvent extends AddCharacterEvent {
  final String musicandspeed;
  const UpdateMusicandspeedEvent(this.musicandspeed);

  @override
  List<Object?> get props => [musicandspeed];
}
