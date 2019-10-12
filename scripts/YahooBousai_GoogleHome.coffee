# Description:
#   Notification of Yahoo! JAPAN Disaster Prevention Bulletin on Google Home..

googlehome = require 'google-home-notifier'
language = 'ja'

module.exports = (robot) ->
  robot.hear /Yahoo! JAPAN 防災速報/i, (msg) ->
    message = msg.message.text
        .replace(/.* のYahoo! JAPAN IDで登録された情報をお届けします。/g, '')
        .replace(/.(発表時刻|配信時刻|気象庁発表).\n.*/g, '')
        .replace(/.タイトル.\n.*/gm, '')
        # .replace(/(-|\*)+[\s\S]*?(-|\*)+/gm, '') # - や * で囲まれたブロック
        .replace(/(-|\*)/g, '')
        .replace(/^$(\r\n|\r|\n)?/gm, '\n') # 空行
        .replace(/▼[\s\S]*/gm, '')
    
    if (message.length > 200)
      message = message.slice(0, 199)

    googlehome.device('Google-Home', language);
    googlehome.notify(message, (res) => console.log(res));
    console.log(message)
