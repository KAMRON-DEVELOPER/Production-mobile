import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object?> get props => [];
}

class GetNotesEvent extends NotesEvent {}

class GetCacheNotesEvent extends NotesEvent {}

class ChangeSequenceEvent extends NotesEvent {}

class ChangeCategoryEvent extends NotesEvent {}

class ChangeColorsEvent extends NotesEvent {}

class PinEvent extends NotesEvent {}
