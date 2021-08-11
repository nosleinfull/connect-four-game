FROM ruby:2.7.1

ENV APP_HOME /cfgame
ARG USER_ID
ARG GROUP_ID

# Installation of dependencies
RUN apt-get update -qq \
  && apt-get install -y \
    # Needed for certain gems
    build-essential \
    # Needed for postgres gem
    libpq-dev \
    nodejs --no-install-recommends \
    # The following are used to trim down the size of the image by removing unneeded data
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
    /var/lib/apt \
    /var/lib/dpkg \
    /var/lib/cache \
    /var/lib/log

# Create a directory for our application
# and set it as the working directory
RUN mkdir -p "$APP_HOME" \
  && chown -R $USER_ID:$GROUP_ID $APP_HOME \
  && addgroup --gid $GROUP_ID cfgame \
  && adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID cfgame

USER $USER_ID
WORKDIR $APP_HOME

# Add our Gemfile and install gems
ADD Gemfile* $APP_HOME/
RUN gem install bundler:2.2.0
RUN bundle install

# Copy over our application code
ADD . $APP_HOME
