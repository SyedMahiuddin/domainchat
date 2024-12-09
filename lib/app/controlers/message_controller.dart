
import 'package:domainchat/app/servieces/api_serviece.dart';
import 'package:get/get.dart';

import '../models/message_model.dart';

class MessageController extends GetxController {

  final RxList<Message> messageList = <Message>[].obs;

  @override
  void onInit() {
    fetchMessages();
    super.onInit();
  }


  Future<void> fetchMessages()async{
    messageList.value= await ApiService.fetchMessages(1);
  }

  String formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return '${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays < 7) {
      return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
