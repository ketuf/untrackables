import 'package:dio/dio.dart';
import 'package:resched/redux/qr/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/combiner.dart';
import 'package:resched/redux/you/reducer.dart';
Stream<dynamic> qrId(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions.
	where((action) => action is QrId)
	.asyncMap<dynamic>((action) => Dio().get('http://100.115.92.195:8888/chatter', options: Options(headers: {
		'Authorization': 'Bearer ${store.state.login.accessToken}'
	})).then<dynamic>((res) => QrIdSuccess(res.data['id'])).catchError((error) => QrIdError(error.response['error'])));
}
Stream<dynamic> qrIdSuccess(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is QrIdSuccess)
	.map((action) => FetchYou());
}
