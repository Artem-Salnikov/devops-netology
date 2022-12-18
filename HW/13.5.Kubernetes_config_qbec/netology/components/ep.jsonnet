local params = import '../params.libsonnet';
[
{
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: 'test',
  },
  spec: {
    type: 'ClusterIP',
    clusterIP: 'None',
    ports: [
      {
        port: 9123
      },
    ],
  },
},
{
  apiVersion: 'v1',
  kind: 'Endpoints',
  metadata: {
    name: 'test',
  },
  subsets: [
    {
      addresses: [
        {
          ip: '5.9.243.188'
        },
      ],
    },
  ],
},
]