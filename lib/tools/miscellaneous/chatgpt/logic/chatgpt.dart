
import 'dart:convert';
import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:http/http.dart' as http;

part 'package:gc_wizard/tools/miscellaneous/chatgpt/logic/chatgpt_text.dart';
part 'package:gc_wizard/tools/miscellaneous/chatgpt/logic/chatgpt_image.dart';

enum ChatGPTstatus {OK, ERROR}

class ChatGPTgetChatJobData {
  final String chatgpt_api_key;
  final String chatgpt_model;
  final String chatgpt_prompt;
  final double chatgpt_temperature;
  final String chatgpt_image_size;
  final bool chatgpt_image_url;

  ChatGPTgetChatJobData({required this.chatgpt_api_key, required this.chatgpt_model, required this.chatgpt_prompt, required this.chatgpt_temperature, required this.chatgpt_image_size, required this.chatgpt_image_url});
}

