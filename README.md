# grafana_install
ytt -f schema.yaml -f values.yaml -f grafana_template.yaml > grafana.yaml

ytt -f ns-rbac/ --data-values-file ns-rbac/grafana.values.yaml > role_binding.yaml

Remove the top portion in role_binding.yaml 

kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.6.1/cert-manager.yaml

kapp deploy -a cert-manager -f https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml

kapp controller v24+

kubectl apply -f https://github.com/vmware-tanzu/carvel-kapp-controller/releases/download/v0.27.0/release.yml

Secret gen controller 

kapp deploy -a sg -f https://github.com/vmware-tanzu/carvel-secretgen-controller/releases/download/v0.5.0/release.yml

