##
## Makefile
##
## Made by @@AUTHOR@@
## Login   <@@AUTHORMAIL@@>
##
## Started on  @@CDATE@@ @@AUTHOR@@
## Last update @@MDATE@@ @@MAUTHOR@@
##

SRC			= main.cpp \

CXXFLAGS	= -Wall -Wextra

LDFLAGS		=

NAME		=
NAME_DEBUG	= $(NAME).debug

OBJ			= $(SRC:.cpp=.o)
OBJ_DEBUG	= $(SRC:.cpp=.debug.o)

RM			= rm -f

CXX			= g++

MAKE		= make -C

all: $(NAME)

$(NAME): $(OBJ)
	$(CXX) $(OBJ) $(LDFLAGS) -o $(NAME)

clean:
	$(RM) $(OBJ) $(OBJ_DEBUG) *.swp *~ *#

fclean: clean
	$(RM) $(NAME) $(NAME_DEBUG)

re: fclean all

debug: CXXFLAGS += -ggdb3
debug: $(OBJ_DEBUG)
	$(CXX) $(OBJ_DEBUG) $(LDFLAGS) -o $(NAME_DEBUG)

%.debug.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

.PHONY: all clean fclean re debug
