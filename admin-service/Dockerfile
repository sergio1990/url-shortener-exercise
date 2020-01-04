FROM node:10.18.0

ENV APP_HOME /app

RUN mkdir -p $APP_HOME
WORKDIR /app

ADD package.json package-lock.json $APP_HOME/
RUN npm i

ADD . $APP_HOME/

CMD ["npm", "run", "build"]
