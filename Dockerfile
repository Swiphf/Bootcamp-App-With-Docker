# Base image
FROM node:14-alpine

WORKDIR ~/bootcamp-app
COPY . ~/bootcamp-app
EXPOSE 8080

# Install dependencies
RUN npm install 
CMD npm run dev