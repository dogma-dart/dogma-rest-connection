// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [RequestHtml] class.
library dogma.rest_connection.src.request_html;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request.dart';
import 'status_codes.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An implementation of [Request] using the dart:html library.
class RequestHtml extends Request {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The request to the API.
  HttpRequest _request;
  /// The completer for the request.
  Completer<Object> _completer;
  /// The stream subscription to the onLoadEnd event.
  ///
  /// Since the request can be fired multiple times the subscription needs to
  /// be kept track of.
  StreamSubscription<ProgressEvent> _loadSubscription;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates a [RequestHtml] for the given [url] using the specified [method] and [responseType].
  ///
  /// If [method] is not specified it is assumed to be [RequestMethod.Get]. If
  /// the [responseType] is not specified it is assumed to be
  /// [ResponseType.Json].
  RequestHtml(String url, {RequestMethod method: RequestMethod.Get, ResponseType responseType: ResponseType.Json})
      : super(url, method, responseType);

  //---------------------------------------------------------------------
  // Request
  //---------------------------------------------------------------------

  @override
  Future<dynamic> send([dynamic data]) {
    // Cancel the current subscription
    if (_loadSubscription != null) {
      _loadSubscription.cancel();
    }

    // Create the request and the associated completer
    _request = new HttpRequest();
    _completer = new Completer<Object>();

    // Open the request
    var methodString;

    switch (method) {
      case RequestMethod.Get:
        methodString = 'GET';
        break;
      case RequestMethod.Post:
        methodString = 'POST';
        break;
      case RequestMethod.Put:
        methodString = 'PUT';
        break;
      case RequestMethod.Delete:
        methodString = 'DELETE';
        break;
    }

    _request.open(methodString, url);

    // Set the headers
    headers.forEach((header, value) {
      _request.setRequestHeader(header, value);
    });

    // Set the response type
    var requestedResponseType;

    switch (responseType) {
      case ResponseType.Json:
        requestedResponseType = 'json';
        break;
      case ResponseType.Text:
        requestedResponseType = 'text';
        break;
      case ResponseType.ByteBuffer:
        requestedResponseType = 'arraybuffer';
        break;
    }

    _request.responseType = requestedResponseType;

    // Setup the callbacks
    _loadSubscription = _request.onLoadEnd.listen((onData) {
      var status = _request.status;

      if (requestSuccessful(status)) {
        var response = _request.response;

        if (responseType == ResponseType.Json) {
          if (response is String) {
            try {
              response = JSON.decode(response);
            } on FormatException catch (ex) {
              _completer.completeError(new Error());
            }
          }

          assert(response is Map || response is List);
        } else if (responseType == ResponseType.ByteBuffer) {
          assert(response is ByteBuffer);
        } else if (responseType == ResponseType.Text) {
          assert(response is String);
        }

        _completer.complete(response);
      } else {
        _completer.completeError(new Error());
      }
    });

    // Send the request
    _request.send(data);

    return _completer.future;
  }
}
