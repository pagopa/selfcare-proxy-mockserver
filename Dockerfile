ARG APP_IMAGE=mockserver/mockserver
FROM $APP_IMAGE as mockserver
COPY services/* ./config/*
RUN true
EXPOSE 1080