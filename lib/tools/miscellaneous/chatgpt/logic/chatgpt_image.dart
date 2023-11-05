part of 'package:gc_wizard/tools/miscellaneous/chatgpt/logic/chatgpt.dart';

final BASE_URL_CHATGPT_IMAGE = 'https://api.openai.com/v1/images/generations';

enum ChatGPTimageDataType {URL, BASE64, NULL}

Map<String, String> IMAGE_SIZE = {
  '256x256' : '256x256',
  '512x512' : '512x512',
  '1024x1024' : '1024x1024',
};

class ChatGPTimageOutput {
  final ChatGPTstatus status;
  final String httpCode;
  final String httpMessage;
  final String imageData;
  final ChatGPTimageDataType imageDataType;

  ChatGPTimageOutput({required this.status, required this.httpCode, required this.httpMessage, required this.imageData, required this.imageDataType,});
}

Future<ChatGPTimageOutput> ChatGPTgetImageAsync(GCWAsyncExecuterParameters? jobData) async {
  if (jobData?.parameters is! ChatGPTgetChatJobData) {
    return Future.value(
        ChatGPTimageOutput(status: ChatGPTstatus.ERROR, httpCode: '', httpMessage: '', imageData: '', imageDataType: ChatGPTimageDataType.NULL));
  }
  var ChatGPTgetChatJob = jobData!.parameters as ChatGPTgetChatJobData;
  ChatGPTimageOutput output = await _ChatGPTgetImageAsync(
      ChatGPTgetChatJob.chatgpt_api_key,
      ChatGPTgetChatJob.chatgpt_model,
      ChatGPTgetChatJob.chatgpt_prompt,
      ChatGPTgetChatJob.chatgpt_temperature,
      ChatGPTgetChatJob.chatgpt_image_url,
      sendAsyncPort: jobData.sendAsyncPort);

  jobData.sendAsyncPort?.send(output);

  return output;
}

Future<ChatGPTimageOutput> _ChatGPTgetImageAsync(String APIkey, String model, String prompt, double temperature, bool imageUrl, {SendPort? sendAsyncPort}) async {
  String httpCode = '';
  String httpMessage = '';
  String imageData = '';
  ChatGPTstatus status = ChatGPTstatus.ERROR;

  try {
    final Map<String, String> CHATGPT_MODEL_HEADERS = {
      'Content-Type': 'application/json',
      'Authorization' : 'Bearer '+APIkey,
    };

    final CHATGPT_IMAGE_BODY = {
      'model': 'model',
      'prompt': prompt,
      'n': 1,
      'size': '1024x1024',
      'response_format': imageUrl ? 'url' : 'b64_json',
    };

    final body = jsonEncode(CHATGPT_IMAGE_BODY);
    print(body);
    final uri = BASE_URL_CHATGPT_IMAGE;
    final http.Response response = await http.post(
      Uri.parse(uri),
      headers: CHATGPT_MODEL_HEADERS,
      body: body,
    );
    httpCode = response.statusCode.toString();
    httpMessage = response.reasonPhrase.toString();
    imageData = response.body;
    if (httpCode != '200') {
      print('ERROR    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(imageData);
    } else {
      status = ChatGPTstatus.OK;
      print('CORECT    ----------------------------------------------------------------');
      print(httpCode);
      print(httpMessage);
      print(imageData);
    }
  } catch (e) {
    print(e.toString());
  }

  return ChatGPTimageOutput(status: status, httpCode: httpCode, httpMessage: httpMessage, imageData: imageData, imageDataType: ChatGPTimageDataType.NULL);
}