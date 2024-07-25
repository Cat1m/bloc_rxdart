import 'package:bloc_rxdart/src/domain/models/photo/photo.dart';

abstract class PhotoRepository {
  Stream<List<Photo>> getPhotos();
}
