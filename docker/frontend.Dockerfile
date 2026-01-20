# 1) Build React app
FROM node:18-alpine AS build
WORKDIR /app

COPY client/package*.json ./
RUN npm install

COPY client ./
RUN npm run build

# 2) Serve static files with nginx
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY infra/docker/frontend.default.conf /etc/nginx/conf.d/default.conf

#nginx's container internal port
EXPOSE 80

#Run Nginx in the foreground so Docker keeps the container alive.
CMD ["nginx", "-g", "daemon off;"]
