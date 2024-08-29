#! /bin/bash
CLUSTER_ID=$1;
CLUSTER_NAME=$2;

# Создание сервисного аккаунта администратора кластера k8s
kubectl create -f k8s_sa.yaml;

# Подготовка сертификата кластера
yc managed-kubernetes cluster get --id $CLUSTER_ID --format json | \
  jq -r .master.master_auth.cluster_ca_certificate | \
  awk '{gsub(/\\n/,"\n")}1' > jenkins/ca.pem;

# Получение токена сервисного 
SA_TOKEN=$(kubectl -n kube-system get secret $(kubectl -n kube-system get secret | \
  grep admin-user-token | \
  awk '{print $1}') -o json | \
  jq -r .data.token | \
  base64 -d);

# Получения IP кластера кластера
MASTER_ENDPOINT=$(yc managed-kubernetes cluster get --id $CLUSTER_ID \
  --format json | \
  jq -r .master.endpoints.external_v4_endpoint);

# Добавление кластера в файл конфигурации
kubectl config set-cluster $CLUSTER_NAME \
  --server=$MASTER_ENDPOINT \
  --kubeconfig jenkins/kube_config;

# Добаление токена в файл конфигурации
kubectl config set-credentials admin-user \
  --token=$SA_TOKEN \
  --kubeconfig jenkins/kube_config;

# Добавление информации о контексте в файл конфигурации

kubectl config set-context default \
  --cluster=$CLUSTER_NAME \
  --user=admin-user \
  --kubeconfig jenkins/kube_config;


