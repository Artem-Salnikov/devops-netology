local p = import '../params.libsonnet';
local params = p.components.back;

[
    {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
        labels: {
            app: 'backend'
        },
        name: 'backend'
    },
    spec: {
        replicas: params.replicas,
        selector: {
            matchLabels: {
                app: 'backend'
            }
        },
        template: {
            metadata: {
                labels: {
                    app: 'backend'
                }
            },
            spec: {
                containers: [
                    {
                        image: params.rep + '/' + params.tag,
                        name: 'backend',
                        imagePullPolicy: 'IfNotPresent',
                        env: [
                            {
                                name: 'DATABASE_URL',
                                value: params.db_url,
                            },
                        ],
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
        name: 'backend',
        labels: {
            app: 'backend'
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
            app: 'backend'
        },
    },
},
]