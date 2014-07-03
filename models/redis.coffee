redis  = require 'redis'
client = redis.createClient 9976, 'grouper.redistogo.com', auth_pass: 'f712ab7335fd7f41bfbb29d42e6604a8'


exports.throw = (bottle, callback) ->
  ID = Math.random().toString(16).substr 2

  #以 hash 类型保存漂流瓶对象
  client.HMSET ID, bottle, (err, result) ->
    if err
      return callback code: 0, msg: '请过会儿再试试吧！'

    # 设置漂流瓶生存期为 1 天
    client.EXPIRE ID, 86400
    callback code: 1, msg: result


exports.pick = (callback) ->
  # 设定 50% 的几率捡到海星
  if Math.random() <= 0.5
    return callback code: 0, msg: '捡到海星了~'

  # 随机返回一个ID
  client.RANDOMKEY (err, ID) ->
    unless ID
      return callback code: 0, msg: '大海空空如也..'


    # 根据 ID 获得完整的信息
    client.HGETALL ID, (err, bottle) ->
      if err
        return callback code: 0, msg: '瓶子破损了..'

      # 删除此漂流瓶
      client.DEL ID
      callback code: 1, msg: bottle