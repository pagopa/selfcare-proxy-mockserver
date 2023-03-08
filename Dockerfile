FROM mockserver/mockserver:5.15.0 as mockserver
COPY services/* /config/
EXPOSE 1080
CMD []