##
## Makefile
##
## Made by @@AUTHOR@@
## Login   <@@AUTHORMAIL@@>
##
## Started on  @@CDATE@@ @@AUTHOR@@
## Last update @@MDATE@@ @@MAUTHOR@@
##

SRCS		= main.c \

CFLAGS		= -Wall -Wextra

LDFLAGS		=

NAME		= a.out
NAME_DEBUG	= $(NAME).debug

OBJDIR		= obj
SRCDIRS		= $(shell find . -name "*.c" -exec dirname {} \; | uniq)

OBJS		= $(SRCS:%.c=$(OBJDIR)/%.o)
OBJS_DEBUG	= $(SRCS:%.c=$(OBJDIR)/%.debug.o)
DEPS		= $(OBJS:%.o=%.d)

RM			:= rm -rf
CC			?= gcc
MAKE		:= make -C
MKDIR		:= mkdir -p

all: directories $(NAME)

directories:
	@for dir in $(SRCDIRS); \
	do \
		$(MKDIR) $(OBJDIR)/$$dir; \
	done

$(NAME): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(NAME)

clean:
	$(RM) $(OBJDIR)

distclean: clean
	$(RM) $(NAME) $(NAME_DEBUG)

debug: CFLAGS += -ggdb3
debug: $(OBJS_DEBUG)
	$(CC) $(OBJS_DEBUG) $(LDFLAGS) -o $(NAME_DEBUG)

$(OBJDIR)/%.debug.o: %.c
	@$(CC) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CFLAGS) $<
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.c
	@$(CC) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CFLAGS) $<
	$(CC) $(CFLAGS) -c $< -o $@

ifneq "$(MAKECMDGOALS)" "clean"
-include $(DEPS)
endif

.PHONY: all directories clean distclean re debug
