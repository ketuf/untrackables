import 'package:redux/redux.dart';
class UrlState {
	String? url;
	UrlState({ required this.url });
	UrlState.initial(): url = 'http://100.115.92.195:8888';
}
class UrlAction {}
final urlReducer = combineReducers<UrlState>([]);
