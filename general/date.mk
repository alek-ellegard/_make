

time := $(shell date '+%H:%M:%S')

# convenience named date vars
month-year := $(shell date '+%m-%Y')
yday := $(shell date -v-1d '+%d-%m-%y')

# date syntax'ed
date-m-yr := $(shell date '+%m-%Y')
date := $(shell date '+%d-%m-%Y')
date-1d := $(shell date -v-1d '+%d-%m-%y')
date-2d := $(shell date -v-2d '+%d-%m-%y')
date-3d := $(shell date -v-3d '+%d-%m-%y')
date-4d := $(shell date -v-4d '+%d-%m-%y')
date-5d := $(shell date -v-5d '+%d-%m-%y')
date-6d := $(shell date -v-6d '+%d-%m-%y')
date-7d := $(shell date -v-6d '+%d-%m-%y')

dates:
	@echo
	@echo "date: $(date)"
	@echo "time: $(time)"
	@echo
