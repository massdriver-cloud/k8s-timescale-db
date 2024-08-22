## Kubernetes TimescaleDB

TimescaleDB is an open-source relational database designed for time-series data. It is built as an extension to PostgreSQL, providing deeper insights by combining time-series data with the full power and flexibility of SQL.

### Design Decisions

- **Kubernetes Integration:** This setup uses Kubernetes Helm Charts to deploy TimescaleDB in a Kubernetes cluster.
- **Security:** Superuser credentials are securely generated and managed.
- **Resources Management:** Configurable CPU and memory limits to ensure appropriate resources allocation.
- **Persistent Storage:** Data volumes are setup using Kubernetes Persistent Volume Claims (PVCs) for data retention.

### Runbook

#### Pod Not Starting

If your TimescaleDB pod isn't starting, it might be due to improper resource configuration or issues connecting to the Kubernetes API. You can check the pod status using kubectl commands.

Get the status of the pods:

```sh
kubectl get pods -n <namespace>
```

To view detailed logs of a specific pod:

```sh
kubectl logs -n <namespace> <pod-name>
```

#### PVC Issues

Persistent Volume Claims (PVCs) are essential for TimescaleDB data persistence. If PVCs are not binding, it might prevent the pods from starting.

Check the status of the PVCs:

```sh
kubectl get pvc -n <namespace>
```

Describe the PVC to get more details:

```sh
kubectl describe pvc <pvc-name> -n <namespace>
```

#### Failed PostgreSQL Connections

If you face issues connecting to the TimescaleDB instance, you need to check the service and credentials.

Confirm the Kubernetes service is correctly set up:

```sh
kubectl get svc -n <namespace>
```

Verify the connection using `psql`:

```sh
psql -h <service-name>.<namespace>.svc.cluster.local -U <username> -d <database-name> -p <port>
```

If there is a password prompt, ensure you use the correct credentials. You might also need to export the password:

```sh
export PGPASSWORD='<password>'
```

#### Checking Database Health

If the database appears to be running but is unresponsive, you can execute health checks using SQL commands.

Connect to the TimescaleDB instance:

```sh
psql -h <service-name>.<namespace>.svc.cluster.local -U <username> -d <database-name> -p <port>
```

Run diagnostic queries to check the database health:

```sql
SELECT * FROM pg_stat_activity;
SELECT pg_size_pretty(pg_database_size('<database-name>'));
SELECT now(), pg_postmaster_start_time(), 
       now() - pg_postmaster_start_time() as uptime;
```

### Conclusion

This guide provides an overview of managing TimescaleDB in a Kubernetes environment and includes common troubleshooting steps. Utilize the given commands to diagnose and resolve potential issues.

