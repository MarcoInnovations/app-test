# Sample roll-out of an application from Jenkins to the Application account (using EKS)

##### Here are some options provided to deploy an application from core-infra Jenkins to the application EKS cluster.  One is a combination of YAML's and kubectl, the other is using a HELM chart.  

##### Both options will have the same result: grab a ECR image from transit account, install this in the advanced account with a deployment and a service, resulting in a hello-world test page, running on pods inside the EKS workernodes, behind an ELB.  
<br></br>
### HELM:
Create your helm chart with your application as usual.  Place your helm chart in a repo, which can be reached from the internet.  

In the pipeline, this repo is added to your helm installation (previously installed by the EKS Infrastructure creation).  Now this chart can be installed with default values, making sure you add the app to the desired namespace.  Currently the ‘application domain-name’ is used as namespace and will be automatically created if it does not exists.  

Before we can install, some household steps need to be performed: we are fetching the EKS name and switch to the proper context for kubectl.  Then we are assuming a cross-account role.  Both allow us to access the advanced EKS and deploy resources.  

A Jenkinsfile is provided as a guideline to add to your CI/CD pipeline that will deploy the application.  

The creation of the loadBalancer will take a minute or two before it is operational.  Also, we have seen DNS replication take up to 5 minutes, before the URL became active.  

As example roll out can be found here: http://x-x-x.aws.cloud

⎈ Happy Helming! ⎈
<br></br>
### YAML:
A Jenkinsfile is provided which will create your Service and Deployment file on the fly, based on a couple of variables at the top of the file (as ‘def’).  

In this example, we choose another approach: we are fetching the EKS kubeconfig information on the fly during install and use that to connect to the EKS cluster.

Same as with Helm, it may take a few minutes before all moving parts are in place.  

An example roll-out can be found here: http://y-y-y.aws.cloud

Folder Structure:
| [root]
|-- [helm-chart-helloworld]
    | helloworld-app.tgz
    | index.yaml
|-- [helm-helloworld-app]
    |-- [templates]
        | _helpers.tpl
        | deployment.yaml
        | ingress.yaml
        | NOTES.txt
        | service.yaml
    | .helmignore
    | Chart.yaml
    | Jenkinsfile
    | values.yaml
|-- [helm-helloworld-app-delete]
    | jenkinsfile
|-- [helm-tra]
    | index.yaml
|-- [yaml-helloworld-in-application]
    | jenkinsfile
|-- [yaml-helloworld-in-application-delete]
    | jenkinsfile
| README.md


