CFILES	:= src/*.c src/*/*.c
RM		:= rm -f
NAME	:= miniRT
CC		:= gcc
UNAME	:= $(shell uname -s)

# macOS: bundled mlx/ (OpenGL/AppKit) · Linux: bundled mlx_linux/ (X11)
ifeq ($(UNAME),Linux)
MLXDIR	:= mlx_linux
MLXLINK	:= -L $(MLXDIR) -lmlx -lXext -lX11 -lm -lpthread
PLATFORM	:= -D LINUX=1 -std=gnu17
# build only the library (./configure would also build mlx's test program, which needs libbsd)
MLXBUILD	:= cd $(MLXDIR) && { echo "INC=/usr/include"; grep -v %%%% Makefile.mk; } > Makefile.gen && $(MAKE) -f Makefile.gen all
MLXCLEAN	:= rm -f $(MLXDIR)/*.o $(MLXDIR)/libmlx*.a $(MLXDIR)/Makefile.gen
else
MLXDIR	:= mlx
MLXLINK	:= -L $(MLXDIR) -lmlx -framework OpenGL -framework Appkit
PLATFORM	:= -D MACOS=1
MLXBUILD	:= $(MAKE) -C $(MLXDIR)
MLXCLEAN	:= $(MAKE) -C $(MLXDIR) clean
endif

INCDIR	:= -I ./include -I $(MLXDIR) -I libft

LIB		:= libmlx.a
LIBFT	:= libft.a
LIBDIR	:= $(MLXDIR)/$(LIB)
LIBFTDIR	:= libft
LIBFTPATH	:= $(LIBFTDIR)/$(LIBFT)
CFLAGS	:= -Wall -Wextra -Werror $(INCDIR) #-fsanitize=address 
FILE ?=

GREEN = \033[0;32m
BLUE = \033[0;34m
VIOLET = \033[0;35m
BOLD = \033[1m
NC = \033[0m

all: $(NAME)

$(NAME): $(CFILES) $(LIBDIR) $(LIBFTPATH)
	@$(CC) $(CFLAGS) $(PLATFORM) $(CFILES) -o $(NAME) -L $(LIBFTDIR) -lft $(MLXLINK)
	@echo -e "$(BLUE)$(BOLD)[ ok ] $(NAME): created$(NC)"

linux: all

$(LIBDIR):
	@$(MLXBUILD)

$(LIBFTPATH):
	@make -C $(LIBFTDIR)

clean:
	@$(MLXCLEAN)
	@make -C $(LIBFTDIR) clean
	@clear
	@echo -e "$(VIOLET)$(BOLD)[ ok ] $^: mlx objs deleted$(NC)"
	@echo -e "$(VIOLET)$(BOLD)[ ok ] $^: libft objs deleted$(NC)"


fclean: clean
	@$(RM) $(NAME)
	@$(RM) $(LIBDIR)
	@$(RM) $(LIBFTPATH)
	@clear
	@echo -e "$(VIOLET)$(BOLD)[ ok ] $^: mlx deleted$(NC)"
	@echo -e "$(VIOLET)$(BOLD)[ ok ] $^: libft deleted$(NC)"

run: all
	./$(NAME) $(FILE)

re: fclean all

rerun: re run

.PHONY: clean fclean all linux re run rerun
