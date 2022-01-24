import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/widgets/highway.dart';
import 'package:resched/widgets/typer.dart';
import 'package:resched/widgets/helpers/border.dart';
import 'package:resched/widgets/login.dart';
import 'package:resched/redux/register/reducer.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/register/epics.dart';
import 'package:resched/redux/login/epics.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:resched/widgets/home.dart';
import 'package:resched/widgets/qr.dart';
import 'package:resched/widgets/follow.dart';
import 'package:resched/redux/qr/epics.dart';
import 'package:resched/redux/follow/epics.dart';
import 'package:resched/redux/you/epics.dart';
import 'package:resched/widgets/profile_following.dart';
import 'package:resched/widgets/chatter.dart';
import 'package:resched/widgets/chat.dart';
import 'package:resched/redux/chat/epics.dart';
import 'package:resched/redux/profile/epics.dart';
void main() {
	runApp(MyApp());
}
final eschep = combineEpics<AppState>([
	register,
	login,
	loginFetchSuccess,
	loginFetchSuccessTwo,
	qrId,
	qrIdSuccess,
	followFetch,
	fetchYou,
	fetchMessageChatAction,
	fetchSuccessMessageChatAction,
	messagesChatAction,
	fetchProfileAction
]);
var epicMiddleware = EpicMiddleware(eschep);
final store = Store<AppState>(combineReducers<AppState>([appReducer]), initialState: AppState.initial(), middleware: [epicMiddleware, NavigationMiddleware()]);
class MyApp extends StatelessWidget {
	Widget build(BuildContext) {
		return StoreProvider<AppState>(
			store: store,
			child: MaterialApp(
      				title: 'Flutter Demo',
      				theme: ThemeData(
        				primarySwatch: Colors.yellow,
        				brightness: Brightness.dark,
        				tabBarTheme: TabBarTheme(
        					labelColor: Colors.yellow,
        				),
        				iconTheme: IconThemeData(
        					color: Colors.yellow
        				)
      				),
      				navigatorKey: NavigatorHolder.navigatorKey,
      				routes: {
      					'/': (ctx) => Register(),
      					'/login': (ctx) => Login(),
      					'/home': (ctx) => Home(),
      					'/follow': (ctx) => Follow(),
      					'/qr': (ctx) => Qr(),
      					'/profile_following': (ctx) => ProfileFollowing(),
      					'/chatter': (ctx) => Chatter(),
      					'/chat': (ctx) => Chat()
      				}
    	));
	}
}
class Register extends StatelessWidget {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  List<Widget> foschorm(BuildContext context, RegisterState state) {
    return [
  	  Typer(),
      SizedBox(height: 160),
      TextField(
         cursorColor: Colors.yellow,
         style: const TextStyle(color: Colors.yellow),
         obscureText: false,
         decoration: InputDecoration(
         labelText: 'E-mail',
         labelStyle: const TextStyle(color: Colors.yellow),
         border: const OutlineInputBorder(),
         enabledBorder: border(),
         focusedBorder: border(),    
        ),
        controller: _emailController,
      ),
      SizedBox(height: 40),
      TextField(
      cursorColor: Colors.yellow,
      style: const TextStyle(color: Colors.yellow),
      obscureText: false,
      decoration: InputDecoration(
      labelText: 'Username',
      labelStyle: const TextStyle(color: Colors.yellow),
      border: const OutlineInputBorder(),
      enabledBorder: border(),
      focusedBorder: border()
      ),
      controller: _usernameController,
      ),
      SizedBox(height: 40),
      TextField(
      cursorColor: Colors.yellow,
      obscureText: true,
      decoration: InputDecoration(
      labelText: 'Password',
      labelStyle: const TextStyle(color: Colors.yellow),
      border: const OutlineInputBorder(),
      enabledBorder: border(),
      focusedBorder: border()
      ),
      controller: _passwordController,
      ),
      SizedBox(height: 40),
    ];
  }


