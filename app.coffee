express    = require 'express'
bodyParser = require 'body-parser'
redis      = require './models/redis'


app = express()
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use express.static  __dirname + "/app"


#
# 路由
#

# 捡一个漂流瓶
app.post '/', (req, res) ->
  redis.pick (result) ->
    res.json result


# 扔一个漂流瓶
app.post '/post', (req, res) ->
  unless req.body.content
    return res.json code: 0, msg: '信息不完整'

  redis.throw req.body, (result) ->
    res.json result


#启动服务
app.set 'port', process.env.PORT || 8080

app.listen app.get 'port'
console.log "正在监听 #{app.get 'port'} 端口"