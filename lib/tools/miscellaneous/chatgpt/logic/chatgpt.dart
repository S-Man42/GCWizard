
import 'dart:isolate';

import 'package:gc_wizard/common_widgets/async_executer/gcw_async_executer_parameters.dart';
import 'package:http/http.dart' as http;

enum ChatGPTstatus {OK, ERROR}

class ChatGPTmodelOutput {
  final ChatGPTstatus status;
  final String httpCode;
  final String httpMessage;
  final List<String> models;

  ChatGPTmodelOutput({required this.status, required this.httpCode, required this.httpMessage, required this.models,});
}

class ChatGPTgetModelListJobData {
  final String chatgpt_api_key;

  ChatGPTgetModelListJobData({required this.chatgpt_api_key});
}

Future<ChatGPTmodelOutput> ChatGPTgetModelListAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! ChatGPTgetModelListJobData) {
    return Future.value(
        ChatGPTmodelOutput(status: ChatGPTstatus.ERROR, httpCode: '', httpMessage: '', models: [], ));
  }
  var chatGPTmodelJob = jobData!.parameters as ChatGPTgetModelListJobData;
  ChatGPTmodelOutput output = await _ChatGPTgetModelListAsync(
      chatGPTmodelJob.chatgpt_api_key,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<ChatGPTmodelOutput> _ChatGPTgetModelListAsync(String APIkey, {SendPort? sendAsyncPort}) async {
  String base_url_chatGPT_models = 'https://api.openai.com/v1/models';
  String httpCode = '';
  String httpMessage = '';
  List<String> models = [];
  ChatGPTstatus status = ChatGPTstatus.ERROR;

  final Map<String, String> CHATGPT_MODEL_HEADERS = {
          'Authorization' : 'Bearer '+APIkey,
  };

  try {
    final http.Response response = await http.get(
      Uri.parse(base_url_chatGPT_models),
      headers: CHATGPT_MODEL_HEADERS,
    );
    status = ChatGPTstatus.OK;
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase.toString();
    response.body.split('\n').forEach((element) {
      if (element.trim().startsWith('"id"')){
        models.add(element.replaceAll(' ', '').replaceAll('"', '').replaceAll('id', '').replaceAll(':', '').replaceAll(',', ''));
      }
    });
  } catch (e) {
    print(e.toString());
  }

  return ChatGPTmodelOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, models: models, );
}