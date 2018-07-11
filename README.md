# SwaggerPact
A repository for proof of concept that pact can be validated against swagger using SwaggerRequestValidator @  https://bitbucket.org/atlassian/swagger-request-validator

I'm only using the tool that validates a local Pact JSON with a local Swagger Doc. This is coined by the SwaggerRequestValidator as the provider side test but could also extend to consumer testing. The consumer test tool provided by the SwaggerRequestValidator only supports specs written in Java. Not all capabilities for this tool have been explored with the existing tests and future tests would look at utilities provided by the tool such as validating all Consumers/Providers in a given broker. 

# Getting the Project Working
1. Clone the repo and open the swaggerpactexample folder in VSCode.
2. Get JDK8u171/172 (Make sure you **do not** use Java 10. There's a plugin that has issues with this version) http://www.oracle.com/technetwork/java/javase/downloads/index.html
3. Get Java Extension Pack for VSCode
4. Maven included in that extension pack is embedded and I didn't have the greatest time using it so console Maven is also a great option: https://openiam.atlassian.net/wiki/spaces/IAMSUITEV3/pages/524742/Installing+Apache+Maven+on+Mac
5. From the console in vscode (or from terminal in the same directory as the VSCode project) run 
```bash
mvn install
```
6. Navigate to `swaggerpactexample/src/test/java/com/instructure/SwaggerPactCanvas.java`
7. Above the test class and each method with `@Test` above them you should be able to select 'Run Test'

# Workflow
1. Generate a Pact (an example of a working Pact rspec can be found in the rspec folder)
  - Move the resulting pact into the pacts folder under resources
2. Get the swagger docs for the endpoint you're testing.
  - Docs can be found at https://canvas.instructure.com/doc/api/
  - Navigate to an endpoint and change the `.html` at the end of the url to `.json`
  - Example: 
  https://canvas.instructure.com/doc/api/account_notifications.html
  to
  https://canvas.instructure.com/doc/api/account_notifications.json
3. Convert to Swagger 2.0

  - The URL you now have is a Swagger 1.2 Doc. In order to conver to a Swagger 2.0 doc run `npm install -g api-spec-converter`
  - run `api-spec-converter endpoint_url_here --from=swagger_1 --to=swagger_2 > swagger.json`
4. Take the local swagger doc and move it into the oai folder under resources and reference it as your swagger JSON url
5. Look at one of the existing tests and write a test that will validate the pact against the swagger doc.

# Things to Watch out for
1. Be very cognisant of the response Content-Type header in your pact. The parser used by the SwaggerRequestValidator uses this to discover the expected response body.
2. To be added

# TODO
*Add example for post and update.* 

The reason these two widely used methods have yet to be included is because canvas-lms swagger docs require the body in the form of multipart/form data. I've queried pact to see if there is support for this in languages other than Java/JVM. If Pact does not have support multipart/form data then the docs can be changed to require a JavaScript body instead.
