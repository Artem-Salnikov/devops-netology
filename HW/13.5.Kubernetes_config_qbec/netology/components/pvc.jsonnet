local p = import '../params.libsonnet';
local params = p.components.pvc;
[
    {
    apiVersion: 'v1',
    kind: 'PersistentVolumeClaim',
    metadata: {
        name: params.pvc_name,
    },
    spec: {
        storageClassName: '',
        accessModes: [
            'ReadWriteOnce'
        ],
        resources: {
            requests: {
                storage: params.capacity,
            },
        },
    },
    },
]  