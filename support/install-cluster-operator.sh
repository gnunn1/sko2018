export AMQ_STREAMS_HOME=/home/gnunn/Development/kafka/amq-streams-1.0

oc new project sko --display-name="Seat Registration"

oc apply -f ${AMQ_STREAMS_HOME}/install/cluster-operator/020-RoleBinding-strimzi-cluster-operator.yaml -n sko
oc apply -f ${AMQ_STREAMS_HOME}/install/cluster-operator/031-RoleBinding-strimzi-cluster-operator-entity-operator-delegation.yaml -n sko
oc apply -f ${AMQ_STREAMS_HOME}/install/cluster-operator/032-RoleBinding-strimzi-cluster-operator-topic-operator-delegation.yaml -n sko

# Install Templates
oc apply -f ${AMQ_STREAMS_HOME}/examples/templates/cluster-operator -n sko

# Create project for Operator
oc new-project kafka-operator --display-name="Kafka Cluster Operator"
sed -i 's/namespace: .*/namespace: kafka-operator/' ${AMQ_STREAMS_HOME}/install/cluster-operator/*RoleBinding*.yaml
oc apply -f ${AMQ_STREAMS_HOME}/install/cluster-operator -n kafka-operator

# Deploy Kafka Cluster
oc apply -f sko-kafka-persistent.yaml -n sko

echo "Please update cluster operator deployment to reference sko namespace"
