import 'package:characters_list_app/core/constants/url_handler.dart';
import 'package:characters_list_app/features/characters_page/data/models/page_model.dart';

import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteCharactersPageDataSource {
  Future<CharactersPageModel> getPage(int pageNumber);
}

class RemoteCharactersDataSourceImpl implements RemoteCharactersPageDataSource {
  final http.Client client;

  RemoteCharactersDataSourceImpl({required this.client});

  @override
  Future<CharactersPageModel> getPage(int pageNumber) async {
    final response = await client.get(
      Uri.parse(Urls.getCharactersPage(pageNumber)),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final etag = response.headers['etag'];
      return CharactersPageModel.fromJson(
        json,
      ).copyWith(pageNumber: pageNumber, etag: etag);
    } else {
      throw ServerException();
    }
  }
}
