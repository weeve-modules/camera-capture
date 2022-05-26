FROM debian:buster-slim


RUN apt-get update && apt-get upgrade -y 
RUN apt-get -f install
RUN apt-get autoclean
RUN apt-get autoremove

RUN apt-get install curl -y


WORKDIR /home/pi/test
COPY click.sh .
RUN chmod +x click.sh



ENTRYPOINT [ "/home/pi/test/click.sh" ]