part of 'combined_bloc.dart';

@freezed
class CombinedEvent with _$CombinedEvent {
  const factory CombinedEvent.fetchDataEvent() = _FetchDataEvent;
}
