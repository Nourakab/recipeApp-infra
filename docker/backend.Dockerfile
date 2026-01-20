FROM node:18

# Create app directory where Docker will put all copied files in there
WORKDIR /app

# Copy backend package files
#This is done first so Docker can install dependencies before copying all the code 
#— which speeds up rebuilds.
COPY ../../backend/package*.json ./

# Install dependencies
#--production means “don’t install devDependencies”, linter, testing tools
RUN npm install

# Copy backend source
COPY backend .

# Expose API port
EXPOSE 3001

# Start the server
CMD ["npm", "start"]
