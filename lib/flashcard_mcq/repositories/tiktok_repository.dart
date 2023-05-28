import 'dart:collection';

import 'package:cross_mobile/api_service.dart';
import 'package:cross_mobile/flashcard_mcq/models/flash_card.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_model.dart';
import 'package:cross_mobile/flashcard_mcq/models/mcq_option.dart';

class TikTokRepository {
  final APIService _apiService;

  TikTokRepository(this._apiService);

  Future<FlashCard> fetchNextFollowing() async {
    final response = await _apiService.get<Map<String, dynamic>>(path: APIService.following);
    if (response != null) {
      return FlashCard.fromJson(response);
    } else {
      throw Exception("Failed to Fetch next info");
    }
  }

  Future<MCQModel> fetchNextForYou() async {
    final response = await _apiService.get<Map<String, dynamic>>(path: APIService.forYou);
    if (response != null) {
      return MCQModel.fromJson(response);
    } else {
      throw Exception("Failed to Fetch next info");
    }
  }

  Future<List<MCQOption>> fetchAnswers(String id) async {
    Map<String, dynamic> queryParams = HashMap();
    queryParams["id"] = id;
    final response =
        await _apiService.get<Map<String, dynamic>>(path: APIService.revealAnswer, queryParams: queryParams);
    if (response != null) {
      return (response["correct_options"] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((e) => MCQOption.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to fetch answers");
    }
  }
}
