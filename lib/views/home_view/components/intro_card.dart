import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IntroCards extends StatelessWidget {

  const IntroCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String intro = AppLocalizations.of(context)!.startPrompt;

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:16, horizontal: 24),
            child: Text(intro,
                textAlign: TextAlign.center,
                maxLines: 3,
               overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
        ),
      ),
    );
  }
}
