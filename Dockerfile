# ARG is required
ARG APP_IMAGE=hello-world:linux
FROM $APP_IMAGE
ADD --chown=1001:0 https://github.com/microsoft/ApplicationInsights-Java/releases/download/3.2.11/applicationinsights-agent-3.2.11.jar /applicationinsights-agent.jar