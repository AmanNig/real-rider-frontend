# Step 1: Build the React app
FROM node:18 AS builder


COPY package.json package-lock.json ./
RUN npm install

COPY . ./
RUN npm run build

# Step 2: Serve the app using nginx
FROM nginx:alpine

# Copy build files from the builder stage
COPY --from=builder /build /usr/share/nginx/html

# Copy custom nginx configuration if needed
# COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
