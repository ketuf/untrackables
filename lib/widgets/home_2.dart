import 'package:flutter/material.dart';
import 'package:resched/widgets/highway.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:redux/redux.dart';
import 'package:resched/redux/bottom_nav/reducer.dart';
import 'package:resched/redux/you/reducer.dart';
import 'package:resched/redux/models.dart';
import 'package:resched/redux/home/reducer.dart';
import 'package:resched/redux/conversations/reducer.dart';
import 'package:resched/redux/stream/reducer.dart';
List<List<Widget>> body(_HomeViewModel viewModel) => [
	[
		viewModel.isStreamFetch ? LinearProgressIndicator() : ListView.builder(
				itemCount: viewModel.streamMsgOutgoing.length,
				itemBuilder: (context, index) {
					final msg = viewModel.streamMsgOutgoing[index];
					if(!msg.isUs) {
	 				return Container(
						padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
						child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: <Widget>[
								Align(
										alignment: Alignment.topLeft,
										child: Container(
													decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(20),
															color: Colors.yellow,
													),
													padding: const EdgeInsets.all(16),
													child: Row(children: <Widget>[
															msg.isToMutual ? IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 10), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.toEncryptedId!, nickname: msg.to!)), constraints: BoxConstraints(), padding: EdgeInsets.zero): Container(),
															SizedBox(width: 50, child: Text('to: ${msg.to!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
													])
										)),
										Align(
											alignment: Alignment.topCenter,
											child: Container(
														decoration: BoxDecoration(
																borderRadius: BorderRadius.circular(20),
																color: Colors.yellow,
														),
														padding: EdgeInsets.all(16),
														child: SizedBox(width: 100, child: Tooltip(message: '${msg.date.toLocal()}', child: Text(msg.value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold, textAlign: TextAlign.right))))
											)
										),
									Align(
										alignment: Alignment.topRight,
										child: Container(
													decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(20),
															color: Colors.yellow,
													),
													padding: EdgeInsets.all(16),
													child: Row(children: <Widget>[
															SizedBox(width: 50, child: Text('from: ${msg.from!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
															msg.isFromMutual ? IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 10), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.fromEncryptedId! , nickname: msg.from!)), constraints: BoxConstraints(), padding: EdgeInsets.zero): Container(),
													])
										)
									)
							])
					);
				} else {
					return Container(
						padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
						child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: <Widget>[
								Align(
										alignment: Alignment.topLeft,
										child: Container(
													decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(20),
															color: Colors.yellow,
													),
													padding: EdgeInsets.all(16),
													child: Row(children: <Widget>[
														msg.isToMutual ? IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.toEncryptedId!, nickname: msg.to!)), constraints: BoxConstraints(), padding: EdgeInsets.zero) : Container(),
														SizedBox(width: 50, child: Text('to ${msg.to!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),


										])
									)),
								Align(
										alignment: Alignment.topRight,
										child: Container(
													decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(20),
															color: Colors.yellow,
													),
													padding: const EdgeInsets.all(16),
													child: SizedBox(width: 200, child: Tooltip(message: '${msg.date.toLocal()}', child: Text(msg.value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold, overflow: TextOverflow.clip))))
										)
										),


						]));
				}
				}
			),
 			ListView.builder(
						itemCount: viewModel.streamMsgIncoming.length,
						itemBuilder: (context, index) {
							final msg = viewModel.streamMsgIncoming[index];
							if(!msg.isUs) {
			 				return Container(
								padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
								child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: <Widget>[
										Align(
												alignment: Alignment.topLeft,
												child: Container(
															decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(20),
																	color: Colors.yellow,
															),
															padding: const EdgeInsets.all(16),
															child: Row(children: <Widget>[
																	msg.isFromMutual ? IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.toEncryptedId!, nickname: msg.from!)), constraints: BoxConstraints(), padding: EdgeInsets.zero) : Container(),
																	Text('from ${msg.from!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
															])
												)),
												Align(
													alignment: Alignment.topCenter,
													child: Container(
																decoration: BoxDecoration(
																		borderRadius: BorderRadius.circular(20),
																		color: Colors.yellow,
																),
																padding: EdgeInsets.all(16),
																child: Tooltip(message: '${msg.date.toLocal()}', child: Text(msg.value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
													)
												),
											Align(
												alignment: Alignment.topRight,
												child: Container(
															decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(20),
																	color: Colors.yellow,
															),
															padding: EdgeInsets.all(16),
															child: Row(children: <Widget>[
																	Text('to ${msg.to!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
																	msg.isToMutual ? IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.toEncryptedId!, nickname: msg.from!)), constraints: BoxConstraints(), padding: EdgeInsets.zero) : Container(),
															])
												)
											)
									])
							);
						} else {
							return Container(
								padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
								child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: <Widget>[
									Align(
										alignment: Alignment.topLeft,
										child: Container(
													decoration: BoxDecoration(
															borderRadius: BorderRadius.circular(20),
															color: Colors.yellow,
													),
													padding: EdgeInsets.all(16),
													child: Row(children: <Widget>[
															IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed: () => viewModel.profileFollower(Follower(encryptedId: msg.toEncryptedId!, nickname: msg.from!)), constraints: BoxConstraints(), padding: EdgeInsets.zero),
															Text('from: ${msg.from!}', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
													])
										)
									),
										Align(
												alignment: Alignment.topRight,
												child: Container(
															decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(20),
																	color: Colors.yellow,
															),
															padding: const EdgeInsets.all(16),
															child: Tooltip(message: '${msg.date.toLocal()}', child: Text(msg.value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
												)),
									])
								);
							}
						}
					)
	],
	[
		ListView.builder(
			itemCount: viewModel.conversations.length,
			itemBuilder: (context, index) {
				return ListTile(
					title: Text(viewModel.conversations[index][viewModel.conversations.length-1].toFrom),
					subtitle: Text(viewModel.conversations[index][viewModel.conversations.length-1].value),
					onTap: () => viewModel.navigateChat(Follower(encryptedId: viewModel.conversations[index][viewModel.conversations.length-1].encryptedId, nickname: viewModel.conversations[index][viewModel.conversations.length-1].toFrom))
				);
			}
		),
		DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: Colors.black54,
					bottom: TabBar(
						tabs: <Widget>[
							Tab(icon: Icon(Icons.arrow_upward)),
							Tab(icon: Icon(Icons.arrow_downward))
						],
						indicatorColor: Colors.yellow
					)),
					backgroundColor: Colors.black54,
					body: TabBarView(
						children: <Widget>[
						ListView.builder(
							itemCount: viewModel.outgoings.length,
							itemBuilder: (context, index) {
								return Container(
									padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
									child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,  children: <Widget>[
											Align(
													alignment: Alignment.topRight,
													child: Container(
																decoration: BoxDecoration(
																		borderRadius: BorderRadius.circular(20),
																		color: Colors.yellow,
																),
																padding: const EdgeInsets.all(16),
																child: Row(children: <Widget>[
																		IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed: () => viewModel.profileFollower(Follower(encryptedId: viewModel.outgoings[index].encryptedId, nickname: viewModel.outgoings[index].toFrom)), constraints: BoxConstraints(), padding: EdgeInsets.zero),
																		Text(viewModel.outgoings[index].toFrom, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
																])
													)),
												Align(
													alignment: Alignment.topRight,
													child: Container(
																decoration: BoxDecoration(
																		borderRadius: BorderRadius.circular(20),
																		color: Colors.yellow,
																),
																padding: EdgeInsets.all(16),
																child: Tooltip(message: '${viewModel.outgoings[index]!.date.toLocal()}', child: Text(viewModel.outgoings[index].value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
													)
													)
												])
									);
							}
						),
						ListView.builder(
							itemCount: viewModel.incomings.length,
							itemBuilder: (context, index) {
								return Container(
										padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
										child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
											Align(
												alignment: Alignment.topLeft,
												child: Container(
															decoration: BoxDecoration(
																	borderRadius: BorderRadius.circular(20),
																	color: Colors.yellow,
															),
															padding: const EdgeInsets.all(16),
															child: Tooltip(message: '${viewModel.incomings[index]!.date.toLocal()}', child: Text(viewModel.incomings[index].value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
												)
											),
											Align(
												alignment: Alignment.topRight,
												child: Container(
															decoration: BoxDecoration(
																	color: Colors.yellow,
																	borderRadius: BorderRadius.circular(20),
															),
															padding: const EdgeInsets.all(16),
															child: Row(children: <Widget>[
																Text(viewModel.incomings[index].toFrom, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
																		IconButton(icon: Icon(Icons.add_to_home_screen, color: Colors.black, size: 20), onPressed:() => viewModel.profileFollower(Follower(encryptedId: viewModel.incomings[index].encryptedId, nickname: viewModel.incomings[index].toFrom)), constraints: BoxConstraints(), padding: EdgeInsets.zero)
																])
													))])
												);
											}
										)])
						)

					),
			],
	[
		ListView.builder(
			itemCount: viewModel.following.length,
			itemBuilder: (context, index) {
				return ListTile(
					title: Text('${viewModel.following[index].nickname}'),
					subtitle: Text('followers: ${viewModel.following[index].followers}, following:  ${viewModel.following[index].following}'),
					onTap: () => viewModel.profileFollower(viewModel.following[index])
				);
			}
		),
		ListView.builder(
			itemCount: viewModel.followers.length,
			itemBuilder: (context, index) {
				return ListTile(
					title: Text('${viewModel.followers[index].nickname}'),
					subtitle: Text('followers: ${viewModel.followers[index].followers}, following:  ${viewModel.followers[index].following}'),
					onTap: () => viewModel.profileFollower(viewModel.followers[index])
				);
			}
		)
	]
];


