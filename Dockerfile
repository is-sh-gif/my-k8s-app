# Use an official Node.js base image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy your app files into the image
COPY package*.json ./
RUN npm install
COPY . .

# Tell Docker what port your app uses
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
