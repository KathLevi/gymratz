// This is for testing login screen functionality

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymratz/screens/register.dart';
// import 'package:mockito/mockito.dart';

import 'package:gymratz/screens/login.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Login screen functionality', (WidgetTester tester) async {
    // arrange
    final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
      '/register': (BuildContext context) => RegisterScreen(),
    };
    
    // act
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      home: LoginScreen()
    ));

    await tester.tap(find.byKey(Key('signUpButton')));
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(RegisterScreen), findsOneWidget);

  });
}
