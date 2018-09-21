var http = require('http')

function start(route) {
    function onRequest(request, response) {
        if (request.method != "POST")
        {
            console.log("不是post，不处理")
            return;
        }

        route(request,response)
    }

    http.createServer(onRequest).listen(80)
    console.log("Server has started at :80")
}

//web = new start()
exports.start = start;
