
// this file has the baseline default parameters
{
  components: {
    front: {
      rep: 'artemsalnikov',
      tag: '13-kubernetes-config-frontend',
      port: 80,
    },
    back: {
      rep: 'artemsalnikov',
      tag: '13-kubernetes-config-backend',
      db_url: 'postgres://postgres:postgres@db:5432/news',
      port: 9000,
    },
    db: {
      rep: 'artemsalnikov',
      tag: 'postgres',
      port: 5432,
      POSTGRES_USER: 'postgres',
      POSTGRES_PASSWORD: 'postgres',
    },
    pv: {
      capacity: '2Gi',
    },
    pvc: {
      capacity: '2Gi',
    },
  },
}
