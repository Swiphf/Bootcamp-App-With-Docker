# Base image
FROM node:14-alpine

RUN ls -la
RUN pwd
# RUN mkdir bootcamp-app
WORKDIR /bootcamp-app
EXPOSE 8080

# Install dependencies
RUN npm install 
# CMD npm run dev