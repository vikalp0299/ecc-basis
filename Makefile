GMPROOT   := $(HOME)/Developements/homebrew/Cellar/gmp/6.2.1
GIVAROROOT:= $(HOME)/Developements/Givaro

LDFLAGS   := -L$(GMPROOT)/lib -L$(GIVAROROOT)/lib
INCLUDES  := -I$(GMPROOT)/include -I$(GIVAROROOT)/include -Iinclude
LIBS 	  := -lgmp -lgivaro 

CXX       := g++
CXXFLAGS  := -std=c++11 -O0 -g3 -Wall -fmessage-length=0


OBJ_DIR  := ./obj
BIN_DIR  := ./bin
TARGET   := test
SRC      := $(wildcard src/*.cpp)

OBJECTS  	 := $(SRC:%.cpp=$(OBJ_DIR)/%.o)
DEPENDENCIES := $(OBJECTS:.o=.d)

all: clean build $(BIN_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $< -MMD -o $@
	

$(BIN_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $(BIN_DIR)/$(TARGET) $^ $(LDFLAGS) $(LIBS)

-include $(DEPENDENCIES)

.PHONY: all build clean run

build:
	@echo "[*] 🛠   Building           "
	@echo 
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(OBJ_DIR)

clean:
	@echo "[*] 🧻🧻 Cleaning           "
	@echo
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(BIN_DIR)/*

run: all
	@echo "[*] 🚀 Start Running       "
	@echo 
	$(BIN_DIR)/$(TARGET)
	@echo
	@echo "[*] Finish running         "