class Home extends StatelessWidget {
	Widget build(BuildContext context) {
		return Stack(children: [
			HighWay(),
			StoreConnector<AppState, _HomeViewModel>(
				converter: (store) => _HomeViewModel.create(store),
				builder: (context, viewModel) {
				return DefaultTabController(
				length: 2,
				child: Scaffold(
					appBar: AppBar(
						iconTheme: IconThemeData(
							color: Colors.yellow
						),
						title: Text('(un)trackabl.es', style: TextStyle(color: Colors.yellow)),
						backgroundColor: Colors.black,
						actions: <Widget>[
							StoreConnector<AppState, VoidCallback>(
								converter: (store) {
									return () => store.dispatch(NavigateToAction.push('/follow'));
								},
								builder: (context, callback) {
									return IconButton(icon: Icon(Icons.add), onPressed: callback, color: Colors.yellow);
								}
							),
							StoreConnector<AppState, VoidCallback>(
								converter: (store) {
									return () => store.dispatch(NavigateToAction.replace('/qr'));
								},
								builder: (context, callback) {
									return IconButton(icon: const Icon(Icons.qr_code), onPressed: callback, color: Colors.yellow);
								}
							)
						],
						bottom: (viewModel.index == 0) ?
							TabBar(
								tabs: [
									const Tab(icon: Icon(Icons.arrow_upward)),
									const Tab(icon: Icon(Icons.arrow_downward))
								],
								indicatorColor: Colors.yellow
							) : (viewModel.index == 1 ? TabBar(
								tabs: [
									Tab(icon: Icon(Icons.outbond)),
									Tab(icon: Icon(Icons.other_houses))
								],
								indicatorColor: Colors.yellow
							) :
								TabBar(
								indicatorColor: Colors.yellow,
								tabs: [
									Tab(icon: Icon(Icons.arrow_upward), text: '${viewModel.following.length}'),
									Tab(icon: Icon(Icons.arrow_downward), text: '${viewModel.followers.length}')
								]
							))
					),
					body: TabBarView(
						children: body(viewModel)[viewModel.index]
					),
					backgroundColor: Colors.black54,
					bottomNavigationBar: BottomNavigationBar(
								backgroundColor: Colors.black,
								selectedItemColor: Colors.yellow,
								currentIndex: viewModel.index,
								onTap:(i) => viewModel.navigate(i),
								items: const <BottomNavigationBarItem>[
									BottomNavigationBarItem(
										icon: Icon(Icons.dynamic_feed),
										label: 'stream'
									),
									BottomNavigationBarItem(
										icon: Icon(Icons.chat),
										label: 'chat',
									),
									BottomNavigationBarItem(
										icon: Icon(Icons.flash_on),
										label: 'followers'
									),

								]
							)
				)
			);
			},
			onInit: (store) => [store.dispatch(FetchHomeAction()), store.dispatch(FetchConversationsAction()), store.dispatch(FetchStreamAction())],
			)
		]);
	}
}
class _HomeViewModel {
	final bool isStreamFetch;
	final List<Follower> followers;
	final List<Follower> following;
	final List<OurMsg> incomings;
	final List<OurMsg> outgoings;
	final int index;
	final Function(int) navigate;
	final Function(Follower) profileFollower;
	final Function fetchStreamAction;
	final Function(Follower) navigateChat;
	final List<List<OurMsg>> conversations;
	final List<StreamMsg> streamMsgOutgoing;
	final List<StreamMsg> streamMsgIncoming;
	_HomeViewModel({
		required this.isStreamFetch,
		required this.followers,
		required this.following,
		required this.index,
		required this.navigate,
		required this.profileFollower,
		required this.navigateChat,
		required this.fetchStreamAction,
		required this.incomings,
		required this.outgoings,
		required this.conversations,
		required this.streamMsgOutgoing,
		required this.streamMsgIncoming
	});
	factory _HomeViewModel.create(Store<AppState> store) {
		List<Follower> followers = store.state.you.followers;
		List<Follower> following = store.state.you.following;
		int index = store.state.bottomNav.selected;
		_navigate(int i) {
			store.dispatch(BottomNavIndex(i));
		}
		_profileFollower(Follower f) {
			store.dispatch(NavigateToAction.push("/chatter", arguments: f));
		}
		_navigateChat(Follower f) {
			store.dispatch(NavigateToAction.push('/chat', arguments: f));
		}
		_fetchStreamAction(FetchStreamAction action) {
			store.dispatch(action);
		}
		return _HomeViewModel(
			isStreamFetch: store.state.stream.isFetch,
			followers: followers,
			following: following,
			index: index,
			navigate: _navigate,
			profileFollower: _profileFollower,
			navigateChat: _navigateChat,
			fetchStreamAction: _fetchStreamAction,
			incomings: store.state.home.incomings,
			outgoings: store.state.home.outgoings,
			conversations: store.state.conversations.msgs,
			streamMsgOutgoing: store.state.stream.outgoing,
			streamMsgIncoming: store.state.stream.incoming
		);
	}
}
