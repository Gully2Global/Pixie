import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/models/story_model.dart';

import 'add_character_event.dart';
import 'add_character_state.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  AddCharacterBloc()
      : super(const AddCharacterState(
            currentPageIndex: 0,
            language: Language.English,
            lovedOnce: null,
            selectedindex: -1,
            selectedindexlesson: -1,
            selectedindexcharactor: -1,
            genre: 'Funny',
            musicAndSpeed: 'Bedtime',
            fav: false,
            charactorname: null)) {
    // Handle page change events
    on<PageChangeEvent>((event, emit) {
      emit(state.copyWith(currentPageIndex: event.currentPageIndex));
    });

    // Handle language change events
    on<LanguageChangeEvent>((event, emit) {
      emit(state.copyWith(language: event.language));
    });

    // Handle resetting lovedOnce to null
    on<ResetLovedOnceEvent>((event, emit) {
      emit(state.copyWith(lovedOnce: null));
    });
    // handle Loved once change event
    on<AddLovedOnceEvent>((event, emit) {
      emit(state.copyWith(
          lovedOnce: event.lovedOnce, selectedindex: event.selectedindex));
    });

    // Handle resetting lovedOnce to null
    on<ResetlessonEvent>((event, emit) {
      emit(state.copyWith(lessons: null));
    });
    // handle Llesson change event
    on<AddlessonEvent>((event, emit) {
      emit(state.copyWith(
          lessons: event.lesson,
          selectedindexlesson: event.selectedindexlesson));
    });

    // handle add charctor change event
    on<AddcharactorstoryEvent>((event, emit) {
      emit(state.copyWith(
          charactorname: event.charactorname,
          selectedindexcharactor: event.selectedindexcharactor));
    });

    // Handle update genre event
    on<UpdateGenreEvent>((event, emit) {
      emit(state.copyWith(genre: event.genre));
    });
    // Handle update music speed event
    on<UpdateMusicandspeedEvent>((event, emit) {
      emit(state.copyWith(musicAndSpeed: event.musicandspeed));
    });
    // Handle update favbutton event
    on<UpdatefavbuttonEvent>((event, emit) {
      emit(state.copyWith(fav: event.fav));
    });

    // Handle ResetStateEvent to reset bloc state to initial values
    on<ResetStateEvent>((event, emit) {
      emit(const AddCharacterState(
          currentPageIndex: 0,
          language: Language.English,
          lovedOnce: null,
          selectedindex: -1,
          selectedindexlesson: -1,
          selectedindexcharactor: -1,
          genre: 'Funny',
          musicAndSpeed: 'Bedtime',
          fav: false));
    });
  }
}
