# Base image
FROM node:14-alpine

# RUN mkdir -p /home/bootcamp/bootcamp-app && cd home/bootcamp/bootcamp-app && ls -la
WORKDIR /
RUN RUN apt-get install -y git
RUN git init && git clone https://github.com/Swiphf/Bootcamp-App-With-Docker.git 
# COPY package*.json home/bootcamp/bootcamp-app/
RUN npm install 
# COPY . home/bootcamp/bootcamp-app
EXPOSE 8080

# Install dependencies
# CMD npm run dev