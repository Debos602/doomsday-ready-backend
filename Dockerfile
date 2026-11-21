FROM node:22-slim
WORKDIR /app
# prisma.config.ts and src/config/env.js are needed by `prisma generate` (postinstall)
COPY package*.json prisma.config.ts ./
COPY prisma ./prisma
COPY src ./src
RUN npm install --no-audit --no-fund
EXPOSE 4000
# Apply migrations, seed the sample data (idempotent), then start the API.
CMD ["sh", "-c", "npx prisma migrate deploy && node prisma/seed.js && node src/server.js"]
