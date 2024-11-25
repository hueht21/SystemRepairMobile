import 'package:googleapis_auth/auth_io.dart';

class AuthenticationFcmFirebase {


  static Future<String> getToken() async {
    final credentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "systemrepair-73db0",
      "private_key_id": "fd65ecbb7784a1a9b17379e3d1a5eff28f6a768f",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDeYLQk9nPbH1m+\n/ePTaaAv04ItAPEVadbjLrAFQ9ln8uDQZ019klZ6K/hS5tCnu/ubRqHdxOTo4dET\nPEIHo4n7dqsKWrMGQFI74QhMLh4kCzL+1nHGezS3KJ4qDlzUbE1At3V+9wu9k6nU\n+MVffP2VHRsQxVg2W2V36v9y+i4wuRDEQ0lp349fW7mTsPoUKW8HCTelUwDUdN/o\nTLu1Y5H4HP4yt2qCtH+B/mHgHzyCz4bqR9EaAYsElnrWfMXcdTk18IY4wZ8MfK62\npMGXGBcEn378F8jVy6/MDh8dfkM6iYz1YelXiEMFDXmrXSmGremAeeMABmYDSsjo\nPFmkPOiTAgMBAAECggEAbSClprHu3uw+nXR4dgoSmwW/jxg0Nt7uniQOKzdFnDZb\nTsozA9lpaKDlRsGQSY/9hBCgZHU4JHSUpkze1mLR1r5AZ19lFT9BW7Mt4DyNfACm\n8NoJkW5qyys6msbblT7klkqxdTIE5+5r3GCMczSiOKfE3XEKvfoSDEwdOa4+Npfg\neFC2nsH+0CDgw3s40o3DjBtuY16YGCm/XyBHwpy5EwZuBsmOegiiNSVmU58sis7n\nCCcoPK4sDFxDDKDyGDqKOf0hQOoCaZt8pF3maE94YAr15GpPDjpAuQC1FZIop3oU\niYNGewhTnUqsl+/MyNFQPDM8N5W+lqpNQErvabe4sQKBgQD7tA75tmuwAbM9Ym4h\nOQ/OtMPdP0LAY7UVuZufbOs2HpCeTnlT3RYceLw3trMKf5mEB95/czTtRNCPhv8O\nyIw07lnsE9NrVcMd2h5vSpYl7crTRtBb8fcqsNEhPArRqdsae6SxV+k32oPD5Dib\n3nCtgOAKLahDra2trrJqmIag6wKBgQDiLH4XtwOHeJjaRrSRiVa53apuvvPQqSeX\nW+5W3oLqirmSHfzCUISaR6zxlRGsabEa8F8knY31JzG9zek7f4YSJk4NnnHrsfcy\nofeLrjN3k5GHcIkHC8tsD/aqNBTOU0vhBMTmcDtzln0N/kEdqej2QdkPw0Sa7KeX\nG9SuGGYs+QKBgQDPzBok7AZBe1XXkqBrCynStAeTa3uXS3mfYulol8ojlt4743tk\n0fxEKyTwNgPf4fICP2DgBWOnko1AQOnm8YhW1oQkU0XSsi3wQjeoF4KX85XkEO1J\nSxyMAQfWETS5XSpG1dbkljgy5VKs8YgOnniVtPTBUmo83XCqF7SyLhPPWwKBgQDI\n/4VnieuG/zPH98IM/KKoN0h5dxWywEFBEB/173Uk/vf/1MqF3Yyal0wovbOhJ6SP\nLkM/hQ1dauGXrmCx0ZjSlFwVWlQfhF8NDkeySLPQdsKEPQxpyJ+Vf3JUvEgpPHlY\nliZuLBuJk5m7T9OKiy9PeiFvErfrfplJfyA5P9G98QKBgEQ4oeQkcDb355rufxkq\nyAVwn9+EyzzQt8qJEcoOw/EBQylgJUBBj4nVOHppmu/YqEW5KyrmwcLTwczyPjOu\nTyI2sOI6cPsztEclMQQNtXu8RsVm8isbleNvH8swGM3wcqVOoagY6AYxX3+6GI9D\nDvMEvot8vULijBeR4IAn6AcT\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-zpgwh@systemrepair-73db0.iam.gserviceaccount.com",
      "client_id": "116077910719822734623",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-zpgwh%40systemrepair-73db0.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });

    final scopes = [
      "https://www.googleapis.com/auth/firebase.messaging"
    ]; // Thay thế bằng danh sách SCOPES của bạn
    final client = await clientViaServiceAccount(credentials, scopes);
    return client.credentials.accessToken.data;
  }
}