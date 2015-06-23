
HAML_FILES := $(wildcard src/views/*.haml)
HTML_FILES := $(addprefix www/views/,$(notdir $(HAML_FILES:.haml=.html)))

SCSS_FILES := $(wildcard src/styles/*.scss)
WIDGET_SCSS_FILES := $(wildcard src/styles/widgets/*.scss)
CSS_FILES := $(addprefix www/css/,$(notdir $(SCSS_FILES:.scss=.css)))

COFFEE_FILES := $(wildcard src/javascript/*.coffee)
JS_FILES := $(addprefix www/javascript/,$(notdir $(COFFEE_FILES:.coffee=.js)))



.PHONEY: all
all:
	make js
	make www/css/app.css
	make html
	make images



.PHONEY: images
images:
	#cp src/images/*.png www/images/
	#cp src/images/*.svg www/images/


.PHONEY: html
html: $(HTML_FILES)
www/views/%.html: src/views/%.haml
	bundle exec haml $< $@


#.PHONEY: css
www/css/app.css: $(SCSS_FILES) $(WIDGET_SCSS_FILES)
	bundle exec scss src/styles/app.scss www/css/app.css


.PHONEY: js
js: $(JS_FILES)
www/javascript/%.js: src/javascript/%.coffee
	coffee --compile -o www/javascript $<



.PHONEY: clean
clean:
	rm -f www/views/*.html
	rm -f www/css/*.css
	rm -f www/javascript/*.js
	rm -f www/images/*.*


.PHONEY: run
run:
	bundle exec rackup

.PHONEY: docker_image
docker_image:
	docker build -t gsa-ads .


