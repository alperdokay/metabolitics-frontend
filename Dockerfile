 #OLD DOCKER COMMANDS

#FROM node:10.5 as build-stage
#
#COPY . /app
#
#WORKDIR /app
#
#RUN npm install
#
#RUN npm run ng build --prod
#
#FROM nginx:1.15
#
#COPY nginx.conf /etc/nginx/nginx.conf
#
#COPY --from=build-stage app/dist/metabol /app
#
#EXPOSE 80

# OLD DOCKER COMMANDS


 #NEW DOCKER COMMANDS

## STAGE 1: Build ###

FROM node:10.5 AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

#RUN npm run build --prod --aot --vendor-chunk --common-chunk --delete-output-path --buildOptimizer
RUN $(npm bin)/ng build --prod

### STAGE 2: Run ###

FROM nginx:1.15

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build app/dist/metabol /app

RUN touch /var/run/nginx.pid && \
  chown -R nginx:nginx /var/run/nginx.pid && \
  chown -R nginx:nginx /var/cache/nginx && \
  chown -R nginx:nginx /usr/share/nginx/html

USER nginx

EXPOSE 80

# NEW DOCKER COMMANDS
