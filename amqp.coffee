class MeteorAmqp
  queues: []
  constructor: (@url) ->
    @amqp = Npm.require('amqplib/callback_api')
    @connect()
  connect: ->
    @wrappedAmqp = Async.wrap(@amqp, ['connect'])
    @conn = @wrappedAmqp.connect(@url)
    @wrappedConn = Async.wrap(@conn, ['createChannel'])
    @ch = @wrappedConn.createChannel()
    @wrappedChannel = Async.wrap(@ch, ['assertQueue'])
  addQueue: (q) ->
    unless _.indexOf @queues, q
      @queues.push q
      @wrappedChannel.assertQueue(q, durable: false)
  consume: (q, cb, options) ->
    unless _.indexOf @queues, q
      @addQueue(q)
    @ch.consume q, Meteor.bindEnvironment(cb, options)