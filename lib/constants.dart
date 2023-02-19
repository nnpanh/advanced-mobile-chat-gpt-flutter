import 'package:flutter/material.dart';

final receiverStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(.12),
          offset: const Offset(0, 27),
          blurRadius: 27,
          spreadRadius: .5)
    ]);

final senderStyle = BoxDecoration(
    color: Colors.teal,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: [
      BoxShadow(
          color: Colors.grey.withOpacity(.12),
          offset: const Offset(0, 27),
          blurRadius: 27,
          spreadRadius: .5)
    ]);


const token = "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";