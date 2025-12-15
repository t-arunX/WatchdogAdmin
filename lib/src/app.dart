import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/chat_screen.dart';
import 'providers/chat_provider.dart';
import 'constants/theme.dart';

class ChatGPTCloneApp extends StatelessWidget {
  const ChatGPTCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        title: 'ChatGPT Clone',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const ChatScreen(),
      ),
    );
  }
}
