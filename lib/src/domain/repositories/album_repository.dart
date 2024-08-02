import 'package:bloc_rxdart/src/domain/models/album/album_model.dart';

abstract class AlbumRepository {
  Stream<List<AlbumModel>> getAlbum();
}
