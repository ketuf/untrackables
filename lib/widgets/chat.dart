import 'package:flutter/material.dart';
import 'package:resched/widgets/helpers/border.dart';
import 'package:resched/widgets/highway.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:resched/redux/chat/reducer.dart';
class Chat extends StatelessWidget {
	final _messageController = TextEditingController();
	Widget build(BuildContext context) {
		final args = ModalRoute.of(context)!.settings.arguments as Follower;
		return StoreConnector<AppState, ChatState>(
			converter: (store) => store.state.chat,
			builder: (store, state) {
				if(state.isFetch) {
					return Stack(children: <Widget>[
						HighWay(),
						Scaffold(
							backgroundColor: Colors.black54,
							body: LinearProgressIndicator()
						)
					]);
				}
				print(state.text.length);
				return Stack(children: <Widget>[
					HighWay(),
					Scaffold(
						backgroundColor: Colors.black54,
						appBar: AppBar(title: Text(''), backgroundColor: Colors.black54),
						body: Stack(children: <Widget>[
						Padding(padding: EdgeInsets.only(bottom: 100), child:
						ListView.builder(
							itemCount: state.text.length,
							itemBuilder: (context, index) {
							    return Container(
							    	padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
							    	child: Align(
							    		alignment: state.text[index].ours ? Alignment.topRight : Alignment.topLeft,
							    		child: Container(
					    		          decoration: BoxDecoration(
						    		            borderRadius: BorderRadius.circular(20),
						    		            color: Colors.yellow,
					    		          ),
					    		          padding: EdgeInsets.all(16),
					    		          child: Tooltip(message: '${state.text[index]!.date.toLocal()}', child: Text(state.text[index].value, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)))
								    	)
								    	)
							    );
							}
						)),
						Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
						Container(
						  margin: EdgeInsets.all(15.0),
						  height: 61,
						  child: Row(
						    children: [
						      Expanded(
						        child: Container(
						          decoration: BoxDecoration(
						            color: Colors.yellow,
						            borderRadius: BorderRadius.circular(35.0),
						            boxShadow: [
						              BoxShadow(
						                  offset: Offset(0, 3),
						                  blurRadius: 5,
						                  color: Colors.black)
						            ],
						          ),
						          child: Row(
						            children: [
						              IconButton(
						                  icon: Icon(Icons.chat , color: Colors.black,), onPressed: () {}),
						              Expanded(
						                child: TextField(
								                cursorColor: Colors.black,
								                style: TextStyle(color: Colors.black),
						    	                decoration: InputDecoration(
						                      		hintText: "Message...",
						                      		hintStyle: TextStyle( color:     Colors.yellow),
						                      		border: InputBorder.none
						                      	),
						                controller: _messageController,
						              )),
						              IconButton(
						                icon: Icon(Icons.photo_camera ,  color: Colors.black),
						                onPressed: () {},
						              ),
						              IconButton(
						                icon: Icon(Icons.attach_file ,  color: Colors.black),
						                onPressed: () {},
						              )
						            ],
						          ),
						        ),
						      ),
						      SizedBox(width: 15),
						      StoreConnector<AppState, VoidCallback>(
						      	converter: (store) {
									return () => store.dispatch(FetchMessageChatAction(_messageController.text, args.encryptedId));
						      	},
						      	builder: (state, callback) {
							      	return Container(
							        padding: const EdgeInsets.all(15.0),
							        decoration: BoxDecoration(
							            color: Colors.yellow, shape: BoxShape.circle),
							        child: InkWell(
							          child: Icon(
							            Icons.send_rounded,
							            color: Colors.black,
							          ),
							          onTap: callback
							        ),
							      );
						      	}
							),
						    ],
						  ),
						) ,
						])
					]))
				]);
			},
			onInit: (store) => store.dispatch(MessagesChatAction(args.encryptedId)),
			onWillChange: (ChatState? prev, ChatState? cur) {
				if(cur!.isFetchError!) {
					print('snackbar');
					var snackbar = SnackBar(
						content: Text('${cur!.fetchErrorMessage!}', style: TextStyle(color: Colors.yellow)),
						backgroundColor: Colors.black
					);
					ScaffoldMessenger.of(context).showSnackBar(snackbar);
				} else if (cur!.isFetchSuccess) {
					_messageController.text = '';
				}
			}
		);
	}
}
