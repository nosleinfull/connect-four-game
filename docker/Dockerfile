FROM ruby:2.7.1

ENV APP_HOME /cfgame
ARG USER_ID
ARG GROUP_ID
ENV NODE_VERSION 12

RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list


# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
    # Needed for certain gems
    build-essential \
    # Needed for postgres gem
    libpq-dev \
    nodejs --no-install-recommends \
    nodejs yarn \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Create a directory for the app code
RUN mkdir -p "$APP_HOME" \
  && chown -R $USER_ID:$GROUP_ID $APP_HOME \
  && addgroup --gid $GROUP_ID cfgame \
  && adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID cfgame \
  && usermod -g sudo cfgame

RUN chown -R cfgame:cfgame "$APP_HOME"

USER $USER_ID

# Send "ctrl-c"-like signal when stopping
STOPSIGNAL SIGINT

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler:2.2.0

WORKDIR $APP_HOME

# Add our Gemfile and install gems
ADD Gemfile* $APP_HOME/

RUN bundle install
RUN rails webpacker:install

# Copy over our application code
ADD . $APP_HOME
