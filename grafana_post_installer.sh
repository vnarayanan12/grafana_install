#!/usr/bin/bash

DEBUG=false

# Assigns the deployed grafana pod name with unique identifier to a variable...
GRAFANA_POD_NAME=`kubectl get pods -n istio-system | grep grafana | awk '{ print $1 }'`

if [ $DEBUG == True ] 
then
  echo "Extracted pod name is: $GRAFANA_POD_NAME"
  echo "kubectl exec -it pod/$GRAFANA_POD_NAME -n istio-system -- /bin/bash cd /var/lib/grafana/dashboards"
fi

echo "Preparing to copy all Kubernetes dashboards to the deployed container..."
kubectl cp ./dashboards_json_files/kubernetes/ istio-system/$GRAFANA_POD_NAME:/var/lib/grafana/dashboards/
echo "Preparing to copy all Prometheus dashboards to the deployed container..."
kubectl cp ./dashboards_json_files/prometheus/ istio-system/$GRAFANA_POD_NAME:/var/lib/grafana/dashboards/
echo "Preparing to copy all Istio dashboards to the deployed container..."
kubectl cp ./dashboards_json_files/istio/ istio-system/$GRAFANA_POD_NAME:/var/lib/grafana/dashboards/