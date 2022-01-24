import 'package:redux/redux.dart';
import 'package:resched/redux/register/reducer.dart';
import 'package:resched/redux/login/reducer.dart';
import 'package:resched/redux/follow/reducer.dart';
import 'package:resched/redux/qr/reducer.dart';
import 'package:resched/redux/url/reducer.dart';
import 'package:resched/redux/bottom_nav/reducer.dart';
import 'package:resched/redux/you/reducer.dart';
import 'package:resched/redux/chat/reducer.dart';
import 'package:resched/redux/profile/reducer.dart';
class AppState {
	final RegisterState register;	
	final LoginState login;
	final FollowState follow;
	final QrState qr;
	final UrlState url;
	final BottomNavState bottomNav;
	final YouState you;
	final ChatState chat;
	final ProfileState profile;
	AppState({ 
		required this.register, 
		required this.login, 
		required this.follow, 
		required this.qr, 
		required this.url, 
		required this.bottomNav, 
		required this.you, 
		required this.chat,
		required this.profile
	});
	AppState.initial():
		register = RegisterState.initial(),
		login = LoginState.initial(),
		follow = FollowState.initial(),
		qr = QrState.initial(),
		url = UrlState.initial(),
		bottomNav = BottomNavState.initial(),
		you = YouState.initial(),
		chat = ChatState.initial(),
		profile = ProfileState.initial();
	AppState copyWith({
		RegisterState? register,
		LoginState? login,
		FollowState? follow,
		QrState? qr,
		UrlState? url,
		BottomNavState? bottomNav,
		YouState? you,
		ChatState? chat,
		ProfileState? profile
	}) {
		return AppState(
			register: register ?? this.register,
			login: login ?? this.login,
			follow: follow ?? this.follow,
			qr: qr ?? this.qr,
			url: url ?? this.url,
			bottomNav: bottomNav ?? this.bottomNav,
			you: you ?? this.you,
			chat: chat ?? this.chat,
			profile: profile ?? this.profile
		);
	}
}
final appReducer = combineReducers<AppState>([
	TypedReducer<AppState, RegisterAction>(_register), 
	TypedReducer<AppState, LoginAction>(_login),
	TypedReducer<AppState, FollowAction>(_follow),
	TypedReducer<AppState, QrAction>(_qr),
	TypedReducer<AppState, UrlAction>(_url),
	TypedReducer<AppState, BottomNavAction>(_bottomNav),
	TypedReducer<AppState, YouAction>(_you),
	TypedReducer<AppState, ChatAction>(_chat),
	TypedReducer<AppState, ProfileAction>(_profile)
]);
AppState _register(AppState state, RegisterAction action) {
	return state.copyWith(register: registerReducer(state.register, action));	
}
AppState _login(AppState state, LoginAction action) {
	return state.copyWith(login: loginReducer(state.login, action));
}
AppState _follow(AppState state, FollowAction action) {
	return state.copyWith(follow: followReducer(state.follow, action));
}
AppState _qr(AppState state, QrAction action) {
	return state.copyWith(qr: qrReducer(state.qr, action));
}
AppState _url(AppState state, UrlAction action) {
	return state.copyWith(url: urlReducer(state.url, action));
}
AppState _bottomNav(AppState state, BottomNavAction action) {
	return state.copyWith(bottomNav: bottomNavReducer(state.bottomNav, action));
}
AppState _you(AppState state, YouAction action) {
	return state.copyWith(you: youReducer(state.you, action));
} 
AppState _chat(AppState state, ChatAction action) {
	return state.copyWith(chat: chatReducer(state.chat, action));
}
AppState _profile(AppState state, ProfileAction action) {
	return state.copyWith(profile: profileReducer(state.profile, action));
}
class Follower {
	String? personalNickname;
	String nickname;
	String encryptedId;
	int followers;
	int following;
	Follower.fromJson(Map<String, dynamic> jsoschon):
		nickname = jsoschon['nickname'],
		encryptedId = jsoschon['encryptedId'],
		followers = jsoschon['followers'],
		following = jsoschon['following'],
		personalNickname = jsoschon['personalNickname'] ?? '';	
}
