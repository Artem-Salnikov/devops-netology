local p = import '../params.libsonnet';
local params = p.components.db;
[
    {
        apiVersion: 'apps/v1',
        kind: 'StatefulSet',
        metadata: {
            labels: {
                app: 'db'
            },
            name: 'db'
        },
        spec: {
            selector: {
                matchLabels: {
                    app: 'db'
                }
            },
            serviceName: 'db',
            replicas: params.replicas,
            template: {
                metadata: {
                    labels: {
                        app: 'db'
                    }
                },
                spec: {
                    containers: [
                        {
                            name: 'db',
                            image: params.rep + '/' + params.tag,
                            volumeMounts: [
                                {
                                    mountPath: '/data',
                                    name: 'my-volume'
                                }
                            ],
                            ports: [
                                {
                                    name: 'postgresqlkub',
                                    containerPort: params.port,
                                    protocol: 'TCP'
                                }
                            ],
                            env: [
                                {
                                    name: 'POSTGRES_USER',
                                    value: params.POSTGRES_USER,
                                },
                                {
                                    name: 'POSTGRES_PASSWORD',
                                    value: params.POSTGRES_PASSWORD,
                                },
                                {
                                    name: 'POSTGRES_DB',
                                    value: 'news'
                                }
                            ]
                        }
                    ],
                    volumes: [
                        {
                            name: 'my-volume',
                            persistentVolumeClaim: {
                                claimName: params.pvc_name,
                            },
                        },
                    ],
                },
            },
        },
    },
{
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
        name: 'db',
        labels: {
            app: 'db'
        }
    },
    spec: {
        type: 'ClusterIP',
        ports: [
            {
                port: params.port,
                targetPort: params.port,
                protocol: 'TCP'
            }
        ],
        selector: {
            app: 'db'
        },
    },
},
]