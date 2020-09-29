 #OLD DOCKER COMMANDS

FROM node:10.5 as build

COPY . /app

WORKDIR /app

COPY package*.json /app/

RUN npm install

ARG configuration=production

RUN npm run build -- --outputPath=./dist/out --configuration $configuration

FROM nginx:1.15

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build app/dist/metabol /app

EXPOSE 80

# OLD DOCKER COMMANDS


 #NEW DOCKER COMMANDS

## STAGE 1: Build ###

#FROM node:10.5 AS build-stage
#
#WORKDIR /app
#
#COPY package.json package-lock.json ./
#
#RUN npm install
#
#COPY . .
#
##RUN npm run build --prod --aot --vendor-chunk --common-chunk --delete-output-path --buildOptimizer
#RUN npm ci && npm run build
#
#### STAGE 2: Run ###
#
#FROM nginx:1.15
#
#COPY nginx.conf /etc/nginx/nginx.conf
#
#COPY --from=build app/dist/metabol /app
#
#
#USER nginx
#
#EXPOSE 80

# NEW DOCKER COMMANDS
