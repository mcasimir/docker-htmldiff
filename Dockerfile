FROM ruby:alpine

RUN gem install --no-ri --no-rdoc sinatra htmldiff

COPY server.rb server.rb

EXPOSE 4567

CMD ["ruby", "server.rb"]
