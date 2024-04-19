    #!/bin/bash

    set -e

    NAMESPACE='sre'
    DEPLOYMENT='swype-app'
    MAX_RESTARTS=3

    while true; do
    RESTARTED=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")
    printf ${restarted}
    if [ $RESTARTED -gt $MAX_RESTARTS ]; then
        printf "scale down the deployment to zero."
        kubectl scale deploy ${DEPLOYMENT} -n ${NAMESPACE} --replicas=0
        break
    else
        sleep 60
    fi 
    done