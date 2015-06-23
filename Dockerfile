FROM nginx:latest

#install everything needed to build and test
RUN apt-get update
RUN apt-get install ruby gem -y
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN npm install -g coffee-script
RUN ln -s /usr/bin/nodejs /usr/bin/node

#cleanup apt-get, save space
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#build the site and test
COPY ./ /src
WORKDIR /src
RUN gem install bundler
RUN bundle install
RUN npm install
RUN make all

#run test, all test must pass to build the image
RUN npm test


#setup site with nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm -Rf /usr/share/nginx/html
RUN ln -s /src/www /usr/share/nginx/html
CMD ["nginx"]

