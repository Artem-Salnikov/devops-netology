local p = import '../params.libsonnet';
local params = p.components.pv;
[
    {
    apiVersion: 'v1',
    kind: 'PersistentVolume',
    metadata: {
        name: params.pv_name,
    },
    spec: {
        storageClassName: '',
        accessModes: [
            'ReadWriteOnce'
        ],
        capacity: {
            storage: params.capacity,
        },
        hostPath: {
            path: "/data/pv",
        },
    },
    },
]