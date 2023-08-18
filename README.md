# redis-cluster-compose

Any-node redis cluster in a single docker-compose.

By default it starts 9-nodes cluster, with 3 master nodes.

If you want other nodes amount:
- add or remove nodes (please note that your new nodes amount, **MUST** be divisible by 3)
- edit `nodes` argument for `cluster-up.sh`

note: nodes names (`redis_node_N`) are important, if you want/need to change them,
dont forget to modify `node_name` function in `cluster-up.sh` accordingly.


# usage

```shell
docker compose up
```

# connections scheme

This scheme was made by [decompose](https://github.com/s0rg/decompose) tool:

![svg](/blob/main/redis-cluster.svg)


# license

MIT
