## ihomer:amqp 0.0.1

Initial version wrapping amqplib the Meteor way

# usage
```
amqp = new MeteorAmqp('amqp://localhost')

queue = 'hello'

cb = (msg) ->
  log(" [x] Received: #{msg.content.toString()}")

options = noAck: true

amqp.consume(queue, cb, options)
```