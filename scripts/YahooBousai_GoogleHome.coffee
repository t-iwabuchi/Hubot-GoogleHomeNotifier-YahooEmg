# Description:
#   Notification of Yahoo! JAPAN Disaster Prevention Bulletin on Google Home..

googlehome = require 'google-home-notifier'
language = 'ja'

module.exports = (robot) ->
  robot.hear /Yahoo! JAPAN 防災速報/i, (msg) ->
    message = msg.message.text
        .replace(/.* のYahoo! JAPAN IDで登録された情報をお届けします。/g, '')
        .replace(/-+[\s\S]*?-+/gm, '')
        .replace(/-/g, '')
        .replace(/\n\n/g, '\n')
        .replace(/▼[\s\S]*/gm, '')
    
    if (message.length > 200)
      message = message.slice(0, 199)

    googlehome.device('Google-Home', language);
    googlehome.notify(message, (res) => console.log(res));
    console.log(message)
