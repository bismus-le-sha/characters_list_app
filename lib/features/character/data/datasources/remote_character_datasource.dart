import 'package:characters_list_app/core/constants/url_handler.dart';
import 'package:characters_list_app/features/character/data/models/page_model.dart';

import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class RemoteCharacterDataSource {
  Future<PageModel> getPage(int pageNumber);
}

class RemoteCharacterDataSourceImpl implements RemoteCharacterDataSource {
  final http.Client client;

  RemoteCharacterDataSourceImpl({required this.client});

  @override
  Future<PageModel> getPage(int pageNumber) async {
    final response = await client.get(
      Uri.parse(Urls.getCharactersPage(pageNumber)),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final etag = response.headers['etag'];
      return PageModel.fromJson(
        json,
      ).copyWith(pageNumber: pageNumber, etag: etag);
    } else {
      throw ServerException();
    }
  }
}
