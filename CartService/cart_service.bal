import ballerinax/jaeger as _;
import ballerina/http;
import ballerina/io;

http:Client productServiceClient = check new ("http://localhost:9232/productservice");

@display {
    label: "cartservice"
}
service /cartservice on new http:Listener(9233) {

    resource function get cartInfo(int userId) returns json {    
        io:println("checkout the cart for user id: " + userId.toString());
        // get card and get product id
        return getProductData(1);
    }
}

function getProductData(int productId) returns json {
    http:Response|error val = productServiceClient->get("/productInfo?productId=123");
    if val is error {
        io:println("Error in getting product data");
    } else {
        io:println("status is: " + val.statusCode.toString());
    }
    return { "productId": productId, "productName": "MacBook Pro", "price": 2000.00 };
}
