#!/bin/sh

get_ip() { echo -n $(getent hosts "$1" | awk '{ print $1 ; exit }'); }
node_name() { echo -n "redis_node_$1"; }

PORT="$1"
NODES_COUNT="$2"
ALIVE_COUNT="$(redis-cli -h $(node_name 1) -p $PORT cluster nodes | grep -c 'connected')"

if [ "$ALIVE_COUNT" -eq "$NODES_COUNT" ]; then  # cluster ready
    echo "[*] your $NODES_COUNT-node(s) redis-cluster is ready"
    echo
    sleep 5
    exit 0
fi

# replicas = (nodes / 3) - 1
REPLICAS_COUNT=$(echo "$NODES_COUNT" | awk '{ print (+ $1 / 3) - 1; exit }')

echo "[*] creating cluster for $NODES_COUNT nodes (replicas: $REPLICAS_COUNT)"
sleep 5 # give some time for our nodes to up

nodes="" # will be filled with node-ip:port values, separated by trailing space

for n in $(seq 1 "$NODES_COUNT"); do
    nodes="$nodes$(get_ip $(node_name $n)):$PORT "
done
 
redis-cli -h $(node_name 1) \
          -p $PORT \
          --cluster-replicas $REPLICAS_COUNT \
          --cluster-yes \
          --cluster create $nodes

exit 1 # will be restarted for the next try
