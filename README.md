# SwaggerPact
A repository for proof of concept that pact can be validated against swagger using SwaggerPactValidator

# TODO
Add example for post and update. The reason these two widely used methods have yet to be included is because canvas-lms swagger docs require data in the form of multipart/form data. I've queried pact to see if there is support for this in languages other than Java/JVM. If Pact does not have support than the docs can be changed to require a JavaScript body instead.
