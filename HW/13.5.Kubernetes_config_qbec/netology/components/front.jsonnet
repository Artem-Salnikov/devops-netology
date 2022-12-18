local p = import '../params.libsonnet';
local params = p.components.front;

[
    {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
        labels: {
            app: 'frontend'
        },
        name: 'frontend'
    },
    spec: {
        replicas: params.replicas,
        selector: {
            matchLabels: {
                app: 'frontend'
            }
        },
        template: {
            metadata: {
                labels: {
                    app: 'frontend'
                }
            },
            spec: {
                containers: [
                    {
                        image: params.rep + '/' + params.tag,
                        name: 'frontend',
                        imagePullPolicy: 'IfNotPresent',
                        env: [
                            {
                                name: 'BASE_URL',
                                value: 'http://backend:9000'
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
        name: 'frontend',
        labels: {
            app: 'frontend'
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
            app: 'frontend'
        },
    },
},
]