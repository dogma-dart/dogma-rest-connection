// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.tests.basic_access_credentials;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:unittest/unittest.dart';
import 'package:dogma_rest_connection/basic_access_credentials.dart';
import 'package:dogma_rest_connection/src/client.dart';

import '../shared/response.dart';
import '../shared/routes.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

void _clientCommunication() {
  group('onRequest', () {
    test('username:password', () {
      var credentials = new BasicAccessCredentials('username', 'password');
      var client = new Client(credentials);

      var callback = expectAsync(() {
        expect(true, true);
      });

      client.get(routes['basicAuthenticationUsername']).then((value) {
        callback();
      });
    });
  });
}

void _tokenGeneration() {
  group('Token generation', () {
    test('username:password', () {
      var credentials = new BasicAccessCredentials('username', 'password');

      expect(credentials.token, tokenUsernamePassword);
    });
    test('Aladdin:open sesame', () {
      var credentials = new BasicAccessCredentials('Aladdin', 'open sesame');

      expect(credentials.token, tokenAladdinOpenSesame);
    });
  });
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  group('BasicAccessCredentials', () {
    _tokenGeneration();
    _clientCommunication();
  });
}
