# Base image
FROM node:14-alpine

WORKDIR home/bootcamp/bootcamp-app
COPY . home/bootcamp/bootcamp-app
EXPOSE 8080

# Install dependencies
RUN npm install 
CMD npm run dev