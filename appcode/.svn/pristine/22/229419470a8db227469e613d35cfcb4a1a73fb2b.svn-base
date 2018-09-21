ecc = require('eosjs-ecc')
exports.createkey = function (res) {
    ecc.randomKey().then(privateKey => {
        var body = {
            "Private Key" : privateKey,
            "Public Key" : ecc.privateToPublic(privateKey)
        }
        console.log(body)
        res.writeHead(200, {'Content-Type': 'application/json'});
        res.end(JSON.stringify(body));
    })
}
