
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    pv +: {
        pv_name: 'pv-stage',
    },
    pvc +: {
        pvc_name: 'pvc-stage',
    },
    front +: {
        replicas: 1
  },
    back +: {
        replicas: 1
    },
    db +: {
        pvc_name: 'pvc-stage',
        replicas: 1
},
}
}