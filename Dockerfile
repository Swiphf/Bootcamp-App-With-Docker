# # Base image
FROM node:14-alpine

# COPY . /bootcamp-app
# WORKDIR /bootcamp-app
# EXPOSE 8080

# # Install dependencies
# RUN npm install 
# CMD npm run initdb
# CMD npm run dev


WORKDIR /usr/src/app

COPY package*.json ./

RUN npm init -y

RUN npm install 

COPY .   /usr/src/app
EXPOSE 8080

#RUN npm run initdb 

CMD ["npm", "run", "initdb"] 

CMD ["npm", "run", "dev"]