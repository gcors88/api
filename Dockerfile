FROM ubuntu:18.04

# Install Node.js, Yarn and required dependencies
RUN apt-get update -y \
  && apt-get install -y curl gnupg build-essential -y \
  && curl --silent --location https://deb.nodesource.com/setup_14.x | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get remove -y --purge cmdtest \
  && apt-get update \
  && apt-get install -y nodejs yarn \
  # remove useless files from the current layer
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/lib/apt/lists.d/* \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && apt-get autoclean -y

# Install Git because package depends on Git
RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y git

# Copy project production folders
COPY ./src ./src

# Copy config files
COPY ./package.json ./package.json

# install dependencies
RUN npm install @types/node
RUN npm install --production

# Configure container network
EXPOSE 80 8080 3009

CMD NODE_PATH=dist/ NODE_ENV=$NODE_ENV npm run start:prod