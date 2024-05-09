TARGET		=	echo_listen
SRC			=	$(wildcard src/*.v)
V			?=	v

all:	$(TARGET)

$(TARGET): $(SRC)
	$(V) . -prod -o $(TARGET)

clean:

fclean: clean
	$(RM) $(TARGET)
