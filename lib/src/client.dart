// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

/// Contains the [Client] class.
library dogma.rest_connection.src.client;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:math' as math;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'request.dart';
import 'request_factory.dart';
import 'request_method.dart';

import 'rest_credentials.dart';

//---------------------------------------------------------------------
// Exports
//---------------------------------------------------------------------

export 'request_method.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A wrapper around a [Request] used to handle retries.
///
/// When a request fails due to a network or authentication error the [Future]
/// returned by [Request.send] is no longer valid. Because of this the request
/// needs to be wrapped by the client so it can handle any retries internally
/// before notifying the application.
///
/// Since the class is only used by [Client] it is not exposed by the library.
class _ClientRequest {
  /// The [Request] to wrap.
  final Request request;
  /// The [Completer] used to notify the application when the [request] completes.
  final Completer<dynamic> completer = new Completer<dynamic>();
  /// The number of attempts to get the resource.
  int attempts = 0;

  /// Creates an instance of the [_ClientRequest] class.
  _ClientRequest(this.request);
}

class Client {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// Access credentials for the client.
  final RestCredentials credentials;
  /// Pending client requests.
  final List<_ClientRequest> _pendingRequests = new List<_ClientRequest>();
  /// Requests that are currently in flight.
  final List<_ClientRequest> _activeRequests = new List<_ClientRequest>();

  /// The maximum number of retries to attempt.
  int retryAttempts = 1;
  /// The maximum number of active requests to allow.
  int maxActiveRequests = 4;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  Client(this.credentials);

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The number of pending requests.
  ///
  /// A request is pending if it has not yet been dispatched.
  ///
  /// This can happen for the following reasons.
  /// * The server has not yet been authenticated with.
  int get pendingRequestCount => _pendingRequests.length;

  /// The number of active requests.
  ///
  /// A request is active if it has been dispatched but no response has been
  /// received.
  int get activeRequestCount => _activeRequests.length;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Makes a request for the resource at [url] using the GET method.
  Future<dynamic> get(String url, [dynamic data]) {
    return open(url, data: data, method: RequestMethod.Get);
  }

  /// Makes a request for the resource at [url] using the PUT method.
  Future<dynamic> put(String url, [dynamic data]) {
    return open(url, data:data, method: RequestMethod.Put);
  }

  /// Makes a request for the resource at [url] using the POST method.
  Future<dynamic> post(String url, [dynamic data]) {
    return open(url, data: data, method: RequestMethod.Post);
  }

  /// Makes a request for the resource at [url] using the DELETE method.
  Future<dynamic> delete(String url, [dynamic data]) {
    return open(url, data: data, method: RequestMethod.Delete);
  }

  /// Makes a request for the resource at [url] using the given method.
  Future<dynamic> open(String url,
                      {dynamic data,
                       RequestMethod method: RequestMethod.Get,
                       ResponseType responseType: ResponseType.Json})
  {
    // Create the request
    var request = createRequest(url, method, responseType);
    var requestClient = new _ClientRequest(request);

    _pendingRequests.add(requestClient);

    // Process the requests if the credentials are still valid.
    _processRequests();

    return requestClient.completer.future;
  }

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Begins processing any pending requests.
  void _processRequests() {
    // See if the credentials are valid
    if (true) {
      // See if there are any requests that can be processed.
      var requestsToQueue = maxActiveRequests - activeRequestCount;

      if (requestsToQueue > 0) {
        requestsToQueue = math.min(requestsToQueue, _pendingRequests.length);

        for (var i = 0; i < requestsToQueue; ++i) {
          var requestClient = _pendingRequests[i];
          var request = requestClient.request;

          credentials.onRequest(request);

          request.send().then((value) {
            _onResponse(requestClient, value);
          }, onError: (error) {
            _onResponseError(requestClient, error);
          });

          _activeRequests.add(requestClient);
        }

        _pendingRequests.removeRange(0, requestsToQueue);
      }
    }
  }

  /// Callback for a successful response.
  void _onResponse(_ClientRequest requestClient, dynamic value) {
    _activeRequests.remove(requestClient);

    requestClient.completer.complete(value);
  }

  /// Callback for a response that errored.
  void _onResponseError(_ClientRequest requestClient, Object error) {
    _activeRequests.remove(requestClient);

    // See if the resource should be requested again
    requestClient.attempts++;

    if (requestClient.attempts <= retryAttempts) {
      // Give the resource request another try
      _pendingRequests.add(requestClient);
    } else {
      // Giving up on the resource
      requestClient.completer.completeError(error);
    }

    // Process any pending requests
    _processRequests();
  }
}
