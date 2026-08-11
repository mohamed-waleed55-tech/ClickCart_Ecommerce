import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/ai_shopping/data/ai_repo.dart';
import 'package:ecommerce_app/features/ai_shopping/data/ai_shopping_response.dart';
import 'package:ecommerce_app/features/ai_shopping/data/api_service.dart';
import 'package:flutter/material.dart';

class AiAssistantRepositoryImp implements AiAssistantRepository {
  final ApiService _apiService;
  final String _apiKey;

  AiAssistantRepositoryImp(Dio dio, this._apiKey)
      : _apiService = ApiService(dio);

  @override
  Future<AiShoppingResponse> getShoppingIntent(String userMessage) async {
   final requestBody = {
  "contents": [
    {
      "parts": [
        {
          "text": '''
          You are a helpful Shopping Assistant API.
          
          TASK: Extract shopping parameters from the user message.
          
          RULES:
          1. If the message is about products, fill the "category", "maxPrice", and "searchQuery" fields.
          2. If the message is conversational (greeting, question about time, etc.), set "category", "maxPrice", and "searchQuery" to null, and put the response in "replyText".
          3. Return ONLY valid JSON that matches the schema exactly. NO extra text, NO markdown, NO "thoughtSignature".
          
          SCHEMA:
          {
            "category": "string or null",
            "maxPrice": 0.0,
            "searchQuery": "string or null",
            "replyText": "رسالة ودودة بالعربي للمستخدم"
          }
          
          USER MESSAGE: "$userMessage"
          '''
        }
      ]
    }
  ],
  "generationConfig": {
    "responseMimeType": "application/json",
    "temperature": 0.1 
  }
};

    try {
      final httpResponse = await _apiService.parseUserIntent(_apiKey, requestBody);
      final responseData = httpResponse.data;
      print(responseData);
      debugPrint(responseData.toString());

      // 1. التحقق من وجود candidates واستخراج النص بأمان دون استخدام [0] بشكل مباشر
      final candidates = responseData?['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw Exception("لم يرجع النموذج أي نتائج (قد يكون بسبب قيود الأمان).");
      }

      final firstCandidate = candidates.first as Map<String, dynamic>?;
      final parts = firstCandidate?['content']?['parts'] as List?;
      
      if (parts == null || parts.isEmpty) {
        throw Exception("استجابة نموذج الذكاء الاصطناعي فارغة.");
      }

      final String? rawText = parts.first['text'] as String?;
      if (rawText == null || rawText.isEmpty) {
        throw Exception("النص المستخرج من Gemini فارغ.");
      }

      // 2. تنظيف النص وتحويله إلى JSON
      final cleanJsonText = rawText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final Map<String, dynamic> jsonMap = jsonDecode(cleanJsonText);

      return AiShoppingResponse.fromJson(jsonMap);
    } catch (e) {
      if (e is DioException) {
    print("Status: ${e.response?.statusCode}");
    print("Data: ${e.response?.data}");
  }

  print(e);
  rethrow;
    }
  }
}