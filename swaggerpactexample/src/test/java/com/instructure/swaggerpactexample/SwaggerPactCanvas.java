package com.instructure.swaggerpactexample;

import org.junit.Test;
import com.atlassian.oai.validator.pact.PactProviderValidationResults;
import com.atlassian.oai.validator.pact.PactProviderValidator;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

import static org.junit.Assert.fail;

/**
 * A proof of concept for Pact validating against swagger using Atlassian's SwaggerRequestValidator pacakge
 * All tests are based off examples provided by Atlassian and does not cover full capabilities of the tool
 */
public class SwaggerPactCanvas {
    public static final String PROVIDER_ID = "Canvas LMS API";
    public static final String CONSUMER_ID = "GenericConsumer";
	public static final String SWAGGER_JSON_URL = "/oai/account_notification.json";
    /**
     * Testsing a valid provider against a Swagger Doc
     */
    @Test
    public void validate_withValidConsumer_returnsMapWithNoValidationErrors() {

        final PactProviderValidator validator = PactProviderValidator
        .createFor(SWAGGER_JSON_URL)
        .withConsumer("Generic Consumer", getClass().getResource("/pacts/generic_consumer-canvas_lms_api.json"))
        .build();

        final PactProviderValidationResults results = validator.validate();

        assertNoBreakingChanges(results);
        assertThat(results.hasErrors(), is(false));
    }
    /**
     * Testing an invalid provider against a Swagger Doc
     */
    @Test
    public void validate_withInValidConsumer_returnsMapWithValidationErrors() {

        final PactProviderValidationResults results =
                PactProviderValidator
                        .createFor(SWAGGER_JSON_URL)
                        .withConsumer(CONSUMER_ID, getClass().getResource("/pacts/invalid_canvas.json"))
                        .build()
                        .validate();
        assertThat(results.getValidationFailureReport(), results.hasErrors(), is(true));
    }

    //From https://bitbucket.org/atlassian/swagger-request-validator
    private void assertNoBreakingChanges(final PactProviderValidationResults results) {
        if (results.hasErrors()) {
            final StringBuilder msg = new StringBuilder("Validation errors found.\n\t");
            msg.append(results.getValidationFailureReport().replace("\n", "\n\t"));
            fail(msg.toString());
        }
    }

}
