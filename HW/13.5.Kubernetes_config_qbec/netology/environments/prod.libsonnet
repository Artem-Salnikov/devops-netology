
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {    
    pv +: {
        pv_name: 'pv-prod'
    },
    pvc +: {
        pvc_name: 'pvc-prod'
    },
    front +: {
        replicas: 3
    },
    back +: {
        replicas: 3
    },
    db +: {
        pvc_name: 'pvc-prod',
        replicas: 1,
},
  }
}