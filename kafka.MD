* Install: `brew install kafkacat`
* List all of the topics for a particular broker: `kafkacat -L -b host.docker.internal:30002`
* List message for a particular topic: `kafkacat -b host.docker.internal:30002 -t livongo.private.service.demo.template.users2`
* Post a message for a topic: `kafkacat -b host.docker.internal:30002 -P -t livongo.private.service.demo.template.users2`.  Paste contents in then ctrl+d to commit.

