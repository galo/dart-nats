import 'package:test/test.dart';
import 'package:dart_nats/dart_nats.dart';

//please start nats-server on localhost before testing

void main() {
  test("default", () async {
    var client = Client();
    client.connect('localhost');
    var sub = client.sub('subject1');
    client.pub('subject1', 'message1');
    var msg = await sub.stream.first;
    client.close();
    expect(msg.toString(), equals('message1'));
  });
  test("pub with no buffer ", () async {
    var client = Client();
    client.connect('localhost');
    var sub = client.sub('subject1');
    await Future.delayed(Duration(seconds: 1));
    client.pub('subject1', 'message1', buffer: false);
    var msg = await sub.stream.first;
    client.close();
    expect(msg.toString(), equals('message1'));
  });
}
