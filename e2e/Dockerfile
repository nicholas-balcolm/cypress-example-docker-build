FROM cypress/base:10 as tester
WORKDIR /app

COPY package.json .
COPY package-lock.json .
# by setting CI environment variable we switch the Cypress install messages
# to small "started / finished" and avoid 1000s of lines of progress messages
# https://github.com/cypress-io/cypress/issues/1243
ENV CI=1
RUN npm ci
# verify that Cypress has been installed correctly.
# running this command separately from "cypress run" will also cache its result
# to avoid verifying again when running the tests
RUN npx cypress verify

FROM tester as test-run
COPY ./cypress /app/cypress
COPY ./cypress.json /app/
RUN npx cypress run || echo "Tests failed! See test-results image."
WORKDIR /app/cypress
RUN tar -czvf test-results.tar.gz screenshots videos results

FROM scratch as test-results
COPY --from=test-run /app/cypress/test-results.tar.gz /
