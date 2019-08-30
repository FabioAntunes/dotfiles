FROM ubuntu:latest

ENV GITHUB_ACTIONS true
RUN apt-get update && apt-get install -y git sudo curl

WORKDIR /home/dotfiles

COPY . .

