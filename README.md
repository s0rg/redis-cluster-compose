# redis-cluster-compose
Any-node redis cluster in a single docker-compose.

- add or remove nodes (please note that your new nodes amount, must be divisible by 3)
- edit `nodes` argument for `cluster-up.sh`
- `docker-compose up` - start your cluster!

note: nodes names (`redis_node_N`) are important, if you want/need to change them,
dont forget to modify `node_name` function in `cluster-up.sh` accordingly.

# license
MIT
