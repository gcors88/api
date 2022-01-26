FROM ubuntu:18.04

# Install Node.js, Yarn and required dependencies
RUN apt-get update \
  && apt-get install -y curl gnupg build-essential \
  && curl --silent --location https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get remove -y --purge cmdtest \
  && apt-get update \
  && apt-get install -y nodejs yarn \
  # remove useless files from the current layer
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists.d/* \
  && apt-get autoremove \
  && apt-get clean \
  && apt-get autoclean

# Install Git because package depends on Git
RUN apt-get update && apt-get upgrade \
  && apt-get install -y git

# Copy project production folders
COPY ./src ./src

# Copy config files
COPY ./tsconfig.json ./tsconfig.json
COPY ./tsconfig.build.json ./tsconfig.build.json
COPY ./package.json ./package.json
COPY ./ormconfig.ts ./ormconfig.ts

# install dependencies
RUN npm install @types/node
RUN npm install typescript
RUN npm install --production

# Generate dist
RUN npm run build

# Configure container network
EXPOSE 80 8080 3009

CMD NODE_PATH=dist/ NODE_ENV=$NODE_ENV npm run start:prod