  @override
  Widget build(BuildContext context) {
  	return StoreConnector<AppState, RegisterState>(
  		converter: (store) => store.state.register,
  		builder: (context, state) {
  			if (state.isFetchError) {
 				var foschor = foschorm(context, state);
				return Stack(children: <Widget>[
	                 const HighWay(),
	                 Scaffold(
	                 	appBar: AppBar(title: Text('${state.fetchErrorMessage}', style: TextStyle(color: Colors.yellow)), backgroundColor: Colors.transparent),
		              	backgroundColor: Colors.transparent,
	    	           	body: Padding(padding: const EdgeInsets.only(left: 40, right: 40),
	        	            child: Card(color: Colors.black54,
		        	           child: Column(children: foschor))), 
	                   floatingActionButton: StoreConnector<AppState, _ViewModel>(
 						converter: (store) => _ViewModel.create(store),
    					builder: (context, viewmodel) {
 							return Padding(padding: EdgeInsets.all(32), child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
 								children: <Widget>[
 									FloatingActionButton.extended(
				   						onPressed:() => viewmodel.onLogin(),
				   						label: const Text('login'),
	   			   						icon: Icon(Icons.login),
				   						backgroundColor: Colors.yellow
				   					),
				   					FloatingActionButton.extended(
				   						onPressed: () => viewmodel.onRegister(RegisterFetch(_emailController.text, _usernameController.text, _passwordController.text)),
				   						label: const Text('register'),
				   						icon: Icon(Icons.app_registration),
				   						backgroundColor: Colors.yellow
				   					)	
 								])
 							);
  						}
  					))
                ]);
				
  			}
  			else if (state.isFetchSuccess) {
  				return Stack(children: <Widget>[
  					const HighWay(),
 					Scaffold(
						appBar: AppBar(title: Text('Please confirm your e-mail', style: TextStyle(color: Colors.yellow)), backgroundColor: Colors.transparent),
		              	backgroundColor: Colors.black54,
	                )
  				]);
  			} 
			else if (!state.isFetch) {
 				 var foschor = foschorm(context, state);				                
                 return Stack(children: <Widget>[
                 const HighWay(),
                 Scaffold(
	              	backgroundColor: Colors.transparent,
    	           	body: Padding(padding: const EdgeInsets.only(left: 40, right: 40),
        	            child: Card(color: Colors.black54,
	        	           child: Column(children: foschor))),
	        	   floatingActionButton: StoreConnector<AppState, _ViewModel>(
 						converter: (store) => _ViewModel.create(store),
    					builder: (context, viewmodel) {
 							return Padding(padding: EdgeInsets.all(32), child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
 								children: <Widget>[
 									FloatingActionButton.extended(
				   						onPressed:() => viewmodel.onLogin(),
				   						label: const Text('login'),
	   			   						icon: Icon(Icons.login),
				   						backgroundColor: Colors.yellow
				   					),
				   					FloatingActionButton.extended(
				   						onPressed: () => viewmodel.onRegister(RegisterFetch(_emailController.text, _usernameController.text, _passwordController.text)),
				   						label: const Text('register'),
				   						icon: Icon(Icons.app_registration),
				   						backgroundColor: Colors.yellow
				   					)	
 								])
 							);
  						}
  					)
                  )
                ]);
			} else if (state.isFetch) {
                return Stack(children: const <Widget>[
                  HighWay(),
                  Padding(padding: EdgeInsets.only(left: 40, right: 40),
                      child: Card(color: Colors.black54,
                          child: LinearProgressIndicator()))
                ]);				
			} 
			else return HighWay();
  		}	
  	);
  }
}
class _ViewModel {
	final Function onLogin;
	final Function(RegisterFetch) onRegister;
	_ViewModel({
		required this.onLogin,
		required this.onRegister
	});
	factory _ViewModel.create(Store<AppState> store) {
		_onLogin() {
			store.dispatch(NavigateToAction.replace('/login'));
		}
		_onRegister(RegisterFetch rf) {
			store.dispatch(rf);
		}
		return _ViewModel(
			onLogin: _onLogin,
			onRegister: _onRegister
		);
	}
}
