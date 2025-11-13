# Stage 1 — build
FROM node:18-alpine AS builder
WORKDIR /app
# copy package files first for caching
COPY package*.json ./
RUN npm ci --silent
# copy rest of app
COPY . .
# if you have a build step (React/Vite/etc.), run it; otherwise this will be no-op
RUN if [ -f package-lock.json ] || [ -f package.json ]; then npm run build --if-present; fi

# Stage 2 — runtime
FROM node:18-alpine
WORKDIR /app
# only copy production deps and built files
COPY --from=builder /app/package*.json ./
RUN npm ci --only=production --silent
COPY --from=builder /app ./
# expose the port your app listens on
ENV PORT=3000
EXPOSE 3000
# start command (must match your package.json start script)
CMD ["sh","-c","npm start"]
