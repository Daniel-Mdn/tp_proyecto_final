import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tp_proyecto_final/model/client_model.dart';

class ClientProvider extends ChangeNotifier {
  final Dio dio;

  ClientProvider({required this.dio});

}
