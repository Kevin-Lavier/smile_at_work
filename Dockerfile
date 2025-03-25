# Use the official Ruby image as the base image
FROM ruby:3.2

# Set the working directory inside the container to /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock (if they exist) to the /app directory in the container
COPY Gemfile* /app/

# Install dependencies using Bundler
RUN bundle install

# Copy the rest of the application's code into the container's /app directory
COPY . /app

# Expose port 8080 so the container can communicate on that port
EXPOSE 8080

# Start the application by running app.rb using Ruby
CMD ["ruby", "app.rb"]
