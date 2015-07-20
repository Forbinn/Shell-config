##
## Makefile
##
## Made by @@AUTHOR@@
## Login   <@@AUTHORMAIL@@>
##
## Started on  @@CDATE@@ @@AUTHOR@@
## Last update @@MDATE@@ @@MAUTHOR@@
##

SRCS		= main.cpp \

CXXFLAGS	+= -Wall -Wextra

LDFLAGS		=

NAME		= a.out
NAME_DEBUG	= $(NAME).debug

OBJDIR		= .obj
SRCDIRS		= $(shell find . -name "*.cpp" -exec dirname {} \; | uniq)

OBJS		= $(SRCS:%.cpp=$(OBJDIR)/%.o)
OBJS_DEBUG	= $(SRCS:%.cpp=$(OBJDIR)/%.debug.o)
DEPS		= $(OBJS:%.o=%.d)

CXX			?= g++
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
	$(CXX) $(OBJS) $(LDFLAGS) -o $(NAME)

clean:
	$(RM) $(OBJDIR)

distclean: clean
	$(RM) $(NAME) $(NAME_DEBUG)

debug: CXXFLAGS += -ggdb3
debug: $(OBJDIR) $(OBJS_DEBUG)
	$(CXX) $(OBJS_DEBUG) $(LDFLAGS) -o $(NAME_DEBUG)

$(OBJDIR)/%.debug.o: %.cpp
	@$(CXX) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CXXFLAGS) $<
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cpp
	@$(CXX) -MM -MF $(shell echo "$@" | sed 's/^\(.*\)\.o$$/\1\.d/g') -MP -MT $@ $(CXXFLAGS) $<
	$(CXX) $(CXXFLAGS) -c $< -o $@

ifneq "$(MAKECMDGOALS)" "clean"
ifneq "$(MAKECMDGOALS)" "distclean"
-include $(DEPS)
endif
endif

.PHONY: all clean distclean debug
