FROM node:10.18.0

ENV APP_HOME /app

RUN mkdir -p $APP_HOME
WORKDIR /app

COPY package.json package-lock.json ./
RUN npm i

COPY . ./

CMD ["npm", "run", "build"]
