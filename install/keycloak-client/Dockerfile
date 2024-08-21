#Build Steps
FROM node:22-alpine as build-step

RUN mkdir /app
WORKDIR /app

COPY package.json /app
RUN npm install
COPY . /app

RUN npm run build

FROM registry.redhat.io/ubi9/nginx-124@sha256:c1cd1495011bf0eb51280369384bade930c04a1852d47a90e536fa95c7096b39

# Add application sources
COPY --from=build-step /app/build .

# The run script uses standard ways to run the application
CMD nginx -g "daemon off;"
