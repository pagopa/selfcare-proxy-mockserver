FROM mockserver/mockserver:5.15.0@sha256:0f9ef78c94894ac3e70135d156193b25e23872575d58e2228344964273b4af6b as mockserver
COPY services/* /config/
EXPOSE 1080
CMD []