CXX = g++
FLAGS = -std=c++17 -O2

matriz:
	$(CXX) $(FLAGS) -o matriz matriz.cpp
	./matriz | tee matriz.txt
	rm -f matriz

falso:
	$(CXX) $(FLAGS) -pthread -o falso falso_compartir.cpp
	./falso | tee falso.txt
	rm -f falso

todo: matriz falso

limpiar:
	rm -f matriz falso matriz.txt falso.txt
