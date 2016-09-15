# Elasticsearch Setup & Recovery

## Settings
### Set number of replicas for all indices to 0
When you spin up a single node cluster, the default setting for number of replicas is 1. This means that the cluster is going to try to create a second copy of each shard. This is not possible as you only have one node in the cluster. This keeps your cluster (single node) in the yellow status and it will never reach green. A node can function this way but it is annoying to not see a green state when everything is actually healthy.

```
curl -XPUT 'localhost:9200/_settings' -d '{"index": { "number_of_replicas": 0 } }'
```

## Recovering
### Ran out of disk
When you run out of disk, shards will have not been allocated and your cluster will likely be stuck in status RED. To recover, you need to find out which indices are unassigned and assign them manually

##### Commands

Check your clusters health and status of unassigned shards
```
curl -XGET http://localhost:9200/_cluster/health?pretty=true
```

Display the indices health
```
curl -XGET 'http://localhost:9200/_cluster/health?level=indices&pretty'
```

Display shards
```
curl -XGET 'http://localhost:9200/_cat/shards'
```
