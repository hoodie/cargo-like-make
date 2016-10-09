
CXX=g++
CXXFLAGS=-g -W -Wall -Werror -pedantic -std=c++11

CXX_DEBUG=$(CXX) $(CXXFLAGS)

SRC_DIR = src/

MAIN_BIN=$(DEBUG_DIR)dvb
MAIN_LIB=$(DEBUG_DIR)main.o
MAIN_SRC=$(SRC_DIR)main.c++

CPP_SRC = $(shell find $(SRC_DIR) -type f -iname \*.cpp)
HPP_SRC = $(shell find $(SRC_DIR) -type f -iname \*.hpp)
OBJS = $(CPP_SRC:$(SRC_DIR)%.cpp=$(DEBUG_DIR)%.o)

TARGET_DIR = target/
DEBUG_DIR = target/debug/


all: $(MAIN_BIN)

$(DEBUG_DIR): $(TARGET_DIR)
	@mkdir -p $@

$(TARGET_DIR):
	@mkdir -p $@


$(OBJS): $(CPP_SRC) $(HPP_SRC) $(DEBUG_DIR)
	@$(CXX_DEBUG) -c $< -o $@ 

$(MAIN_BIN): $(MAIN_LIB) $(OBJS)
	@$(CXX_DEBUG) $< -o $@ 

$(MAIN_LIB): $(MAIN_SRC) $(DEBUG_DIR) $(CPP_SRC) $(HPP_SRC)
	@$(CXX_DEBUG) -c $(MAIN_SRC) -o $@

#list.o: list.cpp list.h item.h
#	$(CXX) $(CXXFLAGS) -c list.cpp

PHONY: clean run

clean:
	@#rm -f *.o $(MAIN_BIN)
	rm -rf $(TARGET_DIR)

run: $(MAIN_BIN)
	./$<


