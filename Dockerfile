FROM node:16
WORKDIR /usr/src/app
COPY package.json .
RUN npm install --ignore-scripts
COPY . .
EXPOSE 3000
EXPOSE 8080
CMD [ "node", "index.js" ]