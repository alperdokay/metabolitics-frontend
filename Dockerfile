# OLD DOCKER COMMANDS

# FROM node:10.5 as build-stage

# COPY . /app

# WORKDIR /app

# RUN npm install

# RUN npm run build --prod --output-path=./dist

# FROM nginx:1.15

# COPY nginx.conf /etc/nginx/nginx.conf

# COPY --from=build-stage app/dist/metabol /app

# EXPOSE 80

# OLD DOCKER COMMANDS


# NEW DOCKER COMMANDS

### STAGE 1: Build ###

FROM node:10.5 AS build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

### STAGE 2: Run ###

FROM nginx:1.15

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /usr/src/app/dist/metabol /usr/share/nginx/html

EXPOSE 80

# NEW DOCKER COMMANDS