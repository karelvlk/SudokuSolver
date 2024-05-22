# Use the official Haskell image from Docker Hub
FROM haskell:9.0.2

# Set the working directory in the Docker container
WORKDIR /app

# Copy all Haskell source files into the Docker container at /app
COPY ./src /app
COPY ./assets /app/assets

# Update and install system dependencies
RUN apt-get update && apt-get install -y \
    libghc-random-dev \
    && rm -rf /var/lib/apt/lists/*

# Use cabal to update its list of packages and explicitly install the required Haskell packages
RUN cabal update && cabal install random random-shuffle directory --lib

# Compile the Haskell application including all modules
# Make sure to link with the necessary packages using the -package option
RUN ghc -O2 -o myapp -package random -package random-shuffle -package directory \
    main.hs solver.hs generator.hs checker.hs types.hs utils.hs

# Run the Haskell application when the container launches
CMD ["./myapp"]
