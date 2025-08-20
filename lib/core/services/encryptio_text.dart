import 'dart:convert';
import 'dart:typed_data';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';

encryptedText(String text) async {

  try {
    var encryptionKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAw1ix08k7aIoY+SYNZ4Ip53eTlZC+w7RBTW1pO64+K3YtFdrFWxl3w+RD/EesEmzT6AgWvPbW5fACPUWFh+v3SRlli9qmSLdM1jUeTWZWkeKDGimI561oNFUiu7Wdw3BqjcHxSny/GcD8Cw2Mm0XxoziSyrmJgBN24/q4jKyIAEywTC5JbiofgcV+Vd3HZpJXnBzoXmS1gVxQY3k2yT2GzvdfyZBfrOQLACj6zaPlIBrYJ81SWoWEXf4HLzNLOBXUyAUz6nlwJvPTOrkgQ3O+5tel8LWWMARduCNu1/xmIzZy1U6yQE9iEaGkRI36dWYL4sUXVyl8gc3jzt/9RIk51QIDAQAB';
    var pem = '-----BEGIN RSA PUBLIC KEY-----\n$encryptionKey\n-----END RSA PUBLIC KEY-----';
    var public = CryptoUtils.rsaPublicKeyFromPem(pem);
    /// Initalizing Cipher
    var cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));

    /// Converting into a [Unit8List] from List<int>
    /// Then Encoding into Base64
    Uint8List output = cipher.process(Uint8List.fromList(utf8.encode(text)));
    var base64EncodedText = base64Encode(output);
    return base64EncodedText;
  } catch (e, error){
    debugPrint('Error in encryptedText: $e\n$error');
  }

}
