module.exports = (robot) ->
  robot.hear /Yahoo! JAPAN 防災速報/i, (msg) ->
    const googlehome = require('google-home-notifier')
    const language = 'ja';

    googlehome.device('Google-Home', language); 
    googlehome.ip(process.env.HUBOT_GOOGLE_HOME_IP_ADDRESS);
    googlehome.notify(msg.message.text, function(res) {
      console.log(res);
    });

