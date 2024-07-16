import 'package:flutter/material.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}
