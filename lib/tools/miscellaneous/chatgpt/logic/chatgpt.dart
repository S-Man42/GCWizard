
import 'dart:convert';
import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:http/http.dart' as http;

enum ChatGPTstatus {OK, ERROR}
enum ChatGPTimageDataType {URL, BASE64}

final BASE_URL_CHATGPT_CHAT_TEXT = 'https://api.openai.com/v1/chat/completions';
final BASE_URL_CHATGPT_COMPLETIONS_TEXT = 'https://api.openai.com/v1/completions';

final List<String> MODELS_CHAT = [
  'gpt-4', 'gpt-4-0613', 'gpt-4-32k', 'gpt-4-32k-0613', 'gpt-3.5-turbo', 'gpt-3.5-turbo-0613', 'gpt-3.5-turbo-16k', 'gpt-3.5-turbo-16k-0613',
];

final List<String> MODELS_COMPLETIONS = [
  'gpt-3.5-turbo-instruct', 'babbage-002', 'davinci-002',
];

final Map<String, String> ENDPOINTS = {
  'gpt-4' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-32k' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-4-32k-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-16k' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-16k-0613' : BASE_URL_CHATGPT_CHAT_TEXT,
  'gpt-3.5-turbo-instruct': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
  'babbage-002': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
  'davinci-002': BASE_URL_CHATGPT_COMPLETIONS_TEXT,
};

class ChatGPTtextOutput {
  final ChatGPTstatus status;
  final String httpCode;
  final String httpMessage;
  final String textData;

  ChatGPTtextOutput({required this.status, required this.httpCode, required this.httpMessage, required this.textData,});
}

class ChatGPTimageOutput {
  final ChatGPTstatus status;
  final String httpCode;
  final String httpMessage;
  final String imageData;
  final ChatGPTimageDataType imageDataType;

  ChatGPTimageOutput({required this.status, required this.httpCode, required this.httpMessage, required this.imageData, required this.imageDataType,});
}

class ChatGPTgetChatJobData {
  final String chatgpt_api_key;
  final String chatgpt_model;
  final String chatgpt_prompt;
  final double chatgpt_temperature;

  ChatGPTgetChatJobData({required this.chatgpt_api_key, required this.chatgpt_model, required this.chatgpt_prompt, required this.chatgpt_temperature, });
}

Future<ChatGPTtextOutput> ChatGPTgetTextAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! ChatGPTgetChatJobData) {
    return Future.value(
        ChatGPTtextOutput(status: ChatGPTstatus.ERROR, httpCode: '', httpMessage: '', textData: '', ));
  }
  var ChatGPTgetChatJob = jobData!.parameters as ChatGPTgetChatJobData;
  ChatGPTtextOutput output = await _ChatGPTgetTextAsync(
      ChatGPTgetChatJob.chatgpt_api_key,
      ChatGPTgetChatJob.chatgpt_model,
      ChatGPTgetChatJob.chatgpt_prompt,
      ChatGPTgetChatJob.chatgpt_temperature,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<ChatGPTtextOutput> _ChatGPTgetTextAsync(String APIkey, String model, String prompt, double temperature, {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String textData = '';
  String body = '';
  String uri = '';
  ChatGPTstatus status = ChatGPTstatus.ERROR;

  final Map<String, String> CHATGPT_MODEL_HEADERS = {
    'Content-Type': 'application/json',
    'Authorization' : 'Bearer '+APIkey,
  };

  final CHATGPT_CHAT_BODY = {
    'model': model,
    'messages': [
      {'role': 'user', 'content': prompt}
    ],
    'max_tokens': 1000,
    'temperature': temperature,
  };

  final CHATGPT_COMPLETION_BODY = {
    'model': model,
    'prompt': prompt,
    'max_tokens': 1000,
    'temperature': temperature,
  };

  if (MODELS_CHAT.contains(model)) {
    body = jsonEncode(CHATGPT_CHAT_BODY);
  } else {
    body = jsonEncode(CHATGPT_COMPLETION_BODY);
  }
  try {
    uri = ENDPOINTS[model]!;
    final http.Response response = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase.toString();
    textData = response.body;
    if (httpCode != '200') {
      print('ERROR    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    } else {
      status = ChatGPTstatus.OK;
      print('CORECT    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(textData);
    }
  } catch (e) {
    print(e.toString());
  }

  return ChatGPTtextOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, textData: textData, );
}