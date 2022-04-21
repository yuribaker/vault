#!/bin/bash
#vault script to pre-populate an initialized and unsealed vault instance with KV data and example users.
#user tokens can be found in [username].txt files

#enable the kv secrets engine
vault secrets enable -version=2 kv

#populate some dummy data
vault kv put secret/passwords/alice password=!QAZ@WSX adminpassword=$RFV@WSX
vault kv put secret/passwords/bob password=1qaz2wsx
vault kv put secret/passwords/charlie password=)OKM(IJN)

#uploadACL policies


#create users and tokens
vault token create -display-name=alice -policy=adminPol -metadata=usr=alice >>alice.txt
vault token create -display-name=bob -policy=userPol -metadata=usr=bob>> bob.txt

