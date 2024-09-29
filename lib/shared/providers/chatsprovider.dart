import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../model/Chat/chat_model.dart';
import '../components/text_widget.dart';
import '../constants.dart';
import '../style/checkinternet.dart';
import '../style/color.dart';
import '../style/enum/enum.dart';
class ChatsProvider with ChangeNotifier{

  final model = GenerativeModel(model: 'gemini-pro',
      apiKey: AppConstants.apiKey);

   final List<Message> messages = [];
  List<Message> get getmessages {
    return messages;
  }
  bool isTyping = false;
  late TextEditingController textEditingController;
  late ScrollController listScrollController;
  late FocusNode focusNode;
  AppTheme _currentTheme = AppTheme.lightThem;

  AppTheme get currentTheme => _currentTheme;
  String title = "Light mode";
  void toggleTheme() {
    if (_currentTheme == AppTheme.lightThem) {
      _currentTheme = AppTheme.darkTheme;
      title="Dark mode";
      print(_currentTheme);
    } else {
      _currentTheme = AppTheme.lightThem;
      title="Light mode";
      print(_currentTheme);
    }
    notifyListeners();
  }

  void initState() {
    listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
  }
  Future<void> sendMessage(context) async{
    if(await checkInternet()) {
      if (isTyping) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: TextWidget(
              label: "You cant send multiple messages at a time",
            ),
            backgroundColor: AppMainColors.redColor,
          ),
        );
        return;
      }
      if (textEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: TextWidget(
              label: "Please type a message",
            ),
            backgroundColor: AppMainColors.redColor,
          ),
        );
        return;
      }
      try {
        final message = textEditingController.text;
        isTyping = true;
        messages.add(
            Message(isUser: true,
                message: message, date: DateTime.now()));
        textEditingController.clear();
        focusNode.unfocus();
        notifyListeners();
        final content = [Content.text(message)];
        final response = await model.generateContent(content);
        messages.add(Message(
            isUser: false, message: response.text ?? "",
            date: DateTime.now()));
        notifyListeners();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: TextWidget(
            label: error.toString(),
          ),
          backgroundColor: AppMainColors.redColor,
        ));
      } finally {
        scrollListToEND(context);
        isTyping = false;
        notifyListeners();
      }
    }else{
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text('Alert',style: TextStyle(
                color: Colors.black
              ),),
            ),
            content: Text('Please Check Your internet',
                style: TextStyle(
                    color: Colors.black
                )
            ),
          )
      );
    }
    notifyListeners();
  }

  void scrollListToEND(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listScrollController.hasClients) {
        listScrollController.animateTo(
          listScrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 2),
          curve: Curves.easeOut,
        );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: TextWidget(label: "ScrollController not attached to any scroll views"),
        //     backgroundColor: AppMainColors.redColor,
        //   ),
        // );
        print("somthings error");
      }
    });
  }

  void clearMessages() {
    messages.clear();
    notifyListeners();
  }
  void changeTheme(){

  }
@override
  void dispose() {
  listScrollController.dispose();
  textEditingController.dispose();
  focusNode.dispose();
    super.dispose();
  }

}