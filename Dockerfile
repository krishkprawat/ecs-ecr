# Stage 1

FROM node:18 as buildimage

WORKDIR /build

COPY package*.json .
RUN npm install

COPY src/ src/
COPY tsconfig.json tsconfig.json

RUN npm run build



# Stage 2

FROM node:18 as runner

WORKDIR /app

COPY --from=buildimage build/package*.json .
COPY --from=buildimage build/node_modules node_modules/
COPY --from=buildimage build/dist dist/

CMD [ "npm", "start" ]