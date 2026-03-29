# Use a lightweight nginx base image
FROM nginx:alpine

# Author information
LABEL maintainer="Aditya Singh <adityasingh.devops@gmail.com>"

# Copy project files to nginx default directory
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Default command to start nginx
CMD ["nginx", "-g", "daemon off;"]