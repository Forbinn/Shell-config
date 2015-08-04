#
# @@COPYRIGHT@@
#
# Made by @@AUTHOR@@
# Mail <@@AUTHORMAIL@@>
#

SRCS		= main.c \

CFLAGS		+= -Wall -Wextra
ifeq "$(MAKECMDGOALS)" "debug"
CFLAGS		+= -ggdb3
else
CFLAGS		+=
endif

LDFLAGS		=
ifeq "$(MAKECMDGOALS)" "debug"
LDFLAGS		+=
else
LDFLAGS		+=
endif

NAME		= a.out
NAME_DEBUG	= a.debug.out

OBJDIR		= .obj
SRCDIRS		= $(shell find . -name "*.c" -exec dirname {} \; | uniq)

OBJS		= $(SRCS:%.c=$(OBJDIR)/%.o)
OBJS_DEBUG	= $(SRCS:%.c=$(OBJDIR)/%.debug.o)
DEPS		= $(OBJS:%.o=%.d)

CC			?= gcc
MAKE		:= make -C
RM			:= rm -rf
MKDIR		:= mkdir -p

all: $(OBJDIR) $(NAME)

$(OBJDIR):
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

debug: $(OBJDIR) $(OBJS_DEBUG)
	$(CC) $(OBJS_DEBUG) $(LDFLAGS) -o $(NAME_DEBUG)

$(OBJDIR)/%.debug.o: %.c
	@$(CC) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CFLAGS) $<
	$(CC) $(CFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.c
	@$(CC) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CFLAGS) $<
	$(CC) $(CFLAGS) -c $< -o $@

ifneq "$(MAKECMDGOALS)" "clean"
ifneq "$(MAKECMDGOALS)" "distclean"
-include $(DEPS)
endif
endif

.PHONY: all clean distclean re debug
