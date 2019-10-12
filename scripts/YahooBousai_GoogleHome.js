// Description:
//   Notification of Yahoo! JAPAN Disaster Prevention Bulletin on Google Home..

googlehome = require('google-home-notifier')
language = 'ja'

wait = (sec) =>
	new Promise((resolve, reject) => {
	  setTimeout(resolve, sec*1000);
	});

module.exports = (robot) =>
  robot.hear(/Yahoo! JAPAN 防災速報/i, async(msg) => {
    message = msg.message.text
        .replace(/.* のYahoo! JAPAN IDで登録された情報をお届けします。/g, '')
        .replace(/.(発表時刻|配信時刻|気象庁発表).\n.*/g, '')
        .replace(/.タイトル.\n.*/gm, '')
        // .replace(/(-|\*)+[\s\S]*?(-|\*)+/gm, '') // - や * で囲まれたブロック
        .replace(/(-|\*)/g, '')
        .replace(/^$(\r\n|\r|\n)?/gm, '\n') // 空行
        .replace(/▼[\s\S]*/gm, '')

    message = message
        .replace(/mm\/h/g, '毎時ミリメートル')
        .replace(/千曲川/g, 'ちくまがわ')
    
    if (message.length > 200) {
      message = message.slice(0, 199)
      sliced = true
    }

    googlehome.device('Google-Home', language);
    googlehome.notify(message, (res) => console.log(res));
    console.log(message)
    await wait(80)
    if (sliced == true) {
      googlehome.notify("文字数制限のため、一部の情報が削られました", (res) => console.log(res));
      await wait(10)
    }
  })