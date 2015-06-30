
HAML_FILES := $(wildcard src/views/html/*.haml)
HTML_FILES := $(addprefix www/views/,$(notdir $(HAML_FILES:.haml=.html)))

SCSS_FILES := $(wildcard src/views/styles/*.scss)
WIDGET_SCSS_FILES := $(wildcard src/views/styles/widgets/*.scss)
CSS_FILES := $(addprefix www/css/,$(notdir $(SCSS_FILES:.scss=.css)))

COFFEE_FILES := $(wildcard src/views/script/*.coffee)
JS_FILES := $(addprefix www/javascript/,$(notdir $(COFFEE_FILES:.coffee=.js)))



.PHONEY: all
all:
	make js
	make www/css/app.css
	make html
	make images
	make fonts



.PHONEY: images
images:
	cp src/views/images/*.* www/images/


.PHONEY: fonts
fonts:
	cp src/views/fonts/* www/fonts/


.PHONEY: html
html: $(HTML_FILES)
	cp www/views/index.html www/index.html
www/views/%.html: src/views/html/%.haml
	bundle exec haml $< $@


#.PHONEY: css
www/css/app.css: $(SCSS_FILES) $(WIDGET_SCSS_FILES)
	bundle exec scss src/views/styles/app.scss www/css/app.css


.PHONEY: js
js: $(JS_FILES)
www/javascript/%.js: src/views/script/%.coffee
	coffee --compile -o www/javascript $<



.PHONEY: clean
clean:
	rm -f www/*.html
	rm -f www/views/*.html
	rm -f www/css/*.css
	rm -f www/javascript/*.js
	rm -f www/images/*.*
	rm -f www/fonts/*.*


.PHONEY: run
run:
	bundle exec ruby server.rb -o 0.0.0.0

.PHONEY: docker_image
docker_image:
	docker build -t gsa-ads .

.PHONEY: test
test:
	make all
	bundle exec rspec && npm test

