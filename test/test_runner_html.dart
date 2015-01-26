// Copyright (c) 2015, the Dogma Project Authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a zlib license that can be found in
// the LICENSE file.

library dogma.rest_connection.test.test_runner_html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:dogma_rest_connection/src/request_factory_html.dart';

import 'shared/runner.dart';
import 'tests/all.dart' as all;

//---------------------------------------------------------------------
// Application
//---------------------------------------------------------------------

void main() {
  // Initialize the Request factory
  initializeRequests();

  // Make sure the server is present to request to
  testServerConnection().then((_) {
    // Run all the tests
    all.main();
  });
}
