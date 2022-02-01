import 'package:redux_epics/redux_epics.dart';
import 'dart:async';
import 'package:resched/redux/home/reducer.dart';
import 'package:dio/dio.dart';
import 'package:resched/redux/models.dart';
import 'dart:convert';
import 'package:resched/redux/combiner.dart';
Stream<dynamic> fetchHomeAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is FetchHomeAction)
	.asyncMap<dynamic>((action) => Dio().get('${store.state.url.url}/profile', options: Options(headers: {
		'Authorization': 'Bearer ${store.state.login.accessToken}'
	})).then((res) => FetchSuccessHomeAction(
		List<OurMsg>.from(json.decode(res.data['outgoing']).map((x) => OurMsg.fromJson(x))),
		List<OurMsg>.from(json.decode(res.data['incoming']).map((x) => OurMsg.fromJson(x))),
	)).catchError((error) => FetchErrorHomeAction(error.response['error'])));
}

