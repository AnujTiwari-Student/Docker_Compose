FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./
COPY ./prisma ./prisma

RUN npm install

COPY . .

RUN npx prisma generate && npm run build

FROM node:22-alpine AS prod

WORKDIR /app

COPY --from=Build /app/package*.json ./

RUN npm install --only=production

COPY --from=Build /app/dist ./dist
COPY --from=Build /app/prisma ./prisma
COPY --from=Build /app/node_modules/ .

COPY . .

EXPOSE 3000

CMD [ "npm", "run", "dev:docker" ]