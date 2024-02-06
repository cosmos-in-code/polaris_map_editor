part of 'place_bloc.dart';

@immutable
abstract class PlaceEvent {}

class RequestedFindPlace extends PlaceEvent {
  final String queryString;
  RequestedFindPlace(this.queryString);
}

class ChangedText extends PlaceEvent {
  final String text;

  ChangedText(this.text);
}

class RetriedFindPlace extends PlaceEvent {
  RetriedFindPlace();
}

class RequestedShowSearchPlacesField extends PlaceEvent {}

class RequestedHideSearchPlacesField extends PlaceEvent {}

class ToggledSearchPlacesVisibility extends PlaceEvent {}
