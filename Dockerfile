FROM node:latest

WORKDIR /my-app

COPY package*.json ./

RUN npm install

COPY index.js ./

ENV PORT=3000

EXPOSE 3000

CMD ["npm", "run", "dev"]