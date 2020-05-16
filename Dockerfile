FROM ubuntu:latest

RUN apt-get update && apt-get install -y git sudo curl wget
RUN adduser --disabled-password --gecos '' dot \
  && adduser dot sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER dot

COPY --chown=dot:dot . /home/dot/dotfiles/

WORKDIR /home/dot/dotfiles
