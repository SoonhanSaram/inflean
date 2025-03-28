import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// localhost
const emulatorIp = '10.0.2.2:3000';
const simulatrIp = '127.0.0.1:3000';

final ip = Platform.isAndroid ? emulatorIp : simulatrIp;
