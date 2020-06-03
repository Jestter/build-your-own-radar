FROM node:10.15.3 as source
WORKDIR /src/build-your-own-radar
ARG NO_GOOGLE_AUTH=false
ENV SKIP_GOOGLE_AUTH=$NO_GOOGLE_AUTH
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:1.15.9
WORKDIR /opt/build-your-own-radar
COPY --from=source /src/build-your-own-radar/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]