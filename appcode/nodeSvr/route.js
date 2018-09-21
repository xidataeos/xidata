var url = require('url')
var Transfer = require('./transfer')
var Redenvelop = require('./redenvelop')
var Egggame = require('./egggame')
var createkey = require('./createkey')

//转账
//{
// 	"from": "UserA",
// 	"fromPK": "APub",
// 	"to": "UserB",
// 	"toPK": "BPub",
// 	"asset": "100 SH",
// 	"memo": "UserA转账给UserB 100SH"
// }
function execTransfer(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })

    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        trans = new Transfer()
        trans.setRes(res)
        trans.trans(bodyJson.from, bodyJson.fromPK, bodyJson.to, bodyJson.toPK, bodyJson.asset, bodyJson.memo)
    })
}

//发送红包
//{
// 	"user": "UserA",
// 	"userPK": "APubPK",
// 	"asset": "200 SH",
// 	"num": 3,
// 	"memo": "UserA发送数量为3 总额为 200 SH币的红包"
// }
function execRedenvelopSend(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })
    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        redenv = new Redenvelop()
        redenv.setRes(res)
        redenv.send(bodyJson.user, bodyJson.userPK,bodyJson.asset, bodyJson.num, bodyJson.memo)
    })
}

//接收红包
//{
// 	"user": "UserA",
// 	"userPK": "APubPK",
// 	"asset": "200 SH",
// 	"memo": "UserA接收红包，200 SH"
// }
function execRedenvelopRecv(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })
    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        redenv = new Redenvelop()
        redenv.setRes(res)
        redenv.recv(bodyJson.user, bodyJson.userPK,bodyJson.asset, bodyJson.memo)
    })
}

//创建游戏
//{
// 	"gameid": "3",
// 	"creator": "UserA",
// 	"category": "热点游戏",
// 	"memo": "创建一个游戏ID为3的热点游戏"
// }
function execEggCreate(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })
    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        egggame = new Egggame()
        egggame.setRes(res)
        egggame.create(bodyJson.gameid, bodyJson.creator, bodyJson.category, bodyJson.memo)
    })
}

//彩蛋游戏，下注
//{
// 	"gameid": 3,
// 	"gamename": "测试热点游戏",
// 	"user": "UserA",
// 	"userPK": "APK",
// 	"quantity": "300.0000 SH",
// 	"memo": "测试热点游戏下注 300 SH"
// }
function execEggBet(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })
    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        egggame = new Egggame()
        egggame.setRes(res)
        egggame.bet(bodyJson.gameid, bodyJson.gamename, bodyJson.user, bodyJson.userPK, bodyJson.quantity, bodyJson.memo)
    })
}

//彩蛋游戏，结算
//{
// 	"gameid": 3,
// 	"gamename": "测试热点游戏",
// 	"user": "UserA",
// 	"userPK": "APK",
// 	"quantity": "300.0000 SH",
// 	"memo": "测试热点游戏下注 300 SH"
// }
function execEggsettlement(req,res) {
    var body = ''
    req.on('data', function (chunk) {
        body += chunk
    })
    req.on('end', function () {
        var bodyJson = JSON.parse(body)
        egggame = new Egggame()
        egggame.setRes(res)
        egggame.settlement(bodyJson.gameid, bodyJson.gamename, bodyJson.user, bodyJson.userPK, bodyJson.quantity, bodyJson.memo)
    })
}

function route(req,res) {
    var pathname = url.parse(req.url).pathname;
    switch (pathname) {  //判断请求的路径信息
        case ''||'/':
            console.log("\x1B[33m%s%s\x1B[0m", "根目录 ", pathname);
            break;
        case '/fbstransfer':
            console.log("\x1B[33m%s%s\x1B[0m", "转账 ", pathname);
	    //setTimeout(function() { 
            //res.writeHead(200, {'Content-Type': 'application/json'});
            //res.end();
	    //}, 1000);
            execTransfer(req,res)
            break;
        case '/redenvelope/send':
            console.log("\x1B[33m%s%s\x1B[0m", "红包发送 " , pathname);
            execRedenvelopSend(req,res)
            break;
        case '/redenvelope/recv':
            console.log("\x1B[33m%s%s\x1B[0m", "红包接收 ", pathname);
            execRedenvelopRecv(req,res)
            break;
        case '/egggame/create':
            console.log("\x1B[33m%s%s\x1B[0m", "彩蛋游戏-创建 ",pathname);
            execEggCreate(req,res)
            break;
        case '/egggame/bet':
            console.log("\x1B[33m%s%s\x1B[0m", "彩蛋游戏-下注 ",pathname);
            execEggBet(req,res)
            break;
        case '/egggame/settlement':
            console.log("\x1B[33m%s%s\x1B[0m","彩蛋游戏-结算 ",pathname);
            execEggsettlement(req,res)
            break;
        case '/createkey':
            console.log("\x1B[33m%s%s\x1B[0m", "创建密钥对 ", pathname)
            createkey.createkey(res)
            break;
        default:
            console.log("默认路径 ",pathname)
    }
}

exports.route = route
