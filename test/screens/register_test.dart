// This is for testing login screen functionality

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymratz/screens/register.dart';
import 'package:gymratz/screens/login.dart';
import 'package:gymratz/routes.dart';
// import 'package:mockito/mockito.dart';

// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  testWidgets('Register screen functionality', (WidgetTester tester) async {
    // arrange
        
    // act
    await tester.pumpWidget(MaterialApp(
      routes: routes,
      initialRoute: '/register'

    ));

    // expect RegisterScreen from initialRoute
    expect(find.byType(RegisterScreen), findsOneWidget);

    await tester.tap(find.byKey(RegisterScreen.loginButtonKey));
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(LoginScreen), findsOneWidget);

  });
}
