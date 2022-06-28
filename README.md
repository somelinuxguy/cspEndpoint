# Just a basic webhook
For use as a CSP reporting URI

## What it do
All this does is take a POST and log it.

For CSP reporting you need to be able to take a JSON object from anywhere, and record that or parse to a database... whatever you desire. You could use an expensive service like sentry or raygun but if your site is popular you'll run in to thousands of dollars a month for this.

Use a lambda behind an API Gateway instead, and you're all done at a fraction of the price.

# Example Usage / Testing
Probably something like this:
```
cd terraform
terraform init etc etc yadda yadda
...
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

base_url = "https://8675309jenny.execute-api.us-east-2.amazonaws.com/v1"

cthulhu@rlyeh% curl -X POST -d '{"pig":"cat"}' https://218e18pqi7.execute-api.us-east-2.amazonaws.com/v1

Logged
```

# Status Codes
200 is success.

200 is also a failure. We take all your garabge. We don't care.


## TO DO
Create a Dockerfile for those who want to containerize this
Create kubernetes resources 
 - deployment
 - service 

Let's be honest, despite their constant issues CircleCI is pretty nice. Let's add a circleCI build for fun.

What about a deployment? TF is doing the infra build but k8s assumes EKS is in place (yes we use AWS). What if we want to integrate our CircleCI to an ArgoCD as well? Let's do that.

Have you figured out yet I'm doing this to show off my DevOps skillz? Skip the 3 hour technical interview please.
