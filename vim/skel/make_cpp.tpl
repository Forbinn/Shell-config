#
# @@COPYRIGHT@@
#
# Made by @@AUTHOR@@
# Mail <@@AUTHORMAIL@@>
#

SRCS		= main.cpp \

CXXFLAGS	+= -Wall -Wextra
ifeq "$(MAKECMDGOALS)" "debug"
CXXFLAGS	+= -ggdb3
else
CXXFLAGS	+=
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
