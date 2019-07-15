This playbook will automatically setup the demo in OCP 4.1 or later. The following pre-requisites are required to use this playbook:

* This playbook has been tested with ansbile 2.8.2, any 2.8 release should work though
* Must be logged into an OCP 4 cluster with cluster-admin rights. This is required to create an AMQ Streams subscription
* This playbook uses the k8s module so you must have the prereqs for that module (https://docs.ansible.com/ansible/latest/modules/k8s_module.html)
* Update vars/vars.yml to reflect your OpenShift environment

Note that this playbook uses persistent storage and requires a dynamic storage provisioned be available. If you are running OpenShift in AWS, it is recommended that you shift all worked nodes to one AZ, this prevents storage from being unable to cross AZ boundaries in the event a pod is killed. OpenShift Container Storage (OCS) will mitigate this issue once available.

To use this playbook, follow these steps:

```
oc login -u <cluster-admin> <openshift-api-host>
ansible-playbook install.yml
```

Once the demo is deployed, you can access the dashboard from the dashboard route. This will allow you to book seats in an ad-hoc fashion and see the message stream be displayed. To book seats in bulk to demo monitoring, scale up the simulator to a single pod.