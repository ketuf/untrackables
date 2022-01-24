import 'package:dio/dio.dart';
import 'package:resched/redux/login/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/login/reducer.dart';
import 'package:resched/redux/combiner.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:resched/redux/qr/reducer.dart';
import 'package:resched/redux/you/reducer.dart';

Stream<dynamic> login(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is LoginFetch)
	.asyncMap<dynamic>((action) => Dio().post('http://100.115.92.195:8888/auth/token', data: action.body, options: Options(headers: {
		'Content-Type': 'application/x-www-form-urlencoded',
		'Authorization': 'Basic ${action.clientCredentials}'
	})).then<dynamic>((res) => LoginFetchSuccess(res.data['access_token'])).catchError((error) => LoginFetchError(error.response.data['error'])));
}
Stream<dynamic> loginFetchSuccess(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is LoginFetchSuccess)
	.map((action) => NavigateToAction.replace('/home'));
}
Stream<dynamic> loginFetchSuccessTwo(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is LoginFetchSuccess)
	.map((action) => QrId());
}
