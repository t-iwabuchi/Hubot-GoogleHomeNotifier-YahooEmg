# Description:
#   Notification of Yahoo! JAPAN Disaster Prevention Bulletin on Google Home..

googlehome = require 'google-home-notifier'
language = 'ja'

module.exports = (robot) ->
  robot.hear /Yahoo! JAPAN 防災速報/i, (msg) ->
    googlehome.device('Google-Home', language);
    googlehome.ip(process.env.HUBOT_GOOGLE_HOME_IP_ADDRESS);
    googlehome.notify(msg.message.text, (res) => console.log(res));
