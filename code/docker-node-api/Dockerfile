# parent image
FROM node:17-alpine

# setting work directory
WORKDIR /app

# copyig source files 
COPY . .

# installing project dependencies while building
RUN npm i

# exposing port from container
EXPOSE 4000

# running command for container
CMD [ "npm","start" ]

