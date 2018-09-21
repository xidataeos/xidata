Eos = require('eosjs')

// Optional configuration..
config = {
    keyProvider: ['5JzKGBEow61ybBKJuiRikKd7D1egvVM7EFEsz73X5eaAm9HHLC7'], // 配置私钥字符串
    httpEndpoint: 'http://172.26.27.146:8888', //DEV开发链url与端口
    chainId: "cf057bbfb72640471fd910bcb67639c22df9f92470936cddc1ade0e2f2e7dc4f",
    mockTransactions: () => null, // 如果要广播，需要设为null
    // transactionHeaders: (expireInSeconds, callback) => {
    //callback(null/*error*/, headers) //手动设置交易记录头，该方法中的callback回调函数每次交易都会被调用
    //},
    expireInSeconds: 60,
    broadcast: true,
    debug: false,
    sign: true,
    authorization: null // 该参数用于在多签名情况下，识别签名帐号与权限,格式如：account@permission
}

function Transfer() {
    var res;
    this.setRes = function (response) {
        res = response
    }
    this.trans = function (from, fromPubKey, to, toPubKey, asset, memo) {
        eos = Eos(config)
        eos.contract("fbstransfer").then(fbstransfer => {  //hello随便起的变量名
            fbstransfer.transfer(from, fromPubKey, to, toPubKey, asset, memo, {                         //hi是方法名, 'axay'是该hello合约hi方法的参数
                authorization: ['fbstransfer']        //testtesttest是建立该合约的用户
            }).then(result => {
                console.log(JSON.stringify(result));
                res.writeHead(200, {'Content-Type': 'application/json'});
                res.end(JSON.stringify(result));
                //console.log(JSON.stringify(result))
            });
        });
    }
}

module.exports = Transfer;
