class Msg {
	String value;
	DateTime date;
	Msg(this.value, this.date);
	Msg.fromJson(Map<String, dynamic> jsoschon): value = jsoschon['value'], date = DateTime.parse(jsoschon['date']); 	
}
class ChatMsg extends Msg {
	bool ours;
	ChatMsg(this.ours, String value, DateTime date): super(value, date);
	ChatMsg.fromJson(Map<String, dynamic> jsoschon): ours = jsoschon['ours'], super.fromJson(jsoschon);
}
class ProfileFollow {
	bool mutual;
	String nickname;
	String? encryptedId;
	ProfileFollow.fromJson(Map<String, dynamic> jsoschon): 
		mutual = jsoschon['mutual'],
		nickname = jsoschon['nickname'],
		encryptedId = jsoschon['encryptedId'];	
}

