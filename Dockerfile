# docker build --build-arg SLACK_TOKEN={slack_token_value} --build-arg SLACK_APP_TOKEN={slack_app_token_value} --platform {platform (ex. linux/arm64/v8)} -t test_bot:local .
# docker run -it --rm --name test_bot -v "$PWD"/config:/config test_bot:local /bin/sh -c "./flottbot"
FROM target/flottbot:ruby-0.10.0

ARG SLACK_TOKEN
ARG SLACK_APP_TOKEN
ENV SLACK_TOKEN=$SLACK_TOKEN
ENV SLACK_APP_TOKEN=$SLACK_APP_TOKEN

WORKDIR /home/flottbot/test_bot
USER root
RUN apk add sqlite-dev bash && gem install bundler:2.3.26
RUN cp /flottbot ./

COPY test_bot/ test_bot/
COPY config/ config/
COPY data.sqlite3 ./
RUN mkdir log
RUN chmod +x test_bot/bin/test_bot

RUN cd test_bot && bundle config set --local frozen 'true' && bundle

CMD "/flottbot"
