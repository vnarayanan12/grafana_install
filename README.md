# grafana_install

ytt -f ns-rbac/ --data-values-file ns-rbac/grafana.values.yaml > role_binding.yaml

Remove the top portion in role_binding.yaml 
