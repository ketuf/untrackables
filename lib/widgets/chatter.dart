import 'package:flutter/material.dart';
import 'package:resched/redux/combiner.dart';
import 'package:resched/widgets/highway.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/profile/reducer.dart';

class Chatter extends StatelessWidget {
	Widget build(BuildContext context) {
		final args = ModalRoute.of(context)!.settings.arguments as Follower;
			StoreConnector<AppState, ProfileState>(
				converter: (store) => store.state.profile,
				builder: (context, state) {
					return Stack(children: <Widget>[
						HighWay(),
						DefaultTabController(
							length: 3,
							child: Scaffold(
								appBar: AppBar(
									title: Text('${args.nickname}/${args.personalNickname}'), 
									backgroundColor: Colors.transparent,
									bottom: TabBar(
										indicatorColor: Colors.yellow,
										tabs: <Widget>[
											Tab(icon: Icon(Icons.arrow_upward)),
											Tab(icon: Icon(Icons.arrow_downward)),														
											Tab(icon: Icon(Icons.chat))
		
										]
									)), 
									body: TabBarView(
										children: <Widget>[
											StoreConnector<AppState, ProfileState>(
												converter: (store) => store.state.profile,
												builder: (context, state) {
													return ListView.builder(
														itemCount: state.following.length,
														itemBuilder: (context, index) {
															return ListTile(
																title: Text('${state.following[index].nickname}'),
																subtitle: state.following[index].mutual ? Text('mutual') : null,
															);
														}
													);
												}
											),
											Icon(Icons.directions_car),
											DefaultTabController(
												length: 2,
												child: Scaffold(
													appBar: AppBar(
														bottom: TabBar(
															indicatorColor: Colors.yellow,
															tabs: <Widget>[
																Tab(icon: Icon(Icons.arrow_upward)),
																Tab(icon: Icon(Icons.arrow_downward)),																							
															]
														)
													),
													body: TabBarView(
															children: <Widget>[
																ListView.builder(
																	itemCount: state.outgoing.length,
																	itemBuilder: (context, index) {
																    return Container(
																    	padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
																    	child: Align(
																    		alignment: Alignment.center,
																    		child: Container(
														    		          decoration: BoxDecoration(
															    		            borderRadius: BorderRadius.circular(20),
															    		            color: Colors.yellow,
														    		          ),
														    		          padding: EdgeInsets.all(16),
														    		          child: Tooltip(message: '${state.outgoing[index]!.date.toLocal()}', child: Text(state.outgoing[index].value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
																	    	)
																	    	)
													    				);
																	}
																),
																ListView.builder(
																	itemCount: state.incoming.length,
																	itemBuilder: (context, index) {
																		return Container(
																	    	padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
																	    	child: Align(
																	    		alignment: Alignment.center,
																	    		child: Container(
															    		          decoration: BoxDecoration(
																    		            borderRadius: BorderRadius.circular(20),
																    		            color: Colors.yellow,
															    		          ),
															    		          padding: EdgeInsets.all(16),
															    		          child: Tooltip(message: '${state.incoming[index]!.date.toLocal()}', child: Text(state.incoming[index].value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
																		    	)
																	    	)
														    			);
																	}
						 										)
															]
															)									
														)

												)
											])
							))]);

				}
			); 			
	}
}

