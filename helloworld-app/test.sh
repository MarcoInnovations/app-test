#export POD_NAME=$(kubectl --kubeconfig=$(ls ../output/kubeconfig*) get pods --namespace default -l "app.kubernetes.io/name=demo-webserver,app.kubernetes.io/instance=demo-webserver" -o jsonpath="{.items[0].metadata.name}")

export POD_NAME=$(kubectl --kubeconfig=$(ls ../output/kubeconfig*) get pods -n default -l "app.kubernetes.io/name=demo-webserver,app.kubernetes.io/instance=demo-webserver" -o jsonpath="{.items[0].metadata.name}")

echo $POD_NAME

kubectl --kubeconfig=$(ls ../output/kubeconfig*) port-forward $POD_NAME 8080:8081
