# The Terraform Dir
Create the lambda function with iam roles, log groups,
and policy all attached.

Create an API gateway in REST mode and barf out the invoke url

## Important Usage notes

Remember that build and deploy functions should be in your pipeline. Terraform just runs to ensure your infrastructure exists.

Your deployment pipeline (Gitlab runner, circleCI etc.) should "zip lambda_function.zip main.js" for you as part of the build. Otherwise terrform will fail and tell you the zip file doesnt exist when it goes to hash it.

I assume you are following a path like: build -> terraform -> deploy