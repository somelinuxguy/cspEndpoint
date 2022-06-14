// Webhook for recording CSP messages.
//
// Now with 25% less toxic plutonium by-products!
//
const AWS = require('aws-sdk');

let constructResponse = function() {
    let responseObject = {
        statusCode: 200,
        headers: {
            "x-irrelevant-header" : "true"
        },
        body: "Logged"
    }; 
    return responseObject;
};

exports.handler = async (event) => {
    AWS.config.update({ region: "us-east-1" });
    if (event) {
        console.log("request: " + JSON.stringify(event));
    } else {
        console.log("There was no event to log.");
    }
    let response = constructResponse();
    return response;  // return that object, and end our lambda function
};
