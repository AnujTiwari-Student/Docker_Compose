FROM node:22-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci

COPY . .

RUN npx prisma generate && npm run build

FROM node:22-alpine AS prod

WORKDIR /app

COPY --from=build /app/package*.json .
RUN npm install --only=production

COPY --from=build /app/dist ./dist
COPY --from=build /app/prisma ./prisma

EXPOSE 3000

CMD [ "npm", "run", "dev:docker" ]