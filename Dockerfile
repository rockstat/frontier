ARG WEB_SDK_CONTAINER=rockstat/web-sdk:latest
ARG BASE_CONTAINER=rockstat/band-base-ts:latest

FROM $WEB_SDK_CONTAINER as web-sdk-build

FROM $BASE_CONTAINER

LABEL band.service.version="3.3.3"
LABEL band.service.title="Front"
LABEL band.service.def_position="3x0"

ENV PORT 8080

WORKDIR /app

COPY package.json .
COPY yarn.lock .

RUN yarn link "@rockstat/rock-me-ts" \
  && yarn install \
  && yarn cache clean

COPY . .
ENV NODE_ENV production

EXPOSE 8080

COPY --from=web-sdk-build /usr/share/web-sdk static

RUN ln -nsf ../dist ./node_modules/@app \
  && yarn build

CMD [ "yarn", "start:prod"]
