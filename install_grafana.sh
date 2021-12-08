#!/usr/bin/bash

if ! command -v kubectl &> /dev/null
then
    echo "kubectl could not be found"
    exit
else
    kubectl create -f grafana.yaml

    RUNNING_STATUS=""

    # Do not run the post installer until the pod is in a RUNNING state
    while [ "$RUNNING_STATUS" != 'Running' ];
    do
    	RUNNING_STATUS=`kubectl get pods -n istio-system | grep grafana | awk '{ print $3 }'`
    	GRAFANA_POD_NAME=`kubectl get pods -n istio-system | grep grafana | awk '{ print $1 }'`
        echo "The pod ($GRAFANA_POD_NAME) is not running... Standby..."
    done
    
    echo "The pod ($GRAFANA_POD_NAME) is running! Performing grafana post-install script now..."
    
    sh grafana_post_installer.sh
    
    # There is a bug with Grafana.  A second 'grafana_post_installer' is required...
    sh grafana_post_installer.sh

    echo "Grafana and Mesh associated dashboards were installed... To verify: "
    echo "   kubectl exec -it pod/$GRAFANA_POD_NAME -n istio-system -- /bin/bash" 
    echo "   cd /var/lib/grafana/dashboards"
fi