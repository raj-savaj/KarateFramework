function fn() {
    var env = karate.env; // get system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
      env = 'dev';
    }
    var config = {
      ipAddress: '192.168.22.22',
      apiUrl: 'http://192.168.20.22/api/',
      sttUrl: 'http://192.168.20.22:8205/smpp_service/',
      userName: 'admin.xchange',
      password: 'Haudsysops123!'
    }
    if (env == 'dev') {
      // customize
      // e.g. config.foo = 'bar';
    } else if (env == 'e2e') {
      // customize
    }
    return config;
  }