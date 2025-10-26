FROM oven/bun:1

WORKDIR /usr/src/app

# 👇 Accept DATABASE_URL from build arguments
ARG DATABASE_URL
ENV DATABASE_URL=${DATABASE_URL}

# Copy only what you need
COPY ./packages ./packages
COPY ./bun.lock ./bun.lock
COPY ./package.json ./package.json
COPY ./turbo.json ./turbo.json
COPY ./apps/websockets ./apps/websockets

# Install dependencies
RUN bun install

# ✅ Prisma generate needs DATABASE_URL
RUN bun run generate:db

EXPOSE 8081

CMD ["bun", "run", "start:ws"]
