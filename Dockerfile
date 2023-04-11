FROM node:18 AS builder

# Create app directory
WORKDIR /app

RUN mkdir -p ./packages/backend

# Since this project is a mono repo and the backend project is using the choices project
# as a dependency we have to copy both the project's package.json files
COPY packages/backend/package*.json ./packages/backend/
COPY packages/backend/prisma ./packages/backend/prisma/

COPY packages/choices/package*.json ./packages/choices/
COPY packages/choices/dist ./packages/choices/dist

COPY package*.json ./

# Install app dependencies
RUN npm install

COPY . .

RUN npm run backend build

FROM node:18

RUN mkdir -p ./packages/backend

COPY --from=builder /app/packages/backend/node_modules ./packages/backend/node_modules
COPY --from=builder /app/packages/backend/package*.json ././packages/backend
COPY --from=builder /app/packages/backend/dist ./packages/backend/dist

COPY --from=builder /app/packages/choices/dist ./packages/choices/dist
COPY --from=builder /app/packages/choices/package*.json ./packages/choices

COPY --from=builder /app/package*.json ./

EXPOSE 3000
CMD [ "npm", "run", "backend", "start:prod" ]
