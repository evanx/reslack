
set -u -e

  pattern=reslack:* command=del rescan
  redis-cli del reslack:req:q
  redis-cli del reslack:busy:q
  redis-cli del reslack:1:req:h
  redis-cli hset reslack:1:req:h text 'another test message'
  redis-cli lpush reslack:req:q 1
  redis-cli lpush reslack:req:q exit
  #slackUrl=http://localhost:8031 npm start
  slackUrl=$SLACK_URL slackUsername=SqueakyMonkeyBot npm start
  scanCount=1000 format=terse pattern=reslack:* format=key rescan
  scanCount=1000 format=terse pattern=reslack:*:q command=llen rescan
  scanCount=1000 format=terse pattern=reslack:*:h command=hgetall rescan
