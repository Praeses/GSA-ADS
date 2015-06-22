
HAML_FILES := $(wildcard src/views/*.haml)
HTML_FILES := $(addprefix www/views/,$(notdir $(HAML_FILES:.haml=.html)))

SCSS_FILES := $(wildcard src/styles/*.scss)
CSS_FILES := $(addprefix www/css/,$(notdir $(SCSS_FILES:.scss=.css)))

COFFEE_FILES := $(wildcard src/javascript/*.coffee)
JS_FILES := $(addprefix www/javascript/,$(notdir $(COFFEE_FILES:.coffee=.js)))


.PHONEY: all
all:
	#cp lib/*.js www/javascript/
	make js
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


.PHONEY: css
css: $(CSS_FILES)
www/css/%.css: src/styles/%.scss
	bundle exec scss $< $@


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

