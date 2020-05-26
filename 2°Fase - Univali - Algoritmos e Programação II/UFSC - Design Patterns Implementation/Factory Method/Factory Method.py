"""
Created on Thu Jun 14 07:44:02 2018

@author: Matheus Schaly
"""


from abc import ABC, abstractmethod


# Creator
class MazeGame(ABC):
    
    def __init__(self):
        self.rooms = []
        self._prepare_rooms()

    def _prepare_rooms(self):
        room1 = self.make_room()
        room2 = self.make_room()

        room1.connect(room2)
        self.rooms.append(room1)
        self.rooms.append(room2)

    def play(self):
        print("Playing using \"{}\"".format(self.rooms[0]))

    @abstractmethod
    def make_room(self): # Factory Method
        pass


# Concrete Creator 1
class MagicMazeGame(MazeGame):

    def make_room(self):
        return MagicRoom()


# Concrete Creator 2
class OrdinaryMazeGame(MazeGame):

    def make_room(self):
        return OrdinaryRoom()


# Product
class Room(ABC):
    
    def __init__(self):
        self.connected_rooms = []

    def connect(self, room):
        self.connected_rooms.append(room)


# Concrete Product 1
class MagicRoom(Room):
    
    def __str__(self):
        return "Magic room"


# Concrete Product 2
class OrdinaryRoom(Room):
    
    def __str__(self):
        return "Ordinary room"


ordinaryGame = OrdinaryMazeGame()
ordinaryGame.play()

magicGame = MagicMazeGame()
magicGame.play()