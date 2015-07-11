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

CXXFLAGS	= -Wall -Wextra

LDFLAGS		=

NAME		= a.out
NAME_DEBUG	= $(NAME).debug

OBJDIR		= obj
SRCDIRS		= $(shell find . -name "*.cpp" -exec dirname {} \; | uniq)

OBJS		= $(SRCS:%.cpp=$(OBJDIR)/%.o)
OBJS_DEBUG	= $(SRCS:%.cpp=$(OBJDIR)/%.debug.o)
DEPS		= $(OBJS:%.o=%.d)

RM			:= rm -rf
CXX			?= g++
MAKE		:= make -C
MKDIR		:= mkdir -p

all: directories $(NAME)

directories:
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

re: distclean all

debug: CXXFLAGS += -ggdb3
debug: $(OBJS_DEBUG)
	$(CXX) $(OBJS_DEBUG) $(LDFLAGS) -o $(NAME_DEBUG)

$(OBJDIR)/%.debug.o: %.cpp
	@$(CXX) -MM -MF $(subst .debug.o,.debug.d,$@) -MP -MT $@ $(CXXFLAGS) $<
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJDIR)/%.o: %.cpp
	@$(CXX) -MM -MF $(subst .o,.d,$@) -MP -MT $@ $(CXXFLAGS) $<
	$(CXX) $(CXXFLAGS) -c $< -o $@

ifneq "$(MAKECMDGOALS)" "clean"
-include $(DEPS)
endif

.PHONY: all directories clean fclean re debug
