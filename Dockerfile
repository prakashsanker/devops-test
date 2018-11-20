FROM node:10
ARG COMMIT_REF
ARG BUILD_DATE

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package*.json ./
COPY . .
RUN yarn
EXPOSE 3000
RUN yarn build
ENV APP_COMMIT_REF=${COMMIT_REF} \
  APP_BUILD_DATE=${BUILD_DATE}
CMD ["node", "./build/index.js"]