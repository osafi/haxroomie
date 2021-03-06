let config = {
  room1: {
    autoStart: true,
    roomName: process.env.ROOM_NAME || 'haxball',
    noPlayer: true,
    maxPlayers: 20,
    password: process.env.ROOM_PASSWORD || 'haxball',
    token: process.env.HAXBALL_TOKEN,
    public: false,
    repositories: [
      {
        type: 'github',
        repository: 'morko/hhm-sala-plugins'
      },
      {
        type: 'github',
        repository: 'XHerna/hhm-plugins'
      },
      {
        type: 'github',
        repository: 'osafi/hhm-plugins'
      }
    ],
    pluginConfig: {
      'sav/roles': {
        roles: {
          admin: process.env.ROOM_ADMIN_PASSWORD || 'admin123',
          host: process.env.ROOM_HOST_PASSWORD || 'host123'
        }
      },
      'hr/always-one-admin': {},
      'hr/pause': {
        maxPauseTimes: 0
      },
      'hr/kickban': {},
      'osafi/register-route': {
        directorRegistrationUrl: `http://localhost:${process.env.PORT || '8080'}/routes`,
        route: process.env.ROUTE_DIRECTOR_ROUTE || '/',
        username: process.env.ROUTE_DIRECTOR_USER || 'admin',
        password: process.env.ROUTE_DIRECTOR_PASS || 'admin123',
      },
    }
  }
};
module.exports = config;
