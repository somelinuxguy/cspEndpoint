# Just a basic webhook
For use a CSP reporting URI

## What it do
All this does is take a POST and log it.

For CSP reporting you need to be able to take a JSON object from anywhere, and record that or parse to a database... whatever you desire. You could use an expensive service like sentry or raygun but if your site is popular you'll run in to thousands of dollars a month for this.

Use a lambda behind an API Gateway instead, and you're all done at a fraction of the price.

# Endpoint Map
sect.net/webhooks/csp

# Status Codes
200 is success.
200 is also a failure. We take all your garabge. We don't care.


## TO DO
Nothing. It's all done, and perfect, forever.
