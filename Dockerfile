FROM mockserver/mockserver as mockserver
COPY services/* ./config/
EXPOSE 1080
CMD []