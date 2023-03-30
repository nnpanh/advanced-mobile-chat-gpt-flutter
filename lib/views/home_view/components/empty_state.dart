import 'package:flutgpt/views/home_view/components/intro_card.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatefulWidget {
  const EmptyState({
    Key? key,
  }) : super(key: key);

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        20,
        20,
        8,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("VoiceGPT", style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(
              height: 30,
            ),
            const IntroCards(),
          ],
        ),
      ),
    );
  }
}
