#
#FROM node:10.5 as build-stage
#
#COPY . /app
#
#WORKDIR /app
#
#RUN npm install
#
#RUN npm run build --prod --output-path=./dist
#
#
#FROM nginx:1.15
#
#COPY nginx.conf /etc/nginx/nginx.conf
#
#COPY --from=build-stage app/dist/metabol /app
#
#EXPOSE 80




# Stage 1: Build an Angular Docker Image
FROM node as build
WORKDIR /app
COPY package*.json /app/
RUN npm cache clean --force
RUN npm install
COPY . /app
ARG configuration=production
RUN npm run build -- --outputPath=./dist --configuration $configuration
# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:1.15

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build app/dist/metabol /app

EXPOSE 80
